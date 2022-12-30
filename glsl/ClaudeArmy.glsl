// Available at https://www.shadertoy.com/view/dlXGzl

// Modification of HallOfMirrors.glsl

void mainImage(out vec4 fragColor, in vec2 fragCoord) {

	// Number of images to display
	int images = 128;
	// Scale factor per image
	float scale = 0.96;
	
	vec2 uv = fragCoord / iResolution.xy;
	vec2 m = iMouse.xy / iResolution.xy;
	fragColor = vec4(0.0);
	
	// View angle
	float camAngle = iMouse.z > 0.0 ? 1.5 - 2.0 * m.y : 0.6 - sin(iTime) * 0.5;
	
	for (int i = 0; i < images; ++i) {
		// Different heights for variety
		float height = cos(float(i) + iTime) * 0.1;
		
		// Offset, apply scale, reset offset
		vec2 offset = vec2(i, 0.5 + 0.5 * camAngle);
		vec2 pos = uv - offset;
		pos /= pow(scale, float(i));
		vec2 camPos = vec2(iMouse.z > 0.0 ? -m.x : iTime * 0.5, camAngle + height);
		pos += offset + camPos;
		
		// Clamp bottom and discard top
		if (pos.y >= 0.995) continue;
		pos.y = max(pos.y, 0.005);
		
		// Flip every 2nd one for variety
		if (i % 2 == 1) pos.x *= -1.0;
		
		// Below is required if the wrap mode isn't repeat
		pos.x = fract(pos.x);
		
		// Color key (despill from Inigo Quilez)
		vec4 color = texture(iChannel0, pos);
		float rbMax = max(color.r, color.b);
		float og = color.g; 
		color.g = min(color.g, rbMax * 0.85); 
		color += og - color.g;
		color.a = 1.0 - clamp((og - rbMax) * 4.0, 0.0, 1.0);

		// Brightness variation for variety
		color.rgb -= 0.3 - cos(float(i * 4)) * 0.1;
		
		// Tint towards white
		float fog = sqrt(float(i) / float(images));
		color.rgb = mix(color.rgb, vec3(1.0), fog);
		
		// Premultiply color
		color.rgb *= color.a;
		// Composite behind
		fragColor += (1.0 - fragColor.a) * color;
		
		// Early exit
		if (fragColor.a >= 1.0) return;
	}
	
	// Make background white
	fragColor += vec4(1.0 - fragColor.a);
}