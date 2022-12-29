// Available at https://www.shadertoy.com/view/stdcz2

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
	float pixels = mod(iTime * 10., 50.);
	vec2 uv = floor(fragCoord / iResolution.xy * pixels) / pixels;
	fragColor = textureLod(iChannel0, uv, 0.);
}