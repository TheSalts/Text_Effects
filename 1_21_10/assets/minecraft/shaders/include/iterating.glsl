void processIteratingEffect(inout vec4 vertex, float speed, float space) {
    if (speed <= 0.0) speed = 1.0;
    if (space <= 0.0) space = 1.0;

    float charX = floor(vertex.x / 8.0);
    float time = GameTime * 18000.0 * speed;

    float x = mod(charX * 0.4 - time, (5.0 * space) * TAU);
    if (x > TAU) x = TAU;
    
    vertex.y -= (-cos(x) * 0.5 + 0.5) * 2.0;

    applyProjection(vertex);
    finalize();
}
