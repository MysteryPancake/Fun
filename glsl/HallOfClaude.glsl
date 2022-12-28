// Available at https://www.shadertoy.com/view/msSGDm

// Modification of HallOfMirrors.glsl

void mainImage(out vec4 fragColor, in vec2 fragCoord) {

	// Number of images to display
	int images = 96;
	// Scale factor per image
	float scale = 0.9 + cos(iTime) * 0.05;
	// Rotation per image in degrees
	float rotation = sin(iTime) * 90.0;
	// Position offset per image in normalized coordinates (0-1)
	vec2 offset = iMouse.z > 0.0 ? vec2(iMouse.xy / iResolution.xy) : 0.5 + vec2(cos(iTime), sin(iTime)) * 0.5;
	
	const vec3 target = vec3(0.0, 1.0, 0.0); // Find green
	const float threshold = 0.5; // Controls target color range
	const float softness = 0.3; // Controls linear falloff

	float rad = radians(-rotation);
	vec2 uv = fragCoord / iResolution.xy;
	fragColor = vec4(0.0);

	for (int i = 0; i < images; ++i) {
		// Avoid divide by zero error
		if (scale <= 0.0) {
			fragColor = texture(iChannel0, uv);
			break;
		}

		// SCALING: Offset, apply scale, reset offset
		vec2 pos = uv - offset;
		pos /= pow(scale, float(i));
		pos += offset;

		// ROTATION
		float theta = rad * float(i);
		float cs = cos(theta);
		float sn = sin(theta);
		// Offset to center, fix aspect ratio
		pos -= vec2(0.5);
		pos *= iResolution.xy;
		// Rotate coordinate space
		pos = vec2(pos.x * cs - pos.y * sn, pos.x * sn + pos.y * cs);
		// Reset aspect ratio, reset offset
		pos /= iResolution.xy;
		pos += vec2(0.5);

		// Prevent out of bounds bugs, could also be done with clamp
		if (pos.x >= 0.0 && pos.x <= 1.0 && pos.y >= 0.0 && pos.y <= 1.0) {
			// Color key
			vec4 color = texture(iChannel0, pos);
			float diff = distance(color.xyz, target) - threshold;
			color.a = clamp(diff / softness, 0.0, 1.0);
			// Tint towards red/yellow
			color.rgb += vec3(float(i * 4) / float(images), float(i) / float(images), 0.0);
			// Premultiply color
			color.rgb *= color.a;
			// Composite behind
			fragColor = fragColor + (1.0 - fragColor.a) * color;
			// Early exit
			if (color.a >= 1.0) break;
		}
	}
}