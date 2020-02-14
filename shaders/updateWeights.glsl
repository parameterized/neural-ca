
uniform Image weights;
uniform Image gradients;
uniform float alpha;

vec4 effect(vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords)
{
    vec2 uv = screen_coords / love_ScreenSize.xy;
    return Texel(weights, uv) - Texel(gradients, uv) * alpha;
}
