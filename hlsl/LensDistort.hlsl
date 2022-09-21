// HLSL port of LensDistort.glsl for OBS ShaderFilter Plus

#pragma shaderfilter set lens__description Lens
#pragma shaderfilter set lens__min 0.0
#pragma shaderfilter set lens__max 2.0
#pragma shaderfilter set lens__default 0.2
#pragma shaderfilter set lens__step 0.01
#pragma shaderfilter set lens__slider true
uniform float lens;

#pragma shaderfilter set x__description X Offset
#pragma shaderfilter set x__min 0.0
#pragma shaderfilter set x__max 1.0
#pragma shaderfilter set x__default 0.5
#pragma shaderfilter set x__step 0.01
#pragma shaderfilter set x__slider true
uniform float x;

#pragma shaderfilter set y__description Y Offset
#pragma shaderfilter set y__min 0.0
#pragma shaderfilter set y__max 1.0
#pragma shaderfilter set y__default 0.5
#pragma shaderfilter set y__step 0.01
#pragma shaderfilter set y__slider true
uniform float y;

float4 render(float2 uv) {
	const float2 center = float2(x, y);
	const float dist = distance(uv, center);
	const float2 dir = uv - center;
	return image.Sample(builtin_texture_sampler, uv - dist * dir * lens);
}