// Available at https://www.shadertoy.com/view/dtlSWH

// COMMON

// Based on the famous "Cookbook formulae for audio EQ biquad filter coefficients"
// Huge thanks to Robert Bristow-Johnson and Tom St Denis!

// There's 2 types of filters: IIR and FIR

// This shader implements an IIR filter (not the best idea)
// IIR stands for infinite impulse, it's meant to run on infinite past samples
// This isn't possible in parallel, so I had to clamp the range below

// It'd be better to use a FIR filter instead
// FIR filters use convolution with a sinc-based kernel
// They have artifacts too, but probably less than this shader

const float PI = 3.1415926;
const int PAST_SAMPLES = 128;

// Filter types
const int LOW_PASS = 0;
const int HIGH_PASS = 1;
const int BAND_PASS = 2;
const int NOTCH = 3;
const int PEAKING = 4;
const int LOW_SHELF = 5;
const int HIGH_SHELF = 6;

struct BiquadFilter {
    // Coefficients used for visualization
    float a0, a1, a2, b0, b1, b2;
    // Sample tracking variables
	vec2 x1, x2, y1, y2;
};

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
    float phase = PI * 2.0 * (freq * time - df * dftime * exp(-time / dftime));
    float body = sin(phase) * smoothstep(0.3, 0.0, time) * 2.0;
    float click = coloredNoise(time, 8000.0, 2000.0) * smoothstep(0.007, 0.0, time);
    return body + click * 2.0;
}

// Saw wave defined in samples to reduce aliasing
float waveSaw(float freq, int samp) {
    return fract(freq * float(samp) / iSampleRate) * 2.0 - 1.0;
}

// Offset the right channel for better stereo width
vec2 widerSaw(float freq, int samp) {
    int offset = int(freq) * 64;
    return vec2(waveSaw(freq, samp - offset), waveSaw(freq, samp + offset));
}

// Dry sample (no equalization)
vec2 drySample(int samp) {

    // Imprecise time for drums and noise, not ideal
    float time = float(samp) / iSampleRate;

    // Main saw chords
    vec2 result = widerSaw(noteFreq(38.0), samp);
    result += widerSaw(noteFreq(45.0), samp);
    result += widerSaw(noteFreq(66.0), samp);
    result += widerSaw(noteFreq(69.0), samp);
    result += widerSaw(noteFreq(76.0), samp);
    result += widerSaw(noteFreq(80.0), samp);
    
    // Treble noise
    result.x += coloredNoise(time, 14000.0, 3000.0) * 0.75;
    result.y += coloredNoise(time + 0.5, 14000.0, 3000.0) * 0.75;
    
    // Kick and sidechain
    float sidechain = mod(time, 0.5);
    result *= min(1.0, sidechain * 3.0);
    result += kick(sidechain) * 2.0;
    
    return result * 0.1;
}

// From "Simple implementation of Biquad filters" by Tom St Denis
BiquadFilter computeCoefficients(BiquadFilter biquad, int filterType, float dbGain, float freq, float Q) {

    float A = pow(10.0, dbGain / 40.0);
    float omega = 2.0 * PI * freq / iSampleRate;
    float sn = sin(omega);
    float cs = cos(omega);

    // Using Q alpha to make it easier to visualize
    float alpha = sn / (2.0 * Q);
    float beta = sqrt(A + A);

    switch (filterType) {
    case LOW_PASS:
        biquad.b0 = (1.0 - cs) * 0.5;
        biquad.b1 = 1.0 - cs;
        biquad.b2 = (1.0 - cs) * 0.5;
        biquad.a0 = 1.0 + alpha;
        biquad.a1 = -2.0 * cs;
        biquad.a2 = 1.0 - alpha;
        break;
    case HIGH_PASS:
        biquad.b0 = (1.0 + cs) * 0.5;
        biquad.b1 = -(1.0 + cs);
        biquad.b2 = (1.0 + cs) * 0.5;
        biquad.a0 = 1.0 + alpha;
        biquad.a1 = -2.0 * cs;
        biquad.a2 = 1.0 - alpha;
        break;
    case BAND_PASS:
        biquad.b0 = alpha;
        biquad.b1 = 0.0;
        biquad.b2 = -alpha;
        biquad.a0 = 1.0 + alpha;
        biquad.a1 = -2.0 * cs;
        biquad.a2 = 1.0 - alpha;
        break;
    case NOTCH:
        biquad.b0 = 1.0;
        biquad.b1 = -2.0 * cs;
        biquad.b2 = 1.0;
        biquad.a0 = 1.0 + alpha;
        biquad.a1 = -2.0 * cs;
        biquad.a2 = 1.0 - alpha;
        break;
    case PEAKING:
        biquad.b0 = 1.0 + (alpha * A);
        biquad.b1 = -2.0 * cs;
        biquad.b2 = 1.0 - (alpha * A);
        biquad.a0 = 1.0 + (alpha / A);
        biquad.a1 = -2.0 * cs;
        biquad.a2 = 1.0 - (alpha / A);
        break;
    case LOW_SHELF:
        biquad.b0 = A * ((A + 1.0) - (A - 1.0) * cs + beta * sn);
        biquad.b1 = 2.0 * A * ((A - 1.0) - (A + 1.0) * cs);
        biquad.b2 = A * ((A + 1.0) - (A - 1.0) * cs - beta * sn);
        biquad.a0 = (A + 1.0) + (A - 1.0) * cs + beta * sn;
        biquad.a1 = -2.0 * ((A - 1.0) + (A + 1.0) * cs);
        biquad.a2 = (A + 1.0) + (A - 1.0) * cs - beta * sn;
        break;
    case HIGH_SHELF:
        biquad.b0 = A * ((A + 1.0) + (A - 1.0) * cs + beta * sn);
        biquad.b1 = -2.0 * A * ((A - 1.0) + (A + 1.0) * cs);
        biquad.b2 = A * ((A + 1.0) + (A - 1.0) * cs - beta * sn);
        biquad.a0 = (A + 1.0) - (A - 1.0) * cs + beta * sn;
        biquad.a1 = 2.0 * ((A - 1.0) - (A + 1.0) * cs);
        biquad.a2 = (A + 1.0) - (A - 1.0) * cs - beta * sn;
        break;
    }
    
    return biquad;
}

