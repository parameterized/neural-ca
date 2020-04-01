
uniform vec2 delta;

vec4 effect(vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords)
{
    vec2 cs = vec2(64.0);
    vec2 uv = mod(screen_coords - delta, cs);
    int ci = int(screen_coords.x / cs.x);

    return Texel(tex, (uv + vec2(ci * cs.x, 0.0)) / love_ScreenSize.xy);
}
