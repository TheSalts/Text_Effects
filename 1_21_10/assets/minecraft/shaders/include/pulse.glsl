void processPulse(inout vec4 vertex, float speed, float size) {
    float time = GameTime * speed * 1000.0;
    // Scale factor: 0.0 to 1.0 based on sine
    float factor = (sin(time) * 0.5 + 0.5);
    
    // Calculate expansion in pixels.
    // Reduced multiplier to 2.5 for smoother scaling.
    float expansion = size * 2.5 * factor; 

    float vertexId = mod(float(gl_VertexID), 4.0);
    vec2 dir = vec2(0.0);
    
    // Standard Quad: 0=TL, 1=BL, 2=BR, 3=TR (with +Y Down)
    if (vertexId < 0.5) dir = vec2(-1.0, -1.0);      // 0
    else if (vertexId < 1.5) dir = vec2(-1.0, 1.0); // 1
    else if (vertexId < 2.5) dir = vec2(1.0, 1.0);  // 2
    else dir = vec2(1.0, -1.0);                     // 3
    
    // Apply aspect ratio correction (expand width less than height)
    dir *= vec2(0.7, 1.0);
    
    vertex.xy += dir * expansion;

    applyProjection(vertex);
    finalize();
}

