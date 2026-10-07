#version 330
#extension GL_ARB_separate_shader_objects : require

#if !defined(IS_GUI) && !defined(IS_SEE_THROUGH)
#include <minecraft:fog.glsl>
#endif

#include <minecraft:dynamictransforms.glsl>
#include <minecraft:globals.glsl>
#include <minecraft:oit.glsl>
#include <minecraft:coverage.glsl>
#include <minecraft:text_data.glsl>
#include <minecraft:spin_effect.glsl>
#include <minecraft:outline_effect.glsl>
#include <minecraft:hatch_effect.glsl>
#include <minecraft:neon_effect.glsl>
#include <minecraft:split_effect.glsl>
#include <minecraft:chromatic_effect.glsl>
#include <minecraft:extrude_effect.glsl>
#include <minecraft:noise_effect.glsl>
#include <minecraft:liquid_effect.glsl>
#include <minecraft:water_effect.glsl>

uniform sampler2D Sampler0;

#if !defined(IS_GUI) && !defined(IS_SEE_THROUGH)
layout(location = 0) in float sphericalVertexDistance;
layout(location = 1) in float cylindricalVertexDistance;
#endif

layout(location = 2) in vec4 vertexColor;
layout(location = 3) in vec2 texCoord0;

layout(location = 4) in vec3 spinT0;
layout(location = 5) in vec3 spinT1;
layout(location = 6) in vec3 spinT2;
layout(location = 7) in vec3 spinT3;
layout(location = 8) in float spinFlip;
layout(location = 9) in float spinScale;

layout(location = 10) in float fshEffectID;
layout(location = 11) in vec4 fshBaseColor;
layout(location = 12) in vec2 fshCharUV;
layout(location = 13) in vec4 fshEffectColor;
layout(location = 14) in vec4 fshExtrudeColor2;
layout(location = 15) in vec4 fshExtrudeColor3;
layout(location = 16) in vec4 fshEffectParams;
layout(location = 17) in vec3 fshGlyphT0;
layout(location = 18) in vec3 fshGlyphT1;
layout(location = 19) in vec3 fshGlyphT2;
layout(location = 20) in vec3 fshGlyphT3;
layout(location = 21) in float fshDisplayAlpha;

#ifndef OIT_ALPHA_ONLY
layout(location = 0) out vec4 fragColor;
#endif

vec4 textEffectsColor() {
    vec4 effectColor;
    vec2 uv = texCoord0;

    // Apply spin effect
    applySpinEffect(uv, spinT0, spinT1, spinT2, spinT3, spinScale, spinFlip, texCoord0, Sampler0);

    int effectID = int(fshEffectID + 0.5);

    if (effectID == 1) {
        applyOutlineEffect(uv, fshBaseColor, fshEffectColor, fshEffectParams,
                           fshGlyphT0, fshGlyphT1, fshGlyphT2, fshGlyphT3,
                           Sampler0, effectColor);
        effectColor.a *= fshDisplayAlpha;
        return effectColor;
    } else if (effectID == 2) {
        applyHatchEffect(uv, fshBaseColor, fshEffectColor, fshEffectParams,
                         fshGlyphT0, fshGlyphT1, fshGlyphT2, fshGlyphT3,
                         GameTime, Sampler0, effectColor);
        effectColor.a *= fshDisplayAlpha;
        return effectColor;
    } else if (effectID == 3) {
        applyNeonEffect(uv, fshEffectColor, fshEffectParams,
                        fshGlyphT0, fshGlyphT1, fshGlyphT2, fshGlyphT3,
                        GameTime, Sampler0, effectColor);
        effectColor.a *= fshDisplayAlpha;
        return effectColor;
    } else if (effectID == 5) {
        applySplitEffect(uv, fshBaseColor, fshEffectColor, fshEffectParams,
                            fshGlyphT0, fshGlyphT1, fshGlyphT2, fshGlyphT3,
                            GameTime, Sampler0, effectColor);
        effectColor.a *= fshDisplayAlpha;
        return effectColor;
    } else if (effectID == 6) {
        applyChromaticEffect(uv, fshBaseColor, fshEffectColor, fshEffectParams,
                             fshGlyphT0, fshGlyphT1, fshGlyphT2, fshGlyphT3,
                             GameTime, Sampler0, effectColor);
        effectColor.a *= fshDisplayAlpha;
        return effectColor;
    } else if (effectID == 7) {
        applyExtrudeEffect(uv, fshBaseColor, fshEffectColor, fshExtrudeColor2, fshExtrudeColor3,
                           fshEffectParams,
                           fshGlyphT0, fshGlyphT1, fshGlyphT2, fshGlyphT3,
                           Sampler0, effectColor);
        effectColor.a *= fshDisplayAlpha;
        return effectColor;
    } else if (effectID == 8) {
        applyNoiseEffect(uv, fshBaseColor, fshEffectColor, fshEffectParams,
                         fshGlyphT0, fshGlyphT1, fshGlyphT2, fshGlyphT3,
                         GameTime, Sampler0, effectColor);
        effectColor.a *= fshDisplayAlpha;
        return effectColor;
    } else if (effectID == 9) {
        applyLiquidEffect(uv, fshBaseColor, fshEffectColor, fshEffectParams,
                          fshGlyphT0, fshGlyphT1, fshGlyphT2, fshGlyphT3,
                          GameTime, Sampler0, effectColor);
        effectColor.a *= fshDisplayAlpha;
        return effectColor;
    } else if (effectID == 10) {
        applyWaterEffect(uv, fshBaseColor, fshEffectColor, fshEffectParams,
                         fshGlyphT0, fshGlyphT1, fshGlyphT2, fshGlyphT3,
                         GameTime, Sampler0, effectColor);
        effectColor.a *= fshDisplayAlpha;
        return effectColor;
    }

#ifdef IS_GRAYSCALE
    vec4 texColor = texture(Sampler0, uv).rrrr;
#else
    vec4 texColor = texture(Sampler0, uv);
#endif
    return texColor * vertexColor;
}

vec4 calculateFinalColor(vec4 color) {
#ifdef OIT_ACCUMULATE
    color = sampleColorForAccumulation(color);
#endif
#if !defined(IS_SEE_THROUGH) && !defined(IS_GUI)
#ifdef OIT_ACCUMULATE
    vec4 fogColor = vec4(FogColor.rgb * color.a, FogColor.a);
#else
    vec4 fogColor = FogColor;
#endif
    color = apply_fog(color, sphericalVertexDistance, cylindricalVertexDistance,
        FogEnvironmentalStart, FogEnvironmentalEnd,
        FogRenderDistanceStart, FogRenderDistanceEnd, fogColor);
#endif
    return color;
}

void main() {
    vec4 color = textEffectsColor() * ColorModulator;
    if (color.a < 0.1) discard;
#ifdef OIT_ALPHA_ONLY
    executeAlphaOnlyPhase(gl_FragCoord.z, color.a);
#else
    fragColor = calculateFinalColor(color);
#endif
}
