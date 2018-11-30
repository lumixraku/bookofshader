#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

vec3 colorA = vec3(0.149,0.141,0.912); //blue
vec3 colorB = vec3(1.000,0.833,0.224);  // yellow

void main() {
    vec3 color = vec3(0.0);
    float pct = abs(sin(u_time));
    
    // Mix uses pct (a value from 0-1) to
    // mix the two colors
    color = mix(colorA, colorB, pct); //AB之间的slider  值越大 颜色B越多

    // gl_FragColor = vec4(color,1.0);
    gl_FragColor = vec4(color, 1.0);
}

//version of shadertoy ========

// #ifdef GL_ES
// precision mediump float;
// #endif
// vec3 colorA = vec3(0.149,0.141,0.912); //blue
// vec3 colorB = vec3(1.000,0.833,0.224);  // yellow

// void mainImage(out vec4 fragColor, in vec2 fragCoord) {
//     vec3 color = vec3(0.0);
//     float pct = abs(sin(iTime));
    
//     // Mix uses pct (a value from 0-1) to
//     // mix the two colors
//     color = mix(colorA, colorB, pct); //AB之间的slider  值越大 颜色B越多

//     // gl_FragColor = vec4(color,1.0);
//     fragColor = vec4(color, 1.0);
// }