void applyHueColor(float speed, float xPos, float yPos, float alpha) {
    if (speed <= 0.0) speed = 1000.0;

    vec4 texColor = texelFetch(Sampler2, UV2 / 16, 0);

    // See apply_effect.glsl flagDynamicGradient: model-space in GUI keeps the
    // phase stable across batch reorderings; vertex-id fallback for world text.
    bool isGUI = ProjMat[3][3] != 0.0;
    float spatial;
    if (isGUI) {
        spatial = xPos + yPos;
    } else {
        float charId = floor(float(gl_VertexID) / 4.0);
        float vid = mod(float(gl_VertexID), 4.0);
        float x_t = (vid == 2.0 || vid == 3.0) ? 1.0 : 0.0;
        float y_t = (vid == 1.0 || vid == 2.0) ? 1.0 : 0.0;
        spatial = (charId + x_t) * 6.0 + y_t * 7.0;
    }

    vec3 rainbowColor = hue((GameTime * speed) + spatial * 0.01);
    vertexColor = vec4(rainbowColor, alpha) * texColor;
}

void applyHueColor(float speed, float xPos, float yPos) {
    applyHueColor(speed, xPos, yPos, 1.0);
}

void processRainbowEffect(inout vec4 vertex, float speed) {
    float xPos = vertex.x;
    float yPos = vertex.y;
    applyProjection(vertex);
    applyHueColor(speed, xPos, yPos);
    finalize();
}
