void processShakeEffect(inout vec4 vertex, float speed, float intensity) {
    if (speed <= 0.0) speed = 1.0;
    if (intensity <= 0.0) intensity = 1.0;

    float charX = floor(vertex.x / 8.0);
    float time = GameTime * 32000.0 * speed;
    
    float noiseX = noise(charX + time) - 0.5;
    float noiseY = noise(charX - time + 100.0) - 0.5;

    vertex.x += noiseX * intensity;
    vertex.y += noiseY * intensity;

    applyProjection(vertex);
    finalize();
}
