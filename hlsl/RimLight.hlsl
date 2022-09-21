// HLSL port of RimLight.glsl for OBS ShaderFilter Plus

#pragma shaderfilter set lightColor__description Color
#pragma shaderfilter set lightColor__default FF8000FF
uniform float4 lightColor;

#pragma shaderfilter set depth__description Depth
#pragma shaderfilter set depth__default 1
uniform float depth;

#pragma shaderfilter set angle__description Angle
#pragma shaderfilter set angle__default 180
uniform float angle;

float4 render(float2 uv)
{
	float rad = radians(angle);
	float2 offset = float2(sin(rad), cos(rad)) * depth * 0.01;

	float4 color = image.Sample(builtin_texture_sampler, uv);
	float4 colorOffset = image.Sample(builtin_texture_sampler, uv + offset);

	return float4(lerp(color.rgb + lightColor.rgb, color.rgb, colorOffset.a), color.a);
}