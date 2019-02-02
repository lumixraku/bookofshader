// Author @patriciogv - 2015
// http://patriciogonzalezvivo.com

#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

// 关于smoothstep https://en.wikipedia.org/wiki/Smoothstep
// float smoothstep(float edge0, float edge1, float x) {}  表示 x在 edge0 edge1 这个范围内 y将会平缓变化
// 不再此范围 y 则取极值


// dot 是一种很有效的将向量转为标量的方法
// 这里 dot(dist,dist) 是两个相同的向量做dot 那么得到的结果是这个向量长度的平方

float circle(in vec2 _st, in float _radius){
    vec2 dist = _st-vec2(0.5);
	return smoothstep(_radius-(_radius*0.6),
                         _radius+(_radius*0.6),
                         dot(dist,dist)*4.0);
}

void main(){
	vec2 st = gl_FragCoord.xy/u_resolution.xy;
	vec3 color = vec3(circle(st,0.9));
	gl_FragColor = vec4( color, 1.0 );
}
