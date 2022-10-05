// Available at https://www.shadertoy.com/view/NtyfRt

// BUFFER A

#define colorKey(vid) clamp((distance(vid.rgb, target) - threshold) / softness, 0.0, 1.0)

void mainImage(out vec4 fragColor, in vec2 fragCoord) {

	vec2 uv = fragCoord / iResolution.xy;
	
	const vec3 target = vec3(0.0, 1.0, 0.0); // Find green
	const float threshold = 0.7; // Controls target color range
	const float softness = 0.1; // Controls linear falloff
	
	// One sample per rim light pass
	vec4 vid = texture(iChannel0, uv);
	vec4 vid2 = texture(iChannel0, uv + vec2(0.005));
	vec4 vid3 = texture(iChannel0, uv - vec2(0.005));
	
	// Linear color key (https://www.shadertoy.com/view/NsfcWj)
	float factor = colorKey(vid);
	float factor2 = colorKey(vid2);
	float factor3 = colorKey(vid3);
	
	// Yellow rim light
	vid += vec4(1.0, 0.5, 0.5, 0.0) * (1.0 - factor2);
	
	// Blue rim light
	vid += vec4(0.0, 0.0, 1.0, 0.0) * (1.0 - factor3);
	
	fragColor = vec4(vid.rgb, factor);
}

// BUFFER B

void mainImage(out vec4 fragColor, in vec2 fragCoord) {

	vec2 uv = fragCoord / iResolution.xy;
	const vec2 offset = vec2(-0.002, -0.002);

	if (iFrame < 1) {

		// Initialize values to 0
		fragColor = vec4(0.0);

	} else if (iFrame % 8 == 0) {

		// Sample every 8 frames
		vec4 last = texture(iChannel0, uv + offset);
		vec4 vid = texture(iChannel1, uv);
		fragColor = mix(last, vid, vid.a);

	} else {
	
		// Use previous sample
		fragColor = texture(iChannel0, uv + offset);
	}

	// Decrease alpha over time
	fragColor.a = clamp(fragColor.a - 0.0005, 0.0, 1.0);
}

// IMAGE

void mainImage(out vec4 fragColor, in vec2 fragCoord) {

	vec2 uv = fragCoord / iResolution.xy;

	vec4 trail = texture(iChannel1, uv);
	vec4 front = texture(iChannel0, uv);
	vec4 bg = vec4(1.0, 0.2, 0.2, 0.0) + texture(iChannel2, uv * 0.5).r;
	
	vec4 fg = mix(trail, front, front.a);
	fragColor = mix(bg, fg, fg.a);
}