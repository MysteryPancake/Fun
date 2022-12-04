// HLSL port of HallOfMirrors.glsl for OBS ShaderFilter Plus

#pragma shaderfilter set images__description Images
#pragma shaderfilter set images__min 0
#pragma shaderfilter set images__max 128
#pragma shaderfilter set images__default 10
#pragma shaderfilter set images__slider true
uniform int images;

#pragma shaderfilter set scale__description Scale
#pragma shaderfilter set scale__min 0.0
#pragma shaderfilter set scale__max 2.0
#pragma shaderfilter set scale__default 0.75
#pragma shaderfilter set scale__step 0.01
#pragma shaderfilter set scale__slider true
uniform float scale;

#pragma shaderfilter set rotation__description Rotation
#pragma shaderfilter set rotation__min -360.0
#pragma shaderfilter set rotation__max 360.0
#pragma shaderfilter set rotation__default 0.0
#pragma shaderfilter set rotation__step 0.1
#pragma shaderfilter set rotation__slider true
uniform float rotation;

#pragma shaderfilter set offsetX__description Offset X
#pragma shaderfilter set offsetX__min 0.0
#pragma shaderfilter set offsetX__max 1.0
#pragma shaderfilter set offsetX__default 0.5
#pragma shaderfilter set offsetX__step 0.01
#pragma shaderfilter set offsetX__slider true
uniform float offsetX;

#pragma shaderfilter set offsetY__description Offset Y
#pragma shaderfilter set offsetY__min 0.0
#pragma shaderfilter set offsetY__max 1.0
#pragma shaderfilter set offsetY__default 0.5
#pragma shaderfilter set offsetY__step 0.01
#pragma shaderfilter set offsetY__slider true
uniform float offsetY;

#pragma shaderfilter set behind__description Behind
#pragma shaderfilter set behind__default false
uniform bool behind;

float4 render(float2 uv) {
	const float rad = radians(-rotation);
	const float2 offset = float2(offsetX, offsetY);
	const float2 center = float2(0.5, 0.5);
	
	float4 result;
	for (int i = 0; i < images; ++i) {
		// Avoid divide by zero error
		if (scale <= 0.0) {
			result = image.Sample(builtin_texture_sampler, uv);
			break;
		}

		// SCALING: Offset, apply scale, reset offset
		float2 pos = uv - offset;
		pos /= pow(scale, i);
		pos += offset;

		// ROTATION
		const float theta = rad * i;
		const float cs = cos(theta);
		const float sn = sin(theta);
		// Offset to center, fix aspect ratio
		pos -= center;
		pos *= builtin_uv_size;
		// Rotate coordinate space
		pos = float2(pos.x * cs - pos.y * sn, pos.x * sn + pos.y * cs);
		// Reset aspect ratio, reset offset
		pos /= builtin_uv_size;
		pos += center;

		// Prevent out of bounds bugs, could also be done with clamp
		if (pos.x >= 0.0 && pos.x <= 1.0 && pos.y >= 0.0 && pos.y <= 1.0) {
			const float4 color = image.Sample(builtin_texture_sampler, pos);
			if (behind) {
				result = result + (1.0 - result.a) * color;
			} else {
				result = color + (1.0 - color.a) * result;
			}
		}
	}
	// Convert premultiplied alpha to straight alpha
	result.rgb /= result.a;
	return result;
}