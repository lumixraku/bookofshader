#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359

uniform vec2 u_resolution;
uniform float u_time;
float lineWidth = 0.2;
float plot(vec2 st, float pct){
  return  smoothstep( pct-lineWidth, pct, st.y) -
          smoothstep( pct, pct+lineWidth, st.y);
}

void main() {
    vec2 st = gl_FragCoord.xy/u_resolution;

    // Step will return 0.0 unless the value is over 0.5,
    // in that case it will return 1.0
    // step() 阶跃函数  step(x, v)  当 v > x 返回1  否则0 
    float y = step(0.3,st.x);

    vec3 color = vec3(y);

    float pct = plot(st,y);
    color = (1.0-pct)*color+pct*vec3(0.0,1.0,0.0);

    gl_FragColor = vec4(color,1.0);
}