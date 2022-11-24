// Available at https://www.shadertoy.com/view/ddfXRX

// COMMON

#define BPM 128.0
#define STEP 60.0 / BPM
#define LOOPSTEPS 96.0
#define PI 3.1415926538

// BUFFER A

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
	vec2 uv = fragCoord / iResolution.xy;
	float time = mod(iTime, STEP * LOOPSTEPS);
	if (mod(time, STEP) < 0.05 || time >= STEP * 32.0) {
		vec4 vid1 = texture(iChannel0, uv);
		vec4 vid2 = texture(iChannel2, uv);
		fragColor = mod(time * 0.5, STEP * 2.0) <= STEP ? vid1 : vid2;
	} else {
		fragColor = texture(iChannel1, uv);
	}
}

// IMAGE

// From https://www.shadertoy.com/view/ltfSRr
float message(vec2 uv) {
	uv -= vec2(1.0, 10.0);
	if ((uv.x < 0.0) || (uv.x >= 32.0) || (uv.y < 0.0) || (uv.y >= 3.0)) return -1.0;
	int i = 1, bit = int(exp2(floor(32.0 - uv.x)));
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
	
	// Lens distortion, see https://www.shadertoy.com/view/stdcRf
	vec2 uv = fragCoord / iResolution.xy;
	const vec2 center = vec2(0.5);
	float dist = distance(uv, center);
	vec2 dir = uv - center;
	float time = mod(iTime, STEP * LOOPSTEPS);
	float beat = mod(time, STEP);
	float lens = time >= STEP * 32.0 ? 0.3 / beat : max(0.0, 0.75 - beat);
	vec4 color = vec4(uv, 0.5, 0.0) * dist * lens;
	fragColor = texture(iChannel0, uv - dist * dir * lens) + color;
}

// SOUND

#define NOTE(note, start, end) if (time >= start * STEP && time < end * STEP) result += note;
#define NOTE_SAW(note, start, end) NOTE(superSaw(noteFreq(note), time, voices, detune) * amplitude, start, end);
#define NOTE_SINE(note, start, end) NOTE(superSine(noteFreq(note), time - start * STEP, voices, detune) * amplitude, start, end);
#define NOTE_BASS(note, start, end) NOTE(sine(noteFreq(note), time - start * STEP, 0.0, fade) * amplitude, start, end);

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

// For sawtooth synths
float saw(float freq, float time, float phase) {
	return fract(phase + freq * time) * 2.0 - 1.0;
}

// For lead whistle
float sine(float freq, float time, float phase, float fade) {
	return sin(freq * (time + phase) * PI * 2.0) * exp(-fade * time);
}

// For cymbals
vec2 noiseHit(float time, float fade) {
	return (vec2(hash(time * 512.0), hash(time * 1024.0)) - 0.5) * exp(-fade * time);
}

// Multiple saws detuned to make a unison effect
vec2 superSaw(float freq, float time, float voices, float detune) {
	vec2 result = vec2(0.0);
	// See https://www.shadertoy.com/view/mdlSRj
	for (float i = -voices; i <= voices; i++) {
		float frequency = freq + i * detune;
		result.x += saw(frequency, time, hash(2.0 * i));
		result.y += saw(frequency, time, hash(2.0 * i + 1.0));
	}
	return result / voices / 2.0;
}

// Multiple sines detuned to make a unison effect
vec2 superSine(float freq, float time, float voices, float detune) {
	vec2 result = vec2(0.0);
	// See https://www.shadertoy.com/view/mdlSRj
	for (float i = -voices; i <= voices; i++) {
		float frequency = freq + i * detune;
		result.x += sine(frequency, time, hash(2.0 * i) * PI, 1.5);
		result.y += sine(frequency, time, hash(2.0 * i + 1.0) * PI, 1.5);
	}
	return result / voices / 2.0;
}

// From https://www.shadertoy.com/view/sls3WM
float coloredNoise(float time, float freq, float Q) {
	return sin(2.0 * PI * freq * fract(time)) * hash(time * Q);
}

// From https://www.shadertoy.com/view/sls3WM
float kick(float time, float freq) {
	const float df = 512.0, dftime = 0.01;
	float phase = 2.0 * PI * (freq * time - df * dftime * exp(-time / dftime));
	float body = sin(phase) * smoothstep(0.15, 0.0, time) * 2.0;
	float click = coloredNoise(time, 8000.0, 2000.0) * smoothstep(0.01, 0.0, time);
	return body + click;
}

