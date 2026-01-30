void applyEffect(inout vec4 vertex, int effectID, vec4 baseColor, bool isShadow) {
    vec4 displayColor = isShadow ? vec4(baseColor.rgb * 0.25, 1.0) : baseColor;

    // --- Effect ID 1: Shake ---
    if (effectID == 1) {
        vertexColor = displayColor * texelFetch(Sampler2, UV2 / 16, 0);
        processShakeEffect(vertex, paramShakeSpeed, paramShakeIntensity);
        return;
    }

    // --- Effect ID 2: Wavy ---
    if (effectID == 2) {
        applyProjection(vertex);
        vertexColor = displayColor * texelFetch(Sampler2, UV2 / 16, 0);
        applyWaveEffect(paramWaveSpeed, paramWaveAmplitude, paramWaveXFrequency);
        finalize();
        return;
    }

    // --- Effect ID 3: Rainbow ---
    if (effectID == 3) {
        processRainbowEffect(vertex, paramRainbowSpeed);
        return;
    }

    // --- Effect ID 4: Bouncy ---
    if (effectID == 4) {
        vertexColor = displayColor * texelFetch(Sampler2, UV2 / 16, 0);
        float vertexId = mod(float(gl_VertexID), 4.0);
        float time = GameTime * paramBounceSpeed;
        if (vertex.z <= 0.0) {
            if (vertexId == 3.0 || vertexId == 0.0) {
                vertex.y += cos(time) * paramBounceAmplitude + max(cos(time) * paramBounceAmplitude, 0.0);
            }
        } else {
            if (vertexId == 3.0 || vertexId == 0.0) {
                vertex.y -= cos(time) * (paramBounceAmplitude * 30.0) + max(cos(time) * (paramBounceAmplitude * 30.0), 0.0);
            }
        }
        applyProjection(vertex);
        finalize();
        return;
    }

    // --- Effect ID 5: Blinking ---
    if (effectID == 5) {
        vertexColor = displayColor * texelFetch(Sampler2, UV2 / 16, 0);
        float blink = step(0.5, fract(GameTime * paramBlinkSpeed * 1200.0));
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
        vertexColor = displayColor * texelFetch(Sampler2, UV2 / 16, 0);
        processPulse(vertex, paramPulseSpeed, paramPulseSize);
        return;
    }

    // --- Effect ID 7: Spin ---
    if (effectID == 7) {
        vertexColor = displayColor * texelFetch(Sampler2, UV2 / 16, 0);
        processSpin(vertex, paramSpinSpeed, 0.0);
        finalize();
        return;
    }

    // --- Effect ID 8: Sequential Spin ---
    if (effectID == 8) {
        vertexColor = displayColor * texelFetch(Sampler2, UV2 / 16, 0);
        processSequentialSpin(vertex, paramSpinSpeed, 0.0);
        finalize();
        return;
    }

    // --- Effect ID 9: Fade ---
    if (effectID == 9) {
        vertexColor = displayColor * texelFetch(Sampler2, UV2 / 16, 0);
        processFadeEffect(vertex, paramFadeSpeed);
        return;
    }

    // --- Effect ID 10: Wavy + Rainbow ---
    if (effectID == 10) {
        float xPos = vertex.x;
        float yPos = vertex.y;
        applyProjection(vertex);
        applyWaveEffect(paramWaveSpeed, paramWaveAmplitude, paramWaveXFrequency);
        applyHueColor(paramRainbowSpeed, xPos, yPos);
        finalize();
        return;
    }

    // --- Effect ID 11: Bouncy + Rainbow ---
    if (effectID == 11) {
        float xPos = vertex.x;
        float yPos = vertex.y;
        float vertexId = mod(float(gl_VertexID), 4.0);
        float time = GameTime * paramBounceSpeed;
        if (vertex.z <= 0.0) {
            if (vertexId == 3.0 || vertexId == 0.0) {
                vertex.y += cos(time) * paramBounceAmplitude + max(cos(time) * paramBounceAmplitude, 0.0);
            }
        } else {
            if (vertexId == 3.0 || vertexId == 0.0) {
                vertex.y -= cos(time) * (paramBounceAmplitude * 30.0) + max(cos(time) * (paramBounceAmplitude * 30.0), 0.0);
            }
        }
        applyHueColor(paramRainbowSpeed, xPos, yPos);
        applyProjection(vertex);
        finalize();
        return;
    }

    // --- Effect ID 12: Iterating ---
    if (effectID == 12) {
        vertexColor = displayColor * texelFetch(Sampler2, UV2 / 16, 0);
        processIteratingEffect(vertex, paramIteratingSpeed, paramIteratingSpace);
        return;
    }

    // --- Effect ID 13: Shimmer (FSH) ---
    if (effectID == 13) {
        vertexColor = displayColor * texelFetch(Sampler2, UV2 / 16, 0);
        processShimmerEffect(vertex, baseColor);
        return;
    }

    // --- Effect ID 14: Glitch ---
    if (effectID == 14) {
        vertexColor = displayColor * texelFetch(Sampler2, UV2 / 16, 0);
        processGlitchEffect(vertex, paramGlitchSpeed, paramGlitchIntensity);
        return;
    }

    // --- Effect ID 15: Glitch2 (Chromatic Aberration, FSH) ---
    if (effectID == 15) {
        vertexColor = displayColor * texelFetch(Sampler2, UV2 / 16, 0);
        processGlitch2Effect(vertex, baseColor);
        return;
    }
}
