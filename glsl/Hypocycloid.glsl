// Available at https://www.shadertoy.com/view/DtXXRS

const float TAU = 6.28318530;

// From https://iquilezles.org/articles/distfunctions2d
float line(vec2 p, vec2 a, vec2 b) {
	vec2 pa = p - a, ba = b - a;
	float h = clamp(dot(pa, ba) / dot(ba, ba), 0.0, 1.0);
	return length(pa - ba * h);
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {

	vec2 p = (fragCoord - 0.5 * iResolution.xy) / iResolution.y;
	float time = iTime * 2.0;
	float points = floor(time / TAU) + 3.0;
	
	const float outerRadius = 0.45;
	float innerRadius = outerRadius / points;
	
	float innerSpeed = 1.0 - points;
	vec2 drawOffset = vec2(sin(time * innerSpeed), cos(time * innerSpeed));
	vec2 circleOffset = vec2(sin(time), cos(time)) * (outerRadius - innerRadius);
	vec2 trailOffset = circleOffset + drawOffset * innerRadius;
	
	// Draw trail in red channel
	float trail = min(1.0, 0.01 / length(p - trailOffset));
	float last = texture(iChannel0, fragCoord / iResolution.xy).r;
	fragColor.r = max(max(0.0, last - 0.005), trail);
	
	// Draw outer circle in green channel
	fragColor.g = 0.005 / abs(length(p) - outerRadius);
	
	// Draw inner circle in blue channel
	float circleBorder = abs(length(p - circleOffset) - innerRadius);
	float circleLine = line(p, circleOffset, trailOffset);
	fragColor.b = 0.003 / min(circleBorder, circleLine);
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
	vec2 uv = fragCoord / iResolution.xy;
	
	// Draw buffer
	vec3 col = texture(iChannel0, uv).rgb;
	float rbMax = max(col.r, col.b);
	fragColor = vec4(rbMax, col.g + rbMax, col.r, 1.0);
	
	// Draw vignette
	fragColor.b += smoothstep(0.4, 1.0, length(uv - 0.5));
}