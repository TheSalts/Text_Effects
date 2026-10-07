#ifndef TEXT_EFFECTS_26_2_LIQUID_EFFECT_GLSL
#define TEXT_EFFECTS_26_2_LIQUID_EFFECT_GLSL

// Liquid Morph effect: smooth sin-based turbulence that displaces UV coordinates,
// producing a slow organic liquid-like warp animation.
// Requires text_data.glsl to be imported before this file.
// fshEffectParams.x = intensity (pixel displacement radius)
// fshEffectParams.y = speed    (animation rate multiplier)

void applyLiquidEffect(vec2 uv, vec4 baseColor, vec4 effectColor, vec4 effectParams,
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
    float t = gameTime * speed * 1000.0;

    // Smooth turbulence-like displacement via crossed sin/cos products
    vec2 displ = vec2(
        sin(uv.y * 40.0 + t) * cos(uv.x * 25.0 - t * 0.7),
        cos(uv.x * 40.0 - t) * sin(uv.y * 25.0 + t * 0.7)
    ) * intensity / texSize;

    vec2 sampleUV = uv + displ;
    if (sampleUV.x < uvMin.x || sampleUV.x > uvMax.x ||
        sampleUV.y < uvMin.y || sampleUV.y > uvMax.y) {
        discard;
    }
    float a = textEffectsCoverage(tex, sampleUV);
    if (a < 0.1) discard;

    result = vec4(baseColor.rgb, a * baseColor.a);
}

#endif // TEXT_EFFECTS_26_2_LIQUID_EFFECT_GLSL
