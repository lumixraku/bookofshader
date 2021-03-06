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
    random = fract(sin((uv.x +uv.y* 142.212)* 10.) * 2342.43);

    return random;
}

void mainImage(out vec4 fragColor,in vec2 
fragCoord)
{

    // 固定宽高比避免受到画布的影响
    vec2 uv =(fragCoord-.5*iResolution.xy)/iResolution.y;
    
    
    float random = N21(uv);
    // 注意 这个 N21 创建出来的还是伪随机数, 
    // 只是在有限的屏幕范围中看起来很随机
    // N21(uv * 0.0001); 这样的话你就可以看出来周期性的图案了。
    
    vec3 col=vec3(random);
    // Output to screen
    fragColor=vec4(col, 1.);
}

// 最终的渲染结果在 shadertoy 中表现比较好
// 但是 vscode 的 shadertoy 插件中表现不太行 线条有的粗有的细，而且在resize 画布大小的时候极为明显。