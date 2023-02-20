// Available at https://www.shadertoy.com/view/mt2XDd

float getAlpha(vec3 color) {
	return smoothstep(0.5, 0.7, distance(color.rgb, vec3(0.0, 1.0, 0.0)));
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {

	vec2 uv = fragCoord / iResolution.xy;
	vec4 vid = texture(iChannel0, uv);
	fragColor = vid;
	
	// Correct aspect ratio for non-square images
	vec2 aspect = 1.0 / iResolution.xy;
	
	// In pixels
	float shadowLength = 64.0;
	// Lower values mean better precision
	float shadowPrecision = 4.0;
	// In radians
	float shadowAngle = iTime;
	
	float shadowMatte = 0.0;
	for (float i = shadowPrecision; i <= shadowLength; i += shadowPrecision) {
		vec2 offset = vec2(sin(shadowAngle), cos(shadowAngle));
		vec4 col = texture(iChannel0, uv + offset * i * aspect);
		shadowMatte = max(shadowMatte, getAlpha(col.rgb));
	}
	
	// Use shadow to darken
	fragColor -= shadowMatte * 0.25;
	
	// Add back original video
	fragColor = mix(fragColor, vid, getAlpha(vid.rgb));
}