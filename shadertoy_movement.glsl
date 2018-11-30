// https://gamedevelopment.tutsplus.com/tutorials/a-beginners-guide-to-coding-graphics-shaders--cms-23313
void main()
{
    vec4 fragColor = gl_FragColor;
    vec4 fragCoord = gl_FragCoord;

    vec2 xy = gl_FragCoord.xy / iResolution.xy; // Condensing this into one line

    vec4 texColor = texture2D(iChannel0,xy); // Get the pixel at xy from iChannel0
    texColor.r *= abs(sin(iGlobalTime));
    texColor.g *= abs(cos(iGlobalTime));
    texColor.b *= abs(sin(iGlobalTime) * cos(iGlobalTime));
    fragColor = texColor; // Set the screen pixel to that color

    gl_FragColor = fragColor;
}