// Available at https://www.shadertoy.com/view/NtVyzh
void mainImage(out vec4 fragColor, in vec2 fragCoord) {

	vec2 uv = fragCoord / iResolution.xy;
	fragColor = vec4(0.0);

	const vec3 target = vec3(0.0, 1.0, 0.0); // Find green
	const float threshold = 0.5; // Controls target color range
	const float softness = 0.3; // Controls linear falloff

	const float steps = 64.0;
	for (float i = 0.0; i < steps; i++) {

		float percent = i / steps;
		vec2 offset = vec2(sin(iTime * 8.0 - uv.y * 24.0) * percent * 0.15, percent);

		// Color key
		vec4 col = texture(iChannel0, uv - offset * 0.5);
		float diff = distance(col.xyz, target) - threshold;
		float factor = clamp(diff / softness, 0.0, 1.0);

		// Tint
		vec4 tint = mix(col, vec4(0.0, 0.0, 1.0, 0.0), percent);

		fragColor = max(fragColor, tint * factor * (1.0 - percent));
	}
}