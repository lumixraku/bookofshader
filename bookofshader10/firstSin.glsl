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
    vec2 st=gl_FragCoord.xy/u_resolution;
    st*=16.;  //坐标轴范围扩大16倍
    st.y = st.y - 8.0; //平移图像到画布中间位置


    // Smooth interpolation between 0.1 and 0.9
    float y=fract(sin(st.x)*1.);// 当x的在[0.1,0.9]范围时 y是缓慢变化

    
    // y = rand(st.x);
    
    vec3 color=vec3(y);
    
    float pct=plot(st,y);//plot(st, st.x)  返回 y=x图像
    
    // float pct = plot(st, 0.5);
    
    // color = (1.0-pct)*color + pct*vec3(0.0,1.0,0.0);
    color=pct*vec3(0.,1.,0.);
    
    gl_FragColor=vec4(color,1.);
}
