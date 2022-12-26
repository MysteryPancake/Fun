// Available at https://www.shadertoy.com/view/mtlGzj

void mainImage(out vec4 fragColor, in vec2 fragCoord) {

	vec2 uv = fragCoord / iResolution.xy;
	// Original texture without blurring
	vec4 original = texture(iChannel0, uv);
	// Blurred slightly for edge isolation
	vec4 edges = textureLod(iChannel0, uv, 2.0);
	// Blurred more for underlying surface
	float blur = 4.0 + abs(mod(iTime * 4.0, 4.0) - 2.0);
	vec4 blurred = textureLod(iChannel0, uv, blur);
	
	// Mix original with blurred depending on edge difference
	float factor = 3.0 * distance(original.rgb, edges.rgb);
	fragColor = mix(blurred, original, clamp(factor, 0.0, 1.0));
}