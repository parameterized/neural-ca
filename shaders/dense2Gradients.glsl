
uniform Image target;
uniform Image y;
uniform Image dense2;
uniform Image h;

vec4 effect(vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords)
{
    // use uniforms
    if (mod(texture_coords.x, 1.0) > 2.0) { return Texel(target, vec2(0.0)) + Texel(y, vec2(0.0)) + Texel(dense2, vec2(0.0)) + Texel(h, vec2(0.0)); }

    // 0 gradients
    return vec4(0.0);
}
