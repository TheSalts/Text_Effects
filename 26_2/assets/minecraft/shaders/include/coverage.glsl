#ifndef TEXT_EFFECTS_26_2_COVERAGE_GLSL
#define TEXT_EFFECTS_26_2_COVERAGE_GLSL
float textEffectsCoverage(sampler2D tex, vec2 uv) {
#ifdef IS_GRAYSCALE
    return texture(tex, uv).r;
#else
    return texture(tex, uv).a;
#endif
}
#endif
