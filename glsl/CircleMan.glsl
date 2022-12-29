// Available at https://www.shadertoy.com/view/st3cRX

void mainImage(out vec4 fragColor, in vec2 fragCoord) {

	const vec3 target = vec3(0.0, 1.0, 0.0); // Find green
	const float TAU = 6.28318530;
	const float steps = 64.0;
	
	float radius = iMouse.z > 0.0 ? length(0.5 - iMouse.xy / iResolution.xy) : sin(iTime * 4.0) * 0.05 + 0.05;
	vec2 uv = fragCoord / iResolution.xy;
	
	// Correct aspect ratio
	vec2 texSize = vec2(textureSize(iChannel0, 0));
	vec2 aspect = vec2(texSize.y / texSize.x, 1.0);
	
	fragColor = texture(iChannel0, uv);
	for (float i = 0.0; i < TAU; i += TAU / steps) {
		// Sample image in a circular pattern
		vec2 offset = vec2(sin(i), cos(i)) * aspect * radius;
		vec4 col = texture(iChannel0, uv + offset);
		
		// Mix circles with background
		float alpha = smoothstep(0.5, 0.7, distance(col.rgb, target));
		fragColor = max(fragColor, col * alpha);
	}
}