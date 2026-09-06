// Author: nattapat2871 (https://nattapat2871.me)
void processBlinkingEffect(inout vec4 vertex, float speed) {
    applyProjection(vertex);
    if (speed <= 0.0) speed = 0.5;
    float blink = abs(sin(GameTime * 12000. * speed));
    
    vertexColor = blink * get_lightmap_color();
    finalize();
}
