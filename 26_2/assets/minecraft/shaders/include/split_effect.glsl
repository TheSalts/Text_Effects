#ifndef TEXT_EFFECTS_26_2_SPLIT_EFFECT_GLSL
#define TEXT_EFFECTS_26_2_SPLIT_EFFECT_GLSL

// Split effect: cleanly cuts the glyph horizontally at vertical midpoint and
// alternates the top half between the shifted-left position and the original
// position over time.  Bottom half always renders at the original position.
// Requires text_data.glsl to be imported before this file.
// fshEffectParams.x = intensity (pixel offset of the top half, positive shifts left)
// fshEffectParams.y = speed     (toggle rate)

void applySplitEffect(vec2 uv,
                      vec4 baseColor,
                      vec4 effectColor,
                      vec4 effectParams,
                      vec3 glyphT0, vec3 glyphT1, vec3 glyphT2, vec3 glyphT3,
                      float gameTime,
                      sampler2D tex,
                      out vec4 result) {
    vec2 uvMin, uvMax;
    calculateUVBounds(glyphT0, glyphT1, glyphT2, glyphT3, uvMin, uvMax);
    if (uvMax.x < uvMin.x || uvMax.y < uvMin.y) {
        uvMin = vec2(0.0);
        uvMax = vec2(1.0);
    }

    vec2 uvSize = uvMax - uvMin;
    float vNorm = (uvSize.y > 0.0001) ? (uv.y - uvMin.y) / uvSize.y : 0.5;
    bool isTopHalf = vNorm < 0.5;

    // Smooth sin oscillation between original and shifted positions.
    // shiftFactor: 0 = original, 1 = fully shifted left.
    float speed = effectParams.y;
    float shiftFactor = sin(gameTime * speed * 3000.0) * 0.5 + 0.5;

    float shiftRatio = clamp(effectParams.x * 0.2, 0.05, 0.6);

    float scaledU;
    if (isTopHalf) {
        // Top half — interpolate sampling between shifted and original.
        // At shiftFactor=0: subtract = shiftRatio*uvSize (= bottom formula, original pos)
        // At shiftFactor=1: subtract = 0                  (= shifted left fully)
        float subtract = (1.0 - shiftFactor) * shiftRatio * uvSize.x;
        scaledU = (uv.x - uvMin.x) * (1.0 + shiftRatio) - subtract;
        if (scaledU < 0.0 || scaledU > uvSize.x) {
            discard; // cut area on either side as the half slides
        }
    } else {
        // Bottom half always at original screen position.
        scaledU = (uv.x - uvMin.x) * (1.0 + shiftRatio) - shiftRatio * uvSize.x;
        if (scaledU < 0.0) {
            discard;
        }
    }

    vec2 sampleUV = vec2(uvMin.x + scaledU, uv.y);

    float a = textEffectsCoverage(tex, sampleUV);
    if (a < 0.1) {
        discard;
    }

    result = vec4(baseColor.rgb, a * baseColor.a);
}

#endif // TEXT_EFFECTS_26_2_SPLIT_EFFECT_GLSL
