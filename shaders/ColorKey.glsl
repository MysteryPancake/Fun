// Available at https://www.shadertoy.com/view/NsfcWj
void mainImage(out vec4 fragColor, in vec2 fragCoord) {

  vec4 col = texture(iChannel0, fragCoord / iResolution.xy);
  vec4 replace = texture(iChannel1, fragCoord / iResolution.xy);
  
  vec3 target = vec3(0.0, 1.0, 0.0); // Find green
  
  float threshold = 0.5; // Controls target color range
  float softness = 0.25; // Controls linear falloff
  
  // Get difference to use for falloff if required
  float diff = distance(col.xyz, target.xyz) - threshold;
  
  // Apply linear falloff if needed, otherwise clamp
  float factor = clamp(diff / softness, 0.0, 1.0);
  
  fragColor = vec4(mix(replace.xyz, col.xyz, factor), col.a);
}