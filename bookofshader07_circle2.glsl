// Author @patriciogv - 2015
// http://patriciogonzalezvivo.com

#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;


//dot = |a||b|cosx
float circle(in vec2 _st, in float _radius){
    vec2 dist = _st-vec2(0.5);
    float len = length(dist);
    //dot(dist,dist)*4.0 也可以替换成 len * len * 4

    // 1.  表示1.0
	return 1.-smoothstep(_radius-(_radius*0.01),
                         _radius+(_radius*0.01),
                         dot(dist,dist)*7.0);
}

void main(){
	vec2 st = gl_FragCoord.xy/u_resolution.xy;

	vec3 color = vec3(circle(st,0.9));

	gl_FragColor = vec4( color, 1.0 );
}