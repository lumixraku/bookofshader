// Author @patriciogv - 2015
// http://patriciogonzalezvivo.com

#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

float plot(vec2 st, float y){

    // 画线 一般都是两个函数相减
    return step(y - 0.01, st.y) - step(y , st.y);
}

void main(){
    vec3 color = vec3(0);
    vec2 st = gl_FragCoord.xy/u_resolution.xy;


    // 坐标起始点是左下角 因此要加个0.5 将图像移动到Y方向的中间
    float y =  0.3 * cos(st.x * 29.) + 0.5;
    float pct = plot(st, y);
    color = vec3(pct) * vec3(1,1,1);

    gl_FragColor = vec4(color, 1.0);
}
