// Available at https://www.shadertoy.com/view/DssXRl

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
		if (distance(vid.rgb, vec3(0.0, 1.0, 0.0)) > 0.8) {
			fragColor = vid;
			return;
		}
	
		// Start with original color
		ivec2 pos = ivec2(fragCoord);
		fragColor = texelFetch(iChannel0, pos, 0);
		
		// Compare pixels in pairs, sliding window along 1 pixel per frame
		bool sampleLeft = pos.x % 2 == iFrame % 2;
		ivec2 offset = pos + ivec2(sampleLeft ? -1 : 1, 0);
		
		// Don't read out of bounds pixels
		ivec2 dims = textureSize(iChannel0, 0);
		if (offset.x < 0 || offset.x >= dims.x || offset.y < 0 || offset.y >= dims.y) {
			return;
		}
		
		// Compare red channel and alpha to know whether we need to swap
		vec4 neighbour = texelFetch(iChannel0, offset, 0);
		if (fragColor.a <= 0.0 || length(fragColor.rgb) > length(neighbour.rgb) == sampleLeft) {
			fragColor = neighbour;
		}
	}
}