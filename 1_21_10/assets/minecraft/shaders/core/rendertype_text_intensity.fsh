#version 150

#moj_import <minecraft:fog.glsl>
#moj_import <minecraft:dynamictransforms.glsl>
#moj_import <minecraft:globals.glsl>
#moj_import <minecraft:text_data.glsl>
#moj_import <minecraft:spin_effect.glsl>

uniform sampler2D Sampler0;

in float sphericalVertexDistance;
in float cylindricalVertexDistance;
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

out vec4 fragColor;

void main() {
    vec2 uv = texCoord0;

    // Apply spin effect
    applySpinEffect(uv, spinT0, spinT1, spinT2, spinT3, spinScale, spinFlip, texCoord0, Sampler0);

    vec4 color = texture(Sampler0, uv) * vertexColor * ColorModulator;

    int effectID = int(fshEffectID + 0.5);

    // Create TextData struct for effect processing
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

    fragColor = apply_fog(color, sphericalVertexDistance, cylindricalVertexDistance, FogEnvironmentalStart, FogEnvironmentalEnd, FogRenderDistanceStart, FogRenderDistanceEnd, FogColor);

    if (vertexColor.rgb == vec3(1.0, 1.0, 1.0)) {
        fragColor = color;
    }
}
