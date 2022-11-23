// Available at https://www.shadertoy.com/view/mdlSRj

// IMAGE

// From https://www.shadertoy.com/view/ltfSRr
float message(vec2 uv) {
	uv -= vec2(1.0, 10.0);
	if ((uv.x < 0.0) || (uv.x >= 32.0) || (uv.y < 0.0) || (uv.y >= 3.0)) return -1.0;
	int i = 1, bit = int(pow(2.0, floor(32.0 - uv.x)));
	if (int(uv.y) == 2) i = 928473456 / bit;
	if (int(uv.y) == 1) i = 626348112 / bit;
	if (int(uv.y) == 0) i = 1735745872 / bit;
	return float(i - 2 * (i / 2));
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
	if (iResolution.y < 2000.0) {
		float c = message(fragCoord / 8.0);
		if (c >= 0.0){
			fragColor = vec4(c);
			return;
		}
	}
	fragColor = vec4(fragCoord / iResolution.xy, 0.5 + 0.5 * mod(iTime, 0.5), 1.0);
}

// SOUND

#define pi 3.1415926538

// 1D hash, from https://www.shadertoy.com/view/4djSRW
float hash(float p) {
	p = fract(p * 0.1031);
	p *= p + 33.33;
	p *= p + p;
	return fract(p);
}

// Midi note to frequency formula
float noteFreq(float note) {
	return 440.0 * pow(2.0, floor(note) / 12.0);
}

// For sawtooth synth
float saw(float freq, float time, float phase) {
	return (fract(phase + freq * time / pi) - 0.5) * 2.0;
}

// For kick drum (808?)
float drum(float freq, float time) {
	return sin(freq * time / pi) * exp(-4.0 * time);
}

// For snares and hi-hats
vec2 noise(float time, float fade) {
	return (vec2(hash(time * 512.0), hash(time * 1024.0)) - 0.5) * exp(-fade * time);
}

vec2 mainSound(int samp, float time) {
	
	// Midi notes (might be offset wrong)
	float a = 0.0;
	float b = 4.0;
	float c = 7.0;
	float d = 11.0;
	float e = 19.0;
	float f = 26.0;
	
	// Hi-hat rhythm divisions per beat
	float rhythm = 4.0;
	
	// Base note for the drum (808?)
	float drumNote = 5.0;
	
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
	vec2 result = vec2(0.0);
	
	// Apply unison effect to each note
	for (int i = 0; i < notes.length(); i++) {
	
		// Place notes around center frequency
		for (float j = -spread; j <= spread; j++) {
			float frequency = notes[i] + j;
			float amplitude = abs(sin(time * pi * 2.0));
			result.x += saw(frequency, time, hash(2.0 * j)) * amplitude;
			result.y += saw(frequency, time, hash(2.0 * j + 1.0)) * amplitude;
		}
	}
	
	// Prevent volume clipping
	result /= float(notes.length()) * spread;
	
	// Distort drum by making it 2x louder, then clamp to hard clip it
	result += clamp(drum(noteFreq(drumNote), fract(time * 2.0)) * 2.0, -0.9, 0.9);
	
	// Add snare every 2 drums
	result += noise(fract(time + 0.5), 5.0) * 0.6;
	
	// Add hi-hats depending on rhythm division
	result += noise(fract(time * rhythm), 7.0) * 0.5;
	
	return result;
}