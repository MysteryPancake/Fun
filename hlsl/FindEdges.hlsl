// HLSL port of FindEdges.glsl for OBS ShaderFilter Plus

#pragma shaderfilter set radius__description Radius
#pragma shaderfilter set radius__min 1.0
#pragma shaderfilter set radius__max 20.0
#pragma shaderfilter set radius__default 1.0
#pragma shaderfilter set radius__step 0.1
#pragma shaderfilter set radius__slider true
uniform float radius;

#pragma shaderfilter set emphasis__description Emphasis
#pragma shaderfilter set emphasis__min 0.0
#pragma shaderfilter set emphasis__max 1.0
#pragma shaderfilter set emphasis__default 0.0
#pragma shaderfilter set emphasis__step 0.01
#pragma shaderfilter set emphasis__slider true
uniform float emphasis;

float4 render(float2 uv) {

	// Brightest neighbour and direction toward it
	float4 brightest;
	float2 direction;

	const float2 pixelSize = 1.0 / builtin_uv_size;

	// Sample in a 3 x 3 kernel
	for (int x = -1; x <= 1; ++x) {
		for (int y = -1; y <= 1; ++y) {

			// Ignore self
			if (x == 0 && y == 0) continue;
			
			// Sample neighbour
			const float2 pos = float2(x, y);
			const float4 neighbour = image.Sample(builtin_texture_sampler, uv + pos * radius * pixelSize);
			
			// Store neighbour with maximum brightness
			if (length(neighbour) > length(brightest)) {
				brightest = neighbour;
				direction = pos;
			}
		}
	}
	
	// Colorize (direction range is -1 to 1)
	const float3 colorized = float3(direction.xy, -direction.x);

	// Emphasise more intense edges
	const float4 self = image.Sample(builtin_texture_sampler, uv);
	const float weight = lerp(1.0, distance(brightest.rgb, self.rgb), emphasis);

	return float4(colorized * weight, self.a);
}