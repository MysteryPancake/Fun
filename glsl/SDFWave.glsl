// Available at https://www.shadertoy.com/view/Dtl3z2

const float TAU = 6.2831853072;

// Ping-pong triangle waveform
vec2 triangle(vec2 p, vec2 period) {
	return abs(mod(p, period) - period * 0.5);
}

// For sharper transitions than regular cos
float sharpCos(float x, float smoothness) {
	float s = cos(x);
	return s / sqrt(smoothness + s * s);
}

// Inefficient but simple SDF, uses 10 grids
float waveSDF(vec2 p) {

	float d = 9999.9;
	for (float i = 0.0; i < 1.0; i += 0.1) {
		// Base distortion
		float distort = cos(4.0 * iTime + i * TAU) * 0.1;
		
		// Transition between different Y offsets
		float a = sharpCos(iTime, 0.02) * 0.5 + 0.5;
		float b = sharpCos(iTime * 0.5, 0.01) * 0.5 + 0.5;
		vec2 offset = vec2(i + distort, a * i - b * distort);
		
		// Repeat domain using a grid
		vec2 tri = triangle(p + offset, vec2(1.0, 0.5));
		
		// Use a sphere SDF
		d = min(d, length(tri));
	}
	return d - 0.05;
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {

	// Normalized coordinates, ripped from Inigo Quilez
	vec2 p = (2.0 * fragCoord - iResolution.xy) / iResolution.y;
	vec2 m = (2.0 * iMouse.xy - iResolution.xy) / iResolution.y;
	
	float d = waveSDF(p);

	// Coloring, ripped from Inigo Quilez
	vec3 col = vec3(1.0) - sign(d) * vec3(0.1, 0.4, 0.7);
	col *= 1.0 - exp(-6.0 * abs(d));
	col *= 0.8 + 0.2 * cos(120.0 * d);
	col = mix(col, vec3(1.0), 1.0 - smoothstep(0.0, 0.015, abs(d)));

	if (iMouse.z > 0.001) {
		d = waveSDF(m);
		col = mix(col, vec3(1.0, 1.0, 0.0), 1.0 - smoothstep(0.0, 0.005, abs(length(p - m) - abs(d)) - 0.0025));
		col = mix(col, vec3(1.0, 1.0, 0.0), 1.0 - smoothstep(0.0, 0.005, length(p - m) - 0.015));
	}
	
	fragColor = vec4(col, 1.0);
}