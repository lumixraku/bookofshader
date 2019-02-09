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

    vec2 r=abs(st.xy);
    float s=max(abs(st.x),abs(st.y));




    // step(.4,s) 当 s > 0.4时
    // step(s,.5) 当 s < 0.5时
    // 这两个step相乘 表示且
    vec4 f=vec4(vec3(step(.4,s)* step(s,.5)),1.);
    gl_FragColor = f;
}