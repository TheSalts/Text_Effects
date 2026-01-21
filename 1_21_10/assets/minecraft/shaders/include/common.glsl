void finalize() {
    vertexColor *= ColorModulator;
}

void applyProjection(inout vec4 vertex) {
    gl_Position = ProjMat * ModelViewMat * vertex;
}

void applyColorTexture() {
    vec4 texColor = texelFetch(Sampler2, UV2 / 16, 0);
    vertexColor = Color * texColor;
}
