#version 150

void applyEffect(inout vec4 vertex, int effectID, vec4 baseColor, bool isShadow) {
    vec4 displayColor = isShadow ? vec4(baseColor.rgb * 0.25, 1.0) : baseColor;

    // --- Effect ID 1: Shake ---
    if (effectID == 1) {
        float speed = SHAKE_SPEED;
        float intensity = SHAKE_INTENSITY;
        vertexColor = displayColor * texelFetch(Sampler2, UV2 / 16, 0);
        processShakeEffect(vertex, speed, intensity);
        return;
    }

    // --- Effect ID 2: Wavy ---
    if (effectID == 2) {
        float speed = WAVE_SPEED;
        applyProjection(vertex);
        vertexColor = displayColor * texelFetch(Sampler2, UV2 / 16, 0);
        applyWaveEffect(speed);
        finalize();
        return;
    }

    // --- Effect ID 3: Rainbow ---
    if (effectID == 3) {
        float speed = RAINBOW_SPEED;
        processRainbowEffect(vertex, speed);
        return;
    }

    // --- Effect ID 4: Bouncy ---
    if (effectID == 4) {
        float speed = BOUNCE_SPEED;
        float amplitude = BOUNCE_AMPLITUDE;
        vertexColor = displayColor * texelFetch(Sampler2, UV2 / 16, 0);
        float vertexId = mod(float(gl_VertexID), 4.0);
        float time = GameTime * speed;
        if (vertex.z <= 0.0) {
            if (vertexId == 3.0 || vertexId == 0.0) {
                vertex.y += cos(time) * amplitude + max(cos(time) * amplitude, 0.0);
            }
        } else {
            if (vertexId == 3.0 || vertexId == 0.0) {
                vertex.y -= cos(time) * (amplitude * 30.0) + max(cos(time) * (amplitude * 30.0), 0.0);
            }
        }
        applyProjection(vertex);
        finalize();
        return;
    }

    // --- Effect ID 5: Blinking ---
    if (effectID == 5) {
        float speed = BLINK_SPEED;
        vertexColor = displayColor * texelFetch(Sampler2, UV2 / 16, 0);
        float blink = step(0.5, fract(GameTime * speed * 1200.0));
        if (blink < 0.5) {
            gl_Position = vec4(2.0, 2.0, 2.0, 1.0);
            finalize();
            return;
        }
        applyProjection(vertex);
        finalize();
        return;
    }



    // --- Effect ID 6: Pulse ---
    if (effectID == 6) {
        float speed = PULSE_SPEED;
        float size = PULSE_SIZE;
        vertexColor = displayColor * texelFetch(Sampler2, UV2 / 16, 0);
        processPulse(vertex, speed, size);
        return;
    }

    if (effectID == 7) {
        float speed = SPIN_SPEED;
        float axis = 0.0;
        vertexColor = displayColor * texelFetch(Sampler2, UV2 / 16, 0);
        processSpin(vertex, speed, axis);
        finalize();
        return;
    }

    // --- Effect ID 8: Delayed Spin ---
    // Spin -> Wait -> Spin
    if (effectID == 8) {
        float speed = SPIN_SPEED;
        float axis = 0.0;
        vertexColor = displayColor * texelFetch(Sampler2, UV2 / 16, 0);
        processDelayedSpin(vertex, speed, axis);
        finalize();
        return;
    }


    // --- Effect ID 9: Fade ---
    if (effectID == 9) {
        float speed = FADE_SPEED;
        vertexColor = displayColor * texelFetch(Sampler2, UV2 / 16, 0);
        processFadeEffect(vertex, speed);
        return;
    }

    // --- Effect ID 10: Wavy + Rainbow ---
    if (effectID == 10) {
        float waveSpeed = WAVE_SPEED;
        float rainbowSpeed = RAINBOW_SPEED;
        float xPos = vertex.x;
        float yPos = vertex.y;
        applyProjection(vertex);
        applyWaveEffect(waveSpeed);
        applyHueColor(rainbowSpeed, xPos, yPos);
        finalize();
        return;
    }

    // --- Effect ID 11: Bouncy + Rainbow ---
    if (effectID == 11) {
        float bounceSpeed = BOUNCE_SPEED;
        float bounceAmp = BOUNCE_AMPLITUDE;
        float rainbowSpeed = RAINBOW_SPEED;
        float xPos = vertex.x;
        float yPos = vertex.y;
        float vertexId = mod(float(gl_VertexID), 4.0);
        float time = GameTime * bounceSpeed;
        if (vertex.z <= 0.0) {
            if (vertexId == 3.0 || vertexId == 0.0) {
                vertex.y += cos(time) * bounceAmp + max(cos(time) * bounceAmp, 0.0);
            }
        } else {
            if (vertexId == 3.0 || vertexId == 0.0) {
                vertex.y -= cos(time) * (bounceAmp * 30.0) + max(cos(time) * (bounceAmp * 30.0), 0.0);
            }
        }
        applyHueColor(rainbowSpeed, xPos, yPos);
        applyProjection(vertex);
        finalize();
        return;
    }




}
