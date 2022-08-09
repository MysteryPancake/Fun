// Based on https://www.shadertoy.com/view/7ttyD7
// Available at https://www.shadertoy.com/view/stcyRS
float rand(float co) {
	return fract(sin(co) * sin(iTime * 0.5));
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
	vec2 uv = fragCoord / iResolution.xy;
	float smallest = 1.0;
	vec3 result;
	for (int i = 0; i < 100; i++) {
		float j = float(i);
		float xDiff = rand(j) - uv.x;
		float yDiff = rand(j) - uv.y;
		float dist = xDiff * xDiff + yDiff * yDiff;
		if (dist < smallest) {
			smallest = dist;
			result = vec3(rand(j), rand(j + 1.0), rand(j + 1.0));
		}
	}
	fragColor = vec4(result, 1.0);
}