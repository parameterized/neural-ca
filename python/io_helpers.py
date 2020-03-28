
import numpy as np
import PIL.Image
import tensorflow as tf


def load_image(path):
    img = PIL.Image.open(path)
    img = np.float32(img) / 255.
    return img

def save_image(path, img):
    img = np.uint8(np.clip(img, 0, 1) * 255.)
    PIL.Image.fromarray(img).save(path)

def serialize_lua(path, ca):
    [d1_kernel, d1_bias, d2_kernel, d2_bias] = [v.numpy() for v in ca.weights]
    d1_kernel = d1_kernel[0, 0]
    d2_kernel = d2_kernel[0, 0]

    rows = ['{{ {} }}'.format(','.join([str(v) for v in row]))
            for row in d1_kernel]
    d1_kernel_s = '{{ {} }}'.format(',\n'.join(rows))
    d1_bias_s = '{{ {} }}'.format(','.join([str(v) for v in d1_bias]))

    rows = ['{{ {} }}'.format(','.join([str(v) for v in row]))
            for row in d2_kernel]
    d2_kernel_s = '{{ {} }}'.format(',\n'.join(rows))
    d2_bias_s = '{{ {} }}'.format(','.join([str(v) for v in d2_bias]))

    s = """
return {{

    d1_kernel = {},

    d1_bias = {},

    d2_kernel = {},

    d2_bias = {}

}}
""".format(d1_kernel_s, d1_bias_s, d2_kernel_s, d2_bias_s)

    with open(path, 'w') as f:
        f.write(s)
