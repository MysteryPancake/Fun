// Available at https://www.shadertoy.com/view/dtfGRl

// Modification of HallOfMirrors.glsl

void mainImage(out vec4 fragColor, in vec2 fragCoord) {

	// Number of images to display
	int images = 96;
	// Scale factor per image
	float scale = 0.9 + cos(iTime) * 0.05;
	// Rotation per image in degrees
	float rotation = sin(iTime) * 45.0;
	// Position offset per image in normalized coordinates (0-1)
	vec2 offset = iMouse.z > 0.0 ? vec2(iMouse.xy / iResolution.xy) : 0.5 + vec2(cos(iTime), sin(iTime)) * 0.25;

	float rad = radians(-rotation);
	vec2 uv = fragCoord / iResolution.xy;
	fragColor = vec4(0.0);
	
	for (int i = 0; i < images; ++i) {
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

		// Color key
		vec4 color = texture(iChannel0, pos);
		color.a = smoothstep(0.5, 0.8, distance(color.rgb, vec3(0.0, 1.0, 0.0)));
		// Tint towards red/yellow
		color.rgb += vec3(float(i * 4) / float(images), float(i) / float(images), 0.0);
		// Premultiply color
		color.rgb *= color.a;
		// Composite behind
		fragColor += (1.0 - fragColor.a) * color;
		// Early exit
		if (color.a >= 1.0) break;
	}
	
	// Make background yellow
	fragColor += (1.0 - fragColor.a) * vec4(1.0, 1.0, 0.0, 1.0);
}