#version 150

#moj_import <minecraft:fog.glsl>

uniform float GameTime;
uniform vec4 ColorModulator;
uniform float FogStart;
uniform float FogEnd;
uniform vec4 FogColor;

#moj_import <minecraft:text_data.glsl>
#moj_import <minecraft:spin_effect.glsl>
#moj_import <minecraft:outline_effect.glsl>
#moj_import <minecraft:hatch_effect.glsl>
#moj_import <minecraft:neon_effect.glsl>
#moj_import <minecraft:split_effect.glsl>
#moj_import <minecraft:chromatic_effect.glsl>
#moj_import <minecraft:extrude_effect.glsl>
#moj_import <minecraft:noise_effect.glsl>
#moj_import <minecraft:liquid_effect.glsl>
#moj_import <minecraft:water_effect.glsl>

uniform sampler2D Sampler0;

in float vertexDistance;
in vec4 vertexColor;
in vec2 texCoord0;

in vec3 spinT0;
in vec3 spinT1;
in vec3 spinT2;
in vec3 spinT3;
in float spinFlip;
in float spinScale;

in float fshEffectID;
in vec4 fshBaseColor;
in vec2 fshCharUV;
in vec4 fshEffectColor;
in vec4 fshExtrudeColor2;
in vec4 fshExtrudeColor3;
in vec4 fshEffectParams;
in vec3 fshGlyphT0;
in vec3 fshGlyphT1;
in vec3 fshGlyphT2;
in vec3 fshGlyphT3;
in float fshDisplayAlpha;

out vec4 fragColor;

void main() {
    vec2 uv = texCoord0;

    applySpinEffect(uv, spinT0, spinT1, spinT2, spinT3, spinScale, spinFlip, texCoord0, Sampler0);

    int effectID = int(fshEffectID + 0.5);

    if (effectID == 1) {
        applyOutlineEffect(uv, fshBaseColor, fshEffectColor, fshEffectParams,
                           fshGlyphT0, fshGlyphT1, fshGlyphT2, fshGlyphT3,
                           Sampler0, fragColor);
        fragColor.a *= fshDisplayAlpha;
        return;
    } else if (effectID == 2) {
        applyHatchEffect(uv, fshBaseColor, fshEffectColor, fshEffectParams,
                         fshGlyphT0, fshGlyphT1, fshGlyphT2, fshGlyphT3,
                         GameTime, Sampler0, fragColor);
        fragColor.a *= fshDisplayAlpha;
        return;
    } else if (effectID == 3) {
        applyNeonEffect(uv, fshEffectColor, fshEffectParams,
                        fshGlyphT0, fshGlyphT1, fshGlyphT2, fshGlyphT3,
                        GameTime, Sampler0, fragColor);
        fragColor.a *= fshDisplayAlpha;
        return;
    } else if (effectID == 5) {
        applySplitEffect(uv, fshBaseColor, fshEffectColor, fshEffectParams,
                            fshGlyphT0, fshGlyphT1, fshGlyphT2, fshGlyphT3,
                            GameTime, Sampler0, fragColor);
        fragColor.a *= fshDisplayAlpha;
        return;
    } else if (effectID == 6) {
        applyChromaticEffect(uv, fshBaseColor, fshEffectColor, fshEffectParams,
                             fshGlyphT0, fshGlyphT1, fshGlyphT2, fshGlyphT3,
                             GameTime, Sampler0, fragColor);
        fragColor.a *= fshDisplayAlpha;
        return;
    } else if (effectID == 7) {
        applyExtrudeEffect(uv, fshBaseColor, fshEffectColor, fshExtrudeColor2, fshExtrudeColor3,
                           fshEffectParams,
                           fshGlyphT0, fshGlyphT1, fshGlyphT2, fshGlyphT3,
                           Sampler0, fragColor);
        fragColor.a *= fshDisplayAlpha;
        return;
    } else if (effectID == 8) {
        applyNoiseEffect(uv, fshBaseColor, fshEffectColor, fshEffectParams,
                         fshGlyphT0, fshGlyphT1, fshGlyphT2, fshGlyphT3,
                         GameTime, Sampler0, fragColor);
        fragColor.a *= fshDisplayAlpha;
        return;
    } else if (effectID == 9) {
        applyLiquidEffect(uv, fshBaseColor, fshEffectColor, fshEffectParams,
                          fshGlyphT0, fshGlyphT1, fshGlyphT2, fshGlyphT3,
                          GameTime, Sampler0, fragColor);
        fragColor.a *= fshDisplayAlpha;
        return;
    } else if (effectID == 10) {
        applyWaterEffect(uv, fshBaseColor, fshEffectColor, fshEffectParams,
                         fshGlyphT0, fshGlyphT1, fshGlyphT2, fshGlyphT3,
                         GameTime, Sampler0, fragColor);
        fragColor.a *= fshDisplayAlpha;
        return;
    }

    vec4 color = texture(Sampler0, uv) * vertexColor * ColorModulator;

    TextData textData;
    textData.uv = uv;
    textData.spinT0 = spinT0;
    textData.spinT1 = spinT1;
    textData.spinT2 = spinT2;
    textData.spinT3 = spinT3;
    textData.color = color;
    textData.vertexColor = vertexColor;

    if (color.a < 0.1) {
        discard;
    }

    fragColor = linear_fog(color, vertexDistance, FogStart, FogEnd, FogColor);

    if (vertexColor.rgb == vec3(1.0, 1.0, 1.0)) {
        fragColor = color;
    }
}
