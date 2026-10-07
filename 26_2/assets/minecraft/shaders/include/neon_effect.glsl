#ifndef TEXT_EFFECTS_26_2_NEON_EFFECT_GLSL
#define TEXT_EFFECTS_26_2_NEON_EFFECT_GLSL

// Neon effect: glowing glyph with a halo sampled from surrounding pixels.
// Requires text_data.glsl to be imported before this file.
// fshEffectParams.x = intensity (halo strength multiplier)
// fshEffectParams.y = flickerSpeed (multiplier for flicker sine frequency)

#ifndef PI
#define PI 3.14159265359
#endif

void applyNeonEffect(vec2 uv,
                     vec4 effectColor,
                     vec4 effectParams,
                     vec3 glyphT0, vec3 glyphT1, vec3 glyphT2, vec3 glyphT3,
                     float gameTime,
                     sampler2D tex,
                     out vec4 result) {
    float currentA = textEffectsCoverage(tex, uv);
    float intensity    = effectParams.x;
    float flickerSpeed = effectParams.y;

    vec2 uvMin, uvMax;
    calculateUVBounds(glyphT0, glyphT1, glyphT2, glyphT3, uvMin, uvMax);

    // Fallback when glyph corners are not yet populated (all-zero from vsh)
    if (uvMax.x < uvMin.x || uvMax.y < uvMin.y) {
        uvMin = vec2(0.0);
        uvMax = vec2(1.0);
    }

    vec2 texSize = vec2(textureSize(tex, 0));

    // Accumulate halo alpha from 8 directions x 3 radii
    float halo = 0.0;
    const int SAMPLES = 8;
    for (int i = 0; i < SAMPLES; i++) {
        float angle = float(i) * (PI / float(SAMPLES) * 2.0);
        for (float r = 1.0; r <= 3.0; r += 1.0) {
            vec2 offset = vec2(cos(angle), sin(angle)) * (r / texSize);
            vec2 sampleUV = uv + offset;
            if (sampleUV.x < uvMin.x || sampleUV.x > uvMax.x ||
                sampleUV.y < uvMin.y || sampleUV.y > uvMax.y) {
                continue;
            }
            halo += textEffectsCoverage(tex, sampleUV) / r;
        }
    }
    halo /= float(SAMPLES) * 3.0;
    halo *= intensity;

    // Subtle compound flicker — disabled when flickerSpeed == 0.
    float flicker = 1.0;
    if (flickerSpeed > 0.0001) {
        flicker = 0.85 + 0.15 * sin(gameTime * flickerSpeed * 5000.0)
                              * (0.5 + 0.5 * sin(gameTime * flickerSpeed * 10000.0 + 1.7));
    }

    vec3 neonColor = effectColor.rgb * flicker;

    if (currentA > 0.1) {
        // Glyph interior: render at full neon color
        result = vec4(neonColor, currentA * effectColor.a);
    } else if (halo > 0.05) {
        // Halo region outside glyph
        result = vec4(neonColor, halo * effectColor.a);
    } else {
        discard;
    }
}

#endif // TEXT_EFFECTS_26_2_NEON_EFFECT_GLSL
