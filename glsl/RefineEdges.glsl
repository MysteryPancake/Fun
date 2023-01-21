// Available at https://www.shadertoy.com/view/dl23Wt

const float TAU = 6.28318530;

float getAlpha(vec3 col) {
	const vec3 green = vec3(0.0, 1.0, 0.0);
	return step(0.65, distance(col, green));
}

float inverseLerp(float x, float xMin, float xMax) {
	return (x - xMin) / (xMax - xMin);
}

// From https://www.shadertoy.com/view/lsdGzN
float xyzF(float t) {
	return mix(pow(t, 1.0 / 3.0), 7.787037 * t + 0.139731, step(t, 0.00885645));
}

vec3 rgb2lch(vec3 c) {
	c *= mat3(0.4124, 0.3576, 0.1805, 0.2126, 0.7152, 0.0722, 0.0193, 0.1192, 0.9505);
	c.x = xyzF(c.x);
	c.y = xyzF(c.y);
	c.z = xyzF(c.z);
	vec3 lab = vec3(max(0.0, 116.0 * c.y - 16.0), 500.0 * (c.x - c.y), 200.0 * (c.y - c.z)); 
	return vec3(lab.x, length(vec2(lab.y, lab.z)), atan(lab.z, lab.y));
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {

	const float dirSteps = 64.0;
	
	// Radius
	float radius = iMouse.z > 0.0 ? iMouse.x / iResolution.x * 128.0 : sin(iTime * 6.0) * 8.0 + 16.0;
	
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
	if (length(dirAvg) <= 0.0) return;
	
	// Calculate average direction
	dirAvg = normalize(dirAvg);

	// STEP 2: Raycast in average direction until an edge is hit
	
	float d = radius * 0.5;
	float move = d * 0.5;
	// Binary search works better than linear search
	for (int i = 0; i < 8; i++, move *= 0.5) {
		vec4 col = texture(iChannel0, uv + dirAvg * aspect * d);
		d += alpha != getAlpha(col.rgb) ? -move : move;
	}
	
	// STEP 3: Fix interior direction and distance
	
	dirAvg = interior ? dirAvg : -dirAvg;
	d = interior ? radius - d : d + radius;
	
	// STEP 4: Sample colors inside and outside edge
	
	vec3 insideColor = texture(iChannel0, uv - dirAvg * aspect * d).rgb;
	vec3 outsideColor = texture(iChannel0, uv + dirAvg * aspect * (radius * 2.0 - d)).rgb;
	
	// STEP 5: Lerp between a property, I used the chrominance but Photoshop likely doesn't
	
	float chroma = inverseLerp(rgb2lch(fragColor.rgb).y, rgb2lch(outsideColor).y, rgb2lch(insideColor).y);
	
	// Display matte
	fragColor.rgb = vec3(chroma);
}