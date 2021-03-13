
// Space Gif by Martijn Steinrucken aka BigWings - 2019
// Email:countfrolic@gmail.com Twitter:@The_ArtOfCode
// License Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.
// Original idea from:
// https://boingboing.net/2018/12/20/bend-your-spacetime-continuum.html
//
// To see how this was done, check out this tutorial:
// https://youtu.be/cQXAbndD5CQ
//

float Xor(float a, float b) {
    return a*(1.-b) + b*(1.-a);
}
void mainImage( out vec4 fragColor, in vec2 fragCoord )
{

    vec2 uv = (fragCoord.xy-iResolution.xy*.5)/iResolution.y;
	
    // uv *= mat2(.707, -.707, .707, .707);
    uv *= 15.;
    
    vec2 gv = fract(uv)-.5; 
	vec2 id = floor(uv);
    float col = 0.;
	float m = 0.;
    float t;
    for(float y=-1.; y<=1.; y++) {
    	for(float x=-1.; x<=1.; x++) {
            vec2 offs = vec2(x, y);
            float d = length(gv + offs);
            t = -iTime+length(id-offs)*.2;
            float r = mix(.5, .8, sin(t)*.5+.5);
    		float c = smoothstep(r, r*.9, d);
            m = Xor(m ,c);
    		// m = m*(1.-c) + c*(1.-m);
        }
    }
    col += mod(m, 2.);

    fragColor = vec4(col);
}