void processFadeEffect(inout vec4 vertex, float speed) {
    if (speed <= 0.0) speed = 0.5;
    
    applyProjection(vertex);
    
    float alpha = sin(GameTime * 3000.0 * speed);
    alpha = (alpha + 1.0) * 0.5;
    
    vec4 texColor = texelFetch(Sampler2, UV2 / 16, 0);
    
    vertexColor = Color * texColor;
    vertexColor.a *= alpha; 
    
    finalize();
}
