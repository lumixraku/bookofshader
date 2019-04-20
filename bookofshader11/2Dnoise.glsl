#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

// 2D Random
float random(in vec2 st){
    return fract(sin(dot(st.xy,
            vec2(12.9898,78.233)))
        *43758.5453123);
}

float randomSin(in vec2 st){
    return fract(sin(u_time * dot(st.xy,
                vec2(12.9898,78.233)))
            *43758.5453123);
}
    
// 2D Noise based on Morgan McGuire @morgan3d
// https://www.shadertoy.com/view/4dS3Wd
float noise(in vec2 st){
    vec2 i=floor(st);
    vec2 f=fract(st);
    
    // Four corners in 2D of a tile
    float a=random(i);
    float b=random(i+vec2(1.,0.));
    float c=random(i+vec2(0.,1.));
    float d=random(i+vec2(1.,1.));


    // float a=randomSin(i);
    // float b=randomSin(i+vec2(1.,0.));
    // float c=randomSin(i+vec2(0.,1.));
    // float d=randomSin(i+vec2(1.,1.));    
    
    // Smooth Interpolation
    
    // Cubic Hermine Curve.  Same as SmoothStep()
    vec2 u=f*f*(3.-2.*f);
    u = smoothstep(0.,1.,f);
    
    // Mix 4 coorners percentages
    // return mix(a,b,u.x);
    // return mix(c,d,u.x);
    // return mix(a,c,u.y);
    // return mix(b,d,u.y);


    // return mix((c-a),(d-b),u.x);
    // return mix((a-c),(b-d),u.y)*u.x; 
            //  c       d
            //  +-------+
            //  |       |
            //  |       |
            //  |       |
            //  +-------+
            //  a       b

    return mix(a,b,u.x) + 
    +mix((c-a),(d-b),u.x)*u.y;
}

void main(){
    vec2 st=gl_FragCoord.xy/u_resolution.xy;
    
    // Scale the coordinate system to see
    // some noise in action
    vec2 pos=vec2(st*5.);

    // vec2 pos=sin(u_time) * vec2(st*5.);
    
    // Use the noise function
    float n=noise(pos);
    
    gl_FragColor=vec4(vec3(n),1.);
}
        