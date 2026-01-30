struct TextData {
    vec2 uv;
    vec3 spinT0;
    vec3 spinT1;
    vec3 spinT2;
    vec3 spinT3;
    vec4 color;
    vec4 vertexColor;
};

vec2 calculateUVBounds(vec3 t0, vec3 t1, vec3 t2, vec3 t3, out vec2 uvMin, out vec2 uvMax) {
    uvMin = vec2(100.0);
    uvMax = vec2(-100.0);

    if (t0.z > 0.001) { vec2 p = t0.xy / t0.z; uvMin = min(uvMin, p); uvMax = max(uvMax, p); }
    if (t1.z > 0.001) { vec2 p = t1.xy / t1.z; uvMin = min(uvMin, p); uvMax = max(uvMax, p); }
    if (t2.z > 0.001) { vec2 p = t2.xy / t2.z; uvMin = min(uvMin, p); uvMax = max(uvMax, p); }
    if (t3.z > 0.001) { vec2 p = t3.xy / t3.z; uvMin = min(uvMin, p); uvMax = max(uvMax, p); }

    return uvMax - uvMin;
}
