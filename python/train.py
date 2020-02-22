
import os
import numpy as np
from keras.models import Model
from keras.layers import Input, Conv2D, Multiply, Add, Lambda
from keras.optimizers import Adam
from keras.preprocessing.image import load_img, img_to_array, save_img
from custom_layers import *

np.random.seed(0)

target = load_img('../gfx/mock.png', color_mode='rgba')
target = img_to_array(target) / 255.


def serialize_lua():
    [d1_kernel, d1_bias] = l_conv1.get_weights()
    d1_kernel = d1_kernel[0, 0]  # all 1x1
    [d2_kernel, d2_bias] = l_conv2.get_weights()
    d2_kernel = d2_kernel[0, 0]

    rows = ['{{ {} }}'.format(','.join([str(v) for v in row]))
            for row in d1_kernel]
    d1_kernel_s = '{{ {} }}'.format(',\n'.join(rows))
    d1_bias_s = '{{ {} }}'.format(','.join([str(v) for v in d1_bias]))

    rows = ['{{ {} }}'.format(','.join([str(v) for v in row]))
            for row in d2_kernel]
    d2_kernel_s = '{{ {} }}'.format(',\n'.join(rows))
    d2_bias_s = '{{ {} }}'.format(','.join([str(v) for v in d2_bias]))

    s = '''
return {{

    d1_kernel = {},

    d1_bias = {},

    d2_kernel = {},

    d2_bias = {}

}}
'''.format(d1_kernel_s, d1_bias_s, d2_kernel_s, d2_bias_s)

    with open('train_output/weights.lua', 'w') as f:
        f.write(s)


l_in = Input(shape=(64, 64, 16))
l_pad = TiledPadding()
l_preprocess = Perceive()
l_conv1 = Conv2D(128, kernel_size=(1, 1), activation='relu', kernel_initializer='he_normal')
l_conv2 = Conv2D(16, kernel_size=(1, 1), kernel_initializer='zeros')
l_alive_mask = AliveMask()
# todo: random update mask
l_multiply = Multiply()
l_add = Add()
l_clip = Clip()

# unroll to 10 timesteps
h_in = l_in
for _ in range(10):
    h_pad_in = l_pad(h_in)
    h_preprocess = l_preprocess(h_pad_in)
    h_conv1 = l_conv1(h_preprocess)
    h_conv2 = l_conv2(h_conv1)
    h_new_state = l_add([h_in, h_conv2])
    h_alive_mask = l_alive_mask(h_pad_in)
    h_out = l_multiply([h_new_state, h_alive_mask])
    h_out = l_clip(h_out)
    h_in = h_out
l_out_x2 = h_out
l_out_rgba = Lambda(lambda x: x[:, :, :, :4], lambda s: (s[0], s[1], s[2], 4))(l_out_x2)

model = Model(inputs=l_in, outputs=[l_out_rgba, l_out_x2])
model.compile(optimizer=Adam(0.002), loss=['mse', None])


seed = np.zeros((64, 64, 16))
seed[32, 32, 3:] = 1.
# todo: larger pool
x = np.repeat(np.expand_dims(seed, 0), 16, axis=0)
y = np.repeat(np.expand_dims(target, 0), 16, axis=0)

# train
os.makedirs('train_output', exist_ok=True)
print('training ...')
for i in range(4000):
    print(i)
    if (i == 2000):
        model.compile(optimizer=Adam(0.0002), loss=['mse', None])
    model.train_on_batch(x, [y])
    rgba, x2 = model.predict(x)
    x = x2
    # todo: replace highest loss
    x[np.random.randint(16)] = seed

    if (i + 1) % 200 == 0:
        output_3x3 = rgba[:9].reshape(3, 3, 64, 64, 4).swapaxes(1, 2).reshape(64 * 3, 64 * 3, 4) * 255.
        save_img('train_output/out_{}.png'.format(i + 1), output_3x3)

model.save('train_output/model.h5')
serialize_lua()
