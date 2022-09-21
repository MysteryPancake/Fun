// Available at https://www.shadertoy.com/view/WtffWX
const vec2 size = vec2(16.0, 9.0);
const float firstp = 0.0001;
const int iterations = 100;
const float tend = 20.0;
const float tstep = 0.5;

float f(float x, float y, float t, float p) {
	return (sin(x * (x + t) / (y + p) + t) + 1.0) * 0.5;
}

float iterate(float x, float y, float t) {
	float p = firstp;
	for (int i = 0; i < iterations; i++) {
		p = f(x, -y, t, p);
	}
	return p;
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
	vec2 uv = (fragCoord / iResolution.xy - 0.5) * size;
	float t = mod(iTime * tstep, tend);
	float p = iterate(uv.x, uv.y, t);
	fragColor = vec4(p, p, p, 1.0);
}