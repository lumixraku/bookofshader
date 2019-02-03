#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359

uniform vec2 u_resolution;
uniform float u_time;
float lineWidth = 0.05;
float plot(vec2 st, float pct){
  return  smoothstep( pct-lineWidth, pct, st.y) -
          smoothstep( pct, pct+lineWidth, st.y);
}

vec3 fromLeft2Right(vec2 st){
    // Step will return 0.0 unless the value is over 0.5,
    // in that case it will return 1.0
    // step() 阶跃函数  step(x, v)  当 v > x 返回1  否则0 
    // https://en.wikipedia.org/wiki/Heaviside_step_function
    float y = step(0.3,st.x);

    vec3 color = vec3(y);
    float pct = plot(st,y);
    

    color = (1.0-pct)*color+pct*vec3(0.0,1.0,0.0);


    return color;
}

vec3 fromBottom2Top(vec2 st){
    float x = step(0.3,st.y);

    vec3 color = vec3(x);
    float pct = plot(st,x);
    
    
    color = (1.0-pct)*color  +  pct*vec3(0.0,1.0,0.0);


    return color;    
}


void main() {
    vec2 st = gl_FragCoord.xy/u_resolution;
    // glsl的笛卡尔坐标系从原点在左下角  右上角是(1,1)
    
    // vec3 color = fromLeft2Right(st);
    vec3 color = fromBottom2Top(st);
    gl_FragColor = vec4(color,1.0);
}