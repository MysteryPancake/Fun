// Available at https://www.shadertoy.com/view/mlf3RB

// COMMON

const float PI = 3.1415926;
const float TAU = 6.28318530;

// From https://www.shadertoy.com/view/lsS3Wc
vec3 hsv2rgb(vec3 c) {
	vec3 rgb = clamp(abs(mod(c.x*6.0+vec3(0.0,4.0,2.0),6.0)-3.0)-1.0, 0.0, 1.0);
	return c.z * mix(vec3(1.0), rgb, c.y);
}

// From https://www.shadertoy.com/view/lsS3Wc
vec3 rgb2hsv(vec3 c) {
	vec4 k = vec4(0.0, -1.0/3.0, 2.0/3.0, -1.0);
	vec4 p = mix(vec4(c.zy, k.wz), vec4(c.yz, k.xy), (c.z<c.y) ? 1.0 : 0.0);
	vec4 q = mix(vec4(p.xyw, c.x), vec4(c.x, p.yzx), (p.x<c.x) ? 1.0 : 0.0);
	float d = q.x - min(q.w, q.y);
	return vec3(abs(q.z + (q.w - q.y) / (6.0*d)), d / q.x, q.x);
}

// BUFFER A

void mainImage(out vec4 fragColor, in vec2 fragCoord) {

	// UVs for texture (left)
	vec2 uv = fragCoord / iResolution.xy;
	vec4 noise = texture(iChannel0, uv);
	
	// UVs for hue circle (right)
	vec2 uv2 = (vec2(1.0 / 0.75, 2.0) * fragCoord - iResolution.xy) / iResolution.y;
	float hue = atan(uv2.x, uv2.y) / TAU;
	
	// Split halfway
	vec3 col = uv.x > 0.5 ? hsv2rgb(vec3(hue, 1.0, 1.0)) : noise.rgb;
	fragColor = vec4(col, 1.0);
}

// IMAGE

void mainImage(out vec4 fragColor, in vec2 fragCoord) {

	// Hue divisions when rounding
	float divisions = 1.0 + round(mod(iTime * 0.5, 4.0));
	// Hue rounding (0 = original, 1 = fully rounded)
	float rounding = cos(iTime * PI) * 0.5 + 0.5;
	
	vec4 tex = texture(iChannel0, fragCoord / iResolution.xy);
	// Convert from RGB to HSV
	vec3 hsv = rgb2hsv(tex.rgb);
	// Round hue to nearest color
	hsv.x = mix(hsv.x, floor(hsv.x * divisions) / divisions, rounding);
	// Convert back from HSV to RGB
	fragColor = vec4(hsv2rgb(hsv), 1.0);
}