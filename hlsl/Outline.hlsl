// HLSL port of Outline.glsl for OBS ShaderFilter Plus

#pragma shaderfilter set color__description Color
#pragma shaderfilter set color__default FFFFFFFF
uniform float4 color;

#pragma shaderfilter set steps__description Steps
#pragma shaderfilter set steps__min 1.0
#pragma shaderfilter set steps__max 64.0
#pragma shaderfilter set steps__default 16.0
#pragma shaderfilter set steps__slider true
uniform float steps;

#pragma shaderfilter set width__description Width
#pragma shaderfilter set width__min 0.0
#pragma shaderfilter set width__max 4.0
#pragma shaderfilter set width__default 1.0
#pragma shaderfilter set width__step 0.01
#pragma shaderfilter set width__slider true
uniform float width;

#pragma shaderfilter set opacity__description Opacity
#pragma shaderfilter set opacity__min 0.0
#pragma shaderfilter set opacity__max 1.0
#pragma shaderfilter set opacity__default 1.0
#pragma shaderfilter set opacity__step 0.01
#pragma shaderfilter set opacity__slider true
uniform float opacity;

float4 render(float2 uv) {

	const float total = steps / 6.28318530;
	float4 result;

	for (float i = 0.0; i < steps; i++) {
		// Sample image in a circular pattern
		const float j = i / total;
		const float4 col = image.Sample(builtin_texture_sampler, uv + float2(sin(j), cos(j)) * width * 0.1);
		result = lerp(result, color, col.a);
	}

	const float4 base = image.Sample(builtin_texture_sampler, uv);
	return lerp(result * opacity, base, base.a);
}