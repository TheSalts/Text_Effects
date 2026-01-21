float hashShake(float n) {
    return fract(sin(n) * 43758.5453123);
}

float noiseShake(float x) {
    float i = floor(x);
    float f = fract(x);
    f = f * f * (3.0 - 2.0 * f);
    return mix(hashShake(i), hashShake(i + 1.0), f);
}

void processShakeEffect(inout vec4 vertex, float speed, float intensity) {
    applyColorTexture();

    if (speed <= 0.0) speed = 8.0;
    if (intensity <= 0.0) intensity = 1.0;

    float time = GameTime * 1200.0 * speed;
    float charIndex = floor(float(gl_VertexID) / 4.0);
    float charSeed = hashShake(charIndex * 127.1);

    float shakeX = noiseShake(time * 1.0 + charSeed * 100.0) * 2.0 - 1.0;
    float shakeY = noiseShake(time * 1.3 + charSeed * 200.0 + 50.0) * 2.0 - 1.0;

    shakeX += sin(time * 0.7 + charSeed * 6.28) * 0.3;
    shakeY += cos(time * 0.9 + charSeed * 6.28 + 1.57) * 0.3;

    float burstPhase = noiseShake(time * 0.15 + charSeed * 50.0);
    float burstIntensity = smoothstep(0.6, 0.8, burstPhase) * (1.0 - smoothstep(0.8, 1.0, burstPhase));
    float currentIntensity = intensity * (0.6 + burstIntensity * 0.8);

    vertex.x += shakeX * currentIntensity;
    vertex.y += shakeY * currentIntensity;

    applyProjection(vertex);
    finalize();
}
