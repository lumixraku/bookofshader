

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
    return -1. + 2. * fract(16. * k * fract(x.x * x.y * (x.x + x.y)));
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



// Some useful functions
vec3 mod289(vec3 x){return x-floor(x*(1./289.))*289.;}
vec2 mod289(vec2 x){return x-floor(x*(1./289.))*289.;}
vec3 permute(vec3 x){return mod289(((x*34.)+1.)*x);}

float snoise(vec2 v)
{

    // Precompute values for skewed triangular grid
    const vec4 C = vec4(.211324865405187,
                        // (3.0-sqrt(3.0))/6.0
                        .366025403784439,
                        // 0.5*(sqrt(3.0)-1.0)
                        -.577350269189626,
                        // -1.0 + 2.0 * C.x
                        .024390243902439);
    // 1.0 / 41.0

    // First corner (x0)
    vec2 i = floor(v + dot(v, C.yy));
    vec2 x0 = v - i + dot(i, C.xx);

    // Other two corners (x1, x2)
    vec2 i1 = vec2(0.);
    i1 = (x0.x > x0.y) ? vec2(1., 0.) : vec2(0., 1.);
    vec2 x1 = x0.xy + C.xx - i1;
    vec2 x2 = x0.xy + C.zz;

    // Do some permutations to avoid
    // truncation effects in permutation
    i = mod289(i);
    vec3 p = permute(
        permute(i.y + vec3(0., i1.y, 1.)) + i.x + vec3(0., i1.x, 1.));

    vec3 m = max(.5 - vec3(
                          dot(x0, x0),
                          dot(x1, x1),
                          dot(x2, x2)),
                 0.);

    m = m * m;
    m = m * m;

    // Gradients:
    //  41 pts uniformly over a line, mapped onto a diamond
    //  The ring size 17*17 = 289 is close to a multiple
    //      of 41 (41*7 = 287)

    vec3 x = 2. * fract(p * C.www) - 1.;
    vec3 h = abs(x) - .5;
    vec3 ox = floor(x + .5);
    vec3 a0 = x - ox;

    // Normalise gradients implicitly by scaling m
    // Approximation of: m *= inversesqrt(a0*a0 + h*h);
    m *= 1.79284291400159 - .85373472095314 * (a0 * a0 + h * h);

    // Compute final noise value at P
    vec3 g = vec3(0.);
    g.x = a0.x * x0.x + h.x * x0.y;
    g.yz = a0.yz * vec2(x1.x, x2.x) + h.yz * vec2(x1.y, x2.y);
    return 130. * dot(m, g);
}

// angle 是以 PI 为单位
mat2 rotate2d(float _angle)
{
    return mat2(cos(_angle), -sin(_angle),
                sin(_angle), cos(_angle));
}

vec2 randomDeltaPosition(vec2 pos)
{
    float a = noise(pos * vec2(cos(u_time * 1.), sin(u_time * 1.)) * .1) * PI;
    return vec2(cos(a), sin(a));
}

void main()
{

    vec2 st = gl_FragCoord.xy / u_resolution.xy;
    st *= 8.0;
    vec2 pos = st.xy; // 旋转90的话还有一个好办法就是 pos = st.yx
    
    float DF = 0.;

    vec2 vel=vec2(u_time*.1);
    pos = pos + vel;
    DF+=noise(st);
    
    pos = pos + randomDeltaPosition(pos);
    DF+=noise(pos)*.25+.25;


    vec3 color = vec3(0.);


    color=vec3(smoothstep(.15,.2,fract(DF)));
    // color += smoothstep(.15, .2, DF);
    // color -= smoothstep(.35, .4, DF);
    // color+=smoothstep(.15,.2,fract(DF)); // fract函数是返回值的小数部分
    // color-=smoothstep(.35,.4, fract(DF));



    gl_FragColor = vec4(color, 1.);
}
