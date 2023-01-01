// Available at https://www.shadertoy.com/view/sltcRf

void mainImage(out vec4 fragColor, in vec2 fragCoord) {

	const vec3 target = vec3(0.0, 1.0, 0.0); // Find green
	const float TAU = 6.28318530;
	const float steps = 32.0;
	
	float radius = iMouse.z > 0.0 ? length(0.5 - iMouse.xy / iResolution.xy) * 100.0 : sin(iTime * 4.0) * 20.0 + 20.0;
	vec2 uv = fragCoord / iResolution.xy;
	
	// Correct aspect ratio
	vec2 aspect = 1.0 / vec2(textureSize(iChannel0, 0));
	
	fragColor = vec4(uv.y, 0.0, uv.x, 1.0);
	for (float i = 0.0; i < TAU; i += TAU / steps) {
		// Sample image in a circular pattern
		vec2 offset = vec2(sin(i), cos(i)) * aspect * radius;
		vec4 col = texture(iChannel0, uv + offset);
		
		// Mix outline with background
		float alpha = smoothstep(0.5, 0.7, distance(col.rgb, target));
		fragColor = mix(fragColor, vec4(1.0), alpha);
	}
	
	// Overlay original video
	vec4 mat = texture(iChannel0, uv);
	float factor = smoothstep(0.5, 0.7, distance(mat.rgb, target));
	fragColor = mix(fragColor, mat, factor);
}