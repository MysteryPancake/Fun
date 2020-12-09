// Available at https://www.shadertoy.com/view/WlffWX
float firstp = 0.1;
int iterations = 10;

float f(float x, float y, float t, float p) {
	return cos(x * (x + t) / (y + p) + t);
}

float iterate(float x, float y, float t) {
	float p = firstp;
	for (int i = 0; i < iterations; i++) {
		p = f(x, y, t, p);
	}
	return p;
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
	float height = sin(iTime) * 0.5 + 1.5;
	vec2 uv = (fragCoord / iResolution.xy) * height;
	float p = iterate(uv.x - height, uv.y - height, cos(iTime));
	fragColor = vec4(1.0 - p, 0.0 - p, 0.0, 1.0);
}