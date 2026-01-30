void processGlitch2Effect(inout vec4 vertex, vec4 baseColor) {
    fshEffectID = 15.0;
    fshBaseColor = baseColor;
    int vid = gl_VertexID % 4;
    spinT0 = spinT1 = spinT2 = spinT3 = vec3(0.0);
    if (vid == 0) spinT0 = vec3(UV0, 1.0);
    if (vid == 1) spinT2 = vec3(UV0, 1.0);
    if (vid == 2) spinT1 = vec3(UV0, 1.0);
    if (vid == 3) spinT3 = vec3(UV0, 1.0);
    applyProjection(vertex);
    finalize();
}
