// Available at https://www.shadertoy.com/view/dsSGWm

// Faithful remake of the deleted "Hall of Mirrors" effect by Red Giant
// Recreated by MysteryPancake

void mainImage(out vec4 fragColor, in vec2 fragCoord) {

	// Number of images to display
	int images = 33;
	// Scale factor per image
	float scale = 0.9 + cos(iTime * 2.0) * 0.1;
	// Rotation per image in degrees
	float rotation = sin(iTime * 0.5) * 45.0;
	// Position offset per image in normalized coordinates (0-1)
	vec2 offset = iMouse.z > 0.0 ? vec2(iMouse.xy / iResolution.xy) : 0.5 + vec2(cos(iTime), sin(iTime)) * 0.5;
	// Composite behind or in front
	bool behind = false;

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
			vec4 color = texture(iChannel0, pos);
			// Alpha blending, see shadertoy.com/view/msSGDm for working example
			if (behind) {
				fragColor = fragColor + (1.0 - fragColor.a) * color;
			} else {
				fragColor = color + (1.0 - color.a) * fragColor;
			}
		}
	}
}