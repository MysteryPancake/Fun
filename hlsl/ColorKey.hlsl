// HLSL port of ColorKey.glsl for OBS ShaderFilter Plus

#pragma shaderfilter set target__description Color
#pragma shaderfilter set target__default 00FF00FF
uniform float4 target;

#pragma shaderfilter set threshold__description Threshold
#pragma shaderfilter set threshold__min 0.0
#pragma shaderfilter set threshold__max 1.0
#pragma shaderfilter set threshold__default 0.5
#pragma shaderfilter set threshold__step 0.01
#pragma shaderfilter set threshold__slider true
uniform float threshold;

#pragma shaderfilter set softness__description Softness
#pragma shaderfilter set softness__min 0.0
#pragma shaderfilter set softness__max 1.0
#pragma shaderfilter set softness__default 0.25
#pragma shaderfilter set softness__step 0.01
#pragma shaderfilter set softness__slider true
uniform float softness;

float4 render(float2 uv) {

	const float4 col = image.Sample(builtin_texture_sampler, uv);

	// Get difference to use for falloff if required
	const float diff = distance(col.rgb, target.rgb) - threshold;

	// Apply linear falloff if needed, otherwise clamp
	const float factor = saturate(diff / softness);
	
	return float4(col.rgb, factor);
}