// Available at https://www.shadertoy.com/view/3tScWR
// Used in https://github.com/MysteryPancake/Waveform
void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 circCoord = (fragCoord - iResolution.xy * 0.5) / iResolution.y;
	vec2 cxy = vec2(2.0, 2.0) * circCoord;
	float radius = dot(cxy, cxy);
	const vec3 ambient = vec3(0.5, 0.2, 0.1);
	const vec3 diffuse = vec3(1, 0.5, 0.2);
	vec3 direction = normalize(vec3(cos(iTime), sin(iTime), -0.5));
	vec3 normal = vec3(cxy, sqrt(1.0 - radius));
	float color = max(dot(normal, direction), 0.0);
	float delta = fwidth(radius);
	float alpha = 1.0 - smoothstep(1.0 - delta, 1.0 + delta, radius);
	const vec4 bgColor = vec4(0, 0.1, 0.2, 1);
	vec4 circColor = vec4(ambient + diffuse * color, alpha);
	fragColor = mix(bgColor, circColor, circColor.a);
}