#version 150

#moj_import <minecraft:fog.glsl>

uniform mat4 ProjMat;
uniform mat4 ModelViewMat;
uniform vec4 ColorModulator;
uniform float GameTime;
uniform int FogShape;

in vec3 Position;
in vec4 Color;
in vec2 UV0;
in ivec2 UV2;

uniform sampler2D Sampler2;

out float vertexDistance;
out vec4 vertexColor;
out vec2 texCoord0;

out vec3 spinT0;
out vec3 spinT1;
out vec3 spinT2;
out vec3 spinT3;
out float spinFlip;
out float spinScale;

out float fshEffectID;
out vec4 fshBaseColor;
out vec2 fshCharUV;
out vec4 fshEffectColor;
out vec4 fshExtrudeColor2;
out vec4 fshExtrudeColor3;
out vec4 fshEffectParams;
out vec3 fshGlyphT0;
out vec3 fshGlyphT1;
out vec3 fshGlyphT2;
out vec3 fshGlyphT3;
out float fshDisplayAlpha;

#moj_import <minecraft:text_effects_utils.glsl>

void main() {
    gl_Position = ProjMat * ModelViewMat * vec4(Position, 1.0);

    vec4 viewPos = ModelViewMat * vec4(Position, 1.0);
    vertexDistance = FogShape == 0 ? length(viewPos.xyz) : max(length(viewPos.xz), abs(viewPos.y));
    vertexColor = Color * texelFetch(Sampler2, UV2 / 16, 0);
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
