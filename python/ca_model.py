
import numpy as np
import tensorflow as tf
from tensorflow.keras.layers import Conv2D


def get_living_mask(x):
    alpha = x[:, :, :, 3:4]
    return tf.nn.max_pool2d(alpha, 3, [1, 1, 1, 1], 'SAME') > 0.1


class CAModel(tf.keras.Model):
    def __init__(self):
        super().__init__()
        self.model = tf.keras.Sequential([
            Conv2D(128, 1, activation=tf.nn.relu, input_shape=(None, None, 16 * 3)),
            Conv2D(16, 1, kernel_initializer='zeros')
        ])
        self(tf.zeros([1, 3, 3, 16])) # build model
    
    @tf.function
    def perceive(self, x):
        identity = np.float32([0, 1, 0])
        identity = np.outer(identity, identity)
        sobel_x = np.outer([1, 2, 1], [-1, 0, 1]) / 8.
        sobel_x = sobel_x.astype('float32')
        sobel_y = sobel_x.T
        kernel = tf.stack([identity, sobel_x, sobel_y], -1)[:, :, None, :]
        kernel = tf.repeat(kernel, 16, 2)
        y = tf.nn.depthwise_conv2d(x, kernel, [1, 1, 1, 1], 'SAME')
        return y
    
    @tf.function
    def call(self, x):
        pre_life_mask = get_living_mask(x)

        x_p = self.perceive(x)
        dx = self.model(x_p)
        update_mask = tf.random.uniform(tf.shape(x[:, :, :, :1])) < 0.5
        x += dx * tf.cast(update_mask, tf.float32)

        post_life_mask = get_living_mask(x)
        life_mask = pre_life_mask & post_life_mask
        return x * tf.cast(life_mask, tf.float32)