// Cheap snare or clap effect
vec2 snare(float time, float freq, float fade) {
	return noiseHit(time, fade) * abs(sin(freq * time * PI * 2.0));
}

vec2 leadBass(float time, float voices, float detune, float amplitude) {
	time = mod(time, STEP * 16.0);
	vec2 result = vec2(0.0);
	NOTE_SAW(57.0, 0.0, 2.0);
	NOTE_SAW(38.0, 0.0, 2.0);
	NOTE_SAW(57.0, 2.5, 6.0);
	NOTE_SAW(38.0, 2.5, 6.0);
	NOTE_SAW(57.0, 6.5, 8.0);
	NOTE_SAW(38.0, 6.5, 8.0);
	NOTE_SAW(61.0, 8.0, 9.5);
	NOTE_SAW(42.0, 8.0, 9.5);
	NOTE_SAW(59.0, 9.5, 10.0);
	NOTE_SAW(40.0, 9.5, 10.0);
	NOTE_SAW(59.0, 10.5, 12.0);
	NOTE_SAW(40.0, 10.5, 12.0);
	NOTE_SAW(56.0, 12.0, 13.5);
	NOTE_SAW(37.0, 12.0, 13.5);
	NOTE_SAW(57.0, 13.5, 14.0);
	NOTE_SAW(38.0, 13.5, 14.0);
	NOTE_SAW(57.0, 14.5, 16.0);
	NOTE_SAW(38.0, 14.5, 16.0);
	return result;
}

vec2 leadChords(float time, float voices, float detune, float amplitude, float offset) {
	time = mod(time, STEP * 16.0);
	vec2 result = vec2(0.0);
	
	// Optimize since every 2nd note is the same
	if (mod(time + STEP * offset, STEP) >= STEP * 0.5) {
		result += superSaw(noteFreq(64.0), time, voices, detune) * amplitude;
	}
	
	NOTE_SAW(66.0, 0.5, 1.0);
	NOTE_SAW(66.0, 1.5, 2.0);
	NOTE_SAW(66.0, 2.5, 3.0);
	NOTE_SAW(66.0, 3.5, 4.0);
	NOTE_SAW(69.0, 4.5, 5.0);
	NOTE_SAW(69.0, 5.5, 6.0);
	NOTE_SAW(69.0, 6.5, 7.0);
	NOTE_SAW(69.0, 7.5, 8.0);
	NOTE_SAW(69.0, 8.5, 9.0);
	NOTE_SAW(68.0, 9.5, 10.0);
	NOTE_SAW(68.0, 10.5, 11.0);
	NOTE_SAW(68.0, 11.5, 12.0);
	NOTE_SAW(73.0, 12.5, 13.0);
	NOTE_SAW(66.0, 13.5, 14.0);
	NOTE_SAW(66.0, 14.5, 15.0);
	NOTE_SAW(66.0, 15.5, 16.0);
	return result;
}

vec2 leadSine(float time, float voices, float detune, float amplitude) {
	time = mod(time, STEP * 32.0);
	vec2 result = vec2(0.0);
	NOTE_SINE(88.0, 0.0, 1.5);
	NOTE_SINE(100.0, 0.0, 1.5);
	NOTE_SINE(93.0, 1.5, 7.0);
	NOTE_SINE(81.0, 1.5, 7.0);
	NOTE_SINE(102.0, 7.0, 8.0);
	NOTE_SINE(90.0, 7.0, 8.0);
	NOTE_SINE(88.0, 8.0, 9.5);
	NOTE_SINE(100.0, 8.0, 9.5);
	NOTE_SINE(85.0, 9.5, 11.0);
	NOTE_SINE(97.0, 9.5, 11.0);
	NOTE_SINE(92.0, 11.0, 12.5);
	NOTE_SINE(80.0, 11.0, 12.5);
	NOTE_SINE(93.0, 12.5, 13.5);
	NOTE_SINE(81.0, 12.5, 13.5);
	NOTE_SINE(90.0, 13.5, 16.0);
	NOTE_SINE(78.0, 13.5, 16.0);
	NOTE_SINE(88.0, 16.0, 17.5);
	NOTE_SINE(100.0, 16.0, 17.5);
	NOTE_SINE(81.0, 17.5, 23.0);
	NOTE_SINE(93.0, 17.5, 23.0);
	NOTE_SINE(90.0, 23.0, 24.0);
	NOTE_SINE(102.0, 23.0, 24.0);
	NOTE_SINE(88.0, 24.0, 25.5);
	NOTE_SINE(100.0, 24.0, 25.5);
	NOTE_SINE(85.0, 25.5, 28.0);
	NOTE_SINE(97.0, 25.5, 28.0);
	NOTE_SINE(88.0, 28.0, 29.0);
	NOTE_SINE(100.0, 28.0, 29.0);
	NOTE_SINE(90.0, 29.0, 29.5);
	NOTE_SINE(102.0, 29.0, 29.5);
	NOTE_SINE(81.0, 29.5, 32.0);
	NOTE_SINE(93.0, 29.5, 32.0);
	return result;
}

