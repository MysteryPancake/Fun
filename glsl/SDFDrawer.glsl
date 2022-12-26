// Available at https://www.shadertoy.com/view/Dls3RS

// BUFFER A

// Larger brush sizes are OK, but have wrong interior distances
const float brushSize = 0.0;

// From https://iquilezles.org/articles/distfunctions2d/
float line(vec2 p, vec2 a, vec2 b) {
	vec2 pa = p - a, ba = b - a;
	float h = clamp(dot(pa, ba) / dot(ba, ba), 0.0, 1.0);
	return length(pa - ba * h);
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {

	// Initialize with invalid blank SDF
	vec2 p = (2.0 * fragCoord - iResolution.xy) / iResolution.y;
	if (iFrame < 1) {
		fragColor.x = length(p) + 999.9;
		return;
	}
	
	// Store previous mouse position (thanks Envy24 for improving)
	vec2 m = (2.0 * iMouse.xy - iResolution.xy) / iResolution.y;
	fragColor.yzw = vec3(m, iMouse.z > 0.0);
	
	// Read previous SDF
	vec4 data = texelFetch(iChannel0, ivec2(fragCoord), 0);
	fragColor.x = data.x;
	if (iMouse.z > 0.0) {
		// Draw line between previous and current mouse position
		float d = line(p, data.w > 0.0 ? data.yz : m, m);
		fragColor.x = min(fragColor.x, d - brushSize);
	}
}

// IMAGE

void mainImage(out vec4 fragColor, in vec2 fragCoord) {

	float d = texelFetch(iChannel0, ivec2(fragCoord), 0).x;
	
	// Coloring, ripped from Inigo Quilez
	vec3 col = vec3(1.0) - sign(d) * vec3(0.1, 0.4, 0.7);
	col *= 1.0 - exp(-6.0 * abs(d));
	col *= 0.8 + 0.2 * cos(120.0 * d);
	col = mix(col, vec3(1.0), 1.0 - smoothstep(0.0, 0.015, abs(d)));
	fragColor = vec4(col, 1.0);
}