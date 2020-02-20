
uniform Image xin;

vec4 effect(vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords)
{
    vec3 d = vec3(-1.0, 0.0, 1.0);
    vec2 cs = vec2(64.0);
    vec4 offset = vec4(0.0, cs.x, cs.x * 2.0, cs.x * 3.0);
    vec2 uv = mod(screen_coords.xy, cs);
    float ci = floor(screen_coords.x / cs.x);
    vec2 xss = vec2(64.0 * 4.0, 64.0);

vec4 n000 = Texel(xin, (mod(uv + d.xx, cs) + offset.xx) / xss);
vec4 n001 = Texel(xin, (mod(uv + d.xy, cs) + offset.xx) / xss);
vec4 n002 = Texel(xin, (mod(uv + d.xz, cs) + offset.xx) / xss);
vec4 n010 = Texel(xin, (mod(uv + d.yx, cs) + offset.xx) / xss);
vec4 n011 = Texel(xin, (uv + offset.xx) / xss);
vec4 n012 = Texel(xin, (mod(uv + d.yz, cs) + offset.xx) / xss);
vec4 n020 = Texel(xin, (mod(uv + d.zx, cs) + offset.xx) / xss);
vec4 n021 = Texel(xin, (mod(uv + d.zy, cs) + offset.xx) / xss);
vec4 n022 = Texel(xin, (mod(uv + d.zz, cs) + offset.xx) / xss);

vec4 n100 = Texel(xin, (mod(uv + d.xx, cs) + offset.yx) / xss);
vec4 n101 = Texel(xin, (mod(uv + d.xy, cs) + offset.yx) / xss);
vec4 n102 = Texel(xin, (mod(uv + d.xz, cs) + offset.yx) / xss);
vec4 n110 = Texel(xin, (mod(uv + d.yx, cs) + offset.yx) / xss);
vec4 n111 = Texel(xin, (uv + offset.yx) / xss);
vec4 n112 = Texel(xin, (mod(uv + d.yz, cs) + offset.yx) / xss);
vec4 n120 = Texel(xin, (mod(uv + d.zx, cs) + offset.yx) / xss);
vec4 n121 = Texel(xin, (mod(uv + d.zy, cs) + offset.yx) / xss);
vec4 n122 = Texel(xin, (mod(uv + d.zz, cs) + offset.yx) / xss);

vec4 n200 = Texel(xin, (mod(uv + d.xx, cs) + offset.zx) / xss);
vec4 n201 = Texel(xin, (mod(uv + d.xy, cs) + offset.zx) / xss);
vec4 n202 = Texel(xin, (mod(uv + d.xz, cs) + offset.zx) / xss);
vec4 n210 = Texel(xin, (mod(uv + d.yx, cs) + offset.zx) / xss);
vec4 n211 = Texel(xin, (uv + offset.zx) / xss);
vec4 n212 = Texel(xin, (mod(uv + d.yz, cs) + offset.zx) / xss);
vec4 n220 = Texel(xin, (mod(uv + d.zx, cs) + offset.zx) / xss);
vec4 n221 = Texel(xin, (mod(uv + d.zy, cs) + offset.zx) / xss);
vec4 n222 = Texel(xin, (mod(uv + d.zz, cs) + offset.zx) / xss);

vec4 n300 = Texel(xin, (mod(uv + d.xx, cs) + offset.wx) / xss);
vec4 n301 = Texel(xin, (mod(uv + d.xy, cs) + offset.wx) / xss);
vec4 n302 = Texel(xin, (mod(uv + d.xz, cs) + offset.wx) / xss);
vec4 n310 = Texel(xin, (mod(uv + d.yx, cs) + offset.wx) / xss);
vec4 n311 = Texel(xin, (uv + offset.wx) / xss);
vec4 n312 = Texel(xin, (mod(uv + d.yz, cs) + offset.wx) / xss);
vec4 n320 = Texel(xin, (mod(uv + d.zx, cs) + offset.wx) / xss);
vec4 n321 = Texel(xin, (mod(uv + d.zy, cs) + offset.wx) / xss);
vec4 n322 = Texel(xin, (mod(uv + d.zz, cs) + offset.wx) / xss);

float x0 = n020.x + 2.0 * n021.x + n022.x - n000.x - 2.0 * n001.x - n002.x;
float x1 = n002.x + 2.0 * n012.x + n022.x - n000.x - 2.0 * n010.x - n020.x;
float x2 = n020.y + 2.0 * n021.y + n022.y - n000.y - 2.0 * n001.y - n002.y;
float x3 = n002.y + 2.0 * n012.y + n022.y - n000.y - 2.0 * n010.y - n020.y;
float x4 = n020.z + 2.0 * n021.z + n022.z - n000.z - 2.0 * n001.z - n002.z;
float x5 = n002.z + 2.0 * n012.z + n022.z - n000.z - 2.0 * n010.z - n020.z;
float x6 = n020.w + 2.0 * n021.w + n022.w - n000.w - 2.0 * n001.w - n002.w;
float x7 = n002.w + 2.0 * n012.w + n022.w - n000.w - 2.0 * n010.w - n020.w;
float x8 = n120.x + 2.0 * n121.x + n122.x - n100.x - 2.0 * n101.x - n102.x;
float x9 = n102.x + 2.0 * n112.x + n122.x - n100.x - 2.0 * n110.x - n120.x;
float x10 = n120.y + 2.0 * n121.y + n122.y - n100.y - 2.0 * n101.y - n102.y;
float x11 = n102.y + 2.0 * n112.y + n122.y - n100.y - 2.0 * n110.y - n120.y;
float x12 = n120.z + 2.0 * n121.z + n122.z - n100.z - 2.0 * n101.z - n102.z;
float x13 = n102.z + 2.0 * n112.z + n122.z - n100.z - 2.0 * n110.z - n120.z;
float x14 = n120.w + 2.0 * n121.w + n122.w - n100.w - 2.0 * n101.w - n102.w;
float x15 = n102.w + 2.0 * n112.w + n122.w - n100.w - 2.0 * n110.w - n120.w;
float x16 = n220.x + 2.0 * n221.x + n222.x - n200.x - 2.0 * n201.x - n202.x;
float x17 = n202.x + 2.0 * n212.x + n222.x - n200.x - 2.0 * n210.x - n220.x;
float x18 = n220.y + 2.0 * n221.y + n222.y - n200.y - 2.0 * n201.y - n202.y;
float x19 = n202.y + 2.0 * n212.y + n222.y - n200.y - 2.0 * n210.y - n220.y;
float x20 = n220.z + 2.0 * n221.z + n222.z - n200.z - 2.0 * n201.z - n202.z;
float x21 = n202.z + 2.0 * n212.z + n222.z - n200.z - 2.0 * n210.z - n220.z;
float x22 = n220.w + 2.0 * n221.w + n222.w - n200.w - 2.0 * n201.w - n202.w;
float x23 = n202.w + 2.0 * n212.w + n222.w - n200.w - 2.0 * n210.w - n220.w;
float x24 = n320.x + 2.0 * n321.x + n322.x - n300.x - 2.0 * n301.x - n302.x;
float x25 = n302.x + 2.0 * n312.x + n322.x - n300.x - 2.0 * n310.x - n320.x;
float x26 = n320.y + 2.0 * n321.y + n322.y - n300.y - 2.0 * n301.y - n302.y;
float x27 = n302.y + 2.0 * n312.y + n322.y - n300.y - 2.0 * n310.y - n320.y;
float x28 = n320.z + 2.0 * n321.z + n322.z - n300.z - 2.0 * n301.z - n302.z;
float x29 = n302.z + 2.0 * n312.z + n322.z - n300.z - 2.0 * n310.z - n320.z;
float x30 = n320.w + 2.0 * n321.w + n322.w - n300.w - 2.0 * n301.w - n302.w;
float x31 = n302.w + 2.0 * n312.w + n322.w - n300.w - 2.0 * n310.w - n320.w;
float x32 = n011.x;
float x33 = n011.y;
float x34 = n011.z;
float x35 = n011.w;
float x36 = n111.x;
float x37 = n111.y;
float x38 = n111.z;
float x39 = n111.w;
float x40 = n211.x;
float x41 = n211.y;
float x42 = n211.z;
float x43 = n211.w;
float x44 = n311.x;
float x45 = n311.y;
float x46 = n311.z;
float x47 = n311.w;

    if (ci == 0) {
        return vec4(x0, x1, x2, x3);
    } else if (ci == 1) {
        return vec4(x4, x5, x6, x7);
    } else if (ci == 2) {
        return vec4(x8, x9, x10, x11);
    } else if (ci == 3) {
        return vec4(x12, x13, x14, x15);
    } else if (ci == 4) {
        return vec4(x16, x17, x18, x19);
    } else if (ci == 5) {
        return vec4(x20, x21, x22, x23);
    } else if (ci == 6) {
        return vec4(x24, x25, x26, x27);
    } else if (ci == 7) {
        return vec4(x28, x29, x30, x31);
    } else if (ci == 8) {
        return vec4(x32, x33, x34, x35);
    } else if (ci == 9) {
        return vec4(x36, x37, x38, x39);
    } else if (ci == 10) {
        return vec4(x40, x41, x42, x43);
    } else if (ci == 11) {
        return vec4(x44, x45, x46, x47);
    }
}
