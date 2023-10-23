// Available at https://www.shadertoy.com/view/cdXSWj

// COMMON

const float BPM = 112.0;
const float SPB = 60.0 / BPM; // Seconds per beat

// This song uses nonstandard tuning (50 cents above 440 Hertz)
const float TUNING = 440.0;
const float MIDIOFFSET = 68.5;

const float TAU = 6.28318530;

// 1D hash, from https://www.shadertoy.com/view/4djSRW
float hash(float p) {
	p = fract(p * 0.1031);
	p *= p + 33.33;
	p *= p + p;
	return fract(p);
}

// MIDI note to frequency formula
float noteFreq(float note) {
	return TUNING * exp2((note - MIDIOFFSET) / 12.0);
}

// Triangle waveform, see https://www.shadertoy.com/view/clXSR7
vec2 tri(float freq, float time, vec2 phase) {
	return abs(fract(phase + freq * time) - 0.5) * 4.0 - 1.0;
}

// Sawtooth waveform, see https://www.shadertoy.com/view/clXSR7
vec2 saw(float freq, float time, vec2 phase) {
	return fract(phase + freq * time) * 2.0 - 1.0;
}

// Basic white noise
vec2 stereoNoise(float time) {
	return vec2(hash(time * 2048.0), hash(time * 1024.0)) * 2.0 - 1.0;
}

vec2 noiseHit(float time, float fade) {
	return stereoNoise(time) * exp(-fade * time);
}

// From https://www.shadertoy.com/view/tttfRj
float noise(float s) {
	int si = int(floor(s));
	float sf = fract(s);
	sf = smoothstep(0.0, 1.0, sf);
	return mix(hash(float(si)), hash(float(si + 1)), sf) * 2.0 - 1.0;
}

// From https://www.shadertoy.com/view/sls3WM
float coloredNoise(float time, float freq, float bandwidth) {
	return sin(TAU * freq * fract(time)) * noise(time * bandwidth);
}

// Used for bass and lead synths
vec2 timedSaw(float freq, float time, float start, float end, float seed) {
	if (time >= start * SPB && time < end * SPB) {
		vec2 phase = vec2(hash(seed * 1024.0));
		// Keep bass mostly mono
		if (freq > 45.0) {
			phase += vec2(hash(1024.0 * seed + 2048.0 * start), hash(2048.0 * seed + 1024.0 * start));
		}
		return saw(noteFreq(freq), time, phase);
	}
	return vec2(0.0);
}

// Used for voices
vec2 timedTri(float freq, float time, float start, float end, float seed) {
	if (time >= start * SPB && time < end * SPB) {
		vec2 phase = vec2(hash(1024.0 * seed + 2048.0 * start), hash(2048.0 * seed + 1024.0 * start));
		float hertz = noteFreq(freq);
		float timeOffset = time - start * SPB;
		// Increase vibrato over time
		float vibrato = sin(time * freq * 0.8) * 1.6 * timeOffset;
		// Layer a triangle and saw wave, makes a string-like sound
		vec2 layers = tri(hertz, time, phase + vibrato) + saw(hertz * 2.0, time, vibrato - phase) * 0.3;
		return layers * min(0.58, timeOffset * 32.0);
	}
	return vec2(0.0);
}

// Seems to reduce compilation time
vec2 sawChord(float time, float start, float a, float b, float c, float d, float e) {
	float end = start + 0.25;
	vec2 result = timedSaw(a, time, start, end, 0.0);
	result += timedSaw(b, time, start, end, 1.0);
	result += timedSaw(c, time, start, end, 2.0);
	result += timedSaw(d, time, start, end, 3.0);
	result += timedSaw(e, time, start, end, 4.0);
	return result;
}

// Seems to reduce compilation time
vec2 lead(float time, float a, float b, float c, float d, float e, float f, float g, float h, float i, float j, float k, float l, float m, float n, float o) {
	vec2 result = vec2(0.0);
	// 3 chord repetition, optimized
	if (time <= SPB * 1.5) {
		float t = mod(time, SPB * 0.5);
		result += sawChord(t, 0.0, a, b, c, d, e);
	}
	
	// 2 chord repetition, don't know how to optimize
	result += sawChord(time, 1.75, f, g, h, i, j);
	result += sawChord(time, 2.25, f, g, h, i, j);
	// Same chord
	result += sawChord(time, 3.0, f, g, h, i, j);
	
	// Different chord
	result += sawChord(time, 3.5, k, l, m, n, o);
	return result;
}

