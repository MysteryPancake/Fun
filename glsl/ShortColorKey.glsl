// Available at https://www.shadertoy.com/view/dtXGDB

// Sharp alpha, 117 chars
void mainImage(out vec4 O, vec2 u) {
	vec4 t = texture(iChannel0, u / iResolution.xy);
	O = t - step(length(t.rgb - vec3(0, 1, 0)), .7);
}

// Smooth alpha, 126 chars
/*void mainImage(out vec4 O, vec2 u) {
	vec4 t = texture(iChannel0, u / iResolution.xy);
	O = t * smoothstep(.5, .7, length(t.rgb - vec3(0, 1, 0)));
}*/

// Terrible alpha, 95 chars
/*void mainImage(out vec4 O, vec2 u) {
	vec4 t = texture(iChannel0, u / iResolution.xy);
	O = t - step(t.r, .1);
}*/