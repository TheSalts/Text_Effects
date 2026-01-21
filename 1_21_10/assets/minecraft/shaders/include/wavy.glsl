void applyWaveEffect(float speed) {
    gl_Position.y += sin(GameTime * speed + (Position.x * WAVE_X_FREQUENCY)) * (WAVE_AMPLITUDE / 150.0);
}

void processWavyEffect(inout vec4 vertex, float speed) {
    applyProjection(vertex);
    applyWaveEffect(speed);
    applyColorTexture();
    finalize();
}
