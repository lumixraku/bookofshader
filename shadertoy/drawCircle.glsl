void mainImage(out vec4 fragColor,in vec2 fragCoord)
{
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv=fragCoord/iResolution.xy; 
    // 但是这样画出来的”圆“是相对于画布而言的
    // 如果画布不是边长相等的矩形，也就是画布不是正方形的时候  那么圆也是一个椭圆

    // 那么为了保持不论画布比例如何，圆始终是圆的话   就只以其中的一个边长算比例就可以了
    uv=(fragCoord-.5*iResolution.xy)/iResolution.y;
    uv *= 2.;

    // Time varying pixel color
    vec3 col=vec3(smoothstep(.0,1.,length(uv)));
    
    // Output to screen
    fragColor=vec4(col,1.);
}