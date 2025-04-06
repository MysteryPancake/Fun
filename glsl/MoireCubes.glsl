// Available at https://www.shadertoy.com/view/W3BGDR

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
	
	vec2 pos = fragCoord / iResolution.y;
	
	// Number of pixels displayed
	float pixels = cos(iTime) * 16. + 32.;
	
	// Pixelate image
	vec4 col = texture(iChannel0, floor(pos * pixels) / pixels);
	
	// Draw cubes with the height shaded based on the brightness
	fragColor = vec4(max(col.r, max(col.g, col.b)) > fract(pos.y * pixels));
}