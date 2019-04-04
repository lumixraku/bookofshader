// Author @patriciogv ( patriciogonzalezvivo.com ) - 2015

#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

#define PI 3.14159265358979323846

vec2 rotate2D(vec2 _st, float _angle){
    _st -= 0.5;
    _st =  mat2(cos(_angle),-sin(_angle),
                sin(_angle),cos(_angle)) * _st;
    _st += 0.5;
    return _st;
}

vec2 tile(vec2 _st, float _zoom){
    _st *= _zoom;
    return fract(_st);
}


// 一个方块汪汪是由2次对向的 smoothstep 组成 OR  step 组成
float box(vec2 _st, vec2 _size, float _smoothEdges){
    // 这是为了使图形在画布上居中 (画布坐标是从左下角开始) 
    _size = vec2(0.5)-_size*0.5;

    
    vec2 radiusVec = vec2(_smoothEdges*0.5);

    // 这是右上部分的白色区域
    vec2 uv = smoothstep(_size,_size+radiusVec,_st);

    // 这是和左下部分的白色区域相交
    uv *= smoothstep(_size,_size+radiusVec,vec2(1.0)-_st);

    //  uv.x 表示在 x 轴方向的有值  最终表达的是 x 在某一个取值上 有一段全部是白色
    //  uv.y 表示在 y 方向的值   两个取并集才能得到画布上四周都有黑色区域的方形   
    return uv.x*uv.y;
}

void main(void){
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    vec3 color = vec3(0.0);

    // Divide the space in 4
    st = tile(st,4.);

    // Use a matrix to rotate the space 45 degrees
    st = rotate2D(st,PI*0.25);

    // Draw a square
    // 因为是旋转45°之后显示  也就是说正方形的对角线长是1 
    // 因此边长为0.7
    color = vec3(   box(st,vec2(0.7),0.01) );
    // color = vec3(st,02.0);

    gl_FragColor = vec4(color,1.0);
}
