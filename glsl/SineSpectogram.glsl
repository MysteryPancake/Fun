// Available at https://www.shadertoy.com/view/NltyDB
void mainImage(out vec4 fragColor, in vec2 fragCoord) {

	vec2 uv = fragCoord / iResolution.xy;
	vec3 result = vec3(0.0);
	const int iterations = 48;
	
	for (int i = 0; i <= iterations; i++) {
		float percent = float(i) / float(iterations);
		float spectrum = texture(iChannel0, vec2(percent, 0.0)).x;
		float amplitude = 0.02 * spectrum;
		float sine = percent + sin(iTime * 8.0 + uv.y * float(i * 4)) * amplitude;
		result += vec3(0.0016 / distance(vec2(sine, uv.y), uv)) * uv.xyx;
	}
	
	fragColor = vec4(result, 1.0);
}