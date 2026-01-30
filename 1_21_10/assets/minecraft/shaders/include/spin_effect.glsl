#moj_import <minecraft:text_data.glsl>

void applySpinEffect(inout vec2 uv, vec3 t0, vec3 t1, vec3 t2, vec3 t3, float scale, float flip, vec2 originalUV, sampler2D texSampler) {
    if (scale >= 0.99 && flip <= 0.5) {
        return;
    }

    vec2 uvMin, uvMax;
    vec2 uvSize = calculateUVBounds(t0, t1, t2, t3, uvMin, uvMax);

    float minX = 1.0;
    float maxX = 0.0;
    bool hasInk = false;

    // Full Area Scan: 20x20 grid (400 samples) to catch all edge details
    for (float x = 0.0; x <= 1.0; x += 0.05) {
        for (float y = 0.0; y <= 1.0; y += 0.05) {
            if (texture(texSampler, uvMin + vec2(x, y) * uvSize).a > 0.1) {
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

    float currentNormX = (originalUV.x - uvMin.x) / uvSize.x;

    float distFromInkCenter = currentNormX - inkCenter;
    float sampleDist = distFromInkCenter / scale;

    if (flip > 0.5) {
        sampleDist = -sampleDist;
    }

    float targetNormX = inkCenter + sampleDist;

    if (targetNormX < 0.0 || targetNormX > 1.0) {
        discard;
    }

    uv.x = uvMin.x + targetNormX * uvSize.x;
}
