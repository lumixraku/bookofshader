#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

float lineWidth=.1;

float plot(vec2 st,float y){
    // return 0.1;
    // return step(0.4, st.y);
    // return smoothstep(0.1, 0.3, st.y);
    
    //截面不渐变的曲线
    // return step(y-lineWidth, st.y) - step(y+lineWidth, st.y);
    
    //截面渐变的曲线
    return smoothstep(y-lineWidth,y,st.y)-
    smoothstep(y,y+lineWidth,st.y);
}

void main(){
    vec3 lineColor = vec3(0., 0., 1.);
    vec2 st=gl_FragCoord.xy/u_resolution;
    st*=8.;//坐标轴范围扩大8倍
    if (mod(st.y, 2.0) < 1.){
        lineColor=vec3(0.,1.,0.);
    }

    //pattern 的 tile 函数实际上就是使用 fract
    st = fract(st);//fract 只取小数部分//相当于 tile 构造出了 8*8 64个坐标 
    
    // Smooth interpolation between 0.1 and 0.9
    
    float y=mod(st.x,2.);

    // 下面两个式子表达相同图形
    // y= mod(st.x,2.) < 1.? 0. : 1.;
    // y=step(1., mod(st.x,2.));
    // 但是后面一种表达式更好 内置函数效率更高些

    
    vec3 color=vec3(y);
    float pct=plot(st,y);//plot(st, st.x)  返回 y=x图像
    
    // float pct = plot(st, 0.5);
    
    // color = (1.0-pct)*color + pct*vec3(0.0,1.0,0.0);
    color=pct*lineColor;
    
    gl_FragColor=vec4(color,1.);
}
