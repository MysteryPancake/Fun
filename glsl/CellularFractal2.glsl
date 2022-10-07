// Available at https://www.shadertoy.com/view/7lGfDy

// COMMON

#define PI_2 1.57079632679489661923

#define resetAfter 768

#define cycleCount (1 + iFrame / resetAfter)

// BUFFER A

float rand(vec2 p) {
	return fract(sin(dot(p, vec2(12.9898, 78.233))) * 43758.5453);
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {

	if (iFrame % resetAfter == 0) {
	
		// Initialize values, stored as color, segment length, direction (radians), length until rotation
		fragColor = vec4(ivec2(fragCoord) == ivec2(iResolution.xy * 0.5) / cycleCount, 0.0, 0.0, 32.0);
		
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
				if (neighbour.x > fragColor.x) {
					
					// Find where each neighbour wants to move next
					ivec2 target = ivec2(round(sin(neighbour.z)), round(cos(neighbour.z)));
					
					// Neighbour wants to move to us, we have to update ourselves
					if (abs(pos.x - target.x) >= 1 && abs(pos.y - target.y) >= 1) {
					
						fragColor = neighbour; // Transfer properties from neighbour to us
						++fragColor.y; // Increase segment length
						
						// Rotate when segment length > length until rotation
						if (fragColor.y > fragColor.w) {
							fragColor.y = 0.0; // New segment, reset segment length
							fragColor.w -= float(cycleCount); // Shrink spiral whenever we rotate
							fragColor.z += PI_2; // Rotate 90 degrees (PI/2 radians)
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
	vec4 self = texelFetch(iChannel0, ivec2(fragCoord) / cycleCount, 0);
	
	// Colorize based on color, length and direction
	fragColor = vec4(self.x, self.y * 0.1, self.z * 0.01, 1.0);
}