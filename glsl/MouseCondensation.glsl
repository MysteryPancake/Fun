// Available at https://www.shadertoy.com/view/ctf3zf

// BUFFER A

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
	vec2 uv = fragCoord / iResolution.xy;
	float blur = max(0.0, texture(iChannel0, uv).r - 0.05);
	if (iMouse.z > 0.0) {
		float circleSdf = distance(fragCoord, iMouse.xy);
		blur = max(blur, 6.0 * smoothstep(128.0, 0.0, circleSdf));
	}
	fragColor.r = blur;
}

// IMAGE

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
	vec2 uv = fragCoord / iResolution.xy;
	float blur = texture(iChannel0, uv).r;
	fragColor = textureLod(iChannel1, uv, 6.0 - blur);
}