// Available at https://www.shadertoy.com/view/Dls3R8

void mainImage(out vec4 fragColor, in vec2 fragCoord) {

	vec2 uv = fragCoord / iResolution.xy;
	
	// Sample foreground and background textures
	vec4 fg = texture(iChannel0, uv);
	vec4 bg = texture(iChannel1, uv);
	
	// Convert foreground color to greyscale
	float gray = length(fg.rgb);
	// Emboss based on change in greyscale color
	gray += 0.5 - (dFdy(gray) + dFdx(gray)) * 4.0 - gray;
	
	// Measure distance to green
	float dist = distance(fg.rgb, vec3(0.0, 1.0, 0.0));
	// Increase contrast, change 0.4 and 0.5 depending how close the green is
	float factor = smoothstep(0.4, 0.5, dist);
	
	// Final composite, mix foreground and background
	fragColor.rgb = mix(bg.rgb, vec3(gray), factor);
}