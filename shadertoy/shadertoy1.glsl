// https://gamedevelopment.tutsplus.com/tutorials/a-beginners-guide-to-coding-graphics-shaders--cms-23313

//https://www.shadertoy.com/new




//下面的代码适用于 VSCode 的 ShaderToy
//全局变量和 ShaderToy.com 略有不同
//iResolution, iGlobalTime, and iDeltaTime, iChannelN are the only uniforms provided.

void main()
{
	vec2 uv = gl_FragCoord.xy ;


    //对角线
    vec4 fragColor = vec4( uv.x, uv.y, sin(iGlobalTime),1.0);

    vec4 solidRed = vec4( iResolution.x / iResolution.y * (uv.y/uv.x), 0.0,0.0,1.0);
    gl_FragColor = solidRed;

}

//对应 shadertoy.com 的代码是这样的
// void mainImage( out vec4 fragColor, in vec2 fragCoord )
// {
// 	vec2 uv = fragCoord.xy ;

//     fragColor = vec4(sin(cos(iTime)),sin(iTime),cos(iTime), 0.5);
//     fragColor = vec4( uv.x, uv.y, sin(iTime),1.0);

//     vec4 solidRed = vec4( iResolution.x / iResolution.y * (uv.y/uv.x), 0.0,0.0,1.0);

//     fragColor = solidRed;

// }