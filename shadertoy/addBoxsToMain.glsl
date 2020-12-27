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

vec4 tree(vec2 uv, vec3 color, float blur) {
    float alpha = taperBox(uv, .03, .03, .0, .25, blur); //trunk
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


// 当设置 color = vec4(0) 的时候 插件中整个界面都透明了  
// 但是网站中还有黑色背景色。
void mainImage(out vec4 fragColor,in vec2 fragCoord)
{
    vec2 uv=(fragCoord-.5*iResolution.xy)/iResolution.y;
    uv.y += 0.5;
    float thickness=1./iResolution.y;// 表示画布中的一个像素 转为 uv 坐标下的值
    vec4 col=vec4(0, 0, 0, 1);

    float blur = 0.0005;
    vec4 tree = tree(uv, vec3(1.), blur);
    // 因为 tree 的计算结果 每个 uv 都对应的白色 
    // 树的形状信息保存在 alpha 中
    // 所以使用 mix
    col = mix(col, tree, tree.a);


    if (abs(uv.x) < thickness * 5. ) {
        col.g = 1.; // x = 0 的时候加上绿色的线 也就是 y 轴
        col.r = 0.;
        col.b = 0.;
    }
    if (abs(uv.y) < thickness * 5. ) {  
        col.g = 1.;// y = 0 的时候加上绿色的线 也就是 x 轴
        col.r = 0.;
        col.b = 0.;
    }   
    if ( abs(uv.y - 1.) < thickness * 5. ) {
        col.b = 1.; // y = 1  的时候加上蓝色的线
        col.r = 0.;
        col.g = 0.;        
    }      

    // 在每一个小数点位置加上红色的刻度线
    // col = vec4(smoothstep(.9, 1., fract(uv.y * 10.)), col.g, 0., 1.);    
    // 上面的做法不行  上面的做法就是只有 uv.y 在 1 附近位置的 r 才是1
    // 其他的 r 都被改写为 0 了。 这样就破坏了🌲的 r 分量了。

    
    if (.98 < fract(uv.y * 10.) && fract(uv.y * 10.) < 1. ) {
        col.rgb = vec3(1., 0., 0.);
    }


       



    // Output to screen
    fragColor=col;
}

// 最终效果以 shadertoy.com 为准。
// vscode shadertoy 插件存在渲染问题。