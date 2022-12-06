// Available at https://www.shadertoy.com/view/ms2XW1

// COMMON

const float PI = 3.1415926538;
const float PI_4 = PI * 0.25;
const float TAU = PI * 2.0;

const float BPM = 200.0;
const float STEP = 60.0 / BPM;

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

// From https://www.shadertoy.com/view/4sBfRd
vec4 char(vec2 p, int c) {
	if (p.x < 0.0 || p.x > 1.0 || p.y < 0.0 || p.y > 1.0) {
		return vec4(0.0);
	}
	vec2 scaled = p / 16.0;
	return textureGrad(iChannel0, scaled + fract(vec2(c, 15 - c / 16) / 16.0), dFdx(scaled), dFdy(scaled));
}

// Modified from https://iquilezles.org/articles/distfunctions2d/
float line(vec2 p, vec2 dir) {
	return length(p - dir * max(dot(p, dir) / dot(dir, dir), 0.0));
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
	if (iResolution.y < 2000.0) {
		float c = message(fragCoord / 8.0);
		if (c >= 0.0){
			fragColor = vec4(c);
			return;
		}
	}
	
	// Center UV coordinates
	vec2 uv = (fragCoord - 0.5 * iResolution.xy) / min(iResolution.x, iResolution.y);
	
	// Start with white background
	fragColor = vec4(1.0);
	float id = floor(iTime / STEP / 4.0);
	
	// Draw each note
	for (int i = 0; i < 12; i++) {
		float phase = float(i) / 12.0 * TAU;
		float radius = 5.0 - sin(PI_4 * (float(i % 2) + iTime) / STEP) * 0.25;
		if (id >= 16.0) {
			radius -= mod(iTime, STEP * 2.0);
		}
		vec2 offset = vec2(cos(phase), sin(phase)) * radius;
		
		// Draw lines around circle
		vec2 dir = vec2(cos(phase + PI_4), sin(phase + PI_4));
		fragColor *= mix(smoothstep(0.0025, 0.005, line(uv, dir)), 1.0, 0.5);
		
		// Draw note letters
		int charIndex = 65 + (5 + i) * 3 % 7;
		fragColor -= char(0.5 + uv * 14.0 + offset, charIndex).r;
		
		// Draw sharp symbols
		if (i <= 6) {
			fragColor -= char(uv * 14.0 + offset, 15).r;
		}
	}
	
	// Draw red highlight
	const vec4 red = vec4(1.0, 0.0, 0.0, 1.0);
	float phase = id * PI / 6.0;
	vec2 angle = vec2(sin(phase), cos(phase));
	float factor = smoothstep(0.0, 0.02, line(uv, angle) - length(uv) * 0.25);
	fragColor += red * (1.0 - factor);
	
	// Draw vignette
	fragColor *= smoothstep(0.0, 0.1, 0.5 - length(uv));
}

// SOUND

#define msin(x,m) sin(TAU * (x) + (m))

// MIDI note to frequency formula
float noteFreq(float note) {
	return 440.0 * exp2((note - 69.0) / 12.0);
}

// 1D hash, from https://www.shadertoy.com/view/4djSRW
float hash(float p) {
	p = fract(p * 0.1031);
	p *= p + 33.33;
	p *= p + p;
	return fract(p);
}

// From https://www.shadertoy.com/view/3scfD2
vec2 epiano(float freq, float t, float nuance) {
	vec2 f0 = vec2(freq * 0.998, freq * 1.002);
	vec2 glass = msin((f0 + 3.0) * t, msin(14.0 * f0 * t, 0.0) * exp(-30.0 * t) * nuance) * exp(-4.0 * t) * nuance;
	glass = sin(glass);
	vec2 body = msin(f0 * t, msin(f0 * t, 0.0) * exp(-0.5 * t) * nuance * pow(440.0 / f0.x, 0.5)) * exp(-t) * nuance;
	return (glass + body) * smoothstep(0.0, 0.001, t) * 0.1;
}

// From https://www.shadertoy.com/view/tttfRj
float noise(float s) {
	int si = int(floor(s));
	float sf = fract(s);
	sf = smoothstep(0.0, 1.0, sf);
	return mix(hash(float(si)), hash(float(si + 1)), sf) * 2.0 - 1.0;
}

// From https://www.shadertoy.com/view/sls3WM
float coloredNoise(float time, float freq, float Q) {
	return sin(2.0 * PI * freq * fract(time)) * noise(time * Q);
}

// From https://www.shadertoy.com/view/sls3WM
float kick(float time) {
	const float df = 512.0, dftime = 0.01, freq = 60.0;
	float phase = 2.0 * PI * (freq * time - df * dftime * exp(-time / dftime));
	float body = sin(phase) * smoothstep(0.3, 0.0, time) * 1.5;
	float click = coloredNoise(time, 8000.0, 2000.0) * smoothstep(0.007, 0.0, time);
	return body + click;
}

vec2 noiseHit(float time, float fade) {
	return (vec2(hash(time * 2048.0), hash(time * 1024.0)) * 2.0 - 1.0) * exp(-fade * time);
}

// Notes are auto-transposed using modulo, so they wrap to the same octave
vec2 chord(float time, float offset, float minor, float funk, float hats) {

	vec2 result = vec2(0.0);
	
	// Bass
	const float bass = 57.0;
	result += epiano(noteFreq(bass + mod(offset, 12.0) - 24.0), time, 2.0);
	
	// Hi-hats
	result += noiseHit(mod(time, STEP), 30.0) * hats;
	
	// Root (bass plus 2 octaves)
	result += epiano(noteFreq(bass + mod(offset, 12.0)), time - STEP * 0.5, 1.25);
	// Third
	result += epiano(noteFreq(bass + mod(offset + 4.0 - minor, 12.0)), time - STEP * funk, 1.5);
	// Fifth
	result += epiano(noteFreq(bass + mod(offset + 7.0, 12.0)), time - STEP * 0.5, 1.25);
	// Seventh
	result += epiano(noteFreq(bass + mod(offset + 11.0 - minor, 12.0)), time - STEP * funk, 1.5);
	// Ninth
	result += epiano(noteFreq(bass + mod(offset + 14.0, 12.0)), time - STEP * funk, 1.5);
	
	return result;
}

vec2 mainSound(int samp, float time) {

	// Unique identifier for current beat
	float id = floor(time / STEP / 4.0);
	// Circle of fifths, move up a fifth each step (7 MIDI notes)
	float offset = id * 7.0;
	// Play a minor chord for every 3 major chords
	float minor = mod(id, 4.0) >= 3.0 ? 1.0 : 0.0;
	// Funkier timing every 4 chords
	float funk = mod(id, 8.0) >= 4.0 ? 1.5 : 1.0;
	// Add hi-hats after a bit
	float hats = id >= 8.0 ? 0.07 : 0.0;
	
	float t = mod(time, STEP * 4.0);
	vec2 result = chord(t, offset, minor, funk, hats);
	// Two tap ping-pong delay
	result += vec2(0.5, 0.2) * chord(t - STEP * 0.5, offset, minor, funk, hats);
	result += vec2(0.05, 0.1) * chord(t - STEP, offset, minor, funk, hats);
	
	// Kick drum
	if (id >= 16.0) {
		result += kick(mod(time, STEP * 2.0)) * 0.45;
	}
	
	return result;
}