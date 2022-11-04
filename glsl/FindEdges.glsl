// Available at https://www.shadertoy.com/view/csjGD1

// BUFFER A

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
	
	// Brightest neighbour and direction toward it
	vec4 brightest = vec4(0.0);
	vec2 direction = vec2(0.0);

	// Sample in a 3 x 3 kernel
	for (int x = -1; x <= 1; ++x) {
		for (int y = -1; y <= 1; ++y) {

			// Ignore self
			if (x == 0 && y == 0) continue;
			
			// Sample neighbour
			vec2 pos = vec2(x, y);
			vec4 neighbour = texelFetch(iChannel0, ivec2(fragCoord + pos), 0);
			
			// Store neighbour with maximum brightness
			if (length(neighbour) > length(brightest)) {
				brightest = neighbour;
				direction = pos;
			}
		}
	}
	
	// Colorize (direction range is -1 to 1)
	vec4 colorized = vec4(direction.xy, -direction.xy);
	
	// Emphasise more intense edges
	vec4 self = texelFetch(iChannel0, ivec2(fragCoord), 0);
	float weight = distance(brightest, self);
	
	fragColor = colorized * weight;
}

// IMAGE

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
	vec2 texSize = vec2(textureSize(iChannel1, 0));
	fragColor = texelFetch(iChannel0, ivec2(fragCoord / iResolution.xy * texSize), 0);
}