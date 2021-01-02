float scale = 5.;


// N stands for noise
// 2 means tow for two dimension input, 1 for one dimension output
float N21(vec2 uv) {

    float random = sin(uv.x*100.); 
    // 上面得到了 100个周期的 sin 函数
    // 但是这个函数的值域是 [0, 1]
    random *= 4342.434;
    random = fract(random);
    // 不过这样得到的是在一个维度上的随机


    random = fract(sin((uv.x +uv.y)* 21.123) * 2342.43);
    // 这样做虽然加上了一个维度 但是 xy 的变化频率是一样的
    // 所以得到的效果就是前面结果 + 旋转了方向而已
    
    // 这个效果就很不错
    // 后面这个值最好是一个大于 10 的小数
    // 数字越大，越混乱，而且雪花会更加细腻。
    random = fract(sin((uv.x* 100. + uv.y* 2142.212)* 542.));

    return random;
}

float SmoothNoise(vec2 uv){
    vec2 localUV = fract(uv );
    vec2 localID = floor(uv );
    
    float randomBL = N21(localID);
    float randomBR = N21(localID + vec2(1, 0));
    float randomTL = N21(localID + vec2(0, 1));
    float randomTR = N21(localID + vec2(1, 1));
    // float random = mix(randomBL, randomBR, localID.x);
    // localUV = smoothstep(0., 1., localUV); // 不这么做的话 会形成很锋利的边缘
    // 或者
    localUV = localUV * localUV * (3. - 2. * localUV);

    float t = mix(randomTL, randomTR, localUV.x);
    float b = mix(randomBL, randomBR, localUV.x);
    float random = mix(b, t, localUV.y);
    return random;

}

void mainImage(out vec4 fragColor,in vec2 
fragCoord)
{

    // 固定宽高比避免受到画布的影响
    vec2 uv =(fragCoord-.5*iResolution.xy)/iResolution.y;
    uv = uv + iTime * .1;

    
    vec3 col=vec3(SmoothNoise(uv * 4.));
    col += vec3(SmoothNoise(uv* 8.)) * .5;
    col += vec3(SmoothNoise(uv * 16.) )* .25;
    col += vec3(SmoothNoise(uv * 32.)) * .125;
    col += vec3(SmoothNoise(uv * 64.)) * .0625;

    col /= 2.;

    fragColor=vec4(col, 1.);
}

// 最终的渲染结果在 shadertoy 中表现比较好
// 但是 vscode 的 shadertoy 插件中表现不太行 线条有的粗有的细，而且在resize 画布大小的时候极为明显。