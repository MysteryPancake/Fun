// Available at https://www.shadertoy.com/view/slKfRc

// COMMON

#define gridSize 8.0

// BUFFER A

#define cell(offset) texelFetch(iChannel0, ivec2(fragCoord) + offset, 0).x

#define resetAfter 64

float rand(vec2 p) {
	return fract(sin(dot(p, vec2(12.9898, 78.233))) * 43758.5453);
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {

	// Skip invisible pixels
	if (fragCoord.x * gridSize > iResolution.x || fragCoord.y * gridSize > iResolution.y) discard;

	if (iFrame % resetAfter == 0) {
	
		// Initialize values, random noise
		fragColor = vec4(vec3(rand(fragCoord / iResolution.xy)), 1.0);
		
	} else {
	
		// Sample current pixel directly
		float self = texelFetch(iChannel0, ivec2(fragCoord), 0).x;

		// Sum of neighbours, 3 x 3 kernel
		float sum = cell(ivec2(-1,  1)) + cell(ivec2(0,  1)) + cell(ivec2(1,  1))
				  + cell(ivec2(-1,  0))                      + cell(ivec2(1,  0))
				  + cell(ivec2(-1, -1)) + cell(ivec2(0, -1)) + cell(ivec2(1, -1));
				 
		// Swap pattern every 64 frames
		float offset = sum > float((1 + iFrame / resetAfter) % 8) ? -0.1 : 0.1;
		fragColor = vec4(vec3(clamp(self + offset, 0.0, 1.0)), 1.0);
	}
}

// IMAGE

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
	fragColor = texelFetch(iChannel0, ivec2(fragCoord / gridSize), 0);
}