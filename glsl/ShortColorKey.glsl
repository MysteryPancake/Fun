// Available at https://www.shadertoy.com/view/dtXGDB

// Sharp alpha, 109 chars (thanks Alpgaga, kishimisu)
void mainImage(out vec4 O, vec2 u) {
	O = texture(iChannel0, u / iResolution.xy);
	O -= step(length(O - vec4(0, 1, 0, 1)), .7);
}

// Smooth alpha, 118 chars
/*void mainImage(out vec4 O, vec2 u) {
	O = texture(iChannel0, u / iResolution.xy);
	O *= smoothstep(.5, .7, length(O - vec4(0, 1, 0, 1)));
}*/

// Terrible alpha, 89 chars
/*void mainImage(out vec4 O, vec2 u) {
	O = texture(iChannel0, u / iResolution.xy);
	O -= step(O.r, .1);
}*/