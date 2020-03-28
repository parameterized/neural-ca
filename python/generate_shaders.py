
# h.glsl
s = """
uniform Image xin;
uniform Image dense1;

vec4 effect(vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords)
{
    vec3 d = vec3(-1.0, 0.0, 1.0);
    vec2 cs = vec2(64.0);
    vec4 offset = vec4(0.0, cs.x, cs.x * 2.0, cs.x * 3.0);
    vec2 uv = mod(screen_coords.xy, cs);
    float ci = floor(screen_coords.x / cs.x);
    vec2 xss = vec2(64.0 * 4.0, 64.0);
    vec2 hss = vec2(64.0 * 32.0, 64.0);
    vec2 dss = vec2(49.0, 32.0);
"""

# neighbors
for k in range(4):
    s += '\n'
    for i in range(3):
        for j in range(3):
            if i == 1 and j == 1:
                s += 'vec4 n{}11 = Texel(xin, (uv + offset.{}x) / xss);\n'.format(k, 'xyzw'[k])
            else:
                s += 'vec4 n{}{}{} = Texel(xin, (mod(uv + d.{}{}, cs) + offset.{}x) / xss);\n'.format(
                    k, i, j, 'xyz'[i], 'xyz'[j], 'xyzw'[k])

# inputs
s += '\n'
for i in range(16):
    c = 'xyzw'[i % 4]
    s += 'float x{0} = n{1}11.{2};\n'.format(i * 3, int(i / 4), c)
    s += 'float x{0} = 0.125 * (n{1}20.{2} + n{1}22.{2} - n{1}00.{2} - n{1}02.{2}) + 0.25 * (n{1}21.{2} - n{1}01.{2});\n'.format(i * 3 + 1, int(i / 4), c)
    s += 'float x{0} = 0.125 * (n{1}02.{2} + n{1}22.{2} - n{1}00.{2} - n{1}20.{2}) + 0.25 * (n{1}12.{2} - n{1}10.{2});\n'.format(i * 3 + 2, int(i / 4), c)

# d1 weights (for ci group of 4 channels)
s += '\n'
for i in range(16 * 3 + 1):
    s += 'vec4 d1_{} = Texel(dense1, vec2({}, ci + 0.5) / dss);\n'.format(i, i + 0.5)

# h
s += '\n'
for i in range(4):
    c = 'xyzw'[i]
    x = []
    for j in range(16 * 3):
        x.append('x{0} * d1_{0}.{1}'.format(j, c))
    # bias
    x.append('d1_48.{}'.format(c))
    s += 'float h{} = {};\n'.format(i, ' + '.join(x))

s += """
    return vec4(h0, h1, h2, h3);
}
"""

with open('../shaders/h.glsl', 'w') as f:
    f.write(s)



# y.glsl
s = """
uniform Image xin;
uniform Image h;
uniform Image dense2;
uniform vec2 randOffset;

float rand(vec2 p)
{
	return fract(sin(dot(p, vec2(12.9898, 4.1414))) * 43758.5453);
}

vec4 effect(vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords)
{
    vec3 d = vec3(-1.0, 0.0, 1.0);
    vec2 cs = vec2(64.0);
    vec2 uv = mod(screen_coords.xy, cs);
    float ci = floor(screen_coords.x / cs.x);
    vec2 xss = vec2(64.0 * 4.0, 64.0);
    vec2 hss = vec2(64.0 * 32.0, 64.0);
    vec2 dss = vec2(129.0, 4.0);
"""

# inputs / activations
s += '\n'
for i in range(int(128 / 4)):
    s += 'vec4 h{0} = max(Texel(h, vec2(uv.x + {0}.0 * cs.x, uv.y) / hss), 0.0);\n'.format(i)

# d2 weights (for ci group of 4 channels)
s += '\n'
for i in range(128 + 1):
    s += 'vec4 d2_{} = Texel(dense2, vec2({}, ci + 0.5) / dss);\n'.format(i, i + 0.5)

# y
s += '\n'
for i in range(4):
    c = 'xyzw'[i]
    x = []
    for j in range(128):
        c2 = 'xyzw'[j % 4]
        x.append('h{}.{} * d2_{}.{}'.format(int(j / 4), c2, j, c))
    # bias
    x.append('d2_128.{}'.format(c))
    s += 'float y{} = {};\n'.format(i, ' + '.join(x))

# return 0 for empty
s += '\n'
x = []
for i in range(3):
    for j in range(3):
        x.append('Texel(xin, mod(uv + d.{}{}, cs) / xss).a <= 0.1'.format('xyz'[i], 'xyz'[j]))
s += 'if ({}) {{ return vec4(0.0); }}\n'.format(' && '.join(x))

s += """
    vec4 res = Texel(xin, screen_coords / xss);
    float update_mask = rand(mod(uv, cs) + randOffset) < 0.5 ? 1.0 : 0.0;
    res += vec4(y0, y1, y2, y3) * update_mask;

    return res;
}
"""

with open('../shaders/y.glsl', 'w') as f:
    f.write(s)
