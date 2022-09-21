// HLSL port of FlowingNoise.glsl for OBS ShaderFilter Plus

#pragma shaderfilter set strength__description Strength
#pragma shaderfilter set strength__min 0.0
#pragma shaderfilter set strength__max 2.0
#pragma shaderfilter set strength__default 0.5
#pragma shaderfilter set strength__step 0.01
#pragma shaderfilter set strength__slider true
uniform float strength;

float hash(float n) {
	return frac(cos(n * 89.42) * 343.42);
}

float shake(float x) {
	return sin(x) * sin(x * 4.0) * cos(x * 8.0) * sin(x * 12.0);
}

float4 render(float2 uv) {
	const float wobble = shake(uv.y + builtin_elapsed_time) * hash(uv.x);
	const float2 offset = float2(0.0, wobble);
	return image.Sample(builtin_texture_sampler, uv + offset * strength);
}