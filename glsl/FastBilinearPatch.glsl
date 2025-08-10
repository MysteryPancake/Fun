// Available at https://www.shadertoy.com/view/W3GXR3

// Forked from Inigo Quilez
// https://www.shadertoy.com/view/3tjczm

// Added a simple least squares approximation (method 2)
// This approximation converges very fast with high accuracy

// 0: hack
// 1: newton
// 2: least squares (my method)
#define METHOD 2

// 0: middle      ---> fast but bad
// 1: line scans  ---> much better, but slower
#define INITIAL 0

// enable SHADOWS and floor plane if you have a fast machine
#define SHADOWS

// Accuracy of least squares approximation
#define ITERATIONS 4
#define TOLERANCE 1e-8

//-------------------------------------------------------

float dot2( in vec3 v ) { return dot(v,v); }

// Returns interpolated position based on barycentric UVW coordinates
vec3 barycentric( in vec3 p0, in vec3 p1, in vec3 p2, in vec3 p3, in vec2 uv )
{
    float u1 = 1.0 - uv.y;
    float v1 = 1.0 - uv.x;
    return p0 * u1 * v1 
         + p1 * u1 * uv.x
         + p2 * uv.y * uv.x
         + p3 * uv.y * v1;
}

vec3 sdBilinearPatch( in vec3 p,
                      in vec3 p0, in vec3 p1, in vec3 p2, in vec3 p3 )
{    
    vec3 A = p1-p0;
    vec3 B = p3-p0;
    vec3 C = p2-p3-p1+p0;
    vec3 D = p0-p;

    // initial guess

#if INITIAL==0
    vec2 uv = vec2(0.5);
#endif
#if INITIAL==1
    vec2 uv = vec2(0.0,0.0);
    float d = dot2(p-p0);
    for( int i=0; i<16; i++ )
    {
        float u = float(i)/15.0;
        vec3 ba = mix( B,p2-p1,u);
        vec3 pa = mix(-D,p -p1,u);
		float v = clamp( dot(pa,ba)/dot(ba,ba), 0.0, 1.0 );
		float t = dot2(pa-ba*v);
        if( t<d ) { d=t; uv=vec2(u,v); }
    }
    //return vec3(sqrt(d),uv);
#endif
    
    // find roots
    
#if METHOD==0
    vec2  k2 = vec2(dot(A,C),dot(B,C));
    vec2  k0 = vec2(dot(B,D),dot(A,D));
    float k1 = dot(A,B)+dot(C,D);
    for( int i=0; i<16; i++ )
    {
      uv.yx = clamp( -(uv*uv*k2 + uv*k1 + k0 ) /
                     vec2( dot2(B+uv.x*C), dot2(A+uv.y*C) ),
                     0.0, 1.0);
    }
    vec3 pq = D+uv.x*A+uv.y*B+uv.x*uv.y*C;
    vec3 nor = cross(A+uv.y*C,B+uv.x*C); // normal
	return vec3( length(pq), uv );
#endif
    
#if METHOD==1
    float AA = dot(A,A);
    float BB = dot(B,B);
    float CC = dot(C,C);
    float BC = dot(B,C);
    float AC = dot(A,C);
    float ABCD = dot(A,B)+dot(C,D);
    float AD = dot(A,D);
    float BD = dot(B,D);
    for( int i=0; i<6; i++ )
    {
        vec2 gra = vec2(
         uv.x*AA + uv.x*uv.y*uv.y*CC + uv.y*ABCD + 2.0*uv.x*uv.y*AC +     uv.y*uv.y*BC + AD,
         uv.y*BB + uv.x*uv.x*uv.y*CC + uv.x*ABCD +     uv.x*uv.x*AC + 2.0*uv.x*uv.y*BC + BD);

        float k1 = 2.0*uv.x*uv.y*CC + ABCD + 2.0*uv.x*AC + 2.0*uv.y*BC;
        mat2x2 hes = mat2x2(
         AA + uv.y*uv.y*CC + 2.0*uv.y*AC,
         k1, k1, 
         BB + uv.x*uv.x*CC + 2.0*uv.x*BC );
        
        uv -= inverse(hes)*gra;
        
        uv = clamp(uv,0.0,1.0);
    }
    vec3 nor = cross(A+uv.y*C,B+uv.x*C); // normal
	return vec3( length(D+uv.x*A+uv.y*B+uv.x*uv.y*C), uv );
#endif

#if METHOD==2
    vec3 E = p2 - p1;
    vec3 F = p2 - p3;

    for (int i = 0; i < ITERATIONS; i++)
    {
        vec3 r = barycentric(p0, p1, p2, p3, uv) - p;
        if (dot(r, r) < TOLERANCE) break;

        vec3 dP_du = mix(B, E, uv.x);
        vec3 dP_dv = mix(A, F, uv.y);
        
        float A11 = dot(dP_du, dP_du);
        float A12 = dot(dP_du, dP_dv);
        float A22 = dot(dP_dv, dP_dv);
        
        vec2 grad = vec2(dot(dP_du, r), dot(dP_dv, r));
        if (dot(grad, grad) < TOLERANCE) break;

        float det = A11 * A22 - A12 * A12;
        if (abs(det) < TOLERANCE) break;

        uv = clamp(uv - vec2(grad.y * A11 - grad.x * A12,
                             grad.x * A22 - grad.y * A12) / det, 0.0, 1.0);
    }

    return vec3(length(p - barycentric(p0, p1, p2, p3, uv)), uv);
#endif
}

