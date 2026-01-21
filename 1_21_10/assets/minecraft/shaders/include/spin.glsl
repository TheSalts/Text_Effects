#version 150

void processSpinEffect(inout vec4 vertex, float speed, float axis, bool oneShot, float delay) {

    if (speed <= 0.0) speed = 2500.0;
    float time = GameTime * speed;
    
    float PI = 3.14159265;
    float cosA;
    
    if (oneShot) {
        if (time > PI * 2.0) {
            cosA = 1.0;
        } else {
            cosA = cos(time);
        }
    } else {
        float period = PI * 2.0;
        float cycle = mod(time, period + delay);
        if (cycle < period) {
            cosA = cos(cycle);
        } else {
            cosA = 1.0;
        }
    }
    
    spinFlip = (cosA < 0.0) ? 1.0 : 0.0;
    spinScale = abs(cosA);

    int vid = gl_VertexID % 4;
    spinT0 = vec3(0.0);
    spinT1 = vec3(0.0);
    spinT2 = vec3(0.0);
    spinT3 = vec3(0.0);
    if (vid == 0) { spinT0 = vec3(texCoord0, 1.0); }
    if (vid == 1) { spinT2 = vec3(texCoord0, 1.0); }
    if (vid == 2) { spinT1 = vec3(texCoord0, 1.0); }
    if (vid == 3) { spinT3 = vec3(texCoord0, 1.0); }

    gl_Position = ProjMat * ModelViewMat * vertex;
}

void processSpin(inout vec4 vertex, float speed, float axis) {
    processSpinEffect(vertex, speed, axis, false, 0.0);
}

void processOneSpin(inout vec4 vertex, float speed, float axis) {
    processSpinEffect(vertex, speed, axis, true, 0.0);
}

void processDelayedSpin(inout vec4 vertex, float speed, float axis) {
    float PI = 3.14159265;
    // Delay: Wait for 1 full rotation duration (2*PI)
    processSpinEffect(vertex, speed, axis, false, PI * 2.0);
}
