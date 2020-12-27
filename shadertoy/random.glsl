float scale = 5.;

void mainImage(out vec4 fragColor,in vec2 fragCoord)
{

    vec2 uv =(fragCoord-.5*iResolution.xy)/iResolution.y;
    uv *= scale;
    
    uv = fract(uv);
    uv -= 0.5; //对 uv 这个向量的每一个分量都减去 .5  // 这样做了之后每一个小 grid 的 uv 原点都是从center 的位置开始
    // uv = abs(uv);

    vec3 col=vec3(0);
    col.rg= uv;
    float id = floor(uv.x);
    
    // Output to screen
    fragColor=vec4(col, 1.);
}

// 最终的渲染结果在 shadertoy 中表现比较好
// 但是 vscode 的 shadertoy 插件中表现不太行 线条有的粗有的细，而且在resize 画布大小的时候极为明显。