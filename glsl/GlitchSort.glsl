// Available at https://www.shadertoy.com/view/csXXWB

// IMAGE

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
	fragColor = vec4(texture(iChannel0, fragCoord / iResolution.xy).rgb, 1.0);
}

// BUFFER A

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
	if (iFrame < 1) {
		// Initialize color to blue
		fragColor = vec4(0.1, 0.1, 0.2, 0.0);
	} else {
		// Use video color when above color key threshold
		vec4 vid = texture(iChannel1, fragCoord / iResolution.xy);
		ivec2 pos = ivec2(fragCoord);
		if (distance(vid.rgb, vec3(0.0, 1.0, 0.0)) > 0.8) {
			fragColor = vid;
		} else {
			// Oscillate background for extra movement
			fragColor = texelFetch(iChannel0, pos + ivec2(0, sin(iTime * 4.0) * 8.0), 0);
			// Force extra sorting
			fragColor.rgb -= 0.01;
		}
		
		// Compare pixels in pairs, sliding window along 1 pixel per frame
		bool sampleTop = pos.x % 2 == iFrame % 2;
		
		// Move brighter pixels more than darker ones
		int jump = max(0, 2 * int(fragColor.r * 256.0)) + 1;
		ivec2 offset = pos + ivec2(sampleTop ? jump : -jump, 0);
		
		// Don't read out of bounds pixels
		ivec2 dims = textureSize(iChannel0, 0);
		if (offset.x < 0 || offset.x >= dims.x || offset.y < 0 || offset.y >= dims.y) {
			return;
		}
		
		// Compare red channel and alpha to know whether we need to swap
		vec4 neighbour = texelFetch(iChannel0, offset, 0);
		if (fragColor.a <= 0.0 || length(fragColor.rgb) < length(neighbour.rgb) == sampleTop) {
			fragColor = neighbour;
		}
	}
}