// Available at https://www.shadertoy.com/view/mdlSRj

const float PI = 3.1415926;

// 1D hash, from https://www.shadertoy.com/view/4djSRW
float hash(float p) {
	p = fract(p * 0.1031);
	p *= p + 33.33;
	p *= p + p;
	return fract(p);
}

// MIDI note to frequency formula
float noteFreq(float note) {
	return 440.0 * exp2((note - 69.0) / 12.0);
}

// For sawtooth synth
float saw(float freq, float time, float phase) {
	return fract(phase + freq * time) * 2.0 - 1.0;
}

// For kick drum (808?)
float drum(float freq, float time) {
	return sin(freq * time * PI) * exp(-4.0 * time);
}

// For snares and hi-hats
vec2 noise(float time, float fade) {
	return (vec2(hash(time * 512.0), hash(time * 1024.0)) - 0.5) * exp(-fade * time);
}

vec2 mainSound(int samp, float time) {
	
	// MIDI notes to play
	float a = 49.0;
	float b = 53.0;
	float c = 56.0;
	float d = 60.0;
	float e = 68.0;
	float f = 75.0;
	
	// Hi-hat rhythm divisions per beat
	float rhythm = 4.0;
	
	// Base note for the drum (808?)
	float drumNote = 34.0;
	
	// Swap notes every 2 beats
	if (fract(time / 4.0) > 0.5) {
		a += 2.0;
		b += 3.0;
		c += 2.0;
		d += 3.0;
		e += 7.0;
		f += 4.0;
		drumNote += 2.0;
		rhythm -= 1.0;
	}
	
	float[] notes = float[] (noteFreq(a), noteFreq(b), noteFreq(c), noteFreq(d), noteFreq(e), noteFreq(f));
	
	// Unison spread, notes to place around each note
	const float spread = 4.0;
	
	// Detune factor in Hertz
	const float detune = 0.3;
	
	vec2 result = vec2(0.0);
	
	// Apply unison effect to each note
	for (int i = 0; i < notes.length(); i++) {
	
		// Place notes around center frequency
		for (float j = -spread; j <= spread; j++) {
			float frequency = notes[i] + j * detune;
			result.x += saw(frequency, time, hash(2.0 * j));
			result.y += saw(frequency, time, hash(2.0 * j + 1.0));
		}
	}
	
	// Prevent volume clipping
	result /= float(notes.length()) * spread;
	
	// Sidechain to sine wave
	result *= abs(sin(time * PI * 2.0));
	
	// Distort drum by making it 2x louder, then clamp to hard clip it
	result += clamp(drum(noteFreq(drumNote), fract(time * 2.0)) * 2.0, -0.9, 0.9);
	
	// Add snare every 2 drums
	result += noise(fract(time + 0.5), 5.0) * 0.6;
	
	// Add hi-hats depending on rhythm division
	result += noise(fract(time * rhythm), 7.0) * 0.5;
	
	return result;
}