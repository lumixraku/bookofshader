// Author @patriciogv - 2015
// http://patriciogonzalezvivo.com

#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

void main(){
    float blur = 0.2;
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    // glsl的笛卡尔坐标系从原点在左下角  右上角是(1,1)

    vec3 color = vec3(0.0);
 
    vec2 pos = vec2(0.5)-st; // 将原点移动到画布正中心
    pos.x = pos.x + 0.05;// 默认有点偏左

    // 首先将笛卡尔坐标系转为 极坐标  用length 得到极坐标的r 用arctan得到极坐标的θ
    float r = length(pos)*2.0; //r的长度为实际值的2倍 这使得后面使用step的时候感觉是在一个(-2,2)的画布上
    float angle = atan(pos.y,pos.x);  // 通过arctan 求出角度

    float f = cos(angle*3.); // *3表示3个半圆
    // f = abs(cos(angle*3.));
    // f = abs(cos(angle*2.5))*.5+.3;
    f = abs(cos(angle*12.)*sin(angle*3.))*.8+.1;
    // f = smoothstep(-.5,1., cos(angle*10.))*0.2+0.5;

    // step() 阶跃函数  step(x, v)  当 v > x 返回1  否则0 
    // 设置 f = cos(angle*1.); 感受下step的变化
    color = vec3( step(0.4,r) );
    color = vec3( step(f,0.71) ); //θ接近45° //google 搜索 cos 45degree得到 0.7


    color = vec3( step(f,r) );
    color = vec3( 1.-smoothstep(f,f+blur,r) );

    gl_FragColor = vec4(color, 1.0);
}
