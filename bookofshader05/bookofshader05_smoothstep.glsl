#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

float lineWidth = 0.1; 
// smoothstep(a, b) 可以理解为分段函数
// x < a 为0  x > b 为1  a < x < b 缓慢变化
// st< 0.1 时值为0  
// st.y 在 0.1, 0.3 逐渐变为1  st.y > 0.3 时都是1
// smoothstep(0.1, 0.3, st.y)

// 该函数返回的值 0 - 1 再变回 0  
// 这样画出来的线  在y轴上看是渐变的 绿色从浅到深再到浅
float plot(vec2 st, float y){ 
    // return 0.1;
    // return step(0.4, st.y);
    // return smoothstep(0.1, 0.3, st.y);    

    //截面不渐变的曲线
    // return step(y-lineWidth, st.y) - step(y+lineWidth, st.y);


    //截面渐变的曲线
    return  smoothstep( y-lineWidth, y, st.y) -
          smoothstep( y, y+lineWidth, st.y);
}

void main() {
    vec2 st = gl_FragCoord.xy/u_resolution;

    // Smooth interpolation between 0.1 and 0.9
    float y = smoothstep(0.1,0.9,st.x);// 当x的在[0.1,0.9]范围时 y是缓慢变化

    // float y = smoothstep(0.4,0.9,st.x);

    vec3 color = vec3(y);

    float pct = plot(st, y);  //plot(st, st.x)  返回 y=x图像

    // float pct = plot(st, 0.5);    
    
    // color = (1.0-pct)*color + pct*vec3(0.0,1.0,0.0);
    color = pct*vec3(0.0,1.0,0.0);

    gl_FragColor = vec4(color,1.0);
}


//ps  此外还有更多step 函数
// 参考 https://thebookofshaders.com/05/   Advance shaping functions
