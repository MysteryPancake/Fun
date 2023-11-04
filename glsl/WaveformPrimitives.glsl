// Available at https://www.shadertoy.com/view/clXSR7

// COMMON

// Sine wave. The constant here is Tau (2 * PI)
float waveSine(float freq, float time) {
	return sin(6.28318530 * freq * time);
}

// Square wave. ceil() has less error than sign().
float waveSquare(float freq, float time) {
	return ceil(0.5 - fract(freq * time)) * 2.0 - 1.0;
}

// Triangle wave
float waveTriangle(float freq, float time) {
	return abs(fract(freq * time - 0.25) - 0.5) * 4.0 - 1.0;
}

// Sawtooth wave
float waveSaw(float freq, float time) {
	return fract(freq * time + 0.5) * 2.0 - 1.0;
}

// Pulse wave. Duty cycle is 0 to 1.
float wavePulse(float freq, float time, float duty) {
	return step(fract(freq * time), duty) * 2.0 - 1.0;
}

// IMAGE

vec3 drawWave(float x, float p) {

	const vec3 red = vec3(1.0, 0.0, 0.0);
	const vec3 yellow = vec3(1.0, 1.0, 0.0);
	const vec3 green = vec3(0.0, 1.0, 0.0);
	
	vec3 color = (x > 0.0 ? green : red) * smoothstep(1.5, 1.0, abs(p));
	float mask = 0.01 / min(abs(p - 1.0), abs(p + 1.0));
	float wave = 0.04 / abs(x - p);
	return color * (min(mask, 1.0) * 0.5 + 0.15) + wave;
}

float timeRange(float start) {
	return step(fract(iTime * 0.2 - start), 0.2) * 16.0;
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {

	const float freq = 0.25;
	vec2 uv = 18.0 * (fragCoord - 0.5 * iResolution.xy) / iResolution.y;
	
	fragColor.rgb = drawWave(waveSine(freq, uv.x - timeRange(0.0) * iTime), uv.y - 7.0);
	fragColor.rgb += drawWave(waveSquare(freq, uv.x - timeRange(0.2) * iTime), uv.y - 3.5);
	fragColor.rgb += drawWave(waveTriangle(freq, uv.x - timeRange(0.4) * iTime), uv.y);
	fragColor.rgb += drawWave(waveSaw(freq, uv.x - timeRange(0.6) * iTime), uv.y + 3.5);
	
	float duty = sin(iTime * 4.0) * 0.25 + 0.5;
	fragColor.rgb += drawWave(wavePulse(freq, uv.x - timeRange(0.8) * iTime, duty), uv.y + 7.0);
}

// SOUND

vec2 mainSound(int samp, float time) {

	const float freq = 200.0;
	time = mod(time, 5.0);
	
	float result = 0.0;
	if (time < 1.0) {
		result = waveSine(freq, time);
	} else if (time < 2.0) {
		result = waveSquare(freq, time);
	} else if (time < 3.0) {
		result = waveTriangle(freq, time);
	} else if (time < 4.0) {
		result = waveSaw(freq, time);
	} else {
		float duty = sin(time * 4.0) * 0.25 + 0.5;
		result = wavePulse(freq, time, duty);
	}
	return vec2(result * 0.1);
}