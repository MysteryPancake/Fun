// Available at https://www.shadertoy.com/view/mdXSWl

// IMAGE

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
	fragColor = texture(iChannel0, fragCoord / iResolution.xy);
}

// BUFFER A

const int scale = 16;

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
	vec2 uv = fragCoord / iResolution.xy;
	if (int(fragCoord.y) % scale == iFrame % scale) {
		fragColor = texture(iChannel0, uv);
	} else {
		fragColor = texture(iChannel1, uv);
	}
}