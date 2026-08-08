// Available at https://www.shadertoy.com/view/ctlGRl

// Modification of ClaudeArmy.glsl

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

void mainImage(out vec4 fragColor, in vec2 fragCoord) {

	// Number of images to display
	int images = 128;
	// Scale factor per image
	float scale = 0.97;
	
	vec2 uv = fragCoord / iResolution.xy;
	vec2 m = iMouse.xy / iResolution.xy;
	fragColor = vec4(0.0);
	
	// View angle
	float camAngle = iMouse.z > 0.0 ? 1.5 - 2.0 * m.y : 0.7 - sin(iTime) * 0.3;
    
	for (int i = 0; i < images; ++i) {
		// Jumping
        float height = cos(float(i) * 0.24 + iTime * 8.0) * 0.25;
        height += sin(uv.x * 10.0 + iTime * 3.0 + float(i) * 0.4) * 0.1;
        
        vec3 bg = hsv2rgb(vec3(uv.x + iTime + float(i) * 0.01, 0.5, 1.0));
        
        // Offset, apply scale, reset offset
		vec2 offset = vec2(i, 0.4 + 0.5 * camAngle);
		vec2 pos = uv - offset;
		pos /= pow(scale, float(i));
        
        vec2 camPos = vec2(iMouse.z > 0.0 ? -m.x : iTime * 0.1, camAngle + height);
		pos += offset + camPos;
		
		// Discard top
		if (pos.y >= 0.995) continue;
        pos.y = max(pos.y, 0.005);
        
        float fog = pow(float(i) / float(images), 0.8);
		
		// Flip every 2nd one for variety
		if (i % 2 == 1) pos.x *= -1.0;
        
        // Below is required if the wrap mode isn't repeat
        pos.x = fract(pos.x);
		
		vec4 colora = texture(iChannel0, pos);
        vec4 colorb = texture(iChannel0, pos + vec2(0.0, 0.02));
        
        // Color key (despill from Inigo Quilez)
		float rbMax = max(colora.r, colora.b);
        float og = colora.g;
        colora.g = min(colora.g, rbMax * 0.85); 
        colora += og - colora.g;
        colora.a = 1.0 - clamp((og - rbMax) * 4.0, 0.0, 1.0);
        
        float edge = smoothstep(0.4, 0.8, distance(colorb.rgb, vec3(0.0, 1.0, 0.0)));
        colora.rgb = mix(colora.rgb * 0.25, vec3(1.0), fog) + (1.0 - edge) * bg;
        
		// Premultiply color
		colora.rgb *= colora.a;
		// Composite behind
		fragColor += (1.0 - fragColor.a) * colora;
		
		// Early exit
		if (fragColor.a >= 1.0) break;
	}
	
	// Make background
    float sat = smoothstep(0.6, 1.2, uv.y - camAngle * .5 + 0.3);
    vec3 bg = hsv2rgb(vec3(uv.x + iTime * .1, sat, 1.0));
    
	fragColor += (1.0 - fragColor.a) * vec4(bg, 1.0);
}