// Available at https://www.shadertoy.com/view/dlfGDB

const float TAU = 6.28318530;

float getAlpha(vec3 col) {
	const vec3 green = vec3(0.0, 1.0, 0.0);
	return smoothstep(0.6, 0.7, distance(col, green));
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {

	const float dirSteps = 32.0;
	const float radiusSteps = 16.0;
	
	// Shrink factor, change with mouse
	float radius = iMouse.z > 0.0 ? length(iMouse.xy / iResolution.xy - 0.5) : 0.1;
	
	vec2 uv = fragCoord / iResolution.xy;
	vec3 bg = vec3(uv.x, 1.0 - uv.y, 1.0) + smoothstep(0.4, 0.6, length(uv - 0.5));
	
	fragColor = texture(iChannel0, uv);
	float alpha = getAlpha(fragColor.rgb);
	
	// Correct aspect ratio
	vec2 texSize = vec2(textureSize(iChannel0, 0));
	vec2 aspect = vec2(texSize.y / texSize.x, 1.0);
	
	// STEP 1: Find average direction away from edge
	
	vec2 dirSum = vec2(0.0);
	float total = 0.0;
	
	for (float i = 0.0; i < TAU; i += TAU / dirSteps) {
		// Move in a circle to find edges within radius
		vec2 dir = vec2(sin(i), cos(i));
		vec4 col = texture(iChannel0, uv + dir * aspect * radius);
		
		// Edge was found, accumulate for average
		if (alpha > getAlpha(col.rgb)) {
			dirSum += dir;
			total++;
		}
	}
	
	// No edges within radius
	if (total <= 0.0) {
		fragColor.rgb = mix(bg, fragColor.rgb, alpha);
		return;
	}
	
	// Calculate average direction
	dirSum = normalize(dirSum / total);

	// STEP 2: Raycast in average direction until an edge is hit
	
	float minD = radius / radiusSteps;
	float d = minD;
	for (; d < radius; d += minD) {
		vec4 col = texture(iChannel0, uv + dirSum * aspect * d);
		// Raycast success, edge was found
		if (alpha > getAlpha(col.rgb)) break;
	}
	
	// Distort the image
	fragColor = texture(iChannel0, uv + dirSum * aspect * (radius - d));
	fragColor.rgb = mix(bg, fragColor.rgb, getAlpha(fragColor.rgb));
}