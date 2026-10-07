#ifndef TEXT_EFFECTS_26_2_OUTLINE_EFFECT_GLSL
#define TEXT_EFFECTS_26_2_OUTLINE_EFFECT_GLSL

// Outline effect: renders a colored border around glyph edges via 8-direction sampling.
// Requires text_data.glsl to be imported before this file.
// fshEffectParams.x = thickness (pixels, min 0.5)

#ifndef PI
#define PI 3.14159265359
#endif

void applyOutlineEffect(vec2 uv,
                        vec4 baseColor,
                        vec4 effectColor,
                        vec4 effectParams,
                        vec3 glyphT0, vec3 glyphT1, vec3 glyphT2, vec3 glyphT3,
                        sampler2D tex,
                        out vec4 result) {
    vec2 uvMin, uvMax;
    calculateUVBounds(glyphT0, glyphT1, glyphT2, glyphT3, uvMin, uvMax);

    // Fallback when glyph corners are not yet populated (all-zero from vsh)
    if (uvMax.x < uvMin.x || uvMax.y < uvMin.y) {
        uvMin = vec2(0.0);
        uvMax = vec2(1.0);
    }

    vec2 texSize = vec2(textureSize(tex, 0));
    float thickness = max(effectParams.x, 0.5);
    vec2 px = thickness / texSize;

    // Treat any sample outside the current glyph's UV cell as transparent
    // so the expanded quad doesn't pick up adjacent atlas cells.
    bool insideBounds = (uv.x >= uvMin.x && uv.x <= uvMax.x &&
                         uv.y >= uvMin.y && uv.y <= uvMax.y);
    float currentA = insideBounds ? textEffectsCoverage(tex, uv) : 0.0;

    float maxA = 0.0;
    for (int i = 0; i < 8; i++) {
        float angle = float(i) * (PI / 4.0);
        vec2 offset = vec2(cos(angle), sin(angle)) * px;
        vec2 sampleUV = uv + offset;
        // Clamp to glyph bounds to avoid bleeding into adjacent glyphs
        if (sampleUV.x < uvMin.x || sampleUV.x > uvMax.x ||
            sampleUV.y < uvMin.y || sampleUV.y > uvMax.y) {
            continue;
        }
        float a = textEffectsCoverage(tex, sampleUV);
        if (a > maxA) maxA = a;
    }

    if (currentA < 0.1 && maxA > 0.5) {
        // Outline pixel
        result = effectColor;
    } else if (currentA >= 0.1) {
        // Glyph interior: use base color
        result = vec4(baseColor.rgb, currentA * baseColor.a);
    } else {
        discard;
    }
}

#endif // TEXT_EFFECTS_26_2_OUTLINE_EFFECT_GLSL
