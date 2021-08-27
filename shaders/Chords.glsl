// Available at https://www.shadertoy.com/view/WtByDR
#define pi 3.1415926538

float noteFreq(float n) {
	return 440.0 * pow(2.0, floor(n) / 12.0);
}

// From https://www.shadertoy.com/view/llByWR
float sawtooth(float d, float x) {
	// Smooth harsh attack
	float smoothAttack = smoothstep(0.0, 1.0, d * 50.0);
	return (1.0 - 2.0 * acos((1.0 - d) * -cos(x / 2.0)) / pi) * (2.0 * atan(sin(x / 2.0) / d) / pi) * smoothAttack;
}

// Time, base note, range, notes per second, mod
float arpeggiate(float t, float b, float r, float n, float m) {
	return mod(floor(t / n), m) * r + b;
}

vec2 mainSound(float time) {
	
	const float phaseOffset = 0.01;

	float bass = arpeggiate(time, 0.0, 3.0, 2.0, 2.0);
	float low = arpeggiate(time, 12.0, 3.0, 2.0, 2.0);
	float mid = arpeggiate(time, 16.0, 2.0, 1.0, 4.0);
	float high = arpeggiate(time, 24.0, 3.0, 2.0, 2.0);
	float higher = arpeggiate(time, 28.0, 2.0, 1.0, 4.0);
	if (mod(floor(time / 16.0), 2.0) != 0.0) {
		bass = arpeggiate(time, 0.0, 2.0, 2.0, 2.0);
		low = arpeggiate(time, 12.0, 2.0, 2.0, 2.0);
		mid = arpeggiate(time, 12.0, 2.0, 2.0, 4.0);
		high = arpeggiate(time, 24.0, 2.0, 2.0, 2.0);
		higher = arpeggiate(time, 36.0, 2.4, 0.25, 4.0);
	}
	
	float[] notes = float[] (bass, low, mid, high, higher);
	float[] amplitudes = float[] (1.2, 1.0, 1.2, 0.6, 0.3);
	
	float left = 0.0;
	float right = 0.0;
	
	for (int i = 0; i < notes.length(); i++) {
		float repeat = mod(time, 0.25) * (5.0 - cos(time) * 2.0);
		if (i == 0) {
			repeat = mod(time, 0.125) * (2.0 - cos(time));
		}
		repeat = min(repeat, 0.7 + cos(time * 0.25) * 0.3);
		float offset = sin(float(i)) * phaseOffset;
		left += sawtooth(repeat, (time + offset) * noteFreq(notes[i])) * amplitudes[i];
		float offset2 = cos(float(i)) * phaseOffset;
		right += sawtooth(repeat, (time + offset2) * noteFreq(notes[i])) * amplitudes[i];
	}
	return vec2(left, right) / float(notes.length());
}
