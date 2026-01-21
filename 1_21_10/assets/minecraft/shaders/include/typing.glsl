void processTypingEffect(inout vec4 vertex, float speed) {
    if (speed <= 0.0) speed = 0.5;
    
    applyProjection(vertex);
    
    vec4 texColor = texelFetch(Sampler2, UV2 / 16, 0);
    vertexColor = Color * texColor;

    float waveX = mod(GameTime * 300.0 * speed, 800.0) - 200.0; 
    
    if (gl_Position.x > waveX) {
        vertexColor.a = 0.0; 
    }
    
    finalize();
}
