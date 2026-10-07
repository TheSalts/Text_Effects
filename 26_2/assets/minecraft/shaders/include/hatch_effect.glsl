#ifndef TEXT_EFFECTS_26_2_HATCH_EFFECT_GLSL
#define TEXT_EFFECTS_26_2_HATCH_EFFECT_GLSL

// Hatch effect: animated diagonal hatching pattern overlaid on the glyph.
// Requires text_data.glsl to be imported before this file.
// fshEffectParams.y = speed (sweep rate)
// fshEffectParams.z = density (number of stripes per glyph diagonal)

void applyHatchEffect(vec2 uv,
                      vec4 baseColor,
                      vec4 effectColor,
                      vec4 effectParams,
                      vec3 glyphT0, vec3 glyphT1, vec3 glyphT2, vec3 glyphT3,
                      float gameTime,
                      sampler2D tex,
                      out vec4 result) {
    float currentA = textEffectsCoverage(tex, uv);
    if (currentA < 0.1) {
        discard;
    }

    vec2 uvMin, uvMax;
    calculateUVBounds(glyphT0, glyphT1, glyphT2, glyphT3, uvMin, uvMax);
    if (uvMax.x < uvMin.x || uvMax.y < uvMin.y) {
        uvMin = vec2(0.0);
        uvMax = vec2(1.0);
    }

    vec2 uvSize = uvMax - uvMin;
    float uNorm = (uvSize.x > 0.0001) ? (uv.x - uvMin.x) / uvSize.x : 0.5;
    float vNorm = (uvSize.y > 0.0001) ? (uv.y - uvMin.y) / uvSize.y : 0.5;

    float speed   = effectParams.y;
    float density = max(effectParams.z, 0.5);
    // Diagonal coordinate (45 degrees), scrolled by time.
    // Multiplier matches other animated effects' time scale (~1 cycle/sec at default speed).
    float diagPos = (uNorm + vNorm) * density - gameTime * speed * 2.0;
    float band = fract(diagPos);
    // 25% duty cycle hard-edged stripes — band in [0, 0.25] is a thin stripe, [0.25, 1] is gap.
    float hatchMask = 1.0 - step(0.25, band);

    vec3 outColor = mix(baseColor.rgb, effectColor.rgb, hatchMask);
    float outAlpha = currentA * mix(baseColor.a, max(baseColor.a, effectColor.a), hatchMask);
    result = vec4(outColor, outAlpha);
}

#endif // TEXT_EFFECTS_26_2_HATCH_EFFECT_GLSL
