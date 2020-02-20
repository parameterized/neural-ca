
import numpy as np
from keras.models import Model
from keras.layers import Input, Conv2D, Multiply, Add
from keras.preprocessing.image import load_img, img_to_array, save_img
from custom_layers import *

np.random.seed(0)

target = load_img('../gfx/mock.png', color_mode='rgba')
target = img_to_array(target) / 255.


l_in = Input(shape=(64, 64, 16))
l_conv_preprocess = Perceive()
l_conv1 = Conv2D(128, kernel_size=(1, 1), activation='relu', kernel_initializer='he_normal')
l_conv2 = Conv2D(16, kernel_size=(1, 1), kernel_initializer='he_normal')

h_pad_input = TiledPadding()(l_in)
h_preprocess = l_conv_preprocess(h_pad_input)
h_conv1 = l_conv1(h_preprocess)
h_conv2 = l_conv2(h_conv1)
h_alive_mask = AliveMask()(h_pad_input)
h_masked_conv2 = Multiply()([h_conv2, h_alive_mask])
h_new_state = Add()([l_in, h_masked_conv2])

l_out = Clip()(h_new_state)

model = Model(inputs=l_in, outputs=l_out)
#model = Model(inputs=l_in, outputs=Perceive()(TiledPadding()(l_in))) # test sobel
model = Model(inputs=l_in, outputs=[h_preprocess, h_conv1, l_out])

'''
d1_kernel = np.zeros((48, 128))
d1_bias = np.zeros((128,))
d2_kernel = np.zeros((128, 16))
d2_bias = np.zeros((16,))
d1_kernel[32, 1] = 1
d2_kernel[1, 0] = 1
d2_bias[:] = -1
d1_kernel = np.expand_dims(d1_kernel, (0, 1))
d2_kernel = np.expand_dims(d2_kernel, (0, 1))
l_conv1.set_weights([d1_kernel, d1_bias])
l_conv2.set_weights([d2_kernel, d2_bias])
'''

x = np.zeros((1, 64, 64, 16))
#x[0, :, :, :4] = target
x[0, 32, 32, :] = 1.

'''
y = model.predict(x)[0, :, :, :4] * 255.
save_img('train_output/test.png', y)
'''
[y_pre, y_conv1, y_out] = model.predict(x)


def serialize_lua():
    [d1_kernel, d1_bias] = l_conv1.get_weights()
    d1_kernel = d1_kernel[0, 0] # all 1x1
    [d2_kernel, d2_bias] = l_conv2.get_weights()
    d2_kernel = d2_kernel[0, 0]

    rows = ['{{ {} }}'.format(','.join([str(v) for v in row])) for row in d1_kernel]
    d1_kernel_s = '{{ {} }}'.format(',\n'.join(rows))
    d1_bias_s = '{{ {} }}'.format(','.join([str(v) for v in d1_bias]))

    rows = ['{{ {} }}'.format(','.join([str(v) for v in row])) for row in d2_kernel]
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

serialize_lua()
