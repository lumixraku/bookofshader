// Author @patriciogv - 2015
// http://patriciogonzalezvivo.com

#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

float random(vec2 st){
    return fract(sin(dot(st.xy,
            vec2(123.9898,2347.233)))*
            1231234.5423);
}

float randomByMouse(vec2 st, vec2 u_mouse){
    return fract(sin(dot(st.xy*u_mouse,
            vec2(123.9898,2347.233)))*
        1231234.5423);
}

void main(){
    vec2 st=gl_FragCoord.xy/u_resolution.xy;
    
    // float rnd=random(st);
    float rnd2=randomByMouse(st, u_mouse);
    
    gl_FragColor=vec4(vec3(rnd2),1.);
}