#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359

uniform vec2 u_resolution;
uniform float u_time;


void main() {
float x = 0.7;//1.2
float y = 0;

// return x modulo of 0.5 
y = mod(x,0.5); //  对 x 取模运算 当 x 0.7  1.2 。。得到的结果一样

// 仅返回数字的小数部分
//y = fract(x); // return only the fraction part of a number


//y = ceil(x);  // nearest integer that is greater than or equal to x
//y = floor(x); // nearest integer less than or equal to x
//y = sign(x);  // extract the sign of x
//y = abs(x);   // return the absolute value of x

// 限定最大值 最小值 约束x介于0.0和1.0之间
//y = clamp(x,0.0,1.0); // constrain x to lie between 0.0 and 1.0
//y = min(0.0,x);   // return the lesser of x and 0.0
//y = max(0.0,x);   // return the greater of x and 0.0 


vec3 color = vec3(y);
gl_FragColor = vec4(color,1.0);
}