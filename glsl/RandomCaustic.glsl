// Available at https://www.shadertoy.com/view/3c3cR8

// BUFFER A

// From https://www.shadertoy.com/view/XdGfRR
vec2 hash21(uint q) {
	uvec2 n = q * uvec2(1597334673U, 3812015801U);
	n = (n.x ^ n.y) * uvec2(1597334673U, 3812015801U);
	return vec2(n) * 2.328306437080797e-10;
}

// Idea from https://github.com/lcrs/_.hips
void mainImage(out vec4 fragColor, in vec2 fragCoord) {

    vec2 uv = fragCoord / iResolution.xy;

    if (iFrame == 0) {
        fragColor.rgb = length(uv - .5) * vec3(0, 0, .01);
        return;
    }

    fragColor = texture(iChannel0, uv) * .995;
    
    const int iterations = 1024;
    for (int i = 0; i < iterations; ++i) {

        // Randomly sample noise texture, treat as coordinate
        vec2 uv2 = hash21(uint(iFrame * iterations + i)) * .1 + iTime * 0.005;
        vec4 coord = texture(iChannel1, fract(uv2));
        
        // Draw a circle when the location is near us
        float dist = distance(uv, coord.xy);
        float circle = smoothstep(.002, .0, dist);
        
        fragColor.rgb += circle * vec3(.1, .3, 1) * .5;
    }
}

// IMAGE

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv = fragCoord / iResolution.xy;
    fragColor = sqrt(texture(iChannel0, uv));
}