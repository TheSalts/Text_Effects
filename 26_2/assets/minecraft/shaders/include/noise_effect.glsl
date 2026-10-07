#ifndef TEXT_EFFECTS_26_2_NOISE_EFFECT_GLSL
#define TEXT_EFFECTS_26_2_NOISE_EFFECT_GLSL

// Noise / Static effect: randomly displaces UV coordinates per pixel,
// with step-quantized time so the noise changes in discrete frames.
// Requires text_data.glsl to be imported before this file.
// fshEffectParams.x = intensity (pixel displacement radius)
// fshEffectParams.y = speed    (frame-change rate multiplier)

// Local random helper (common.glsl is not included in fsh)
float noiseRandom(vec2 seed) {
    return fract(sin(dot(seed, vec2(12.9898, 78.233))) * 43758.5453);
}

void applyNoiseEffect(vec2 uv, vec4 baseColor, vec4 effectColor, vec4 effectParams,
                      vec3 glyphT0, vec3 glyphT1, vec3 glyphT2, vec3 glyphT3,
                      float gameTime, sampler2D tex, out vec4 result) {
    vec2 uvMin, uvMax;
    calculateUVBounds(glyphT0, glyphT1, glyphT2, glyphT3, uvMin, uvMax);
    if (uvMax.x < uvMin.x || uvMax.y < uvMin.y) {
        uvMin = vec2(0.0); uvMax = vec2(1.0);
    }

    vec2 texSize = vec2(textureSize(tex, 0));
    float intensity = effectParams.x;
    float speed = effectParams.y;

    // Step-quantized noise animation — discrete frame jumps for TV-static feel.
    float t = floor(gameTime * speed * 1500.0);
    vec2 noiseOff = vec2(
        noiseRandom(vec2(floor(uv.y * texSize.y) + t, 0.0)) - 0.5,
        noiseRandom(vec2(floor(uv.x * texSize.x) + t, 1.0)) - 0.5
    ) * intensity / texSize;

    vec2 sampleUV = uv + noiseOff;
    if (sampleUV.x < uvMin.x || sampleUV.x > uvMax.x ||
        sampleUV.y < uvMin.y || sampleUV.y > uvMax.y) {
        discard;
    }
    float a = textEffectsCoverage(tex, sampleUV);
    if (a < 0.1) discard;

    // Subtle brightness flicker per frame
    float bright = 0.85 + 0.3 * noiseRandom(vec2(t, 0.5));
    result = vec4(baseColor.rgb * bright, a * baseColor.a);
}

#endif // TEXT_EFFECTS_26_2_NOISE_EFFECT_GLSL
