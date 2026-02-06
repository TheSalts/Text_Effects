#version 150

#moj_import <minecraft:fog.glsl>
#moj_import <minecraft:dynamictransforms.glsl>
#moj_import <minecraft:projection.glsl>
#moj_import <minecraft:globals.glsl>

in vec3 Position;
in vec4 Color;
in vec2 UV0;
in ivec2 UV2;

uniform sampler2D Sampler2;

out float sphericalVertexDistance;
out float cylindricalVertexDistance;
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

#moj_import <minecraft:text_effects_utils.glsl>

void main() {
    gl_Position = ProjMat * ModelViewMat * vec4(Position, 1.0);

    sphericalVertexDistance = fog_spherical_distance(Position);
    cylindricalVertexDistance = fog_cylindrical_distance(Position);
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

    applyTextEffects();
}
