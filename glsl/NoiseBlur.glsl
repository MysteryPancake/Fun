// Available at https://www.shadertoy.com/view/NlGczW
vec2 noise(vec2 p) { // From https://www.shadertoy.com/view/Msf3WH
	p = vec2(dot(p, vec2(127.1, 311.7)), dot(p, vec2(269.5, 183.3)));
	return -1.0 + 2.0 * fract(sin(p) * 43758.5453123);
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {

	vec2 uv = fragCoord / iResolution.xy;
	vec2 center = vec2(0.5);
	if (iMouse.z > 0.0) {
		center = iMouse.xy / iResolution.xy;
	}

	vec2 offset = noise(iTime + uv) * pow(distance(uv, center), (1.0 + sin(iTime)) * 2.0);
	fragColor = texture(iChannel0, uv + offset);
}