// Available at https://www.shadertoy.com/view/DlXGRs

// From https://www.shadertoy.com/view/Xds3zN
mat3 setCamera(in vec3 ro, in vec3 ta, float cr) {
	vec3 cw = normalize(ta - ro);
	vec3 cp = vec3(sin(cr), cos(cr), 0.0);
	vec3 cu = normalize(cross(cw, cp));
	vec3 cv = cross(cu,cw);
	return mat3(cu, cv, cw);
}

// Invalid SDF, distance never reaches 0
float map(vec3 p, float r) {
	float d = 8.0;
	// 6 grids of overlapping circles
	for (float i = 0.0; i < 6.0; i++) {
		vec3 offset = vec3(i * 4.2, i * 0.5, i * 3.4);
		float grid = length(mod(p + offset, 6.0) - 3.0);
		// Negative radius, ensures no convergence
		d = min(grid + r, d);
	}
	return d;
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {

	vec2 q = (fragCoord.xy - 0.5 * iResolution.xy) / iResolution.y;
	
	const float fov = 1.0;
	vec3 ro = vec3(iTime * 8.0, 0.0, 0.0);
	mat3 ca = setCamera(ro, vec3(-1.0, 0.0, 0.0), 0.0);
	vec3 rd = ca * normalize(vec3(q, fov));
	
	// Animate radius over time
	float radius = -cos(iTime) + 2.0;

	// Raymarching with only 8 iterations produces clouds
	float dist = 1.0;
	for (int i = 0; i < 8; i++) {
		// Don't bother checking for convergence
		dist += map(ro + rd * dist, radius);
	}
	float light = 12.0 + radius * 6.0;
	float shade = pow(light / dist, 2.0);
	fragColor = vec4(0.0, shade * light / dist, shade, 1.0);
}