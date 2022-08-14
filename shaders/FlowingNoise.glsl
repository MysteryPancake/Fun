float noise(float n) {
	return fract(cos(n * 89.42) * 343.42);
}

float shake(float x) {
	return sin(x) * sin(x * 4.0) * cos(x * 8.0) * sin(x * 12.0);
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
	vec2 uv = fragCoord / iResolution.xy;
	fragColor = texture(iChannel0, uv + vec2(0.0, shake(uv.y + iTime) * noise(uv.x)) * 0.5);
}