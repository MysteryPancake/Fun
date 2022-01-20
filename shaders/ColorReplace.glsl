// Available at https://www.shadertoy.com/view/sslyDB
void mainImage(out vec4 fragColor, in vec2 fragCoord) {

  vec4 col = texture(iChannel0, fragCoord / iResolution.xy);
  
  vec3 target = vec3(0.0, 0.0, 0.0); // Find black
  vec3 replace = vec3(1.0, 0.0, 0.0); // Replace with red
  
  float threshold = 0.25; // Controls target color range
  float softness = 0.25; // Controls soft falloff
  
  // Get difference to use for falloff if required
  float diff = distance(col.xyz, target.xyz) - threshold;
  
  // Apply soft falloff if needed, otherwise clamp
  float factor = clamp(diff / softness, 0.0, 1.0);
  
  fragColor = vec4(mix(replace, col.xyz, factor), col.a);
}