// Main filter processing, returns wet output in y1
BiquadFilter process(BiquadFilter biquad, int samp) {

    // Precompute coefficients
    float c0 = biquad.b0 / biquad.a0;
    float c1 = biquad.b1 / biquad.a0;
    float c2 = biquad.b2 / biquad.a0;
    float c3 = biquad.a1 / biquad.a0;
    float c4 = biquad.a2 / biquad.a0;

    // Calculate past sample
    vec2 currentSample = drySample(samp);

    // Apply the filter
    vec2 result = c0 * currentSample + c1 * biquad.x1 + c2 * biquad.x2 - c3 * biquad.y1 - c4 * biquad.y2;

    // Shift x1 to x2, sample to x1
    biquad.x2 = biquad.x1;
    biquad.x1 = currentSample;

    // Shift y1 to y2, result to y1
    biquad.y2 = biquad.y1;
    biquad.y1 = result;
    
    return biquad;
}

// Automation must be done here, so it respects past samples
BiquadFilter processAutomation(int currentSamp, float currentTime) {
    
    // Zero initial samples
    BiquadFilter biquad;
    biquad.x1 = biquad.x2 = biquad.y1 = biquad.y2 = vec2(0.0);
    
    // Run filter based on past samples
    for (int i = PAST_SAMPLES; i >= 0; i--) {
    
        int samp = currentSamp - i;
        float time = currentTime - float(i) / iSampleRate;
    
        // Modulate filter quality over time
        float Q = 1.5 + cos(time * 3.0);

        // Modulate frequency over time
        float range = iSampleRate * 0.25;
        float freq = mod(time, 28.0) >= 14.0 ? 500.0 : cos(time * PI * 2.0) * range * 0.95 + range;

        // Swap between all 7 filter types
        int filterType = int(mod(time * 0.5, 7.0));

        // Set shelving filters to 6dB of gain (200% boost)
        const float dbGain = 6.0;

        biquad = computeCoefficients(biquad, filterType, dbGain, freq, Q);
        biquad = process(biquad, samp);
    }
    
    // Return final sample and coefficients
    return biquad;
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

// Linear scale to decibel scale
float gainTodB(float gain) {
    return 20.0 * log(gain) / log(10.0);
}

// Based on https://www.desmos.com/calculator/m1m7rhdpda
float drawResponseCurve(BiquadFilter biquad, vec2 uv) {
    
    // X looks wonky, probably due to log scale
    float x = sin(0.5 * uv.x * PI);
    x *= x;

    float a = biquad.b0 + biquad.b2;
    float b = biquad.a0 + biquad.a2;
    float c = (a + biquad.b1) / 2.0;
    float d = (b + biquad.a1) / 2.0;
    
    float e = c * c - x * (4.0 * biquad.b0 * biquad.b2 * (1.0 - x) + biquad.b1 * a);
    float f = d * d - x * (4.0 * biquad.a0 * biquad.a2 * (1.0 - x) + biquad.a1 * b);
    float gain = sqrt(e / f);
    
    float volume = gainTodB(gain) * 0.05 + 0.5;
    float line = 0.01 / abs(uv.y - volume);
    
    float under = step(uv.y, volume) * 0.25 + line;
    
    return under;
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    if (iResolution.y < 2000.0) {
		float c = message(fragCoord / 8.0);
		if (c >= 0.0) {
			fragColor = vec4(c);
			return;
		}
	}
    
    vec2 uv = fragCoord / iResolution.xy;
    int samp = int(uv.x * 128.0) + iFrame;
    
    // Run biquad filter and get coefficients
    BiquadFilter biquad = processAutomation(samp, iTime);
    
    // Draw original sample in red
    float dryDist = abs(biquad.x1.x * 0.5 + 0.5 - uv.y);
    vec3 col = vec3(0.5, 0.0, 0.0) * min(1.0, 0.005 / dryDist);
    
    // Draw processed sample in yellow
    float wetDist = abs(biquad.y1.x * 0.5 + 0.5 - uv.y);
    col += vec3(0.5, 0.5, 0.0) * min(1.0, 0.005 / wetDist);
    
    // Draw magnitude response curve
    col += drawResponseCurve(biquad, uv);
    
    fragColor = vec4(col, 1.0);
}

// SOUND

vec2 mainSound(int samp, float time) {

    vec2 wet = processAutomation(samp, time).y1;
    
    // Hide the popping noise when the filter changes mode
    float fade = 1.-pow(cos(time * 1. * PI) * .5 + .5, 512.);
    
    return wet * fade;
}