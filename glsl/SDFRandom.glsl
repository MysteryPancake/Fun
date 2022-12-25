// Available at https://www.shadertoy.com/view/DtsGRS

const float iterations = 32.0;

float noise(float n) {
	return fract(cos(n * 7589.42) * 343.53);
}

// Ping-pong triangle waveform
vec2 triangle(vec2 p, vec2 period) {
	return abs(mod(p, period) - period * 0.5);
}

// Overlap a bunch of triangle waveforms
float chaos(vec2 p) {

	float spread = 0.5 + cos(iTime * 2.0) * 0.5;
	float dist = 9999.9;
	
	for (float i = 1.0; i <= iterations; i++) {
		// Random starting offset for each waveform
		vec2 offset = vec2(noise(i), noise(i + iterations));
		// Period could be randomized, kept linear here
		vec2 period = vec2(spread) + i * 0.02;
		// Generate triangle waveform
		vec2 tri = triangle(p + offset * spread, period);
		// Pick closest point
		dist = min(dist, length(tri));
	}
	return dist;
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {

	// Normalized coordinates, ripped from Inigo Quilez
	vec2 p = (2.0 * fragCoord - iResolution.xy) / iResolution.y;
	vec2 m = (2.0 * iMouse.xy - iResolution.xy) / iResolution.y;
	
	float d = chaos(p);

	// Coloring, ripped from Inigo Quilez
	vec3 col = vec3(1.0) - sign(d) * vec3(0.1, 0.4, 0.7);
	col *= 1.0 - exp(-6.0 * abs(d));
	col *= 0.8 + 0.2 * cos(120.0 * d);
	col = mix(col, vec3(1.0), 1.0 - smoothstep(0.0, 0.015, abs(d)));

	if (iMouse.z > 0.001) {
		d = chaos(m);
		col = mix(col, vec3(1.0, 1.0, 0.0), 1.0 - smoothstep(0.0, 0.005, abs(length(p - m) - abs(d)) - 0.0025));
		col = mix(col, vec3(1.0, 1.0, 0.0), 1.0 - smoothstep(0.0, 0.005, length(p - m) - 0.015));
	}
	
	fragColor = vec4(col, 1.0);
}