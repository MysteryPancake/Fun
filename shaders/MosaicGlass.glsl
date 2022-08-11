void mainImage(out vec4 fragColor, in vec2 fragCoord) {
	vec2 uv = fragCoord / iResolution.xy;
	float pixels = mod(iTime * 10.0, 50.0);
	fragColor = textureLod(iChannel0, (uv + floor(uv * pixels) / pixels) * 0.5, 0.0);
}