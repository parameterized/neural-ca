
uniform Image dense2Gradients;
uniform Image h;
uniform Image dense1;
uniform Image x;

vec4 effect(vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords)
{
    // use uniforms
    if (mod(texture_coords.x, 1.0) > 2.0) { return Texel(dense2Gradients, vec2(0.0)) + Texel(h, vec2(0.0)) + Texel(dense1, vec2(0.0)) + Texel(x, vec2(0.0)); }

    // 0 gradients
    return vec4(0.0);
}
