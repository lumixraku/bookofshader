#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

float lineWidth=.1;

float rand(float i){
return fract(abs(sin(u_time)) * sin(dot(vec2(i),
        vec2(123423.9898,78.233)))*
    458.543);
}


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
    st*=16.;//坐标轴范围扩大16倍
    st.y=st.y-8.;//平移图像到画布中间位置
    float y;
    
    float i=floor(st.x);// integer
    float f=fract(st.x);// fraction
    y=rand(i);
    // y=rand(i-1.);// 看起来是图形左1一个单位 rand(i+1.)看起来是图形右移动一个单位


    // y=mix(rand(i),rand(i+1.),.8); 
    //mix(a, b, pct) = (1-pct)*a + pct*b
    // The mix function returns the linear blend of x and y,i.e.the product of x and(1-a)plus the product of y and a.

    // i *= sin(u_time);
    // f *= sin(u_time);

    y=mix(rand(i),rand(i+1.),smoothstep(0., 1.,f));
    float u=f*f*(3.-2.*f);// custom cubic curve
    y=mix(rand(i),rand(i+1.),u);// using it in the interpolation

    // draw 
    vec3 color=vec3(y);    
    float pct=plot(st,y);//plot(st, st.x)  返回 y=x图像
    color=pct*vec3(0.,1.,0.);
    
    gl_FragColor=vec4(color,1.);
}

