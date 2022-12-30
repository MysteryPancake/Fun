// Available at https://www.shadertoy.com/view/dtXGDB

// By FabriceNeyret2, 105 chars :O
void mainImage(out vec4 O, vec2 u) {
	vec4 G = O = texture(iChannel0, u / iResolution.xy);
	G.ga--;
	dot(G, G) < .5 ? O-- : O;
}

// Sharp alpha, 109 chars (thanks Alpgaga, kishimisu)
/*void mainImage(out vec4 O, vec2 u) {
	O = texture(iChannel0, u / iResolution.xy);
	O -= step(length(O - vec4(0, 1, 0, 1)), .7);
}*/

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