#moj_import <minecraft:text_data.glsl>

float random_glitch2(vec2 seed) {
    return fract(sin(dot(seed, vec2(12.9898, 78.233))) * 43758.5453);
}

float noise_glitch2(float n) {
    float i = floor(n);
    float f = fract(n);
    return mix(random_glitch2(vec2(i, 0.0)), random_glitch2(vec2(i + 1.0, 0.0)), smoothstep(0.0, 1.0, f));
}

bool uvBoundsCheck_glitch2(vec2 uv, vec2 uvMin, vec2 uvMax) {
    if(isnan(uv.x) || isnan(uv.y)) return true;
    const float error = 0.0001;
    return uv.x < uvMin.x + error || uv.y < uvMin.y + error || uv.x > uvMax.x - error || uv.y > uvMax.y - error;
}

void applyGlitch2Effect(inout TextData data, sampler2D texSampler) {
    // Calculate UV bounds
    vec2 uvMin, uvMax;
    calculateUVBounds(data.spinT0, data.spinT1, data.spinT2, data.spinT3, uvMin, uvMax);

    // Glitch2 with animated noise offset
    float noiseX = noise_glitch2(GameTime * 12000.0) - 0.5;
    float noiseY = noise_glitch2(GameTime * 12000.0 + 19732.134) - 0.5;
    vec2 offset = vec2(0.5 / 256, 0.0) + vec2(0.5, 1.0) * vec2(noiseX, noiseY) / 256;

    vec2 uv = data.uv + offset;
    vec4 s1 = texture(texSampler, uv);
    s1.rgb *= s1.a;
    if(uvBoundsCheck_glitch2(uv, uvMin, uvMax)) s1 = vec4(0.0);

    uv = data.uv - offset;
    vec4 s2 = texture(texSampler, uv);
    s2.rgb *= s2.a;
    if(uvBoundsCheck_glitch2(uv, uvMin, uvMax)) s2 = vec4(0.0);

    // Combine chromatic samples with original color
    vec4 chromaticEffect = (s1 * vec4(1.0, 0.25, 0.0, 1.0)) + (s2 * vec4(0.0, 0.75, 1.0, 1.0));

    // Get original text sample
    vec4 originalSample = texture(texSampler, data.uv);

    // Blend chromatic effect behind the original text
    data.color = mix(chromaticEffect, originalSample, originalSample.a);
    data.color.rgb *= data.vertexColor.rgb;
}
