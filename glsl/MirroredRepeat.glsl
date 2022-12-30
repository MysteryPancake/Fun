// VARIANT 1: Floating point coordinates
// For float, vec2, vec3, vec4, etc.
vec2 mirror(vec2 p, vec2 size) {
	return abs(mod(p + size, 2.0 * size) - size);
}

// VARIANT 2: Integer coordinates
// My derivation: developer.blender.org/D16432
int mirror(int p, int size) {
	p = abs(p + int(p < 0)) % (2 * size);
	return p >= size ? 2 * size - p - 1 : p;
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {

	float scale = sin(iTime) * 3.0 + 4.0;
	ivec2 size = textureSize(iChannel0, 0);
	
	float mid = fragCoord.x / iResolution.x - 0.5;
	if (mid > 0.0) {
		// Integer demo
		ivec2 p = ivec2(fragCoord * scale);
		ivec2 uv = ivec2(mirror(p.x, size.x), mirror(p.y, size.y));
		fragColor = texelFetch(iChannel0, uv, 0);
	} else {
		// Floating point demo
		vec2 uv = mirror(fragCoord * scale / vec2(size), vec2(1.0));
		fragColor = texture(iChannel0, uv);
	}
	
	// Line down the center
	fragColor *= smoothstep(0.0, 0.01, abs(mid));
}