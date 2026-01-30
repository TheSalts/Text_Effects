void applyHueColor(float speed, float xPos, float yPos) {
    if (speed <= 0.0) speed = 1000.0;

    vec4 texColor = texelFetch(Sampler2, UV2 / 16, 0);
    vec3 rainbowColor = hue((GameTime * speed) + (xPos + yPos) * 0.01);
    vertexColor = vec4(rainbowColor, 1.0) * texColor;
}

void processRainbowEffect(inout vec4 vertex, float speed) {
    float xPos = vertex.x;
    float yPos = vertex.y;
    applyProjection(vertex);
    applyHueColor(speed, xPos, yPos);
    finalize();
}
