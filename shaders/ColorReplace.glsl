// Available at https://www.shadertoy.com/view/sslyDB
void mainImage(out vec4 fragColor, in vec2 fragCoord) {

  vec4 col = texture(iChannel0, fragCoord / iResolution.xy);
  
  vec3 target = vec3(1.0, 1.0, 1.0); // Find white
  vec3 replace = vec3(0.0, 1.0, 0.0); // Replace with green
  
  float threshold = 0.5; // Controls target color range
  float softness = 0.2; // Controls soft falloff
  
  // Get difference to find whether soft falloff is required
  float diff = threshold - distance(col.xyz, target.xyz);
  
  // Apply soft falloff if needed, otherwise don't bother
  float factor = diff > 0.0 ? 0.0 : clamp(abs(diff) / softness, 0.0, 1.0);
  
  fragColor = vec4(mix(replace, col.xyz, factor), col.a);
}