#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER

uniform sampler2D texture;
uniform vec2 texOffset;
uniform float time;
uniform float wobblysize;
uniform float wobblyspeed;
uniform float noiseSize;
uniform vec3 glowValue;
uniform float doInvert;
uniform float bw;
varying vec4 vertColor;
varying vec4 vertTexCoord;


vec2 wobblize(vec4 inp, float speed, float size){
	vec2 result;
	result.s = inp.s+ 0.005 * size * sin((time + inp.s*4*speed)*10);
	result.t = inp.t+ 0.005 *size * sin((time + inp.t*4*speed+1)*10);
	return result;
}
float rng(){
    return (0.5-fract(sin(dot(vec2(sin(time*vertTexCoord.s+vertTexCoord.t),cos(time*vertTexCoord.t+vertTexCoord.s)) ,vec2(12.9898,78.233))) * 43758.5453))*2;
}

vec2 noise(vec2 inp, float size){
	return vec2(inp.s+size*rng()*0.01,inp.t+size*rng()*0.01);
}
vec4 glow(vec4 orig,vec3 mult){
	return vec4(orig.xyz * mult,orig.w);
}
vec4 invert(vec4 col){
	return vec4(1.0-col.rgb,col.w);
}
vec4 toBW(vec4 col,float mult){
	vec3 mean = vec3(col.r+ col.g + col.b)/3.0;
	return vec4(mean*mult+col.rgb*(1.0-mult),col.w);
}
void main() {

  vec2 tc = noise(wobblize(vertTexCoord,wobblyspeed,wobblysize),noiseSize);
  vec4 col = toBW(glow(texture2D(texture, tc),glowValue), bw);
  if (doInvert>0.01){
  	col = invert(col);
  }


  gl_FragColor = col;  
}