vec2 bass(float time, float fade, float amplitude) {
	time = mod(time, STEP * 16.0);
	vec2 result = vec2(0.0);
	NOTE_BASS(38.0, 0.5, 1.0);
	NOTE_BASS(38.0, 1.0, 1.5);
	NOTE_BASS(38.0, 1.5, 2.0);
	NOTE_BASS(38.0, 2.5, 3.0);
	NOTE_BASS(38.0, 3.0, 3.5);
	NOTE_BASS(38.0, 3.5, 4.0);
	NOTE_BASS(38.0, 4.0, 4.5);
	NOTE_BASS(38.0, 4.5, 5.0);
	NOTE_BASS(38.0, 5.0, 5.5);
	NOTE_BASS(38.0, 5.5, 6.0);
	NOTE_BASS(38.0, 6.5, 7.0);
	NOTE_BASS(38.0, 7.0, 7.5);
	NOTE_BASS(38.0, 7.5, 8.0);
	NOTE_BASS(42.0, 8.0, 8.5);
	NOTE_BASS(42.0, 8.5, 9.0);
	NOTE_BASS(42.0, 9.0, 9.5);
	NOTE_BASS(40.0, 9.5, 10.0);
	NOTE_BASS(40.0, 10.5, 11.0);
	NOTE_BASS(40.0, 11.0, 11.5);
	NOTE_BASS(40.0, 11.5, 12.0);
	NOTE_BASS(37.0, 12.0, 12.5);
	NOTE_BASS(37.0, 12.5, 13.0);
	NOTE_BASS(37.0, 13.0, 13.5);
	NOTE_BASS(38.0, 13.5, 14.0);
	NOTE_BASS(38.0, 14.5, 15.0);
	NOTE_BASS(38.0, 15.0, 15.5);
	NOTE_BASS(38.0, 15.5, 16.0);
	return result;
}

vec2 cymbals(float time, float amplitude) {
	//vec2 pan = mod(time + STEP * 0.5, STEP * 2.0) > STEP ? vec2(0.5, 1.0) : vec2(1.0, 0.5);
	vec2 pan = mod(time, STEP * 2.0) > STEP ? vec2(0.5, 1.0) : vec2(1.0, 0.5);
	return noiseHit(mod(time + STEP * 0.5, STEP), 3.0) * amplitude * pan;
}

// For debugging
vec2 metronome(float time) {
	return vec2(sin(PI * 880.0 * time) * exp(-32.0 * time));
}

vec2 mainSound(int samp, float iTime) {
	
	float time = mod(iTime, STEP * LOOPSTEPS);
	float beat = mod(time, STEP);
	vec2 result = vec2(0.0);
	float sidechain = 1.0;
	
	if (time >= STEP * 16.0) {
		sidechain = 1.0 - exp(-6.0 * beat);
		result += cymbals(time, 0.4);
	}
	
	if (time >= STEP * 32.0) {
		result += kick(beat, noteFreq(33.0)) * 0.4;
		result += leadSine(time, 2.0, 4.0, 0.35);
		result += snare(mod(time + STEP, STEP * 2.0), noteFreq(21.0), 4.0);
		result += bass(time, 6.0, 0.6 * sidechain);
	}
	
	if (time < STEP * 30.5 || time >= STEP * 32.0) {
		result += leadBass(time, 1.0, 0.5, 0.4 * sidechain);
	}
	
	// Make it more funky every 2nd loop
	float funk = int(iTime / (STEP * LOOPSTEPS)) % 2 == 0 ? 0.5 : 0.0;
	result += leadChords(time, 2.0, 0.5, 0.6 * sidechain, funk);
	
	//result += metronome(beat);
	
	return clamp(result, -1.0, 1.0);
}