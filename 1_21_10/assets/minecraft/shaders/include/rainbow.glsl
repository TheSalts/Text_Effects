vec3 hue(float t) {
    t = fract(t);
    float r = abs(t * 6.0 - 3.0) - 1.0;
    float g = 2.0 - abs(t * 6.0 - 2.0);
    float b = 2.0 - abs(t * 6.0 - 4.0);
    return clamp(vec3(r, g, b), 0.0, 1.0);
}

void applyHueColor(float speed) {
    if (speed <= 0.0) speed = 1000.0;

    vec4 texColor = texelFetch(Sampler2, UV2 / 16, 0);
    vec3 rainbowColor = hue((GameTime * speed) + gl_Position.x / 400.0 + gl_Position.y / 400.0);
    vertexColor = vec4(rainbowColor, 1.0) * texColor;
}

void processRainbowEffect(inout vec4 vertex, float speed) {
    applyProjection(vertex);
    applyHueColor(speed);
    finalize();
}
