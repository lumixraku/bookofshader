#define S(x,y,z)smoothstep(x,y,z)

// float skewbox(vec2 uv,vec3 top,vec3 bottom,float blur){
//     float y=within(top.z,bottom.z,uv.y);
//     float left=mix(top.x,bottom.x,y);
//     float right=mix(top.y,bottom.y,y);
    
//     float horizontal=B(left,right,uv.x,blur);
//     float vertical=B(bottom.z,top.z,uv.y,blur);
//     return horizontal*vertical;
// }
/**
* 
画梯形
p 画布上点的坐标
wb width of bottom
wt width of top
yb height of bottom
yt height of top
*/
float tamperBox(vec2 p, float wb, float wt, float yb, float yt, float blur) {
    // float m = S(-0.01,0.5, p.y);

    // 效果是 yb 以上的几乎都是白色
    float bottomRange=S(-blur, blur,p.y - yb); 
    // 或者这样理解
    // -.01 < p.y-yb < .01  从 0 变化到 1
    // 也就是 当 p.y 很靠近 yb 这个值的上方 是白色

    // 这里表示 yt 以下都是白色
    // float topRange = S(-blur, blur, yt - p.y); // 这样第三个参数有点难移理解
    // 用下面的办法 第三个参数还是表示点p 到yt 的距离  
    // 这个函数则是 -blur < p.y-yt < blur 在此区间范围时  f(g) 从 1 ～ 0
    // 也就是说 p.y 在 yt 上面的部分取值为 0
    float topRange=S(blur,-blur,p.y - yt); 

    // horizonRange
    p.x = abs(p.x);
    float rect = 0.;
    float horizonRangeBottom = S(-blur, blur, wb - p.x) * .5;
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

void mainImage(out vec4 fragColor,in vec2 fragCoord)
{
    vec2 uv=(fragCoord-.5*iResolution.xy)/iResolution.y;
    
    float thickness=1./iResolution.y;// 表示画布中的一个像素 转为 uv 坐标下的值
    vec3 col=vec3(0);
    if(abs(uv.x)<thickness||abs(uv.y)<thickness){
        col.g=1.;
    }
    col += tamperBox(uv, .3, .1, .1, .3, 0.01);
    col += tamperBox(uv, .03, .03, .0, .25, 0.01);
    
    // Output to screen
    fragColor=vec4(col,1.);
}