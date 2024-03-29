// Available at https://www.shadertoy.com/view/cllSRn

// UV distortion for fun
vec2 distort(vec2 uv) {
	return uv * (1.0 - length(uv * 0.1));
}

// Function to converge towards, use mouse to move target
bvec2 check(vec2 guess) {
	vec2 target = iMouse.z > 0.0 ?
		distort((iMouse.xy - 0.5 * iResolution.xy) / iResolution.y)
		: vec2(sin(iTime * 2.0) * 0.5, cos(iTime * 2.0) * 0.5);
	return greaterThan(guess, target);
}

// From https://iquilezles.org/articles/distfunctions2d
float line(vec2 p, vec2 a, vec2 b) {
	vec2 pa = p - a, ba = b - a;
	float h = clamp(dot(pa, ba) / dot(ba, ba), 0.0, 1.0);
	return length(pa - ba * h);
}

// Modified from https://www.shadertoy.com/view/lsS3Wc
vec3 hue2rgb(float hue) {
	return clamp(abs(mod(hue * 6.0 + vec3(0.0, 4.0, 2.0), 6.0) - 3.0) - 1.0, 0.0, 1.0);
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {

	vec2 uv = distort((fragCoord - 0.5 * iResolution.xy) / iResolution.y);
	fragColor.rgb = vec3(0.0);
	
	// Draw grid
	vec2 grid = fract(uv * 16.0);
	fragColor.rgb += vec3(step(0.9, max(grid.x, grid.y))) * 0.05;
	
	// Binary search
	int steps = 6;
	vec2 current = vec2(0.0);
	vec2 move = vec2(0.25);
	
	for (int i = 0; i < steps; i++, move *= 0.5) {
		// Store previous for line
		vec2 last = current;
		
		// Move another half towards the target
		bvec2 result = check(current);
		current.x += result.x ? -move.x : move.x;
		current.y += result.y ? -move.y : move.y;
		
		// Draw line
		float dist = line(uv, last, current);
		float percent = float(i) / float(steps);
		vec3 hue = hue2rgb(percent);
		fragColor.rgb += hue * (0.005 + percent * 0.005) / dist;
	}
	
	// Draw vignette
	fragColor.rgb += smoothstep(0.5, 2.0, length(uv));
}