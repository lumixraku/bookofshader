float scale = 5.;

void mainImage(out vec4 fragColor,in vec2 fragCoord)
{

    vec2 uv =(fragCoord-.5*iResolution.xy)/iResolution.y;
    uv *= scale;
    vec2 id = floor(uv);
    float idx = floor(uv.x);

    uv = fract(uv);
    // uv.x = uv.x - .5;
    uv -= 0.5; //对 uv 这个向量的每一个分量都减去 .5  // 这样做了之后每一个小 grid 的 uv 原点都是从center 的位置开始


    vec3 col=vec3(0);
    col.rg= uv;

    // 每一个 grid 画坐标轴
    float thickness = scale * 1. / iResolution.y;  // 表示画布中的1 个像素 转为 uv 坐标下的值  
    // 注意不要忘了乘以 scale 
    // 毕竟scale了之后 1. / iResolution.xy 并不是一像素了

    float border = thickness * 2.;
    if (abs(uv.x) < thickness ) {
        col.g = 1.;
    }
    if (abs(uv.y)<thickness) {
        col.r = 1.;
    }
    if (abs(uv.y - 0.5) < border || abs(uv.x - 0.5) < border) {
        col = vec3(1.);
    }

    float alpha = 1.;
    fragColor=vec4(col, alpha);
}

// 最终的渲染结果在 shadertoy 中表现比较好
// 但是 vscode 的 shadertoy 插件中表现不太行 线条有的粗有的细，而且在resize 画布大小的时候极为明显。