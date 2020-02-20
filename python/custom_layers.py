
import numpy as np
from keras import backend as K
from keras.layers import Layer

class TiledPadding(Layer):
    '''Pad width and height by 1 on each side
    with input as if it were tiled

    # Input shape
        4D tensor with shape:
        `(batch_size, rows, cols, channels)`

    # Output shape
        4D tensor with shape:
        `(batch_size, rows + 2, cols + 2, channels)`
    '''

    def compute_output_shape(self, input_shape):
        shape = list(input_shape)
        assert len(shape) == 4  # only valid for 4D tensors
        shape[1] += 2
        shape[2] += 2
        return tuple(shape)

    def call(self, inputs):
        top = inputs[:, :1, :, :]
        bottom = inputs[:, -1:, :, :]
        left = inputs[:, :, :1, :]
        right = inputs[:, :, -1:, :]
        top_left = inputs[:, :1, :1, :]
        top_right = inputs[:, :1, -1:, :]
        bottom_left = inputs[:, -1:, :1, :]
        bottom_right = inputs[:, -1:, -1:, :]

        outputs = K.concatenate([bottom, inputs, top], axis=1)
        left = K.concatenate([bottom_left, left, top_left], axis=1)
        right = K.concatenate([bottom_right, right, top_right], axis=1)
        outputs = K.concatenate([right, outputs, left], axis=2)
        return outputs

class Perceive(Layer):
    '''Preprocess state grid with sobel filters and identity

    # Input shape
        4D tensor with shape:
        `(batch_size, rows, cols, channels)`
    
    # Output shape
        4D tensor with shape:
        `(batch_size, rows - 2, cols - 2, channels * 3)
    '''

    def build(self, input_shape):
        sobel_x = np.array([[-1, 0, +1],
                            [-2, 0, +2],
                            [-1, 0, +1]])
        sobel_y = sobel_x.T
        sobel_x = np.expand_dims(sobel_x, (2, 3))
        sobel_y = np.expand_dims(sobel_y, (2, 3))
        sobel = np.concatenate((sobel_x, sobel_y), axis=-1)
        sobel = np.repeat(sobel, input_shape[-1], axis=2)
        self.sobel = K.constant(sobel)

    def compute_output_shape(self, input_shape):
        shape = list(input_shape)
        assert len(shape) == 4
        assert shape[1] >= 3 and shape[2] >= 3
        shape[1] -= 2
        shape[2] -= 2
        shape[3] *= 3
        return tuple(shape)
    
    def call(self, inputs):
        sobel = K.depthwise_conv2d(inputs, self.sobel)
        cell_identities = inputs[:, 1:-1, 1:-1, :]
        outputs = K.concatenate([sobel, cell_identities], axis=-1)
        return outputs

class AliveMask(Layer):
    '''Mask if no neighboring cells have alpha > 0.1 (4th channel)

    # Input shape
        4D tensor with shape:
        `(batch_size, rows, cols, channels)`
    
    # Output shape
        4D tensor with shape:
        `(batch_size, rows - 2, cols - 2, channels)`
    '''

    def compute_output_shape(self, input_shape):
        shape = list(input_shape)
        assert len(shape) == 4  # only valid for 4D tensors
        assert shape[1] >= 3 and shape[2] >= 3 and shape[3] >= 4
        shape[1] -= 2
        shape[2] -= 2
        return tuple(shape)
    
    def call(self, inputs):
        alphas = inputs[:, :, :, 3:4]
        pool = K.pool2d(alphas, pool_size=(3, 3), strides=(1, 1), padding='valid', pool_mode='max')
        mask = pool > 0.1
        outputs = K.cast(mask, 'float32')
        #outputs = K.repeat_elements(outputs, 16, axis=3) # warning: node 'alive_mask_1/concat' has self cycle fanin 'alive_mask_1/concat'
        return outputs

class Clip(Layer):
    '''Clip to [0, 1]'''

    def compute_output_shape(self, input_shape):
        return input_shape
    
    def call(self, inputs):
        return K.clip(inputs, 0., 1.)
