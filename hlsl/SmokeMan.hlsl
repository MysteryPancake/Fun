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
#pragma shaderfilter set steps__min 3.0
#pragma shaderfilter set steps__max 128.0
#pragma shaderfilter set steps__default 64.0
#pragma shaderfilter set steps__slider true
uniform float steps;

#pragma shaderfilter set speed__description Speed
#pragma shaderfilter set speed__min 0.0
#pragma shaderfilter set speed__max 64.0
#pragma shaderfilter set speed__default 4.0
#pragma shaderfilter set speed__slider true
uniform float speed;

#pragma shaderfilter set spread__description Spread
#pragma shaderfilter set spread__min 0.0
#pragma shaderfilter set spread__max 1.0
#pragma shaderfilter set spread__default 0.15
#pragma shaderfilter set spread__step 0.01
#pragma shaderfilter set spread__slider true
uniform float spread;

#pragma shaderfilter set frequency__description Frequency
#pragma shaderfilter set frequency__min 0.0
#pragma shaderfilter set frequency__max 64.0
#pragma shaderfilter set frequency__default 24.0
#pragma shaderfilter set frequency__slider true
uniform float frequency;

#pragma shaderfilter set height__description Height
#pragma shaderfilter set height__min 0.0
#pragma shaderfilter set height__max 1.0
#pragma shaderfilter set height__default 0.5
#pragma shaderfilter set height__step 0.01
#pragma shaderfilter set height__slider true
uniform float height;

float4 render(float2 uv)
{
	float4 result;

	for (float i = 0.0; i < steps; i++) {
		const float percent = i / steps;
		const float2 offset = float2(sin(builtin_elapsed_time * speed + uv.y * frequency) * percent * spread, percent);

		const float4 col = image.Sample(builtin_texture_sampler, uv + offset * height);
		const float4 tint = lerp(col, col * float4(tintColor.rgb, 0.0), percent);

		result = max(result, tint);
	}

	const float4 base = image.Sample(builtin_texture_sampler, uv);
	return lerp(result, base, lerp(0.0, base.a, baseMix));
}