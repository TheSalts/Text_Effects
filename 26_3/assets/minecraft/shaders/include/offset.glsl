#ifndef TEXT_EFFECTS_26_3_OFFSET_GLSL
#define TEXT_EFFECTS_26_3_OFFSET_GLSL

vec2 currentOffset = vec2(0.0);

void setOffset(float x, float y) {
    currentOffset = vec2(x, y);
}

void applyOffset(inout vec4 vertex) {
    vec4 clip = ProjMat * ModelViewMat * vertex;
    bool isGUI = ProjMat[3][3] != 0.0;

    if (isGUI) {
        vertex.xy += currentOffset;
    } else {
        float worldScale = 0.05;

        vec3 cameraRight = vec3(ModelViewMat[0][0], ModelViewMat[1][0], ModelViewMat[2][0]);
        vec3 cameraUp    = vec3(ModelViewMat[0][1], ModelViewMat[1][1], ModelViewMat[2][1]);

        vertex.xyz += cameraRight * (currentOffset.x * worldScale);
        vertex.xyz -= cameraUp * (currentOffset.y * worldScale);
    }
}
#endif // TEXT_EFFECTS_26_3_OFFSET_GLSL