//-------------------------------------------------------

vec3 gVerts[8]; // Deformed cube geometry

const float kRoundness = 0.03;

// sdf
vec3 map( in vec3 p )
{
    vec3 res = vec3(length(p-gVerts[0]),0.0,0.0);

    
    //   2---3
    //  /   /|
    // 6---7 |
    // |   | 1
    // 4---5/
    
    vec3 tmp;
    tmp = sdBilinearPatch(p, gVerts[0], gVerts[2], gVerts[3], gVerts[1]); if( tmp.x<res.x ) res = tmp;
    tmp = sdBilinearPatch(p, gVerts[7], gVerts[6], gVerts[4], gVerts[5]); if( tmp.x<res.x ) res = tmp;
    tmp = sdBilinearPatch(p, gVerts[0], gVerts[1], gVerts[5], gVerts[4]); if( tmp.x<res.x ) res = tmp;
    tmp = sdBilinearPatch(p, gVerts[2], gVerts[6], gVerts[7], gVerts[3]); if( tmp.x<res.x ) res = tmp;
    tmp = sdBilinearPatch(p, gVerts[0], gVerts[4], gVerts[6], gVerts[2]); if( tmp.x<res.x ) res = tmp;
    tmp = sdBilinearPatch(p, gVerts[1], gVerts[3], gVerts[7], gVerts[5]); if( tmp.x<res.x ) res = tmp;
    
    res.x -= kRoundness; // round it a bit
    return res;
}

// https://iquilezles.org/articles/intersectors
vec2 iSphere( in vec3 ro, in vec3 rd, in vec4 sph )
{
	vec3 oc = ro - sph.xyz;
	float b = dot( oc, rd );
	float c = dot( oc, oc ) - sph.w*sph.w;
	float h = b*b - c;
	if( h<0.0 ) return vec2(-1.0);
    h = sqrt(h);
	return vec2(-b-h,-b+h);
}

int raycast( in vec3 ro, in vec3 rd, out vec3 oUVT)
{
    int   obj = 0;
    float tmin = 2.0;
    float tmax = 5.0;
    vec2  uv = vec2(0.0);

    // floor
    #ifdef SHADOWS
    float tf = (-2.0 - ro.y) / rd.y;
    if( tf>0.0 ) { tmax=min(tmax,tf); obj=1; oUVT = vec3(0.0,0.0,tf); }
    #endif

    // bounding sphere
    vec2 bs = iSphere(ro,rd,vec4(0.0,0.0,0.0,sqrt(3.0)+kRoundness));
    if( bs.y>0.0 )
    {
        tmin = max(tmin,bs.x); // clip search space
        tmax = min(tmax,bs.y); // clip search space
        
        // rayamarch cube
        float t = tmin;
        for( int i=0; i<256; i++ )	
        {
            vec3 pos = ro + t*rd;
            vec3 duv = map(pos);
            uv = duv.yz;
            if( (duv.x)<0.001 ) break;
            t += duv.x;
            if( t>tmax ) break;        
        }

        if( t<tmax )
        {
            obj = 2;
            oUVT = vec3(uv,t);
        }
    }

    return obj;
}


// https://iquilezles.org/articles/rmshadows
float calcSoftshadow( in vec3 ro, in vec3 rd )
{
    float tmin = 0.001;
    float tmax = 8.0;

    float res = 1.0;
    
    // bounding sphere
    vec2 bs = iSphere(ro,rd,vec4(0.0,0.0,0.0,sqrt(3.0)+kRoundness+0.2));
    if( bs.y>0.0 )
    {
        tmin = max(tmin,bs.x); // clip search space
        tmax = min(tmax,bs.y); // clip search space
        
        float t = tmin;
        for( int i=0; i<64; i++ )
        {
            float h = map( ro + rd*t ).x;
            float s = clamp(8.0*h/t,0.0,1.0);
            res = min( res, s*s*(3.0-2.0*s) );
            t += clamp( h, 0.02, 0.5 );
            if( res<0.005 || t>tmax ) break;
        }
    }
    return clamp( res, 0.0, 1.0 );
}


