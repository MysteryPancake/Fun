// Available at https://www.shadertoy.com/view/WtByDR

#define pi 3.1415926538

// MIDI note to frequency formula
float noteFreq(float note) {
	return 440.0 * exp2(floor(note - 69.0) / 12.0);
}

// From https://www.shadertoy.com/view/llByWR
float sawtooth(float time, float x) {
	// Smooth harsh attack
	float smoothAttack = min(1.0, time * 50.0);
	return (1.0 - 2.0 * acos((1.0 - time) * -cos(x / 2.0)) / pi) * (2.0 * atan(sin(x / 2.0) / time) / pi) * smoothAttack;
}

float arpeggiate(float time, float baseNote, float range, float notesPerSecond, float repeat) {
	return mod(floor(time / notesPerSecond), repeat) * range + baseNote;
}

vec2 mainSound(in int samp, float time) {
	
	const float phaseOffset = 0.01;

	float bass = arpeggiate(time, 69.0, 3.0, 2.0, 2.0);
	float low = arpeggiate(time, 81.0, 3.0, 2.0, 2.0);
	float mid = arpeggiate(time, 85.0, 2.0, 1.0, 4.0);
	float high = arpeggiate(time, 93.0, 3.0, 2.0, 2.0);
	float higher = arpeggiate(time, 97.0, 2.0, 1.0, 4.0);
	if (mod(floor(time / 16.0), 2.0) != 0.0) {
		bass = arpeggiate(time, 69.0, 2.0, 2.0, 2.0);
		low = arpeggiate(time, 81.0, 2.0, 2.0, 2.0);
		mid = arpeggiate(time, 81.0, 2.0, 2.0, 4.0);
		high = arpeggiate(time, 93.0, 2.0, 2.0, 2.0);
		higher = arpeggiate(time, 105.0, 2.4, 0.25, 4.0);
	}
	
	float[] notes = float[] (bass, low, mid, high, higher);
	float[] amplitudes = float[] (1.2, 1.0, 1.2, 0.6, 0.3);
	
	vec2 result = vec2(0.0);
	
	for (int i = 0; i < notes.length(); i++) {
		float repeat = mod(time, 0.25) * (5.0 - cos(time) * 2.0);
		if (i == 0) {
			repeat = mod(time, 0.125) * (2.0 - cos(time));
		}
		repeat = min(repeat, 0.7 + cos(time * 0.25) * 0.3);
		
		float offsetLeft = sin(float(i)) * phaseOffset;
		result.x += sawtooth(repeat, (time + offsetLeft) * noteFreq(notes[i])) * amplitudes[i];
		
		float offsetRight = cos(float(i)) * phaseOffset;
		result.y += sawtooth(repeat, (time + offsetRight) * noteFreq(notes[i])) * amplitudes[i];
	}
	
	return result / float(notes.length());
}