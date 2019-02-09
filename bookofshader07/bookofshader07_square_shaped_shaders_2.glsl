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

    float r;
    r = dot(st.xy, st.xy);
    r = length(max( abs(st.xy) ,0.1 ));

    // r = step(0.9, r);
    gl_FragColor = vec4(r,r,r,1); ;
}