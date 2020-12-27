#define S(x,y,z)smoothstep(x,y,z)

/**
* 
画梯形
p 画布上点的坐标
wb width of bottom
wt width of top
yb height of bottom
yt height of top

返回的是需要着色部分的像素的 alpha 的值。
如果这个像素不是🌲的一部分，那么这个返回的 alpha 就是 0 
*/
float taperBox(vec2 p, float wb, float wt, float yb, float yt, float blur) {
    // float m = S(-0.01,0.5, p.y);

    // 效果是 yb 以上的几乎都是白色
    float bottomRange=S(-blur, blur,p.y - yb); 
    // 或者这样理解
    // -.01 < p.y-yb < .01  从 0 变化到 1
    // 也就是 当 p.y 很靠近 yb 这个值的上方 是白色

    // 这里表示 yt 以下都是白色
    // float topRange = S(-blur, blur, yt - p.y); // 这样第三个参数有点难移理解
    // 用下面的办法 第三个参数还是表示点p 到 yt 的距离  
    // 这个函数则是 -blur < p.y-yt < blur 在此区间范围时  f(g) 从 1 ～ 0
    // 也就是说 p.y 在 yt 上面的部分取值为 0
    float topRange=S(blur,-blur,p.y - yt); 

    // horizonRange
    p.x = abs(p.x);
    float rect = 0.;
    float horizonRangeBottom = S(-blur, blur, wb - p.x);
    rect = topRange * bottomRange * horizonRangeBottom;
    // 到这里就画了一个关于 y 轴水平对称的矩形了

    // 但是我们需要梯形
    // 也即是 p.y == y.t 的时候 width 是 widthOfTop  
    // p.y == y.b 的时候 width 是 widthOfBottom
    float w = mix(wb, wt,(p.y - yb)/(yt - yb));
    float horizonrange = S(blur,-blur,p.x -w);
    rect=bottomRange*topRange*horizonrange;
    return rect;
}

vec4 tree(vec2 uv, vec2 pos, vec3 color, float blur) {
    uv -= pos; // pos.y > 0 是希望🌲在原点上方  因此想要🌲偏上，那么就移动摄像机往下走 因此这里是减法
    float alpha = taperBox(uv, .03, .03, -.05, .25, blur); //trunk
    alpha += taperBox(uv, .2, .1, .25, .5, blur); // bottom
    alpha += taperBox(uv, .15, .05, .5, .75, blur); // middle
    alpha += taperBox(uv, .1, .0, .75, 1., blur); // top 

    float shadow = taperBox(uv -vec2(.2, .0), .1, .5, .15, .25, blur);
    shadow += taperBox(uv + vec2(.25,0 ), .1, .5, .4, .5, blur);
    shadow += taperBox(uv - vec2(.25,0 ), .1, .5, .7, .75, blur);

    // color = vec3(shadow); // 观察 shadow 的形状
    color -= shadow * .8;
    return vec4(color, alpha);
}

float getRandomHeight(float x) {
    return sin(x * .3211) + sin(x)* .542;
}

// 当设置 color = vec4(0) 的时候 插件中整个界面都透明了  
// 但是网站中还有黑色背景色。
void mainImage(out vec4 fragColor,in vec2 fragCoord)
{
    vec2 uv=(fragCoord-.5*iResolution.xy)/iResolution.y;
    uv.x += iTime * .1;
    // uv.y += 0.5;
    uv *= 5.;
    float idX = floor(uv.x);
    float randomSeed = fract(sin(idX * 324.56)*5424.343) * 2. - 1.;   //[-1, 1]


    float thickness=1./iResolution.y;// 表示画布中的一个像素 转为 uv 坐标下的值
    vec4 col=vec4(0, 0, 0, 1);

    float blur = 0.0005;

    // float ground = S(blur, -blur, uv.y - sin(uv.x));
    float randomMountain = getRandomHeight(uv.x);
    float ground = S(blur, -blur, uv.y + randomMountain); //y 和 x 关系 是一个 sin 函数的组合
    col += vec4(vec3(ground), 1.); 

    
    uv.x = fract(uv.x) - .5;
    // col.rg = uv;
    float randomHeight = getRandomHeight(idX + .5); // 不加 .5 的话 看起来🌲和山坡存在频率不同步的情况 有相位差
    vec2 pos = vec2( 0., -randomHeight);   
    vec3 treeColor = vec3(1.);
    vec2 treeUVScale = vec2(1., 1. + randomSeed * .2);
    vec4 tree = tree(uv * treeUVScale, pos, treeColor, blur);
    // 因为 tree 的计算结果 每个 uv 都对应的白色 
    // 树的形状信息保存在 alpha 中
    // 所以使用 mix
    col = mix(col, tree, tree.a);


    // Output to screen
    fragColor=col;
}

// 最终效果以 shadertoy.com 为准。
// vscode shadertoy 插件存在渲染问题。