// Author: @patriciogv
// Title: 4 cells DF
#define PI 3.14159265359
#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

vec2 point[10];

void main(){

    point[1]=vec2(abs(sin(u_time*PI/5.)),.75);
    point[2]=vec2(0.25, abs(sin(u_time*PI/5.)));
    point[3]=vec2(abs(cos(u_time*PI/5.)),.25);
    point[4]=vec2(0.25,abs(cos(u_time*PI/5.)));
point[5]=vec2(.25,abs(sin(u_time*PI/5.)));
point[6]=vec2(abs(cos(u_time*PI/5.)),.25);
point[7]=vec2(.25,abs(cos(u_time*PI/5.)));
point[8]=vec2(abs(sin(u_time*PI/5.)),.75);
point[9]=vec2(abs(cos(u_time*PI/5.)),.25);

    vec2 st=gl_FragCoord.xy/u_resolution.xy;
    // st = st * 2. -1.;
    st*=3.;
    vec3 color=vec3(.0);
    vec2 ipos=floor(st);
    vec2 fpos=fract(st);
    int idx = 1;
    for(int x=0;x<3; x++){
        for(int y=0;y<3; y++){
            if(ipos.x==float(x) && ipos.y==float(y)){
                float dist=distance(fpos,point[x+y+1]);
                color=vec3(dist);
                idx = idx + 1;
            }
        }
    }
// if(ipos.x == 0. && ipos.y == 0.){
//     // color = vec3(1.,1.,1.);

// }
// if(ipos.x==0.&&ipos.y==1.){
//     // color = vec3(1.,1.,1.);
//     float dist=distance(fpos,point[2]);
//     color=vec3(dist);
// }
// if(ipos.x==1.&&ipos.y==0.){
//     // color = vec3(1.,1.,1.);
//     float dist=distance(fpos,point[3]);
//     color=vec3(dist);
// }
// if(ipos.x==1.&&ipos.y==1.){
//     // color = vec3(1.,1.,1.);
//     float dist=distance(fpos,point[4]);
//     color=vec3(dist);
// }
    
    // float dist=distance(st,point);
    // color = vec3(dist);

    gl_FragColor=vec4(color,1.);
}