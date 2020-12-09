// Available at https://www.shadertoy.com/view/WtffWX
float w = 16.0;
float h = 9.0;
float firstp = 0.0001;
int iterations = 100;
float tstart = 0.0;
float tend = 20.0;
float tstep = 0.5;
//float t = 0.0;

float f(float x, float y, float t, float p) {
	return (sin(x * (x + t) / (y + p) + t) + 1.0) / 2.0;
}

float iterate(float x, float y, float t) {
	float p = firstp;
	for (int i = 0; i < iterations; i++) {
		p = f(x, -y, t, p);
	}
	return p;
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
	vec2 uv = vec2((fragCoord.x / iResolution.x) * w, (fragCoord.y / iResolution.y) * h);
	//t += tstep;
	float t = mod(iTime * tstep, tend);
	float p = iterate(uv.x - (w / 2.0), uv.y - (h / 2.0), t);
	fragColor = vec4(p, p, p, 1.0);
}