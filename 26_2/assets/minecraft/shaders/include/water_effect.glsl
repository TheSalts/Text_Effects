#ifndef TEXT_EFFECTS_26_2_WATER_EFFECT_GLSL
#define TEXT_EFFECTS_26_2_WATER_EFFECT_GLSL

// Water effect: fills the glyph interior with rising water up to a configurable
// level, with a wavy animated surface and a light-to-dark depth gradient below.
// Above the water line the fragment uses the base color (set with apply_color).
//
// fshEffectParams.x = level     (0.0 = empty, 1.0 = full)
// fshEffectParams.y = amplitude (wave height, in glyph-height units)
// fshEffectParams.z = speed     (animation speed)
// fshEffectParams.w = frequency (number of wave crests across the glyph width)

void applyWaterEffect(vec2 uv,
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
        uvMin = vec2(0.0); uvMax = vec2(1.0);
    }

    vec2 uvSize = uvMax - uvMin;
    float uNorm = (uvSize.x > 0.0001) ? (uv.x - uvMin.x) / uvSize.x : 0.5;
    float vNorm = (uvSize.y > 0.0001) ? (uv.y - uvMin.y) / uvSize.y : 0.5;

    float level = clamp(effectParams.x, 0.0, 1.0);
    float amp   = effectParams.y;
    float speed = effectParams.z;
    float freq  = max(effectParams.w, 0.5);

    float t = gameTime * speed * 12000.0;

    // Wave surface offset (signed) in vNorm units.  Two-frequency composite for
    // organic look.  Total amplitude scaled so amp=1 ~= 8% of glyph height.
    float wave = sin(uNorm * 6.2831853 * freq          + t)        * 0.6
               + sin(uNorm * 6.2831853 * freq * 2.0    + t * 1.3)  * 0.4;
    wave *= amp * 0.08;

    // Surface position in vNorm space.  vNorm: 0 = top of glyph, 1 = bottom.
    // level=1 (full) places the surface at the very top → waterLine = 0.
    float waterLine = (1.0 - level) + wave;

    if (vNorm < waterLine) {
        // Above the water — render the glyph at the base color so the silhouette
        // remains visible.  Use apply_color() in the config to control the dry
        // portion (e.g. dimmed grey for an outline-like look).
        result = vec4(baseColor.rgb, currentA * baseColor.a);
        return;
    }

    // Below the water — gradient from light (surface) to dark (deep)
    float depth = (1.0 - waterLine > 0.0001)
        ? (vNorm - waterLine) / (1.0 - waterLine)
        : 0.5;
    depth = clamp(depth, 0.0, 1.0);

    vec3 lightWater = effectColor.rgb;
    vec3 deepWater  = effectColor.rgb * 0.45;
    vec3 waterCol   = mix(lightWater, deepWater, depth);

    // Subtle wave-front highlight near the surface
    float surfaceGlow = smoothstep(0.0, 0.05, depth) * (1.0 - smoothstep(0.0, 0.10, depth));
    waterCol = mix(waterCol, mix(lightWater, vec3(1.0), 0.5), surfaceGlow * 0.4);

    result = vec4(waterCol, currentA * effectColor.a);
}

#endif // TEXT_EFFECTS_26_2_WATER_EFFECT_GLSL
