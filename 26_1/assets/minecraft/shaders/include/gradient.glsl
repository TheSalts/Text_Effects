// 0=↑  1=↗  2=→  3=↘  4=↓  5=↙  6=←  7=↖
void processGradientEffect(inout vec4 vertex, vec3 startColor, vec3 endColor, float direction) {
    float vid = mod(float(gl_VertexID), 4.0);
    float x_t = (vid == 2.0 || vid == 3.0) ? 1.0 : 0.0;
    float y_t = (vid == 1.0 || vid == 2.0) ? 1.0 : 0.0;

    int dir = int(direction);
    float t;
    if      (dir == 0) t = 1.0 - y_t;
    else if (dir == 1) t = (x_t + (1.0 - y_t)) * 0.5;
    else if (dir == 2) t = x_t;
    else if (dir == 3) t = (x_t + y_t) * 0.5;
    else if (dir == 4) t = y_t;
    else if (dir == 5) t = ((1.0 - x_t) + y_t) * 0.5;
    else if (dir == 6) t = 1.0 - x_t;
    else               t = ((1.0 - x_t) + (1.0 - y_t)) * 0.5;

    vec3 gradColor = mix(startColor, endColor, t);
    applyProjection(vertex);
    vec4 texColor = sample_lightmap(Sampler2, UV2);
    vertexColor = vec4(gradColor, 1.0) * texColor;
    finalize();
}

void processDynamicGradientEffect(inout vec4 vertex, vec3 startColor, vec3 endColor, float direction, float speed) {
    float xPos = vertex.x;
    float yPos = vertex.y;

    int dir = int(direction);
    float spatial;
    if      (dir == 0) spatial =  yPos;
    else if (dir == 1) spatial =  xPos + yPos;
    else if (dir == 2) spatial =  xPos;
    else if (dir == 3) spatial =  xPos - yPos;
    else if (dir == 4) spatial = -yPos;
    else if (dir == 5) spatial = -xPos - yPos;
    else if (dir == 6) spatial = -xPos;
    else               spatial = -xPos + yPos;

    float t = 1.0 - abs(fract(GameTime * speed + spatial * 0.01) * 2.0 - 1.0);
    vec3 gradColor = mix(startColor, endColor, t);
    applyProjection(vertex);
    vec4 texColor = sample_lightmap(Sampler2, UV2);
    vertexColor = vec4(gradColor, 1.0) * texColor;
    finalize();
}
