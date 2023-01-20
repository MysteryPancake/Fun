// Available at https://www.shadertoy.com/view/cljGDt

// Function to converge towards, use mouse to move target
bool check(float guess) {
	float target = iMouse.z > 0.0 ? iMouse.x / iResolution.x : sin(iTime) * 0.5 + 0.5;
	return guess > target;
}

// Each step, move another half towards the target
float search(float maximum, int steps) {
	float current = maximum * 0.5;
	float move = current * 0.5;
	for (int i = 0; i < steps; i++, move *= 0.5) {
		current += check(current) ? -move : move;
	}
	return current;
}

// Modified from https://www.shadertoy.com/view/lsS3Wc
vec3 hue2rgb(float hue) {
	return clamp(abs(mod(hue * 6.0 + vec3(0.0, 4.0, 2.0), 6.0) - 3.0) - 1.0, 0.0, 1.0);
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {

	vec2 uv = fragCoord / iResolution.xy;
	
	// X axis is the estimated value, Y axis is the step
	float steps = 12.0;
	float result = search(1.0, int(uv.y * steps));
	float line = 0.002 / abs(uv.x - result);
	fragColor.rgb = hue2rgb(floor(uv.y * steps) / steps) * line;
	
	// Vignette
	fragColor.rgb += smoothstep(0.1, 1.0, length(uv - 0.5)) * 0.25;
}