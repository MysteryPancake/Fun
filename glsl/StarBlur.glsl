// Available at https://www.shadertoy.com/view/NlyBWD
void mainImage(out vec4 fragColor, in vec2 fragCoord) {

	vec2 uv = fragCoord / iResolution.xy;
	
	const float range = 0.2; // Length of glow streaks
	const float steps = 0.002; // Texture samples
	
	for (float i = -range; i < range; i += steps) {
	
		float falloff = 1.0 - abs(i / range);
	
		vec4 blur = texture(iChannel0, uv + i);
		fragColor = max(fragColor, blur * falloff);
		
		blur = texture(iChannel0, uv + vec2(i, -i));
		fragColor = max(fragColor, blur * falloff);
	}
}