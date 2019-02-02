
void main()
{


    vec2 xy = gl_FragCoord.xy / iResolution.xy;//Condensing this into one line

    vec4 texColor = texture2D(iChannel0,xy);//Get the pixel at xy from iChannel0
    texColor = texColor * texColor * texColor; //图片叠加


    texColor.b = xy.x;
    // texColor = texColor * (1, 1, xy.x);

    gl_FragColor = texColor;


}