// I wrote these notes in FL Studio, then wrote a MIDI to code conversion script
vec2 bass1(float time) {
	vec2 result = timedSaw(33.0, time, 0.0, 0.25, 0.0);
	result += timedSaw(33.0, time, 0.5, 0.75, 1.0);
	result += timedSaw(33.0, time, 1.0, 1.25, 2.0);
	result += timedSaw(35.0, time, 1.75, 2.0, 3.0);
	result += timedSaw(35.0, time, 2.25, 2.5, 4.0);
	result += timedSaw(35.0, time, 3.0, 3.25, 5.0);
	result += timedSaw(39.0, time, 3.5, 3.75, 6.0);
	result += timedSaw(40.0, time, 4.0, 4.25, 7.0);
	result += timedSaw(47.0, time, 4.5, 4.75, 8.0);
	result += timedSaw(40.0, time, 5.0, 5.25, 9.0);
	result += timedSaw(38.0, time, 5.75, 6.0, 10.0);
	result += timedSaw(40.0, time, 6.25, 6.5, 11.0);
	result += timedSaw(33.0, time, 7.0, 7.25, 12.0);
	result += timedSaw(35.0, time, 7.5, 7.75, 13.0);
	result += timedSaw(33.0, time, 8.0, 8.25, 14.0);
	result += timedSaw(33.0, time, 8.5, 8.75, 15.0);
	result += timedSaw(33.0, time, 9.0, 9.25, 16.0);
	result += timedSaw(35.0, time, 9.75, 10.0, 17.0);
	result += timedSaw(35.0, time, 10.25, 10.5, 18.0);
	result += timedSaw(35.0, time, 11.0, 11.25, 19.0);
	result += timedSaw(36.0, time, 11.5, 11.75, 20.0);
	result += timedSaw(37.0, time, 12.0, 12.25, 21.0);
	result += timedSaw(44.0, time, 12.5, 12.75, 22.0);
	result += timedSaw(37.0, time, 13.0, 13.25, 23.0);
	result += timedSaw(40.0, time, 13.75, 14.0, 24.0);
	result += timedSaw(42.0, time, 14.25, 14.5, 25.0);
	result += timedSaw(35.0, time, 15.0, 15.25, 26.0);
	result += timedSaw(42.0, time, 15.5, 15.75, 27.0);
	return result;
}

vec2 bass2(float time) {
	vec2 result = timedSaw(33.0, time, 0.0, 0.25, 0.0);
	result += timedSaw(33.0, time, 0.5, 0.75, 1.0);
	result += timedSaw(33.0, time, 1.0, 1.25, 2.0);
	result += timedSaw(35.0, time, 1.75, 2.0, 3.0);
	result += timedSaw(35.0, time, 2.25, 2.5, 4.0);
	result += timedSaw(42.0, time, 2.75, 3.0, 5.0);
	result += timedSaw(35.0, time, 3.0, 3.25, 6.0);
	result += timedSaw(39.0, time, 3.5, 3.75, 7.0);
	result += timedSaw(40.0, time, 4.0, 4.25, 8.0);
	result += timedSaw(47.0, time, 4.5, 4.75, 9.0);
	result += timedSaw(52.0, time, 5.0, 5.25, 10.0);
	result += timedSaw(38.0, time, 5.75, 6.0, 11.0);
	result += timedSaw(45.0, time, 6.25, 6.5, 12.0);
	result += timedSaw(38.0, time, 6.75, 7.0, 13.0);
	result += timedSaw(42.0, time, 7.25, 7.5, 14.0);
	result += timedSaw(35.0, time, 7.5, 7.75, 15.0);
	result += timedSaw(33.0, time, 8.0, 8.25, 16.0);
	result += timedSaw(40.0, time, 8.5, 8.75, 17.0);
	result += timedSaw(45.0, time, 9.0, 9.25, 18.0);
	result += timedSaw(40.0, time, 9.75, 10.0, 19.0);
	result += timedSaw(35.0, time, 10.25, 10.5, 20.0);
	result += timedSaw(35.0, time, 11.0, 11.25, 21.0);
	result += timedSaw(37.0, time, 11.5, 11.75, 22.0);
	result += timedSaw(37.0, time, 12.0, 12.25, 23.0);
	result += timedSaw(44.0, time, 12.5, 12.75, 24.0);
	result += timedSaw(49.0, time, 13.0, 13.25, 25.0);
	result += timedSaw(40.0, time, 13.75, 14.0, 26.0);
	result += timedSaw(42.0, time, 14.25, 14.5, 27.0);
	result += timedSaw(37.0, time, 14.75, 15.0, 28.0);
	result += timedSaw(35.0, time, 15.0, 15.25, 29.0);
	result += timedSaw(37.0, time, 15.5, 15.75, 30.0);
	return result;
}

