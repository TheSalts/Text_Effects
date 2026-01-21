#version 150

#moj_import <minecraft:fog.glsl>
#moj_import <minecraft:dynamictransforms.glsl>

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

out vec4 fragColor;

void main() {
    vec2 uv = texCoord0;

    if (spinScale < 0.99 || spinFlip > 0.5) {
        vec2 uvMin = vec2(100.0);
        vec2 uvMax = vec2(-100.0);
        
        if (spinT0.z > 0.001) { vec2 p = spinT0.xy / spinT0.z; uvMin = min(uvMin, p); uvMax = max(uvMax, p); }
        if (spinT1.z > 0.001) { vec2 p = spinT1.xy / spinT1.z; uvMin = min(uvMin, p); uvMax = max(uvMax, p); }
        if (spinT2.z > 0.001) { vec2 p = spinT2.xy / spinT2.z; uvMin = min(uvMin, p); uvMax = max(uvMax, p); }
        if (spinT3.z > 0.001) { vec2 p = spinT3.xy / spinT3.z; uvMin = min(uvMin, p); uvMax = max(uvMax, p); }

        vec2 uvSize = uvMax - uvMin;

        float minX = 1.0;
        float maxX = 0.0;
        bool hasInk = false;

        // Full Area Scan: 20x20 grid (400 samples) to catch all edge details
        for (float x = 0.0; x <= 1.0; x += 0.05) {
            for (float y = 0.0; y <= 1.0; y += 0.05) {
                if (texture(Sampler0, uvMin + vec2(x, y) * uvSize).a > 0.1) {
                    if (x < minX) minX = x;
                    maxX = x;
                    hasInk = true;
                }
            }
        }

        float inkCenter = 0.5;
        if (hasInk) {
            inkCenter = (minX + maxX) * 0.5;
        }

        float currentNormX = (texCoord0.x - uvMin.x) / uvSize.x;
        
        float distFromInkCenter = currentNormX - inkCenter;
        float sampleDist = distFromInkCenter / spinScale;

        if (spinFlip > 0.5) {
            sampleDist = -sampleDist;
        }

        float targetNormX = inkCenter + sampleDist;

        if (targetNormX < 0.0 || targetNormX > 1.0) {
            discard;
        }

        uv.x = uvMin.x + targetNormX * uvSize.x;
    }

    vec4 color = texture(Sampler0, uv) * vertexColor * ColorModulator;

    if (color.a < 0.1) {
        discard;
    }

    fragColor = apply_fog(color, sphericalVertexDistance, cylindricalVertexDistance, FogEnvironmentalStart, FogEnvironmentalEnd, FogRenderDistanceStart, FogRenderDistanceEnd, FogColor);

    if (vertexColor.rgb == vec3(1.0, 1.0, 1.0)) {
        fragColor = color;
    }
}
