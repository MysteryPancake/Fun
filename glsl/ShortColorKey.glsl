// Available at https://www.shadertoy.com/view/dtXGDB

// Sharp alpha, 111 chars (thanks Alpgaga)
void mainImage(out vec4 O, vec2 u) {
	O = texture(iChannel0, u / iResolution.xy);
	O -= step(length(O.rgb - vec3(0, 1, 0)), .7);
}

// Smooth alpha, 120 chars
/*void mainImage(out vec4 O, vec2 u) {
	O = texture(iChannel0, u / iResolution.xy);
	O *= smoothstep(.5, .7, length(O.rgb - vec3(0, 1, 0)));
}*/

// Terrible alpha, 89 chars
/*void mainImage(out vec4 O, vec2 u) {
	O = texture(iChannel0, u / iResolution.xy);
	O -= step(O.r, .1);
}*/