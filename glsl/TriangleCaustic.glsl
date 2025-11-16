// Available at https://www.shadertoy.com/view/tctcz8

// BUFFER A

// Triangulated version of https://www.shadertoy.com/view/3c3cR8

// https://www.shadertoy.com/view/7dSGWK
float sdQuad(in vec2 p, in vec2 p0, in vec2 p1, in vec2 p2, in vec2 p3) {
	vec2 e0 = p1 - p0; vec2 v0 = p - p0;
	vec2 e1 = p2 - p1; vec2 v1 = p - p1;
	vec2 e2 = p3 - p2; vec2 v2 = p - p2;
	vec2 e3 = p0 - p3; vec2 v3 = p - p3;
    
	vec2 pq0 = v0 - e0*clamp( dot(v0,e0)/dot(e0,e0), 0.0, 1.0 );
	vec2 pq1 = v1 - e1*clamp( dot(v1,e1)/dot(e1,e1), 0.0, 1.0 );
	vec2 pq2 = v2 - e2*clamp( dot(v2,e2)/dot(e2,e2), 0.0, 1.0 );
    vec2 pq3 = v3 - e3*clamp( dot(v3,e3)/dot(e3,e3), 0.0, 1.0 );
    
    vec2 ds = min( min( vec2( dot( pq0, pq0 ), v0.x*e0.y-v0.y*e0.x ),
                        vec2( dot( pq1, pq1 ), v1.x*e1.y-v1.y*e1.x )),
                   min( vec2( dot( pq2, pq2 ), v2.x*e2.y-v2.y*e2.x ),
                        vec2( dot( pq3, pq3 ), v3.x*e3.y-v3.y*e3.x ) ));
	return -sign(ds.y) * sqrt(ds.x);
}

float quadArea(in vec2 A, in vec2 B, in vec2 C, in vec2 D) {
    float s = A.x*B.y + B.x*C.y + C.x*D.y + D.x*A.y
            - A.y*B.x - B.y*C.x - C.y*D.x - D.y*A.x;
    return abs(s) * 0.5;
}

// Idea from https://github.com/lcrs/_.hips
void mainImage(out vec4 fragColor, in vec2 fragCoord) {

    vec2 uv = fragCoord / iResolution.xy;

    if (iFrame == 0) {
        fragColor.rgb = length(uv - .5) * vec3(0, 0, .01);
        return;
    }

    fragColor = texture(iChannel0, uv) * .99;
    
    const int resolution = 128;
    const float area = 1.0 / float(resolution);

    const int iterations = 256;
    for (int i = 0; i < iterations; ++i) {
    
        int frame = (iFrame * iterations) + i;
        int x = frame % resolution;
        int y = frame / resolution;

        // Coordinate system in rest space
        vec2 p0 = vec2(x+1, y  ) * area;
        vec2 p1 = vec2(x,   y  ) * area;
        vec2 p2 = vec2(x,   y+1) * area;
        vec2 p3 = vec2(x+1, y+1) * area;
        
        // Transform coordinate system to noise space
        const float scale = 0.1;
        p0 = texture(iChannel1, fract(p0 * scale)).xy;
        p1 = texture(iChannel1, fract(p1 * scale)).xy;
        p2 = texture(iChannel1, fract(p2 * scale)).xy;
        p3 = texture(iChannel1, fract(p3 * scale)).xy;
        
        float areaRatio = area / quadArea(p0, p1, p2, p3);
        areaRatio = min(areaRatio * .003, 2.);
        
        // Draw quads for each face
        float dist = sdQuad(uv, p0, p1, p2, p3);
        float AA = fwidth(dist) * .5;
        float face = smoothstep(AA, -AA, dist);
        
        fragColor.rgb += vec3(.1, .3, 1) * face * areaRatio;
    }
}

// IMAGE

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv = fragCoord / iResolution.xy;
    fragColor = sqrt(texture(iChannel0, uv));
}