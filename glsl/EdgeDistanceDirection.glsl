// Available at https://www.shadertoy.com/view/mlj3Wd

const float TAU = 6.28318530;

float getAlpha(vec3 col) {
	const vec3 green = vec3(0.0, 1.0, 0.0);
	return step(0.7, distance(col, green));
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {

	const float dirSteps = 64.0;
	
	// Control radius with mouse
	float radius = iMouse.z > 0.0 ? iMouse.x / iResolution.x * 64.0 : sin(iTime * 4.0) * 8.0 + 16.0;
	
	vec2 uv = fragCoord / iResolution.xy;
	fragColor = texture(iChannel0, uv);
	float alpha = getAlpha(fragColor.rgb);
	
	// Correct aspect ratio
	vec2 aspect = 1.0 / vec2(textureSize(iChannel0, 0));
	
	// STEP 1: Find average direction away from edge
	
	vec2 dirAvg = vec2(0.0);
	bool interior = false;
	
	for (float i = 0.0; i < TAU; i += TAU / dirSteps) {
		// Move in a circle to find edges within radius
		vec2 dir = vec2(sin(i), cos(i));
		vec4 col = texture(iChannel0, uv + dir * aspect * radius);
		
		// Edge was found, accumulate for average
		float neighbor = getAlpha(col.rgb);
		if (alpha != neighbor) {
			dirAvg += dir;
			interior = alpha > neighbor;
		}
	}
	
	// No edges within radius
	if (length(dirAvg) <= 0.0) {
		vec3 bg = uv.y < 0.5 ? vec3(0.5) : vec3(0.5, 0.5, 1.0);
		fragColor.rgb = mix(bg, fragColor.rgb, alpha);
		return;
	}
	
	// Calculate average direction
	dirAvg = normalize(dirAvg);

	// STEP 2: Raycast in average direction until an edge is hit
	
	float dist = radius * 0.5;
	float move = dist * 0.5;
	// Binary search works better than linear search
	for (int i = 0; i < 8; i++, move *= 0.5) {
		vec4 col = texture(iChannel0, uv + dirAvg * aspect * dist);
		dist += alpha != getAlpha(col.rgb) ? -move : move;
	}
	
	// STEP 3: Calculate distance and direction from interior
	
	vec2 interiorDir = interior ? dirAvg : -dirAvg;
	float interiorDist = interior ? radius - dist : dist + radius;

	if (uv.y > 0.75) {
		// Direction relative to interior (range -1 to 1)
		fragColor.rgb = vec3(interiorDir * 0.5 + 0.5, 1.0);
	} else if (uv.y > 0.5) {
		// Direction relative to edge (range -1 to 1)
		fragColor.rgb = vec3(dirAvg * 0.5 + 0.5, 1.0);
	} else if (uv.y > 0.25) {
		// Distance from edge
		fragColor.rgb = vec3(dist / radius);
	} else {
		// Distance from interior
		fragColor.rgb = vec3(interiorDist / radius * 0.5);
	}
}