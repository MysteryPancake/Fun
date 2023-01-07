// Available at https://www.shadertoy.com/view/ctS3Dz

// BUFFER A

// From https://www.shadertoy.com/view/4djSRW
float hash(float p) {
	p = fract(p * 0.1031);
	p *= p + 33.33;
	p *= p + p;
	return fract(p);
}

// From https://www.shadertoy.com/view/4djSRW
vec2 hash2d(float p) {
	vec3 p3 = fract(vec3(p) * vec3(0.1031, 0.1030, 0.0973));
	p3 += dot(p3, p3.yzx + 33.33);
	return fract((p3.xx + p3.yz) * p3.zy);
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {

	// Initialize with solid black
	if (iFrame < 1) {
		fragColor.r = 0.0;
		return;
	}
	
	vec2 uv = fragCoord / iResolution.xy;
	float maxVelocity = 2.0 / iResolution.y;
	vec2 offset = vec2(0.0, maxVelocity - cos(iTime * 0.5) * maxVelocity);
	
	// Sample with offset to slide rain down screen
	float a = texture(iChannel0, uv).r;
	float b = texture(iChannel0, uv + offset).r;
	fragColor.r = max(a, b);
	
	// Fade towards blur over time
	fragColor.r = max(0.0, fragColor.r - 0.03);
	
	// Draw 16 drops on screen each frame
	const float drops = 16.0;
	for (float i = 0.0; i < drops; i++) {
		float seed = (iTime + i) * 1024.0;
		vec2 pos = hash2d(seed) * iResolution.xy;
		float size = 4.0 + hash(seed) * 8.0;
		fragColor.r += smoothstep(size, 0.0, distance(fragCoord, pos));
	}
}

// IMAGE

void mainImage(out vec4 fragColor, in vec2 fragCoord) {

	vec2 uv = fragCoord / iResolution.xy;
	
	// Read blur amount from buffer
	float blur = texture(iChannel1, uv).r;
	
	// Use LOD levels to blur texture
	vec4 tex = textureLod(iChannel0, uv, 7.0 - blur * 6.0);
	
	// Add lightning
	tex += exp(mod(iTime - 1.0, 6.0) * -5.0) * (sin(iTime * 36.0) * 0.2 + 0.2);
	
	// Click to show rain matte
	fragColor = iMouse.z > 0.0 ? vec4(blur) : tex * tex;
}

// SOUND

const float TAU = 6.28318530;

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
	return sin(TAU * freq * fract(time)) * noise(time * Q);
}

// Works like Waveshaper in FL Studio
float distort(float x, float time) {
	// Curved distortion, more bass
	float a = smoothstep(0.2, 1.0, abs(x));
	// Straight distortion, more treble
	float b = clamp((abs(x) - 0.6) * 1.5, 0.0, 1.0);
	// Unipolar distortion, same for positive and negative sides
	return sign(x) * mix(a, b, cos(time * 0.5) * 0.5 + 0.5);
}

vec2 mainSound(int samp, float time) {

	vec2 result = vec2(0.0);
	
	// Lightning
	float amplitude = min(1.0, exp(mod(time - 1.0, 6.0) * -0.5));
	result.x += coloredNoise(time, 20.0, 500.0) * amplitude;
	result.y += coloredNoise(time + 1.5, 20.0, 500.0) * amplitude;
	
	// Low frequency rumble
	result.x += coloredNoise(time, 100.0, 1000.0) * 0.3;
	result.y += coloredNoise(time + 1.5, 100.0, 1000.0) * 0.3;
	
	// Mid frequency rumble
	result.x += coloredNoise(time, 700.0, 2000.0) * 0.05;
	result.y += coloredNoise(time + 1.5, 700.0, 2000.0) * 0.05;
	
	// Distorted noise for rain
	result.x += distort(coloredNoise(time, 120.0, 2000.0), time) * 0.25;
	result.y += distort(coloredNoise(time + 1.5, 120.0, 2000.0), time) * 0.25;
	
	return result;
}