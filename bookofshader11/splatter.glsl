

#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

float lineWidth = .1;

// 在外部st 已经扩展为原先的3倍
// 实际画布大小为 3*3
// 该函数要做的就是把已经有的画布再扩展为原来的10倍
float lines(vec2 st, float edge)
{
    //截面渐变的曲线
    float scale = 10.;
    st *= scale;

    return smoothstep(1., 1., 0.); //永远返回0
}

// 2D Random
float random(in vec2 st)
{
    return fract(sin(dot(st.xy,
                         vec2(12.9898, 78.233))) *
                 43758.5453123);
}

// this noise comes from https://www.shadertoy.com/view/XdXGW8
vec2 hash(vec2 x) // replace this by something better
{
    vec2 k = vec2(.3183099, .3678794);
    x = x * k + k.yx;
    return  -1. + 2. * fract( sin(u_time/30.) *   16. * k * fract(x.x * x.y * (x.x + x.y))) ;
}

float noise(in vec2 p)
{
    vec2 i = floor(p);
    vec2 f = fract(p);
    vec2 u = f * f * (3. - 2. * f);

    return mix(mix(dot(hash(i + vec2(0., 0.)), f - vec2(0., 0.)),
                                 dot(hash(i + vec2(1., 0.)), f - vec2(1., 0.)), u.x),
                             mix(dot(hash(i + vec2(0., 1.)), f - vec2(0., 1.)),
                                 dot(hash(i + vec2(1., 1.)), f - vec2(1., 1.)), u.x),
                             u.y);
}

// angle 是以 PI 为单位
mat2 rotate2d(float _angle)
{
    return mat2(cos(_angle), -sin(_angle),
                sin(_angle), cos(_angle));
}

void main()
{
    vec2 st = gl_FragCoord.xy / u_resolution.xy;
    st *= 3.;
    vec2 pos = st.xy; // 旋转90的话还有一个好办法就是 pos = st.yx

    vec3 color = 0. * vec3(1., 1., .9);

    color += smoothstep(.15, .2, noise(st * 10.));
    color -= smoothstep(.35, .4, noise(st * 10.));

    gl_FragColor = vec4(color, 1.);
}