// Available at https://www.shadertoy.com/view/dlfGDB

const float TAU = 6.28318530;

float getAlpha(vec3 col) {
	const vec3 green = vec3(0.0, 1.0, 0.0);
	return smoothstep(0.6, 0.7, distance(col, green));
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {

	const float dirSteps = 32.0;
	
	// Shrink factor, change with mouse
	float radius = iMouse.z > 0.0 ? length(iMouse.xy / iResolution.xy - 0.5) * 500.0 : 30.0;
	
	vec2 uv = fragCoord / iResolution.xy;
	vec3 bg = vec3(uv.x, 1.0 - uv.y, 1.0) + smoothstep(0.4, 0.6, length(uv - 0.5));
	
	fragColor = texture(iChannel0, uv);
	float alpha = getAlpha(fragColor.rgb);
	
	// Correct aspect ratio
	vec2 aspect = 1.0 / vec2(textureSize(iChannel0, 0));
	
	// STEP 1: Find average direction away from edge
	
	vec2 dirAvg = vec2(0.0);
	for (float i = 0.0; i < TAU; i += TAU / dirSteps) {
		// Move in a circle to find edges within radius
		vec2 dir = vec2(sin(i), cos(i));
		vec4 col = texture(iChannel0, uv + dir * aspect * radius);
		// Edge was found, accumulate for average
		if (alpha > getAlpha(col.rgb)) dirAvg += dir;
	}
	
	// No edges within radius
	if (length(dirAvg) <= 0.0) {
		fragColor.rgb = mix(bg, fragColor.rgb, alpha);
		return;
	}
	
	// Calculate average direction
	dirAvg = normalize(dirAvg);

	// STEP 2: Raycast in average direction until an edge is hit
	
	float d = radius * 0.5;
	float move = d * 0.5;
	// Binary search works better than linear search
	for (int i = 0; i < 8; i++, move *= 0.5) {
		vec4 col = texture(iChannel0, uv + dirAvg * aspect * d);
		d += alpha > getAlpha(col.rgb) ? -move : move;
	}
	
	// Distort the image
	fragColor = texture(iChannel0, uv + dirAvg * aspect * (radius - d));
	fragColor.rgb = mix(bg, fragColor.rgb, getAlpha(fragColor.rgb));
}