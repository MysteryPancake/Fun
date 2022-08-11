// Available at https://www.shadertoy.com/view/st3cRX
void mainImage(out vec4 fragColor, in vec2 fragCoord) {

	vec2 uv = fragCoord / iResolution.xy;

	const vec3 target = vec3(0.0, 1.0, 0.0); // Find green
	const float threshold = 0.5; // Controls target color range
	const float softness = 0.1; // Controls linear falloff

	const int steps = 64;
	const float total = float(steps) / 6.28318530;
	
	fragColor = texture(iChannel0, uv);
	
	for (int i = 0; i < steps; i++) {
		// Sample image in a circular pattern
		float j = float(i) / total;
		vec4 col = texture(iChannel0, uv + vec2(sin(j), cos(j)) * 0.1);
		
		// Get difference to use for falloff if required
		float diff = distance(col.xyz, target.xyz) - threshold;
		
		// Apply linear falloff if needed, otherwise clamp
		fragColor = max(fragColor, col * clamp(diff / softness, 0.0, 1.0));
	}
}