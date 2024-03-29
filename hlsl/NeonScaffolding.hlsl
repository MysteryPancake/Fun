// HLSL port of NeonScaffolding.glsl for ShaderFilter Plus

#pragma shaderfilter set colors__description Colors
#pragma shaderfilter set colors__min 2
#pragma shaderfilter set colors__max 8
#pragma shaderfilter set colors__default 4
#pragma shaderfilter set colors__slider true
uniform int colors;

#pragma shaderfilter set scale__description Scale
#pragma shaderfilter set scale__min 1.0
#pragma shaderfilter set scale__max 64.0
#pragma shaderfilter set scale__default 32.0
#pragma shaderfilter set scale__step 0.01
#pragma shaderfilter set scale__slider true
uniform float scale;

#pragma shaderfilter set lineWidth__description Line Width
#pragma shaderfilter set lineWidth__min 0.0
#pragma shaderfilter set lineWidth__max 1.0
#pragma shaderfilter set lineWidth__default 0.1
#pragma shaderfilter set lineWidth__step 0.01
#pragma shaderfilter set lineWidth__slider true
uniform float lineWidth;

#pragma shaderfilter set lightness__description Lightness
#pragma shaderfilter set lightness__min 0.0
#pragma shaderfilter set lightness__max 1.0
#pragma shaderfilter set lightness__default 0.8
#pragma shaderfilter set lightness__step 0.01
#pragma shaderfilter set lightness__slider true
uniform float lightness;

#pragma shaderfilter set bgAlpha__description Background
#pragma shaderfilter set bgAlpha__min 0.0
#pragma shaderfilter set bgAlpha__max 1.0
#pragma shaderfilter set bgAlpha__default 0.2
#pragma shaderfilter set bgAlpha__step 0.01
#pragma shaderfilter set bgAlpha__slider true
uniform float bgAlpha;

#pragma shaderfilter set scrollSpeed__description Scroll Speed
#pragma shaderfilter set scrollSpeed__min 0
#pragma shaderfilter set scrollSpeed__max 2048
#pragma shaderfilter set scrollSpeed__default 60
#pragma shaderfilter set scrollSpeed__slider true
uniform int scrollSpeed;

// Posterized noise
float noise(float2 p, float levels) {
	return floor(frac(sin(dot(floor(p), float2(1.989, 2.233))) * 43758.54) * levels) / levels;
}

// From https://www.shadertoy.com/view/3tdSDj, shortened by FabriceNeyret2
float sdLine(float2 p, float2 dir) {
	return length(p - dir * max(0.0, dot(p, dir) / dot(dir, dir)));
}

// Modified from https://www.shadertoy.com/view/lsS3Wc
float3 hue2rgb(float hue) {
	return clamp(abs(fmod(hue * 6.0 + float3(0.0, 4.0, 2.0), 6.0) - 3.0) - 1.0, 0.0, 1.0);
}

float4 render(float2 uv) {

	const float2 pos = (uv * builtin_uv_size + builtin_elapsed_time * scrollSpeed) / scale;
	
	// Add nice rainbow colors
	const float self = noise(pos, colors);
	const float3 bg = hue2rgb(self);
	float bgMix = 1.0;
	
	// 3 x 3 kernel, checks all 8 neighbors
	for (int x = -1; x <= 1; x++) {
		for (int y = -1; y <= 1; y++) {
		
			// Ignore self
			if (x == 0 && y == 0) continue;
			const float2 offset = float2(x, y);
			
			// Check neighbor has matching color
			if (self == noise(pos + offset, colors)) {
				// Draw a line from the center to the neighbor
				const float dist = sdLine(frac(pos) - 0.5, offset);
				bgMix = min(bgMix, dist / lineWidth);
			}
		}
	}
	
	// Combine background and lines, clip a little
	return lerp(float4(lightness + bg, 1.0), float4(bg * 1.0, bgAlpha), bgMix);
}