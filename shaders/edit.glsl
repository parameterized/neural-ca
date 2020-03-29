
uniform Image xin;
uniform Image edit;

vec4 effect(vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords)
{
    vec2 cs = vec2(64.0);
    vec2 uv = mod(screen_coords, cs) / cs;
    int ci = int(screen_coords.x / cs.x);
    
    vec4 x_c = Texel(xin, screen_coords / love_ScreenSize.xy);
    vec4 edit_c = Texel(edit, uv);
    return edit_c.a < 0.5 ? x_c : (
        edit_c.r < 0.5 ? vec4(0.0) : (
            ci == 1 ? vec4(vec3(0.0), 1.0) : vec4(1.0)
        )
    );
}
