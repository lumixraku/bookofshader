#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;


vec3 implement1(vec2 st) {
    vec3 color = vec3(0.0);
    // Each result will return 1.0 (white) or 0.0 (black).
    float left = step(0.1,st.x);   // Similar to ( X greater than 0.1 )
    float bottom = step(0.1,st.y); // Similar to (if Y greater than 0.1 , then fn value is 1.0)
    // The multiplication of left*bottom will be similar to the logical AND.
    color = vec3( left * bottom );   // 因为只有 left bottom 都是1 结果才是1 一个为0 结果都是0 所以相当于逻辑与
    return color;
}


// 另一种实现 效果一样
vec3 implement2(vec2 st){
    vec3 color = vec3(0.0);
    vec2 lb = step(0.1,st);   // Similar to ( X greater than 0.1 )
    color = vec3(lb.s * lb.t);
    return color;
}

// 加上右上的黑边
vec3 implement3(vec2 st){
    vec3 color = vec3(0.0);
    vec2 lb = step(0.1,st);   // Similar to ( X greater than 0.1 )
    vec2 rt = vec2(1.0) - step(0.9, st);
    color = vec3(lb.s * lb.t);
    color = color * vec3(rt.s * rt.t);
    return color;
}

void main(){
    vec3 color = vec3(0.0);
    vec2 st = gl_FragCoord.xy/u_resolution.xy;  // 实际上是对每个分量分别运算 相当于 st =( coord.x/relu.x, coord.y/relu.y ）
    // color = implement1(st);
    color = implement3(st);




    gl_FragColor = vec4(color,1.0);
}