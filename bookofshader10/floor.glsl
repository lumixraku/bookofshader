// Author @patriciogv - 2015
// Title: Mosaic

#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

float random(vec2 st){
    return fract(sin(dot(st.xy,
            vec2(123423.9898,78.233)))*
        458.543);
    }

float randomByMouse(vec2 st, vec2 m){
    return fract(sin(dot(st.xy*m,
                vec2(123423.9898,78.233)))*
            458.543);
        }    
        
void main(){
    vec2 st=gl_FragCoord.xy/u_resolution.xy;
    
    st*=10.;// Scale the coordinate system by 10
    vec2 ipos=floor(st);// get the integer coords
    vec2 fpos=fract(st);// get the fractional coords
    
    // Assign a random value based on the integer coord
    vec3 color=vec3(random(ipos));
    
    // Uncomment to see the subdivided grid
    color = vec3(random(fpos),random(fpos),random(fpos));
    color=vec3(randomByMouse(fpos, u_mouse),randomByMouse(fpos,u_mouse),randomByMouse(ipos,u_mouse));
    
    gl_FragColor=vec4(color,1.);
}