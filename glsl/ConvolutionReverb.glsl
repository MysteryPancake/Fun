// COMMON

const float BPM = 120.0;
const float SPB = 60.0 / BPM; // Seconds per beat

const float TUNING = 440.0;
const int MIDIOFFSET = 69;

const float TAU = 6.28318530;

const int REVERB_SAMPLES = 512;
const float WETNESS = 0.5;

// MIDI note to frequency formula
float noteFreq(int note) {
	return TUNING * exp2(float(note - MIDIOFFSET) / 12.0);
}

// From https://www.shadertoy.com/view/clXSR7
float waveSaw(float freq, float time) {
	return fract(freq * time + 0.5) * 2.0 - 1.0;
}

// From https://www.shadertoy.com/view/4djSRW
float hash11(float p) {
	p = fract(p * .1031);
	p *= p + 33.33;
	p *= p + p;
	return fract(p);
}

vec2 hash22(vec2 p) {
	vec3 p3 = fract(vec3(p.xyx) * vec3(.1031, .1030, .0973));
	p3 += dot(p3, p3.yzx+33.33);
	return fract((p3.xx+p3.yz)*p3.zy);
}

// Impulse for convolution, this will be sampled REVERB_SAMPLES times
vec2 impulse(float time) {
	time *= iSampleRate;
	return hash22(vec2(time * 452.3, time * 274.6)) * 2.0 - 1.0;
}

// From https://www.shadertoy.com/view/tttfRj
float noise(float s) {
	int si = int(floor(s));
	float sf = fract(s);
	sf = smoothstep(0.0, 1.0, sf);
	return mix(hash11(float(si)), hash11(float(si + 1)), sf) * 2.0 - 1.0;
}

// From https://www.shadertoy.com/view/sls3WM
float coloredNoise(float time, float freq, float bandwidth) {
	return sin(TAU * freq * fract(time)) * noise(time * bandwidth);
}

// From https://www.shadertoy.com/view/sls3WM
// Sliding pitch sine wave, used for bass drop and kick
float drop(float time, float df, float dftime, float freq) {
	return sin(TAU * (freq * time - df * dftime * exp(-time / dftime)));
}

// From https://www.shadertoy.com/view/sls3WM
float kick(float time) {
	float body = drop(time, 512.0, 0.01, 60.0) * smoothstep(0.3, 0.0, time);
	float click = coloredNoise(time, 8000.0, 2000.0) * smoothstep(0.007, 0.0, time);
	return body * 2.0 + click * 1.5;
}

vec2 hats(float time) {
	float falloff = (cos(time * TAU * 0.25 / SPB) + 2.5) * 8.0;
	vec2 noise = hash22(vec2(time * iSampleRate, time * iSampleRate * 123.4)) * 2.0 - 1.0;
	float volume = exp(-falloff * mod(time, SPB / 3.0));
	return noise * volume;
}

// No optimization here, not feeling like it today
float leadSynth(float time) {
	const int notes[] = int[](
		64,54,57,
		64,54,57,
		64,54,57,
		62,52,57,
		61,54,57,
		61,54,57,
		61,54,57,
		59,57,52
	);
	float beatTime = 1.5 * time / SPB;
	int note = notes[int(abs(beatTime)) % notes.length()];
	float volume = step(fract(beatTime), 0.5 + sin(time * TAU * 0.125 / SPB) * 0.05);
	return waveSaw(noteFreq(note), time) * volume;
}

float leadBass(float time) {
	const int notes[] = int[](
		38,38,38,
		38,38,50,
		38,38,38,
		40,40,52,
		42,42,42,
		42,54,42,
		42,42,54,
		37,49,40
	);
	float beatTime = 1.5 * time / SPB;
	int bass = notes[int(abs(beatTime)) % notes.length()];
	float volume = step(fract(beatTime - 0.5), 0.4 + cos(time * TAU * 0.125 / SPB) * 0.1);
	return waveSaw(noteFreq(bass), time) * volume;
}

struct Song {
	vec2 leads;
	vec2 drums;
	vec2 bass;
	vec2 reverb;
	float sidechain;
};

Song getSong(float time, int reverb) {
	Song song;
	song.reverb = vec2(0.0);
	for (int i = 0; i < reverb; i++) {
		float timeOffset = float(i) / iSampleRate;
		
		// Butcher the settings every 2nd time for variety
		bool variety = mod(time - timeOffset, SPB * 64.0) > SPB * 32.0;
		float offsetScale = variety ? 0.5 : 1.2;
		float timeScale = variety ? 2.0 : 1.0;
		
		// Convolution reverb doesn't have a random time offset, but it sounds better with it
		timeOffset += hash11(timeOffset * 126.7) * offsetScale;
		
		song.reverb += leadSynth(time * timeScale - timeOffset) * impulse(timeOffset);
	}
	song.reverb *= 0.105;
	
	song.leads = vec2(leadSynth(time));
	song.bass = vec2(leadBass(time) * 1.3);
	song.drums = hats(time) * 0.7 + kick(mod(time, SPB)) * 0.8;
	song.sidechain = 0.3 + min(1.0, mod(time, SPB) * 6.0) * 0.7;
	
	return song;
}

// IMAGE

// From https://www.shadertoy.com/view/cdXSWj
vec3 drawTrack(vec2 uv, vec2 samp, float offset, vec3 color) {
	float glow = min(1.0, 0.03 / abs(uv.y - samp.x * 0.05 - offset));
	float line = min(1.0, 0.003 / abs(uv.y - samp.y * 0.05 - offset));
	return line + glow * color * 0.4;
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
	vec2 uv = fragCoord / iResolution.xy;
	Song song = getSong(iTime + (uv.x - 1.0) * SPB * 0.1, REVERB_SAMPLES / 4);
	Song songNow = getSong(iTime, 0);
	float boom = 1.0 - songNow.sidechain;
	
	// Draw foreground
	vec3 col = drawTrack(uv, song.drums, 0.8 + boom * 0.1, vec3(1.0, 0.0, 0.0));
	col += drawTrack(uv, song.bass, 0.6 + boom * 0.2, vec3(1.0, 1.0, 0.0));
	col += drawTrack(uv, song.leads, 0.4 - boom * 0.2, vec3(0.0, 0.0, 1.0));
	col += drawTrack(uv, song.reverb, 0.2 - boom * 0.1, vec3(0.5, 0.0, 1.0));
	
	// Draw background
	vec2 center = uv - 0.5;
	vec2 coolUv = fract(center / dot(center, center));
	float dist = sin(iTime * 4.0 - length(coolUv - 0.5) * 24.0 - 8.0 * boom) * 0.5 + 0.5;
	col += min(2.0, (0.05 + boom) / dist) * uv.yxx * (0.1 + boom);
	
	fragColor = vec4(col, 1.0);
}

// SOUND

vec2 mainSound(int samp, float time) {
	Song song = getSong(time, REVERB_SAMPLES);
	vec2 dry = (song.leads + song.bass) * song.sidechain + song.drums;
	vec2 wet = song.reverb * song.sidechain;
	return mix(dry, wet, WETNESS) * 0.45;
}