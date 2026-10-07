#ifndef TEXT_EFFECTS_26_2_CHROMATIC_EFFECT_GLSL
#define TEXT_EFFECTS_26_2_CHROMATIC_EFFECT_GLSL

// Chromatic Aberration effect: R channel offset left, B channel offset right,
// composited additively (screen blend) for a color fringe look.
// Requires text_data.glsl to be imported before this file.
// fshEffectParams.x = intensity (pixel offset radius)
// fshEffectParams.y = speed    (animation frequency multiplier)

#ifndef PI
#define PI 3.14159265359
#endif

void applyChromaticEffect(vec2 uv, vec4 baseColor, vec4 effectColor, vec4 effectParams,
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

    // Animated offset: oscillates between base and base*1.4
    float anim = 1.0 + 0.4 * sin(gameTime * speed * 1000.0);
    vec2 offset = vec2(intensity * anim / texSize.x, 0.0);

    // Sample R, G, B channels from shifted UVs
    float aR = 0.0, aG = 0.0, aB = 0.0;
    vec2 sR = uv - offset;
    vec2 sG = uv;
    vec2 sB = uv + offset;
    if (sR.x >= uvMin.x && sR.x <= uvMax.x && sR.y >= uvMin.y && sR.y <= uvMax.y) aR = textEffectsCoverage(tex, sR);
    if (sG.x >= uvMin.x && sG.x <= uvMax.x && sG.y >= uvMin.y && sG.y <= uvMax.y) aG = textEffectsCoverage(tex, sG);
    if (sB.x >= uvMin.x && sB.x <= uvMax.x && sB.y >= uvMin.y && sB.y <= uvMax.y) aB = textEffectsCoverage(tex, sB);

    float maxA = max(max(aR, aG), aB);
    if (maxA < 0.1) discard;

    // Screen-blend: red copy + main (baseColor) + blue copy
    vec3 color;
    color.r = aR + aG * baseColor.r;
    color.g = aG * baseColor.g;
    color.b = aB + aG * baseColor.b;
    color = clamp(color, 0.0, 1.0);

    result = vec4(color, maxA * baseColor.a);
}

#endif // TEXT_EFFECTS_26_2_CHROMATIC_EFFECT_GLSL
