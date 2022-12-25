// Available at https://www.shadertoy.com/view/Dls3RS

// BUFFER A

const float brushSize = 0.0;

// From https://iquilezles.org/articles/distfunctions2d/
float line(vec2 p, vec2 a, vec2 b) {
	vec2 pa = p - a, ba = b - a;
	float h = clamp(dot(pa, ba) / dot(ba, ba), 0.0, 1.0);
	return length(pa - ba * h);
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {

	vec2 p = (2.0 * fragCoord - iResolution.xy) / iResolution.y;
	// Initialize with invalid blank SDF
	if (iFrame < 1) {
		fragColor.r = length(p) + 999.9;
		return;
	}
	
	// Read previous SDF
	fragColor.r = texelFetch(iChannel0, ivec2(fragCoord), 0).r;
	if (iMouse.z > 0.0) {
		// Get previous mouse position
		vec4 last = texelFetch(iChannel1, ivec2(0, 0), 0);
		// Draw line between previous and current mouse position
		vec2 m = (2.0 * iMouse.xy - iResolution.xy) / iResolution.y;
		float d = line(p, last.b > 0.0 ? last.rg : m, m);
		fragColor.r = min(fragColor.r, d - brushSize);
	}
}

// BUFFER B

// For tracking last mouse position
void mainImage(out vec4 fragColor, in vec2 fragCoord) {
	vec2 m = (2.0 * iMouse.xy - iResolution.xy) / iResolution.y;
	// RG = mouse X and Y, B = was down
	fragColor.rgb = vec3(m, iMouse.z > 0.0);
}

// IMAGE

void mainImage(out vec4 fragColor, in vec2 fragCoord) {

	float d = texelFetch(iChannel0, ivec2(fragCoord), 0).r;
	
	// Coloring, ripped from Inigo Quilez
	vec3 col = vec3(1.0) - sign(d) * vec3(0.1, 0.4, 0.7);
	col *= 1.0 - exp(-6.0 * abs(d));
	col *= 0.8 + 0.2 * cos(120.0 * d);
	col = mix(col, vec3(1.0), 1.0 - smoothstep(0.0, 0.015, abs(d)));
	fragColor = vec4(col, 1.0);
}