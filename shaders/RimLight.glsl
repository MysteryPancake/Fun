// Available at https://www.shadertoy.com/view/fttyz2
void mainImage(out vec4 fragColor, in vec2 fragCoord) {

	vec2 uv = fragCoord / iResolution.xy;
	
	float circle = 1.0 - distance(uv - 0.5, vec2(sin(iTime) * 0.5, cos(iTime) * 0.5));
	float lightStrength = 0.75 + sin(iTime * 5.0) * 0.25;
	vec2 offset = vec2(sin(iTime), cos(iTime)) * 0.01 * lightStrength;

	vec3 target = vec3(0.0, 1.0, 0.0); // Find green
	vec3 background = vec3(circle * lightStrength, 0.0, 0.1); // Replace with background
	vec3 light = vec3(1.0, 0.0, 0.0); // Red light color

	float threshold = 0.7; // Controls target color range
	float softness = 0.1; // Controls linear falloff
	
	// Background color key
	vec4 col = texture(iChannel0, uv);
	float diff = distance(col.xyz, target.xyz) - threshold;
	float factor = clamp(diff / softness, 0.0, 1.0);

	// Same color key with an offset for the edge
	vec4 colOffset = texture(iChannel0, uv + offset);
	float diffOffset = distance(colOffset.xyz, target.xyz) - threshold;
	float lightFactor = 1.0 - clamp(diffOffset / softness, 0.0, 1.0);
	
	// Color correction for fun
	col.xyz *= vec3(1.0, 0.7, 0.9);

	fragColor = vec4(mix(background, col.xyz + light * lightFactor, factor), col.a);
}