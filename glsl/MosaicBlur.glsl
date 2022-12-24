// Available at https://www.shadertoy.com/view/Nt3yRX
#define USE_SMOOTHSTEP

void mainImage(out vec4 fragColor, in vec2 fragCoord) {

	vec2 uv = fragCoord / iResolution.xy;
	float pixels = mod(iTime * 10.0, 50.0);
	
	vec2 rounded = floor(uv * pixels);
	vec4 topLeft = textureLod(iChannel0, rounded / pixels, 0.0);
	vec4 topRight = textureLod(iChannel0, (rounded + vec2(1.0, 0.0)) / pixels, 0.0);
	vec4 bottomLeft = textureLod(iChannel0, (rounded + vec2(0.0, 1.0)) / pixels, 0.0);
	vec4 bottomRight = textureLod(iChannel0, (rounded + vec2(1.0, 1.0)) / pixels, 0.0);
	
	vec2 fraction = fract(uv * pixels);
	#ifdef USE_SMOOTHSTEP
	fraction = smoothstep(0.0, 1.0, fraction);
	#endif
	
	vec4 top = mix(topLeft, topRight, fraction.x);
	vec4 bottom = mix(bottomLeft, bottomRight, fraction.x);
	fragColor = mix(top, bottom, fraction.y);
}