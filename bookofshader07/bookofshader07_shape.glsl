#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

#define PI 3.14159265359
#define TWO_PI 6.28318530718



float shape(vec2 st,vec2 size, int N){
    // st=st*2.-1.; //将坐标轴原点移动到屏幕中间
    st = st * size;
    float a=atan(st.x,st.y)+PI;
    float r=TWO_PI/float(N);
    return cos(floor(.5+a/r)*r-a)*length(st);
}

float box(vec2 st,vec2 size){
    return shape(st, size,4);
}

float triangle(vec2 st,vec2 size){
    return shape(st, size,3);
}

float circle(vec2 st,vec2 size){
    return shape(st, size,100);
}

void main(){
    vec2 st=gl_FragCoord.xy/u_resolution.xy;
    st=st*2.-1.; //将坐标轴原点移动到屏幕中间 //坐标范围[-2, 2]
    // vec3 color = vec3(circle(st, vec2(1.)));  

    vec3 color = vec3(box(st, vec2(3.)));  
    // color = vec3(step(0.8, color)); //将颜色小于0.8的部分都置为黑色
    gl_FragColor=vec4(color, 1.0);
}