vec2 voice1(float time) {
	return timedTri(76.0, time, 1.75, 2.0, 0.0) + timedTri(76.0, time, 2.25, 3.25, 1.0);
}

vec2 voice2(float time) {
	vec2 result = timedTri(79.0, time, 0.0, 0.3, 0.0);
	result += timedTri(79.0, time, 0.5, 0.6, 1.0);
	result += timedTri(79.0, time, 1.0, 1.3, 2.0);
	result += timedTri(76.0, time, 1.5, 1.75, 3.0);
	result += timedTri(79.0, time, 1.75, 2.0, 4.0);
	result += timedTri(78.0, time, 2.25, 3.0, 5.0);
	result += timedTri(76.0, time, 3.0, 4.0, 6.0);
	result += timedTri(79.0, time, 4.0, 4.2, 7.0);
	result += timedTri(79.0, time, 4.5, 4.7, 8.0);
	result += timedTri(79.0, time, 5.0, 5.3, 9.0);
	result += timedTri(76.0, time, 5.5, 5.75, 10.0);
	result += timedTri(78.0, time, 5.75, 6.0, 11.0);
	result += timedTri(78.0, time, 6.25, 8.0, 12.0);
	result += timedTri(79.0, time, 8.0, 8.3, 13.0);
	result += timedTri(79.0, time, 8.5, 8.7, 14.0);
	result += timedTri(79.0, time, 9.0, 9.3, 15.0);
	result += timedTri(76.0, time, 9.5, 9.75, 16.0);
	result += timedTri(79.0, time, 9.75, 10.0, 17.0);
	result += timedTri(78.0, time, 10.25, 11.0, 18.0);
	result += timedTri(76.0, time, 11.0, 11.5, 19.0);
	result += timedTri(76.0, time, 11.75, 12.0, 20.0);
	result += timedTri(83.0, time, 12.25, 12.5, 21.0);
	result += timedTri(83.0, time, 12.75, 13.25, 22.0);
	result += timedTri(81.0, time, 13.25, 13.75, 23.0);
	result += timedTri(80.0, time, 13.75, 14.25, 24.0);
	result += timedTri(78.0, time, 14.25, 14.75, 25.0);
	result += timedTri(80.0, time, 14.75, 15.25, 26.0);
	result += timedTri(76.0, time, 15.25, 16.0, 27.0);
	return result;
}

vec2 voice3(float time) {
	vec2 result = timedTri(76.0, time, 0.75, 0.95, 0.0);
	result += timedTri(76.0, time, 1.0, 1.125, 1.0);
	result += timedTri(76.0, time, 1.25, 1.45, 2.0);
	result += timedTri(76.0, time, 1.5, 1.625, 3.0);
	result += timedTri(76.0, time, 1.75, 1.95, 4.0);
	result += timedTri(91.0, time, 2.0, 2.75, 5.0);
	result += timedTri(88.0, time, 2.75, 3.5, 6.0);
	result += timedTri(86.0, time, 3.725, 4.0, 7.0);
	result += timedTri(88.0, time, 4.0, 5.5, 8.0);
	result += timedTri(76.0, time, 5.5, 5.6, 9.0);
	result += timedTri(76.0, time, 5.725, 6.0, 10.0);
	result += timedTri(76.0, time, 6.0, 6.2, 11.0);
	return result;
}

// From https://www.shadertoy.com/view/sls3WM
// Sliding pitch sine wave, used for bass drop and kick
float drop(float time, float df, float dftime, float freq) {
	return sin(TAU * (freq * time - df * dftime * exp(-time / dftime)));
}

// From https://www.shadertoy.com/view/sls3WM
float kick(float time) {
	float body = drop(time, 512.0, 0.01, 60.0) * smoothstep(0.3, 0.0, time) * 2.0;
	float click = coloredNoise(time, 8000.0, 2000.0) * smoothstep(0.007, 0.0, time);
	return body + click * 2.0;
}

// From https://www.shadertoy.com/view/NddSzl
vec2 snare(float time) {
	vec2 snoise = stereoNoise(time) + coloredNoise(time, 600.0, 1000.0);
	float nenv = (exp(-5.0 * time) + exp(-30.0 * time)) * smoothstep(0.2, 0.0, time) * 0.3;
	const float speed = 20.0;
	float phase = TAU * 180.0 * time + TAU * 80.0 / speed * (1.0 - exp(-time * speed));
	float body = sin(phase) * smoothstep(0.0, 0.005, time) * smoothstep(0.05, 0.0, time);
	return snoise * nenv + body * 3.8;
}

