// Available at https://www.shadertoy.com/view/scd3z7

// For more waveforms, see my shader below
// https://www.shadertoy.com/view/clXSR7

float triangle(float x, float scale, float spacing) {
    return max(0., .5 - abs(mod(x, spacing) / scale - .5)) * 2.;
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 p = (fragCoord - .5 * iResolution.xy) / iResolution.y;
    p.y -= iTime * .2;
    
    float freq_x = sin(iTime) * .2 + .5;
    float freq_y = .1;
    float amp = sin(iTime) * .2;
    float spacing = .2;
    
    float val = triangle(p.y + triangle(p.x, freq_x, freq_x) * amp, freq_y, spacing);
    fragColor = vec4(vec3(val), 1.);
}