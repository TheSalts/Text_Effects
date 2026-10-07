#version 330
#extension GL_ARB_separate_shader_objects : require

#if !defined(IS_GUI) && !defined(IS_SEE_THROUGH)
#include <minecraft:fog.glsl>
#include <minecraft:sample_lightmap.glsl>
#endif

#include <minecraft:dynamictransforms.glsl>
#include <minecraft:projection.glsl>
#include <minecraft:globals.glsl>

layout(location = 0) in vec3 Position;
layout(location = 1) in vec4 Color;
layout(location = 2) in vec2 UV0;
#if !defined(IS_GUI) && !defined(IS_SEE_THROUGH)
layout(location = 3) in ivec2 UV2;
#endif

#if !defined(IS_GUI) && !defined(IS_SEE_THROUGH)
uniform sampler2D Sampler2;
layout(location = 0) out float sphericalVertexDistance;
layout(location = 1) out float cylindricalVertexDistance;
#endif

layout(location = 2) out vec4 vertexColor;
layout(location = 3) out vec2 texCoord0;

layout(location = 4) out vec3 spinT0;
layout(location = 5) out vec3 spinT1;
layout(location = 6) out vec3 spinT2;
layout(location = 7) out vec3 spinT3;
layout(location = 8) out float spinFlip;
layout(location = 9) out float spinScale;

layout(location = 10) out float fshEffectID;
layout(location = 11) out vec4 fshBaseColor;
layout(location = 12) out vec2 fshCharUV;
layout(location = 13) out vec4 fshEffectColor;
layout(location = 14) out vec4 fshExtrudeColor2;
layout(location = 15) out vec4 fshExtrudeColor3;
layout(location = 16) out vec4 fshEffectParams;
layout(location = 17) out vec3 fshGlyphT0;
layout(location = 18) out vec3 fshGlyphT1;
layout(location = 19) out vec3 fshGlyphT2;
layout(location = 20) out vec3 fshGlyphT3;
layout(location = 21) out float fshDisplayAlpha;

#include <minecraft:text_effects_utils.glsl>

void main() {
    gl_Position = ProjMat * ModelViewMat * vec4(Position, 1.0);

#if !defined(IS_GUI) && !defined(IS_SEE_THROUGH)
    sphericalVertexDistance = fog_spherical_distance(Position);
    cylindricalVertexDistance = fog_cylindrical_distance(Position);
#endif

    texCoord0 = UV0;

    spinT0 = vec3(0.0);
    spinT1 = vec3(0.0);
    spinT2 = vec3(0.0);
    spinT3 = vec3(0.0);
    spinFlip = 0.0;
    spinScale = 1.0;

    fshEffectID = 0.0;
    fshBaseColor = Color;
    fshCharUV = UV0;
    fshEffectColor = vec4(0.0);
    fshExtrudeColor2 = vec4(0.0);
    fshExtrudeColor3 = vec4(0.0);
    fshEffectParams = vec4(0.0);
    fshGlyphT0 = vec3(0.0);
    fshGlyphT1 = vec3(0.0);
    fshGlyphT2 = vec3(0.0);
    fshGlyphT3 = vec3(0.0);
    fshDisplayAlpha = Color.a;

    applyTextEffects();
}
