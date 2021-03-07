/**
Polar describle points with angle and distance.
笛卡尔坐标转换到极坐标
vec2 st = vec2(atan(uv.x, uv.y), length(uv))
*/

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = (fragCoord - iResolution.xy * .5)/iResolution.y;
    vec2 st = vec2(atan(uv.x, uv.y), length(uv));
    // 得到的 st 的 y 也就是 length(uv) 是从 0 ～ 1
    // 得到的 st 的 x 也就是 arctan 值域在 (-π π)
    // 这里的定义和数学不一样
    // https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/atan.xhtml
    

    // Output to screen
    // fragColor = vec4(st.x/(3.14159 * 2.) + 0.5);

    // uv = st; ----------------------- (1)
    // make zigzag
    // float x = uv.x * 5.;
    // float m = min(fract(x), fract(1.-x));
    // float c = smoothstep(.1, .0,  uv.y - m * .3 - .2);    
    // fragColor = vec4(c);

    // try to uncomment (1)
    // But there is some defect in the graph we get,
    // watch the bottom of the wheel.
    // 这是因为 st 的范围是从 (-π π)
    // 但是上面的 zigzag 是以 [-1, 1] 范围处理的
    // 所以我们需要把 st 的变化也弄成 [-1, 1]

    uv = vec2(st.x/(3.14159 * 2.) + iTime * .1 + 0.5, st.y);
    // uv = vec2(st.x/(3.14159 * 2.) + iTime * .1 - st.y + 0.5, st.y);
    float x = uv.x * 5.;
    float m = min(fract(x), fract(1.-x));
    float c = smoothstep(.05, .0,  uv.y - m * .3 - .2);    
    fragColor = vec4(c);

}