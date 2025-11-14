// Available at https://www.shadertoy.com/view/W32fWt

#define R iResolution
#define S sin(iTime)
#define T cos(iTime)
#define L(a) length(a)

// For visualization, don't bother golfing this
float t(vec2 p, vec2 A, vec2 B, vec2 C) {
    vec2 e0 = B-A, e1 = C-B, e2 = A-C,
         v0 = p-A, v1 = p-B, v2 = p-C;
    return min(min(
        L(v0 - e0*clamp(dot(v0,e0)/dot(e0,e0), 0., 1.)),
        L(v1 - e1*clamp(dot(v1,e1)/dot(e1,e1), 0., 1.))),
        L(v2 - e2*clamp(dot(v2,e2)/dot(e2,e2), 0., 1.)));
}

// Jake Rice 2D version, try golfing this
void mainImage(out vec4 O, vec2 u) {
	vec2 p = (2.*u-R.xy)/R.y,
         A = vec2(-T, S)*.5,
         B = vec2(-S, T)*.5,
         C = vec2(T, -S)*.5,
         r = vec2(1, -1); // For 2D cross products, cross2d(x,y)=vec2(y,-x)

    float d = L(A-B),
          e = L(B-C),
          f = L(A-C),
          n = dot(A-B, (C-B).yx*r); // Sign/normal
    
    // Incenter (where the bisectors meet)
    vec2 c = (e*A + f*B + d*C) / (d+e+f);
    
    O *= 0.; O.r = 1.; // Red region
    
    // Split along the A-c line
    if (dot(p-A, (A-c).yx*r) < 0.)
        O.r = 0., O.g = 1.;

    // Split along the B-c line excluding C-c
    if (dot(p-B, (B-c).yx*r)*n>0. && dot(p-C, (C-c).yx*r)*n<0.)
        O.rgb = vec3(0,0,1);
    
    O += .01/t(p,A,B,C); // Overlay triangle
}