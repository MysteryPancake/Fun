// Available at https://www.shadertoy.com/view/csf3Rl

// BUFFER A

#define cell(offset) texelFetch(iChannel0, ivec2(fragCoord) + offset, 0)

void mainImage(out vec4 fragColor, in vec2 fragCoord) {

	if (iFrame > 1) {
		// Sum of neighbours, 3 x 3 kernel
		vec4 sum = cell(ivec2(-1,  1)) + cell(ivec2(0,  1)) + cell(ivec2(1,  1))
				 + cell(ivec2(-1,  0))                      + cell(ivec2(1,  0))
				 + cell(ivec2(-1, -1)) + cell(ivec2(0, -1)) + cell(ivec2(1, -1));
				 
		// Average of neighbours
		fragColor = sum / 8.0;
	} else {
		fragColor = texture(iChannel1, fragCoord / iResolution.xy);
	}
}

// MAIN IMAGE

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
	fragColor = texture(iChannel0, fragCoord / iResolution.xy);
}