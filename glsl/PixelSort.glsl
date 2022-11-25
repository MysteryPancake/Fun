// Available at https://www.shadertoy.com/view/DslSRs

// IMAGE

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
	fragColor = vec4(texture(iChannel0, fragCoord / iResolution.xy).rgb, 1.0);
}

// BUFFER A

void mainImage(out vec4 fragColor, in vec2 fragCoord) {

	// Loop every 128 frames
	int frame = iFrame % 128;
	
	if (frame == 0) {
		// Initialize color to texture
		fragColor = texture(iChannel1, fragCoord / iResolution.xy);
	} else {
		// Start with original color
		ivec2 pos = ivec2(fragCoord);
		fragColor = texelFetch(iChannel0, pos, 0);
		
		// Compare pixels in pairs, sliding window along 1 pixel per frame
		bool sampleTop = pos.y % 2 == frame % 2;
		
		// SPEEDUP: Sort larger chunks first, then smaller chunks
		int jump = max(0, 96 - (frame * 2)) + 1;
		ivec2 offset = pos + ivec2(0, sampleTop ? jump : -jump);
		
		// Don't read out of bounds pixels
		ivec2 dims = textureSize(iChannel0, 0);
		if (offset.x < 0 || offset.x >= dims.x || offset.y < 0 || offset.y >= dims.y) {
			return;
		}
		
		// Compare red channel and alpha to know whether we need to swap
		vec4 neighbour = texelFetch(iChannel0, offset, 0);
		if (length(fragColor.rgb) > length(neighbour.rgb) == sampleTop) {
			fragColor = neighbour;
		}
	}
}