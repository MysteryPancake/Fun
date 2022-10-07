// Available at https://www.shadertoy.com/view/stGBWy

// BUFFER A

#define PI_4 0.785398163397448309616

float rand(vec2 p) {
	return fract(sin(dot(p, vec2(12.9898, 78.233))) * 43758.5453);
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {

	if (iFrame < 1) {
	
		// Initialize with noise
		float noise = rand(fragCoord / iResolution.xy);
		float noise2 = rand(fragCoord / iResolution.xy * 0.5);
		
		// Stored as color, segment length, direction (radians), length until rotation
		fragColor = vec4(noise > 0.997 ? noise2 : 0.0, 0.0, round(noise2 * 8.0) * PI_4, 16.0);
		
	} else {
		
		// Sample current pixel directly
		fragColor = texelFetch(iChannel0, ivec2(fragCoord), 0);
		
		// Sample in a 3 x 3 kernel
		for (int x = -1; x <= 1; ++x) {
			for (int y = -1; y <= 1; ++y) {
			
				// Ignore self
				if (x == 0 && y == 0) continue;
				
				// Sample neighbour
				ivec2 pos = ivec2(x, y);
				vec4 neighbour = texelFetch(iChannel0, ivec2(fragCoord) + pos, 0);
				
				// For some reason neighbour.x > 0.0 breaks
				if (neighbour.x > fragColor.x || fragColor.w > neighbour.w) {
					
					// Find where each neighbour wants to move next
					ivec2 target = ivec2(round(sin(neighbour.z)), round(cos(neighbour.z)));
					
					// Neighbour wants to move to us, we have to update ourselves
					if (pos.x + target.x == 0 && pos.y + target.y == 0) {
					
						fragColor = neighbour; // Transfer properties from neighbour to us
						++fragColor.y; // Increase segment length
						
						// Rotate when segment length > length until rotation
						if (fragColor.y > fragColor.w) {
							fragColor.y = 0.0; // New segment, reset segment length
							fragColor.w -= 0.5; // Shrink spiral whenever we rotate
							fragColor.z += PI_4; // Rotate 45 degrees (PI/4 radians)
						}
					}
				}
			}
		}
	}
}

// IMAGE

void mainImage(out vec4 fragColor, in vec2 fragCoord) {

	// Stored as color, segment length, direction (radians), length until rotation
	vec4 self = texture(iChannel0, fragCoord / iResolution.xy);
	
	// Colorize based on length and color
	fragColor = vec4(self.y * 0.25, self.x, 0.0, 1.0);
}