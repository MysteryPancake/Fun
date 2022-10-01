// Available at https://www.shadertoy.com/view/flGfDw

// My SDF circle grid implementation
float sdCircleGrid(in vec2 position, in float radius) {
	// Calculate distance from 0.5 to position mod 1
	return length(fract(position) - 0.5) - radius;
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {

	// Normalized coordinates, ripped from Inigo Quilez
	vec2 p = (4.0 * fragCoord - iResolution.xy) / iResolution.y;
	vec2 m = (4.0 * iMouse.xy - iResolution.xy) / iResolution.y;
	
	float radius = 0.25 + sin(iTime * 2.0) * 0.25;
	float d = sdCircleGrid(p, radius);

	// Coloring, ripped from Inigo Quilez
	vec3 col = vec3(1.0) - sign(d) * vec3(0.1, 0.4, 0.7);
	col *= 1.0 - exp(-6.0 * abs(d));
	col *= 0.8 + 0.2 * cos(120.0 * d);
	col = mix(col, vec3(1.0), 1.0 - smoothstep(0.0, 0.015, abs(d)));

	if (iMouse.z > 0.001) {
		d = sdCircleGrid(m, radius);
		col = mix(col, vec3(1.0, 1.0, 0.0), 1.0 - smoothstep(0.0, 0.005, abs(length(p - m) - abs(d)) - 0.0025));
		col = mix(col, vec3(1.0, 1.0, 0.0), 1.0 - smoothstep(0.0, 0.005, length(p - m) - 0.015));
	}
	
	fragColor = vec4(col, 1.0);
}