// Exponential sidechain curve
float sidechain(float time, float speed) {
	return 1.0 - exp(time * -speed);
}

// For visualisation
struct Song {
	vec2 drums;
	vec2 bass;
	vec2 lead;
	vec2 voice;
	float sidechain;
};

Song getSong(float time) {

	Song song;
	song.drums = song.bass = song.voice = song.lead = vec2(0.0);
	
	// Initial echos on lead synth
	int leadEchos = 4;
	// Sidechain factor (0-1)
	song.sidechain = 1.0;
	// Temporary variable for sidechain
	float t = 0.0;
	
	if (time >= SPB * 15.2) {
		// Snare 1
		t = mod(time - SPB * 3.2, SPB * 4.0);
		song.drums += snare(t);
		song.sidechain *= sidechain(t, 6.0);
		// Bass drop
		if (time < SPB * 16.0) {
			song.bass += clamp(drop(t, 70.0, 0.2, 40.0) * 5.0, -0.7, 0.7) * song.sidechain;
		}
	}
	
	// Drum fill, surrounds snare 1
	t = mod(time, SPB * 16.0) - SPB * 14.7;
	if (t > 0.0) {
		song.drums += kick(t) * 0.45;
		song.sidechain *= sidechain(t, 8.0);
		t -= SPB * 0.34;
		if (t > 0.0) {
			song.drums += kick(t) * 0.5;
			song.sidechain *= sidechain(t, 8.0);
		}
		t -= SPB * 0.5;
		if (t > 0.0) {
			song.drums += kick(t) * 0.55;
			song.sidechain *= sidechain(t, 8.0);
		}
	}
	
	if (time >= SPB * 16.0) {
		// Add more delay after the intro
		leadEchos = 7;
		
		// Kick
		t = mod(time, SPB * 4.0);
		song.drums += kick(t) * 0.7;
		song.sidechain *= sidechain(t, 5.0);

		// Snare 2
		t = mod(time - SPB * 1.2, SPB * 4.0);
		song.drums += snare(t);
		song.sidechain *= sidechain(t, 6.0);

		// Bass
		for (int i = 0; i <= 2; i++) {
			// Linear delay, repeats every 0.05 seconds
			float delay = float(i) * 0.05;
			// Fade echo volume linearly (1 to 0)
			float fade = 1.0 - float(i) / 3.0;
			// Ping-pong panning, pans each echo left then right
			vec2 pan = i <= 0 ? vec2(1.0) : (i % 2 == 0 ? vec2(1.0, 0.5) : vec2(0.5, 1.0));
			song.bass += bass1(mod(time - SPB * 16.0, SPB * 32.0) - delay) * song.sidechain * 0.65 * fade * pan;
			song.bass += bass2(mod(time, SPB * 32.0) - delay) * song.sidechain * 0.65 * fade * pan;
		}
	}
	
	// Wiggle volume a bit to add variety
	float tremolo = 1.0 - sin(time / SPB * TAU) * 0.1;
	
	// Lead voices
	for (int i = 0; i <= 2; i++) {
		// Linear delay
		float delay = float(i) * 0.13;
		// Fade echo volume linearly (1 to 0)
		float fade = 1.0 - float(i) / 3.0;
		// Ping-pong panning, pans each echo right then left
		vec2 pan = i <= 0 ? vec2(1.0) : (i % 2 == 1 ? vec2(1.0, 0.0) : vec2(0.0, 1.0));
		// RIP compilation time
		if (time >= SPB * 16.0) {
			if (mod(time - SPB * 16.0, SPB * 48.0) >= SPB * 32.0) {
				song.voice += voice3(mod(time, SPB * 8.0) - delay) * fade * pan * song.sidechain * tremolo;
			} else {
				song.voice += voice2(mod(time, SPB * 16.0) - delay) * fade * pan * song.sidechain * tremolo;
			}
		} else if (time >= SPB * 8.0) {
			song.voice += voice1(mod(time, SPB * 4.0) - delay) * fade * pan * song.sidechain * tremolo;
		}
	}
	
	// Cut lead delay every few bars for variety
	if (time >= SPB * 64.0 && mod(time, SPB * 64.0) < SPB * 32.0) leadEchos = 0;
	
	// Lead synths
	for (int i = 0; i <= leadEchos; i++) {
		// Exponential delay, seems to reduce phase weirdness
		float delay = (exp(float(i) * 0.1) - 1.0) * 0.5;
		// Fade echo volume linearly (1 to 0)
		float fade = 1.0 - float(i) / float(leadEchos + 1);
		// Ping-pong panning, pans each echo left then right
		vec2 pan = i <= 0 ? vec2(1.0) : (i % 2 == 0 ? vec2(1.0, 0.4) : vec2(0.4, 1.0));
		
		// First bar
		song.lead += lead(mod(time, SPB * 8.0) - delay,
			45.0, 52.0, 60.0, 64.0, 67.0,
			47.0, 54.0, 57.0, 62.0, 66.0,
			47.0, 55.0, 57.0, 62.0, 66.0
		) * song.sidechain * 0.2 * fade * pan * tremolo;
		
		// Repeats after first bar (1st time)
		song.lead += lead(mod(time - SPB * 4.0, SPB * 16.0) - delay,
			52.0, 59.0, 59.0, 64.0, 67.0,
			52.0, 57.0, 57.0, 62.0, 66.0,
			52.0, 57.0, 57.0, 62.0, 66.0
		) * song.sidechain * 0.2 * fade * pan * tremolo;
		
		// Repeats after first bar (2nd time)
		song.lead += lead(mod(time - SPB * 12.0, SPB * 16.0) - delay,
			49.0, 56.0, 59.0, 64.0, 68.0,
			49.0, 56.0, 56.0, 59.0, 64.0,
			49.0, 56.0, 57.0, 59.0, 64.0
		) * song.sidechain * 0.2 * fade * pan * tremolo;
	}
	
	// Hats, first panned right, second panned left
	song.drums += noiseHit(mod(time, SPB * 0.5), 36.0) * 0.45 * vec2(0.6, 1.0);
	song.drums += noiseHit(mod(time - SPB / 6.0, SPB * 0.5), 36.0) * 0.49 * vec2(1.0, 0.6);
	
	// More hats, adds more high end
	if (time > SPB * 32.75) {
		float offset = time + SPB * 0.25;
		t = mod(offset, SPB);
		vec2 hat = vec2(coloredNoise(t, 13000.0, 6000.0), coloredNoise(t, 13000.0, 6200.0));
		// Ping-pong panning, pans left then right
		vec2 pan = mod(offset, SPB * 2.0) >= SPB ? vec2(1.0, 0.3) : vec2(0.3, 1.0);
		song.drums += hat * exp(-5.0 * t) * pan * song.sidechain * 0.5;
	}
	
	const float freq = 16000.0;
	const float bandwidth = 10000.0;
	
	// Riser
	if (time < SPB * 16.0) {
		song.drums += coloredNoise(time, freq, bandwidth) * exp(0.8 * (time - SPB * 16.0)) * song.sidechain * 0.35;
	}
	// Faller
	if (time > SPB * 16.0) {
		song.drums += coloredNoise(time, freq, bandwidth) * exp(SPB * 16.0 - time) * song.sidechain * 0.3;
	}
	
	return song;
}

