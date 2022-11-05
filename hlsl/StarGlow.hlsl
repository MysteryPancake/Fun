// HLSL port of StarGlow.glsl for OBS ShaderFilter Plus

#pragma shaderfilter set threshold__description Threshold
#pragma shaderfilter set threshold__min 0.0
#pragma shaderfilter set threshold__max 1.0
#pragma shaderfilter set threshold__default 0.8
#pragma shaderfilter set threshold__step 0.01
#pragma shaderfilter set threshold__slider true
uniform float threshold;

#pragma shaderfilter set brightness__description Brightness
#pragma shaderfilter set brightness__min 0.0
#pragma shaderfilter set brightness__max 1.0
#pragma shaderfilter set brightness__default 0.1
#pragma shaderfilter set brightness__step 0.01
#pragma shaderfilter set brightness__slider true
uniform float brightness;

#pragma shaderfilter set range__description Range
#pragma shaderfilter set range__min 0.0
#pragma shaderfilter set range__max 1024.0
#pragma shaderfilter set range__default 64.0
#pragma shaderfilter set range__step 1.0
#pragma shaderfilter set range__slider true
uniform float range;

#pragma shaderfilter set steps__description Steps
#pragma shaderfilter set steps__min 1.0
#pragma shaderfilter set steps__max 32.0
#pragma shaderfilter set steps__default 2.0
#pragma shaderfilter set steps__step 1.0
#pragma shaderfilter set steps__slider true
uniform float steps;

float4 render(float2 uv) {

	const float2 pixelSize = 1.0 / builtin_uv_size;
	float4 result = image.Sample(builtin_texture_sampler, uv);

	for (int i = -range; i < range; i += steps) {

		const float falloff = 1.0 - abs(i / range);

		float4 blur = image.Sample(builtin_texture_sampler, uv + i * pixelSize);
		if (blur.r + blur.g + blur.b > threshold * 3.0) {
			result += blur * falloff * steps * brightness;
		}

		blur = image.Sample(builtin_texture_sampler, uv + float2(i, -i) * pixelSize);
		if (blur.r + blur.g + blur.b > threshold * 3.0) {
			result += blur * falloff * steps * brightness;
		}
	}
	
	return result;
}