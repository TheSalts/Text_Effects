#moj_import <minecraft:text_data.glsl>

void applyShimmerEffect(inout TextData data, sampler2D texSampler) {
    vec2 uvMin, uvMax;
    vec2 uvSize = calculateUVBounds(data.spinT0, data.spinT1, data.spinT2, data.spinT3, uvMin, uvMax);

    float localX = (data.uv.x - uvMin.x) / (uvMax.x - uvMin.x);
    float localY = (data.uv.y - uvMin.y) / (uvMax.y - uvMin.y);
    float f = localX + localY - GameTime * 6400.0;

    if (mod(f, 5.0) < 0.75) {
        data.color.rgb = mix(data.color.rgb, vec3(1.0), 0.5);
    }
}
