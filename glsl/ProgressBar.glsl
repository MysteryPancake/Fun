// Available at https://www.shadertoy.com/view/dtsXzr

// With anti-aliasing, by fishy (239 chars)
#define A(x, d) smoothstep(x, x + 12. / iResolution.y, d)
void mainImage(out vec4 O, in vec2 u) {
	u *= 12. / iResolution.x;
	O.a = length(fract(clamp(u, vec2(1, 3), vec2(11, 4))) - .5);
	O = A(.45, O.a) + A(O.a, .4) * (u.x > floor(sin(iTime) * 6. + 7.) ? vec4(.9) : vec4(0, .5, .9, 1));
}

/* Original, by me (195 chars)
void mainImage(out vec4 O, in vec2 u) {
	u *= 12. / iResolution.x;
	O.a = length(fract(clamp(u, vec2(1, 3), vec2(11, 4))) - .5);
	O = step(.45, O.a) + step(O.a, .4) * (u.x > floor(sin(iTime) * 6. + 7.) ? vec4(.9) : vec4(0, .5, .9, 1));
}
*/