// Available at https://www.shadertoy.com/view/sltcRf
void mainImage(out vec4 fragColor, in vec2 fragCoord) {

	vec2 uv = fragCoord / iResolution.xy;

	const vec3 target = vec3(0.0, 1.0, 0.0); // Find green
	const float threshold = 0.6; // Controls target color range
	const float softness = 0.1; // Controls linear falloff

	const float steps = 32.0;
	const float total = steps / 6.28318530;
	float outlineSize = (1.0 + sin(iTime * 4.0)) * 0.01;
	
	// Apply linear color key
	vec4 mat = texture(iChannel0, uv);
	float diff = distance(mat.xyz, target.xyz) - threshold;
	float factor = clamp(diff / softness, 0.0, 1.0);

	fragColor = vec4(uv.y, 0.0, uv.x, 1.0);
	
	for (float i = 0.0; i < steps; i++) {
		// Sample image in a circular pattern
		float j = i / total;
		vec4 col = texture(iChannel0, uv + vec2(sin(j), cos(j)) * outlineSize);
		
		// Apply linear color key
		float diff2 = distance(col.xyz, target.xyz) - threshold;
		fragColor = mix(fragColor, vec4(1.0), clamp(diff2 / softness, 0.0, 1.0));
	}
	
	fragColor = mix(fragColor, mat, factor);
}