// Based on a shader by FMS_Cat.
// https://www.shadertoy.com/view/XtBXDt
// Modified to support OpenFL.

#pragma header
#define PI 3.14159265

uniform float time;
float gaussianWeight[7] = {0.015625, 0.09375, 0.234375, 0.3125, 0.234375, 0.09375, 0.015625};

vec3 tex2D(sampler2D _tex,vec2 _p)
{
    if(_p.x<0.){
        _p.x+=1.;
    }else if(_p.x>1.){
        _p.x-=1.;
    }
    vec3 col=texture(_tex,_p).xyz;
    if(.5<abs(_p.x-.5)){
        col=vec3(.1);
    }
    return col;
}

void main()
{
    vec2 uv=openfl_TextureCoordv;
    vec3 col=tex2D(bitmap,uv);
    
    for(int x=-3;x<=3;x+=1){
        for(int y=-3;y<=3;y+=1){
        col.xyz+=tex2D(bitmap,uv+vec2(x,y)*1E-3).xyz*gaussianWeight[x+3]*gaussianWeight[y+3];
        }
    }

    //float values can go up to 2.0, so tone mapping is required
    col.xyz = 1. - (1. - col.xyz/2)*(1. - col.xyz/2);
    
    gl_FragColor=vec4(col,1.);
}