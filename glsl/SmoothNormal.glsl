// Available at https://www.shadertoy.com/view/dtfSz4

const float TAU = 6.28318530;

void mainImage(out vec4 fragColor, in vec2 fragCoord) {

	const float dirSteps = 16.0;
	const float contrast = 3.0;
	
	// Control radius with mouse
	float radius = iMouse.z > 0.0 ? iMouse.x / iResolution.x * 32.0 : sin(iTime * 4.0) * 2.0 + 3.0;
	
	vec2 uv = fragCoord / iResolution.xy;
	fragColor = texture(iChannel0, uv);
	
	// Correct aspect ratio
	vec2 aspect = 1.0 / vec2(textureSize(iChannel0, 0));
	
	vec2 dirAvg = vec2(0.0);
	for (float i = 0.0; i < TAU; i += TAU / dirSteps) {
	
		// Find color difference in all directions
		vec2 dir = vec2(sin(i), cos(i));
		vec4 col = texture(iChannel0, uv + dir * aspect * radius);
		
		// Scale direction according to difference
		dirAvg += dir * distance(fragColor.rgb, col.rgb);
	}
	
	dirAvg *= contrast;
	fragColor.rgb = vec3(dirAvg * 0.5 + 0.5, 1.0);
}