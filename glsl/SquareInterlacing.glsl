// Available at https://www.shadertoy.com/view/Ds2Sz1

// IMAGE

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
	fragColor = texture(iChannel0, fragCoord / iResolution.xy);
}

// BUFFER A

const int scale = 32;

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
	int modFrame = iFrame % scale;
	vec2 uv = fragCoord / iResolution.xy;
	if (int(fragCoord.x) % scale == modFrame || int(fragCoord.y) % scale == modFrame) {
		fragColor = texture(iChannel1, uv);
	} else {
		fragColor = texture(iChannel0, uv);
	}
}