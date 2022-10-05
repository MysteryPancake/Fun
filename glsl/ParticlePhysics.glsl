// Available at https://www.shadertoy.com/view/flKfzG

// COMMON

#define NUM_PARTICLES 512.0

// To allow the entire buffer to be filled with particles
#define fetch(id) texelFetch(iChannel0, ivec2(mod(id, iResolution.x), floor(id / iResolution.x)), 0)

// BUFFER A

// Position and velocity buffer
void mainImage(out vec4 fragColor, in vec2 fragCoord) {
  
	float id = fragCoord.x - 0.5 + (fragCoord.y - 0.5) * iResolution.x;
	
	// Don't calculate unused particles
	if (id > NUM_PARTICLES) discard;
	
	if (iFrame < 1) {
	
		// Initialize variables
		float x = iResolution.x * fragCoord.x / NUM_PARTICLES;
		float y = iResolution.y * 0.5 + sin(fragCoord.x) * iResolution.y * 0.4;
		
		// Store as position x, position y, velocity x, velocity y
		fragColor = vec4(x, y, sin(fragCoord.x * 256.0) * 4.0, cos(fragCoord.x * 128.0) * 4.0);
		
	} else {
		
		// Read position and velocity data from previous frame
		vec4 posVel = fetch(id);
		vec2 pos = posVel.xy;
		vec2 vel = posVel.zw;
		
		// Simulate gravity
		vel.y -= 0.25;
		
		// Simulate wind
		vel.x += sin(iTime) * 0.5;
		
		// Euler integration (I think)
		pos += vel;
		
		// Dampen each particle differently, for variety
		float dampening = 0.95 + sin(fragCoord.x * 64.0) * 0.05;
		
		// Bounce particles on floor, thanks spalmer for fixes
		if (pos.y < 0.0) {
			vel.y *= -dampening;
			pos.y = max(-pos.y, 0.0);
		}
		
		// Bounce particles on walls, thanks spalmer for fixes
		if (pos.x < 0.0) {
			vel.x *= -dampening;
			pos.x = max(-pos.x, 0.0);
		} else if (pos.x > iResolution.x) {
			vel.x *= -dampening;
			pos.x = iResolution.x + min(iResolution.x - pos.x, 0.0);
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

	// Initialize fragColor, thanks mla for the tip
	fragColor = vec4(0.0);

	for (float i = 0.0; i < NUM_PARTICLES; i++) {
	
		// Read position and velocity data from buffer
		vec4 posVel = fetch(i);
		
		// Draw lines based on position and velocity of each particle
		float trail = 4.0 / line(fragCoord, posVel.xy, posVel.xy + posVel.zw);
		
		// Make faster particles more yellow
		fragColor = max(fragColor, vec4(trail, trail * length(posVel.zw) * 0.02, 0.0, 1.0));
	}
}