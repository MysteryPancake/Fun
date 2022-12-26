// Available at https://www.shadertoy.com/view/mll3zj

// BUFFER A

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
	vec2 uv = fragCoord / iResolution.xy;
	vec4 vid = texture(iChannel0, uv);
	vec4 last = texture(iChannel1, uv);
	fragColor = mix(last, vid, 0.04);
}

// IMAGE

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
	vec2 uv = fragCoord / iResolution.xy;
	vec4 vid = texture(iChannel1, uv);
	float blur = 3.0 / distance(vid.rgb, vec3(0.0, 1.0, 0.0));
	fragColor = textureLod(iChannel0, uv, blur);
}