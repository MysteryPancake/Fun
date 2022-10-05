// Available at https://www.shadertoy.com/view/sslyDB
void mainImage(out vec4 fragColor, in vec2 fragCoord) {

  vec4 col = texture(iChannel0, fragCoord / iResolution.xy);
  
  const vec3 target = vec3(0.0, 0.0, 0.0); // Find black
  const vec3 replace = vec3(1.0, 0.0, 0.0); // Replace with red
  
  const float threshold = 0.25; // Controls target color range
  const float softness = 0.25; // Controls linear falloff
  
  // Get difference to use for falloff if required
  float diff = distance(col.rgb, target) - threshold;
  
  // Apply linear falloff if needed, otherwise clamp
  float factor = clamp(diff / softness, 0.0, 1.0);
  
  fragColor = vec4(mix(replace, col.rgb, factor), col.a);
}
