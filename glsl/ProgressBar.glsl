// Available at https://www.shadertoy.com/view/dtsXzr

// With anti-aliasing, by fishy + iapafoto (218 chars)
#define A(d) smoothstep(-y, y, d - length(fract(clamp(u, vec2(1, 3), vec2(11, 4))) - .5))
void mainImage(out vec4 O, in vec2 u) {
	float y = 12. / iResolution.x; 
	u *= y;
	O = 1. - A(.47) + A(.4) * (u.x > ceil(sin(iTime) * 6. + 6.) ? O - O + .9 : vec4(0, .5, .9, 1));
}

// Original, by me + iapafoto (192 chars)
/* void mainImage(out vec4 O, in vec2 u) {
	u *= 12. / iResolution.x;
	O.a = length(fract(clamp(u, vec2(1, 3), vec2(11, 4))) - .5);
	O = step(.45, O.a) + step(O.a, .4) * (u.x > ceil(sin(iTime) * 6. + 6.) ? O - O + .9 : vec4(0, .5, .9, 1));
}*/