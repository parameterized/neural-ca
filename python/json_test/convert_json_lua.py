
import numpy as np
import json
import base64

file_name = '4000'

with open(file_name + '.json') as f:
    model_json = json.load(f)

w1_b64 = model_json['modelTopology']['node'][57]['attr']['value']['tensor']['tensorContent']
w1b_b64 = model_json['modelTopology']['node'][60]['attr']['value']['tensor']['tensorContent']
w2_b64 = model_json['modelTopology']['node'][64]['attr']['value']['tensor']['tensorContent']
w2b_b64 = model_json['modelTopology']['node'][67]['attr']['value']['tensor']['tensorContent']

w1 = base64.b64decode(w1_b64)
w1 = np.frombuffer(w1, dtype='float32').reshape((48, 128))
w1b = base64.b64decode(w1b_b64)
w1b = np.frombuffer(w1b, dtype='float32').reshape((128,))

w2 = base64.b64decode(w2_b64)
w2 = np.frombuffer(w2, dtype='float32').reshape((128, 16))
w2b = base64.b64decode(w2b_b64)
w2b = np.frombuffer(w2b, dtype='float32').reshape((16,))


rows = ['{{ {} }}'.format(','.join([str(v) for v in row]))
        for row in w1]
d1_kernel_s = '{{ {} }}'.format(',\n'.join(rows))
d1_bias_s = '{{ {} }}'.format(','.join([str(v) for v in w1b]))

rows = ['{{ {} }}'.format(','.join([str(v) for v in row]))
        for row in w2]
d2_kernel_s = '{{ {} }}'.format(',\n'.join(rows))
d2_bias_s = '{{ {} }}'.format(','.join([str(v) for v in w2b]))

s = '''
return {{

d1_kernel = {},

d1_bias = {},

d2_kernel = {},

d2_bias = {}

}}
'''.format(d1_kernel_s, d1_bias_s, d2_kernel_s, d2_bias_s)

with open(file_name + '.lua', 'w') as f:
    f.write(s)
