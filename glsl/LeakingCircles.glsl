// Available at https://www.shadertoy.com/view/7lycWy
void mainImage(out vec4 fragColor, in vec2 fragCoord) {

	vec2 uv = fragCoord / iResolution.xy;
	vec2 noDistort = fragCoord / iResolution.x;
	
	float grid = length(fract(noDistort * 14.0) - 0.5);
	float radius = iTime * 0.03;
	float falloff = radius / length(uv - 0.5);
	float blurred = smoothstep(0.4, 0.6, falloff - grid);
	
	vec3 color = mix(vec3(uv.x, 0.0, uv.y), vec3(1.0), blurred);
	fragColor = vec4(color, 1.0);
}