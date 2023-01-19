// Available at https://www.shadertoy.com/view/cljGDt

// Function to converge towards
bool check(float guess) {
	return guess > sin(iTime) * 0.5 + 0.5;
}

// Each step, move another half towards the target
float search(float maximum, int steps) {
	float current = maximum;
	float move = current * 0.5;
	for (int i = 0; i < steps; i++, move *= 0.5) {
		current -= check(current) ? move : -move;
	}
	return current;
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {

	vec2 uv = fragCoord / iResolution.xy;
	
	// X axis is the estimated value, Y axis is the step
	float result = search(1.0, int(uv.y * 12.0));
	fragColor.rgb = vec3(smoothstep(0.01, 0.0, abs(uv.x - result)));
	
	// Vignette
	fragColor.rgb += length(uv - 0.5) * 0.2;
}