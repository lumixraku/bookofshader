void mainImage(out vec4 fragColor,in vec2 fragCoord)
{
    vec2 uv =(fragCoord-.5*iResolution.xy)/iResolution.y;
    // uv *= 5.;

    float thickness = 1. / iResolution.y;  // 表示画布中的一个像素 转为 uv 坐标下的值
    vec3 col=vec3(0);
    // col.rg = uv;
    if (abs(uv.x) < thickness ) {
        col.g = 1.;
    }
    if (abs(uv.y)<thickness) {
        col.r = 1.;
    }
    
    // Output to screen
    fragColor=vec4(col,1.);
}