// https://iquilezles.org/articles/normalsSDF
vec3 calcNormal( in vec3 pos )
{
#if 0
    vec2 e = vec2(1.0,-1.0)*0.5773*0.0005;
    return normalize( e.xyy*map( pos + e.xyy ).x + 
					  e.yyx*map( pos + e.yyx ).x + 
					  e.yxy*map( pos + e.yxy ).x + 
					  e.xxx*map( pos + e.xxx ).x );
#else
    // inspired by tdhooper and klems - a way to prevent the compiler from inlining map() 4 times
    vec3 n = vec3(0.0);
    for( int i=min(0,iFrame); i<4; i++ )
    {
        vec3 e = 0.5773*(2.0*vec3((((i+3)>>1)&1),((i>>1)&1),(i&1))-1.0);
        n += e*map(pos+0.001*e).x;
    }
    return normalize(n);
#endif    
}

vec2 rot( vec2 p, float an )
{
    return mat2(cos(an), sin(an), -sin(an), cos(an)) * p;
}

const float N = 32.0;
float gridTexture( in vec2 p )
{
	// filter kernel
    vec2 w = fwidth(p) + 0.01;

	// analytic (box) filtering
    vec2 a = p + 0.5*w;                        
    vec2 b = p - 0.5*w;           
    vec2 i = (floor(a)+min(fract(a)*N,1.0)-
              floor(b)-min(fract(b)*N,1.0))/(N*w);
    //pattern
    return (1.0-i.x)*(1.0-i.y);
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv = (2.0*fragCoord-iResolution.xy) / iResolution.y;

    vec3 ro = vec3(0.0, 0.0, 4.0);
    vec3 rd = normalize(vec3(uv, -1.6));

    // vertex deformation, from https://www.shadertoy.com/view/3dXGWs
    float time = iTime;
    float amp = smoothstep(0.0,0.2,0.5-0.5*cos(6.2831*time/15.0));
    for(int i = 0; i<8; i++)
    {
        vec3 p = vec3((ivec3(i)>>ivec3(0,1,2))&1)*2.0-1.0;

        p.xz = rot(p.xz,  amp*cos(time*3.0*6.2831/15.0+p.y+0.0)/2.0 );
        p.yz = rot(p.yz, -amp*cos(time*1.0*6.2831/15.0+p.x+2.0)/1.0 );
        p.xz = rot(p.xz,  4.0 + time*1.0*6.2831/15.0 );
        
        gVerts[i] = p;
    }

    // render
    
    vec3 col = vec3(0.0);

    vec3 uvt;
    int obj = raycast(ro, rd, uvt);
    if( obj>0 )
    {
        float t = uvt.z;
        vec3 pos = ro + t*rd;
    	vec3 nor = vec3(0.0,1.0,0.0);
        vec2 uv = pos.xz*0.25;
        #ifdef SHADOWS
    	if( obj==2 )
        #endif
        {
            uv = uvt.xy;
        	nor = calcNormal(pos);
        }

        // shade and illuminate (oldscool way)
        vec3 tex = texture(iChannel0,uv).xyz;
    	//tex *= gridTexture(4.0*uv);
        
    	vec3  lig = normalize(vec3(6, 5,-1));
        vec3  hal = normalize(lig-rd);
        float dif = clamp(dot(nor,lig),0.0,1.0);
        float spe = pow(max(0.0, dot(nor,hal)), 16.0);
        float amb = 0.5+0.5*nor.y;
        float bou = 0.5+0.5-nor.y;

        #ifdef SHADOWS
        if( dif>0.0 )
        {
    		dif *= calcSoftshadow(pos+0.01*nor, lig);
        }
        #endif

        spe *= 0.04 + 0.96*pow(clamp(1.0-dot(lig,hal),0.0,1.0),5.0);
        col = tex*(4.0*dif*vec3(1.00,0.70,0.70) + 
                   1.0*amb*vec3(0.15,0.10,0.05)+
                   1.0*bou*vec3(0.20,0.07,0.02)) + 
              tex.x*spe*dif*20.0;
        col *= exp2(-t*0.1);
    }
    
    // gain
    col = col*2.0/(1.0+col);
	// gamma
    col = pow(col,vec3(0.4545));
    
    // grade
    col.z += 0.02;

    fragColor = vec4( col, 1.0 );
}