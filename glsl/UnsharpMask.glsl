// Available at https://www.shadertoy.com/view/dtl3Rj

void mainImage(out vec4 fragColor, in vec2 fragCoord) {

	// Optional sharpness boost
	float amount = 1.0;
	// Modulate blur over time
	float radius = abs(mod(iTime * 8.0, 16.0) - 8.0);
	
	// Sample original and blurred image
	vec2 uv = fragCoord / iResolution.xy;
	vec4 original = texture(iChannel0, uv);
	vec4 blurred = textureLod(iChannel0, uv, radius);
	
	// Produce mask
	blurred = original - blurred;
	original += blurred * amount;
	
	// Sharpened image on the left, mask on the right
	fragColor = uv.x > 0.5 ? blurred : original;
}