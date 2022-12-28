// Available at https://www.shadertoy.com/view/dlXGzl

// Modification of HallOfMirrors.glsl

void mainImage(out vec4 fragColor, in vec2 fragCoord) {

	// Number of images to display
	int images = 128;
	// Scale factor per image
	float scale = 0.95;
	
	vec2 uv = fragCoord / iResolution.xy;
	vec2 m = iMouse.xy / iResolution.xy;
	fragColor = vec4(0.0);
	
	// View angle
	float camAngle = iMouse.z > 0.0 ? 1.5 - 3.0 * m.y : sin(iTime) * 0.3 + 0.9;
	
	for (int i = 0; i < images; ++i) {
		// Offset, apply scale, reset offset
		vec2 offset = vec2(i, 0.5 + 0.5 * camAngle);
		vec2 pos = 2.0 * (uv - offset);
		pos /= pow(scale, float(i));
		vec2 camPos = vec2(iMouse.z > 0.0 ? -2.0 * m.x : iTime * 0.5, camAngle);
		pos += offset + camPos;
		
		// Clamp bottom and discard top
		if (pos.y > 1.0) continue;
		pos.y = max(pos.y, 0.005);
		
		// Flip every 2nd person for variety
		if (i % 2 == 0) {
			pos.x *= -1.0;
		}
		
		// Color key
		vec4 color = texture(iChannel0, pos);
		color.a = smoothstep(0.7, 0.9, distance(color.rgb, vec3(0.0, 1.0, 0.0)));
		// Tint towards white
		float fog = sqrt(float(i) / float(images));
		color.rgb -= 0.3 + sin(float(i)) * 0.1;
		color.rgb = mix(color.rgb, vec3(1.0), fog);
		// Premultiply color
		color.rgb *= color.a;
		// Composite behind
		fragColor += (1.0 - fragColor.a) * color;
		// Early exit
		if (color.a >= 1.0) break;
	}
	
	// Make background white
	fragColor += (1.0 - fragColor.a) * vec4(1.0);
}