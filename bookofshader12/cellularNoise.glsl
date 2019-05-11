// Author: @patriciogv
// Title: 4 cells DF

#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

vec2 random2(vec2 p){
    return fract(sin(vec2(dot(p,vec2(127.1,311.7)),dot(p,vec2(269.5,183.3))))*43758.5453);
}

const int checkerboard=3;
float scale=float(checkerboard);
float cellscale = 0.4; //值越大 细胞大小越小
void main(){

    // vec2 offset = vec2(-1.,0);

    vec3 color=vec3(.0);
    vec2 st=gl_FragCoord.xy/u_resolution.xy;
    st*=scale;
    // st = st + offset;
    vec2 ipos=floor(st);
    vec2 fpos=fract(st);


    vec2 mouseponter = u_mouse/u_resolution*scale;
    

    // Tile the space
    vec2 i_st=floor(st);
    vec2 f_st=fract(st);

    float m_dist=1.;// minimun distance
    vec2 m_point;// minimum point

    for(int j=-1;j<=checkerboard;j++){
        for(int i=-1;i<=checkerboard;i++){
            vec2 point=vec2(float(i),float(j));
            vec2 radPoint = random2(vec2(float(i),float(j)));
            point = point + radPoint;
            // vec2 point=random2(i_st+point);
            // vec2 diff=point+point-f_st;
            // float dist=length(diff);
            // point+= random2(0.1 * sin(u_time+point))/2.;
            point+=.5*sin(u_time+6.2831*point); 
            float dist=distance(st,point);
            
            if(dist<m_dist){
                m_dist=dist;
                // m_point=point;
            }
        }
    }    

    
    // Draw the min distance (distance field)
    // color=vec3(m_dist);//值越大 表示距离越远 亮度越高
    color += m_dist;
    
    // Show isolines
    // sin(100 * ...)  //增加变化的频率 表现为更密的变化
    // color = vec3(step(.7,(sin(100.0*m_dist))) );
    // color-=step(.8,abs(sin(100.*m_dist)));
    
    gl_FragColor=vec4(color,1.);
}