void processBlinkingEffect(inout vec4 vertex, float speed) {
    applyProjection(vertex);
    if (speed <= 0.0) speed = 0.5;
    float blink = abs(sin(GameTime * 12000. * speed));
    
    vertexColor = blink * texelFetch(Sampler2, UV2 / 16, 0); 
    finalize();
}
