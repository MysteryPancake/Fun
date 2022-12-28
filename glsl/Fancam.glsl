// Available at https://www.shadertoy.com/view/mlX3Rf

const float PI = 3.14159265359;

// From https://www.shadertoy.com/view/Xds3zN
float sdBox(vec3 p, vec3 b) {
	vec3 d = abs(p) - b;
	return min(max(d.x, max(d.y, d.z)), 0.0) + length(max(d, 0.0));
}

vec2 opU(vec2 a, vec2 b) {
	return a.x < b.x ? a : b;
}

mat3 setCamera(in vec3 ro, in vec3 ta, float cr) {
	vec3 cw = normalize(ta - ro);
	vec3 cp = vec3(sin(cr), cos(cr), 0.0);
	vec3 cu = normalize(cross(cw, cp));
	vec3 cv = cross(cu,cw);
	return mat3(cu, cv, cw);
}

// From https://easings.net/
float outPow(float x, float p) {
	x = clamp(x, 0.0, 1.0);
	return 1.0 - pow(1.0 - x, p);
}

float inPow(float x, float p) {
	x = clamp(x, 0.0, 1.0);
	return pow(x, p);
}

float outElastic(float x) {
	const float c4 = (2.0 * PI) / 3.0;
	return pow(2.0, -10.0 * x) * sin((x * 10.0 - 0.75) * c4) + 1.0;
}

float stars(vec3 p, float t) {
	float d = 9999.9;
	for (float i = 0.0; i < 4.0; i++) {
		vec3 offset = vec3(i * 1.4, i * 1.2, i * -0.5);
		float grid = length(mod(p + offset, 4.0) - 2.0);
		d = min(grid - 0.08, d);
	}
	return d;
}

vec2 map(vec3 p, float t) {
	vec2 res = vec2(sdBox(p + vec3(0.0, 0.0, 0.1), vec3(0.5, 0.5, 0.05)), 1.5);
	res = opU(res, vec2(stars(p, t), 0.5));
	return res;
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {

	vec2 uv = fragCoord / iResolution.xy;
	vec2 q = (fragCoord.xy - 0.5 * iResolution.xy) / iResolution.y;
	
	float mod2 = mod(iTime, 2.0);
	float mod4 = mod(iTime, 4.0);
	
	// Main camera animation
	float xrot = 4.0 - outElastic(0.3 * mod4) * 4.0;
	float yrot = 16.0 - outPow(mod4 * 2.0, 3.0) * 16.0
		- inPow(mod2 - 1.0, 5.0) * 16.0;
	float zrot = mod4 > 2.0
		? 8.0 - outPow(mod2, 4.0) * 8.0
		: sin(iTime * PI) * 0.5;
	
	// Flip motion every 2 iterations
	if (mod(iTime, 8.0) > 4.0) {
		xrot *= -1.0;
		yrot *= -1.0;
		zrot *= -1.0;
	}
	
	float fov = sin(iTime * PI) * 0.3 + 0.7;
	vec3 ro = vec3(xrot, yrot, fov);
	mat3 ca = setCamera(ro, vec3(0.0), zrot);
	vec3 rd = ca * normalize(vec3(q, fov));

	// Raymarching with only 20 iterations produces glow
	vec2 h; vec3 p;
	float t = 0.1;
	const int iters = 20;
	const float tmax = 22.0;
	for (int i = 0; i < iters && t < tmax; i++) {
		p = ro + rd * t;
		h = map(p, iTime);
		if (abs(h.x) < 0.001) {
			break;
		}
		t += h.x;
	}
	
	vec4 red = vec4(1.0, uv.y, 0.5, 1.0);
	vec4 blu = vec4(0.0, uv.y, 1.0, 1.0);
	float fog = min(10.0, 2.0 + 6.0 * mod2) / t;
	vec4 color = (mod4 > 2.0 ? blu : red) * fog;
	
	if (h.y > 1.0) {
		// Video
		vec2 size = vec2(textureSize(iChannel0, 0));
		vec2 uv = vec2(p.x * size.y / size.x, p.y);
		fragColor = texture(iChannel0, 0.5 + uv);
	} else {
		// Background and stars
		fragColor = color;
	}
}