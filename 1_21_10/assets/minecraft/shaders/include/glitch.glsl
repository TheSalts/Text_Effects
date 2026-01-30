void processGlitchEffect(inout vec4 vertex, float speed, float intensity) {
    if (speed <= 0.0) speed = 1.0;
    if (intensity <= 0.0) intensity = 2.0;

    float time = floor(GameTime * 32000.0 * speed);
    float charX = floor(vertex.x / 8.0);
    
    float glitchTrigger = random(vec2(time * 0.1, 0.0));
    
    if (glitchTrigger > 0.7) {
        float offsetX = (random(vec2(charX + time, 1.0)) - 0.5) * intensity * 4.0;
        vertex.x += offsetX;
    }
    
    if (glitchTrigger > 0.85) {
        float offsetY = (random(vec2(charX - time + 50.0, 2.0)) - 0.5) * intensity;
        vertex.y += offsetY;
    }

    applyProjection(vertex);
    finalize();
}
