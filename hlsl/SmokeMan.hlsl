// HLSL port of SmokeMan.glsl for OBS ShaderFilter Plus

#pragma shaderfilter set tintColor__description Tint
#pragma shaderfilter set tintColor__default FFFF00FF
uniform float4 tintColor;

#pragma shaderfilter set baseMix__description Base Mix
#pragma shaderfilter set baseMix__min 0.0
#pragma shaderfilter set baseMix__max 1.0
#pragma shaderfilter set baseMix__default 1.0
#pragma shaderfilter set baseMix__step 0.01
#pragma shaderfilter set baseMix__slider true
uniform float baseMix;

#pragma shaderfilter set steps__description Steps
#pragma shaderfilter set steps__min 1.0
#pragma shaderfilter set steps__max 32.0
#pragma shaderfilter set steps__default 8.0
#pragma shaderfilter set steps__step 1.0
#pragma shaderfilter set steps__slider true
uniform float steps;

#pragma shaderfilter set height__description Height
#pragma shaderfilter set height__min 0.0
#pragma shaderfilter set height__max 1024.0
#pragma shaderfilter set height__default 256.0
#pragma shaderfilter set height__step 1.0
#pragma shaderfilter set height__slider true
uniform float height;

#pragma shaderfilter set speed__description Speed
#pragma shaderfilter set speed__min 0.0
#pragma shaderfilter set speed__max 64.0
#pragma shaderfilter set speed__default 4.0
#pragma shaderfilter set speed__slider true
uniform float speed;

#pragma shaderfilter set frequency__description Frequency
#pragma shaderfilter set frequency__min 0.0
#pragma shaderfilter set frequency__max 64.0
#pragma shaderfilter set frequency__default 24.0
#pragma shaderfilter set frequency__slider true
uniform float frequency;

#pragma shaderfilter set amplitude__description Amplitude
#pragma shaderfilter set amplitude__min 0.0
#pragma shaderfilter set amplitude__max 1.0
#pragma shaderfilter set amplitude__default 0.15
#pragma shaderfilter set amplitude__step 0.01
#pragma shaderfilter set amplitude__slider true
uniform float amplitude;

float4 render(float2 uv) {

	const float2 pixelSize = 1.0 / builtin_uv_size;
	float4 result;

	for (int i = 0; i < height; i += steps) {
		const float percent = i / height;
		const float2 offset = float2(sin(builtin_elapsed_time * speed + uv.y * frequency) * i * amplitude, i);

		const float4 col = image.Sample(builtin_texture_sampler, uv + offset * pixelSize);
		const float4 tint = lerp(col, col * float4(tintColor.rgb, 0.0), percent);

		result = max(result, tint);
	}

	const float4 base = image.Sample(builtin_texture_sampler, uv);
	return lerp(result, base, lerp(0.0, base.a, baseMix));
}