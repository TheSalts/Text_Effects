void processBouncyEffect(inout vec4 vertex, float speed, float amp) {
    applyColorTexture();
    float vertexId = mod(float(gl_VertexID), 4.0);

    if (speed <= 0.0) speed = 3000.0;
    if (amp <= 0.0) amp = 1.0; 

    float time = GameTime * speed; 

    if (vertexId == 3. || vertexId == 0.) {
        vertex.y += cos(time) * amp;
        vertex.y += max(cos(time) * amp, 0.);
    }
    applyProjection(vertex);
    finalize();
}
