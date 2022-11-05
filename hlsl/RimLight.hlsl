// HLSL port of RimLight.glsl for OBS ShaderFilter Plus

#pragma shaderfilter set lightColor__description Color
#pragma shaderfilter set lightColor__default FF8000FF
uniform float4 lightColor;

#pragma shaderfilter set depth__description Depth
#pragma shaderfilter set depth__min 0.0
#pragma shaderfilter set depth__max 128.0
#pragma shaderfilter set depth__default 8.0
#pragma shaderfilter set depth__step 1.0
#pragma shaderfilter set depth__slider true
uniform float depth;

#pragma shaderfilter set angle__description Angle
#pragma shaderfilter set angle__min 0.0
#pragma shaderfilter set angle__max 360.0
#pragma shaderfilter set angle__default 180.0
#pragma shaderfilter set angle__slider true
uniform float angle;

float4 render(float2 uv) {
	
	const float rad = radians(angle);
	const float2 pixelSize = 1.0 / builtin_uv_size;
	const float2 offset = float2(sin(rad), cos(rad)) * depth * pixelSize;

	const float4 color = image.Sample(builtin_texture_sampler, uv);
	const float4 colorOffset = image.Sample(builtin_texture_sampler, uv + offset);

	return float4(lerp(color.rgb + lightColor.rgb, color.rgb, colorOffset.a), color.a);
}