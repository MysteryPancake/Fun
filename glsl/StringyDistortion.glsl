// Available at https://www.shadertoy.com/view/stcyRB
const int samples = 4;

void mainImage(out vec4 fragColor, in vec2 fragCoord) {

	fragColor = vec4(1.0);
	vec2 uv = fragCoord/iResolution.xy;
	
	float m = clamp(mod(iTime * 0.1, 1.1), 0.0, 1.0);
	
	for (int x = 0; x < samples; x++) {
		for (int y = 0; y < samples; y++) {
			vec2 normalised = vec2(float(x) / float(samples), float(y) / float(samples));
			vec4 samp = texture(iChannel0, mix(uv, normalised, m));
			float dist = distance(samp.rgb, vec3(uv.x));
			if (dist < 0.1) {
				fragColor = samp;
				continue;
			}
		}
	}
}