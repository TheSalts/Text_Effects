void applyWaveEffect(float speed, float amplitude, float xFrequency) {
    gl_Position.y += sin(GameTime * speed + (Position.x * xFrequency)) * (amplitude / 150.0);
}

void processWavyEffect(inout vec4 vertex, float speed, float amplitude, float xFrequency) {
    applyProjection(vertex);
    applyWaveEffect(speed, amplitude, xFrequency);
    applyColorTexture();
    finalize();
}
