// Available at https://www.shadertoy.com/view/ms2XWR

const float scale = 32.0;
const float lineWidth = 0.1;

// Posterized noise
float noise(vec2 p, float levels) {
	return floor(fract(sin(dot(p, vec2(1.989, 2.233))) * 43758.54) * levels) / levels;
}

// From https://www.shadertoy.com/view/3tdSDj, shortened by FabriceNeyret2
float line(vec2 p, vec2 a, vec2 b) {
	b -= a; p -= a;
	return length(p - b * clamp(dot(p, b) / dot(b, b), 0.0, 1.0));
}

// Modified from https://www.shadertoy.com/view/lsS3Wc
vec3 hue2rgb(float hue) {
	return clamp(abs(mod(hue * 6.0 + vec3(0.0, 4.0, 2.0), 6.0) - 3.0) - 1.0, 0.0, 1.0);
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
	
	vec2 pos = iMouse.z > 0.0 ? fragCoord - iMouse.xy : fragCoord + iTime * 60.0;
	pos /= scale;
	
	// Number of color subdivisions, ideally a whole number
	float colors = 3.0 + cos(iTime * 0.2);
	
	// Add nice rainbow colors
	float self = noise(floor(pos), colors);
	vec3 bg = hue2rgb(self);
	float bgMix = 1.0;
	
	// 3 x 3 kernel, checks all 8 neighbors
	for (int x = -1; x <= 1; x++) {
		for (int y = -1; y <= 1; y++) {
		
			// Ignore self
			if (x == 0 && y == 0) continue;
			vec2 offset = vec2(x, y);
			
			// Check neighbor has matching color
			float neighbor = noise(floor(pos + offset), colors);
			if (self == neighbor) {
				// Draw a line from the center to the neighbor
				const vec2 center = vec2(0.5);
				float dist = line(fract(pos), center, center + offset);
				bgMix = min(bgMix, dist / lineWidth);
			}
		}
	}
	
	// Combine background and lines, clip a little
	fragColor = vec4(mix(0.8 + bg, bg * 0.25, bgMix), 1.0);
}