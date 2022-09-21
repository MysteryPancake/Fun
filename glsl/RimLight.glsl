// Available at https://www.shadertoy.com/view/fttyz2
void mainImage(out vec4 fragColor, in vec2 fragCoord) {

	vec2 uv = fragCoord / iResolution.xy;
	
	vec2 orbit = vec2(sin(iTime), cos(iTime));
	float circle = 1.0 - distance(uv - 0.5, orbit * 0.5);
	float lightStrength = 0.75 + sin(iTime * 5.0) * 0.25;
	vec2 offset = orbit * lightStrength * 0.01;

	vec3 target = vec3(0.0, 1.0, 0.0); // Find green
	vec3 light = vec3(1.0, 0.5, 0.0); // Orange light color
	vec3 background = vec3(0.0, 0.0, 0.1) + circle * lightStrength * light;

	float threshold = 0.7; // Controls target color range
	float softness = 0.1; // Controls linear falloff
	
	// Background color key
	vec4 col = texture(iChannel0, uv);
	float diff = distance(col.xyz, target) - threshold;
	float factor = clamp(diff / softness, 0.0, 1.0);

	// Same color key with an offset for the edge
	vec4 colOffset = texture(iChannel0, uv + offset);
	float diffOffset = distance(colOffset.xyz, target) - threshold;
	float lightFactor = 1.0 - clamp(diffOffset / softness, 0.0, 1.0);
	
	// Color correction for fun
	col.xyz *= vec3(1.0, 0.7, 0.9);

	fragColor = vec4(mix(background, col.xyz + light * lightFactor, factor), col.a);
}