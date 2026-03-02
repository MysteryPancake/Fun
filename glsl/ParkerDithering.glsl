// Available at https://www.shadertoy.com/view/7cfGz8

// Matt Parker Dithering (youtube.com/watch?v=kT4p1GXq4HY)
// Adapted from @kbjwes77 (shadertoy.com/view/WstXR8)

// Parker square values, flipped to match ShaderToy coordinates
// From en.wikipedia.org/wiki/Magic_square_of_squares#Parker_square
mat3 parkerIndex = mat3(
    vec3(.23, .41, .29),
    vec3(.41, .37, .01),
    vec3(.29, .01, .47));

void mainImage(out vec4 fragColor,in vec2 fragCoord) {

    // Sample texture
    vec2 uv = fragCoord / iResolution.xy;
    float col = texture(iChannel0, uv).r;
    
    // Gamma correction
    col = pow(col, 2.2);
    
    // Find parker matrix entry based on fragment position
    float parkerValue = parkerIndex[int(fragCoord.x) % 3][int(fragCoord.y) % 3];
    if (fragCoord.x > iMouse.x) col = step(parkerValue, col);
    
    // Output color
    fragColor = vec4(vec3(col), 1.);
}