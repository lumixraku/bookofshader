#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

vec3 colorA = vec3(0.149,0.141,0.912); //blue
vec3 colorB = vec3(1.000,0.833,0.224); //yellow


// plot 是和 pct y 有关的函数 G=(y, pct) 其中pct = f(x)
// 且 G会在一个st.y极小的范围上有>0的取值
float plot (vec2 st, float pct){
  return  smoothstep( pct-0.01, pct, st.y) -
          smoothstep( pct, pct+0.01, st.y);
}

void main() {
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    vec3 color = vec3(0.0);

    // vec3 pct = vec3(st.x, st.x/2.0, st.x/100.0);
    vec3 pct = vec3(st.x);

    pct.r = smoothstep(0.0,1.0, st.x);
    pct.g = sin(st.x*PI);
    pct.b = pow(st.x,0.5);

    color = mix(colorA, colorB, pct); //当PCT是一个vec时  是针对rgb三个分量做mix

    // Plot transition lines for each channel
	color = mix(color,vec3(1.0,0.0,0.0),plot(st,pct.r));
    color = mix(color,vec3(0.0,1.0,0.0),plot(st,pct.g));
    color = mix(color,vec3(0.0,0.0,1.0),plot(st,pct.b));

    gl_FragColor = vec4(color,1.0);
}
