/*
https://twitter.com/baldand
https://thndl.com/square-shaped-shaders.html
*/

#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

void main(){
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    st = st * 2.0 - 1.0;

    vec4 f;
    int N=7;
    float a=atan(st.x,st.y)+.2;
    float b=6.28319/float(N);
    f=vec4(vec3(smoothstep(.5,.51, cos(floor(.5+a/b)*b-a)*length(st.xy))),1.);

    gl_FragColor =f ;
}