// IMAGE

vec3 drawTrack(vec2 uv, vec2 samp, float offset, vec3 color) {
	float glow = min(1.0, 0.03 / abs(uv.y - samp.x * 0.1 - offset));
	float line = min(1.0, 0.003 / abs(uv.y - samp.y * 0.1 - offset));
	return line + glow * color * 0.4;
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
	vec2 uv = fragCoord / iResolution.xy;
	Song song = getSong(iTime + (uv.x - 1.0) * SPB * 0.5);
	Song songNow = getSong(iTime);
	float boom = 1.0 - songNow.sidechain;
	
	// Draw foreground
	vec3 col = drawTrack(uv, song.drums, 0.8 + boom * 0.1, vec3(1.0, 0.0, 0.0));
	col += drawTrack(uv, song.bass, 0.6 + boom * 0.2, vec3(1.0, 1.0, 0.0));
	col += drawTrack(uv, song.voice, 0.4 - boom * 0.2, vec3(0.0, 1.0, 0.0));
	col += drawTrack(uv, song.lead, 0.2 - boom * 0.1, vec3(0.0, 0.0, 1.0));
	
	// Draw background
	vec2 center = uv - 0.5;
	vec2 coolUv = fract(center / dot(center, center));
	float dist = abs(coolUv.y - song.drums.x * 0.5 - 0.5);
	col += min(1.0, 0.02 / dist) * 0.2;
	
	// Glow effects
	col *= 1.0 + boom * 2.0;
	col += smoothstep(0.4, 0.6, length(uv - 0.5)) * boom * 0.5;
	fragColor = vec4(col, 1.0);
}

// SOUND

vec2 mainSound(int samp, float time) {
	Song song = getSong(time);
	return 0.75 * (song.drums + song.bass + song.lead + song.voice);
}