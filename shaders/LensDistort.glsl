// Available at https://www.shadertoy.com/view/stdcRf
void mainImage(out vec4 fragColor, in vec2 fragCoord) {

	vec2 uv = fragCoord / iResolution.xy;

	vec2 center = vec2(0.5);
	if (iMouse.z > 0.0) {
		center = iMouse.xy / iResolution.xy;
	}

	float dist = distance(uv, center);
	vec2 dir = uv - center;
	float lens = mod(iTime, 4.0);

	fragColor = texture(iChannel0, uv - dist * dir * lens);
}