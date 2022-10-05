// Available at https://www.shadertoy.com/view/ftKfRy

// COMMON

#define NUM_PARTICLES 512.0

// To allow the entire buffer to be filled with particles
#define fetch(id) texelFetch(iChannel0, ivec2(mod(id, iResolution.x), floor(id / iResolution.x)), 0)

// Mass function swaps every 256 frames to get a different look
#define mass(id) (4.0 + sin(id * (0.1 + floor(float(iFrame) / 256.0) * 0.1)) * 2.0)

// BUFFER A

// Position and velocity buffer
void mainImage(out vec4 fragColor, in vec2 fragCoord) {
  
	float id = fragCoord.x - 0.5 + (fragCoord.y - 0.5) * iResolution.x;
	
	// Don't calculate unused particles
	if (id > NUM_PARTICLES) discard;
	
	if (iFrame % 256 == 0) {
	
		// Initialize variables
		float x = iResolution.x * fragCoord.x / NUM_PARTICLES;
		float y = iResolution.y * 0.5 + sin(fragCoord.x * 0.05) * iResolution.y * 0.25;
		
		// Store as position x, position y, velocity x, velocity y
		fragColor = vec4(x, y, 0.0, 0.0);
		
	} else {
		
		// Read position and velocity data from previous frame
		vec4 posVel = fetch(id);
		vec2 pos = posVel.xy;
		vec2 vel = posVel.zw;
		float m = mass(id);
		
		for (float id2 = 0.0; id2 < NUM_PARTICLES; id2++) {
			
			// Ignore self
			if (id == id2) continue;
			
			// Read position and velocity data from other particles
			vec4 posVel2 = fetch(id2);
			vec2 pos2 = posVel2.xy;
			float m2 = mass(id2);
			
			// Really r should be squared as dot(dir, dir), but distance looks way cooler
			vec2 dir = pos2 - pos;
			float r = distance(pos, pos2); // Incorrect
			
			// Newton's law of attraction
			const float G = 0.0000005;
			float F = G * m * m2 / r;
			
			// Integrate position and velocity
			vel += dir * F;
			pos += vel;
		}
		
		// Combine components again
		fragColor = vec4(pos, vel);
	}
}

// IMAGE

// Line SDF from Inigo Quilez
float line(in vec2 p, in vec2 a, in vec2 b) {
	vec2 ba = b - a;
	vec2 pa = p - a;
	float h = clamp(dot(pa, ba) / dot(ba, ba), 0., 1.);
	return length(pa - h * ba);
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {

	fragColor = vec4(0.0);

	for (float i = 0.0; i < NUM_PARTICLES; i++) {
	
		// Read position and velocity data from buffer
		vec4 posVel = fetch(i);
		
		// Draw lines based on position and velocity of each particle
		float trail = mass(i) / line(fragCoord, posVel.xy, posVel.xy + posVel.zw * 256.0);
		
		// Make faster particles more yellow
		fragColor = max(fragColor, vec4(trail, trail * length(posVel.zw) * 24.0, 0.0, 1.0));
	}
}