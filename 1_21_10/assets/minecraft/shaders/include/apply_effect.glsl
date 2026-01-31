void applyEffect(inout vec4 vertex, int effectID, vec4 baseColor, bool isShadow, bool hasRainbow) {
    vec4 displayColor = isShadow ? vec4(baseColor.rgb * 0.25, 1.0) : baseColor;

    // Helper to apply rainbow or default color
    #define APPLY_COLOR_OR_RAINBOW \
        if (hasRainbow) { \
            applyHueColor(paramRainbowSpeed, vertex.x, vertex.y); \
        } else { \
            vertexColor = displayColor * texelFetch(Sampler2, UV2 / 16, 0); \
        }

    // --- Effect ID 1: Shake ---
    if (effectID == 1) {
        processShakeEffect(vertex, paramShakeSpeed, paramShakeIntensity);
        APPLY_COLOR_OR_RAINBOW
        return;
    }

    // --- Effect ID 2: Wavy ---
    if (effectID == 2) {
        applyProjection(vertex);
        applyWaveEffect(paramWaveSpeed, paramWaveAmplitude, paramWaveXFrequency);
        APPLY_COLOR_OR_RAINBOW
        finalize();
        return;
    }

    // --- Effect ID 4: Bouncy ---
    if (effectID == 4) {
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
        APPLY_COLOR_OR_RAINBOW
        finalize();
        return;
    }

    // --- Effect ID 5: Blinking ---
    if (effectID == 5) {
        float blink = step(0.5, fract(GameTime * paramBlinkSpeed * 1200.0));
        if (blink < 0.5) {
            gl_Position = vec4(2.0, 2.0, 2.0, 1.0);
            finalize();
            return;
        }
        applyProjection(vertex);
        APPLY_COLOR_OR_RAINBOW
        finalize();
        return;
    }

    // --- Effect ID 6: Pulse ---
    if (effectID == 6) {
        processPulse(vertex, paramPulseSpeed, paramPulseSize);
        APPLY_COLOR_OR_RAINBOW
        return;
    }

    // --- Effect ID 7: Spin ---
    if (effectID == 7) {
        processSpin(vertex, paramSpinSpeed, 0.0);
        APPLY_COLOR_OR_RAINBOW
        finalize();
        return;
    }

    // --- Effect ID 8: Sequential Spin ---
    if (effectID == 8) {
        processSequentialSpin(vertex, paramSpinSpeed, 0.0);
        APPLY_COLOR_OR_RAINBOW
        finalize();
        return;
    }

    // --- Effect ID 9: Fade ---
    if (effectID == 9) {
        processFadeEffect(vertex, paramFadeSpeed);
        APPLY_COLOR_OR_RAINBOW
        return;
    }

    // --- Effect ID 10: Iterating ---
    if (effectID == 10) {
        processIteratingEffect(vertex, paramIteratingSpeed, paramIteratingSpace);
        APPLY_COLOR_OR_RAINBOW
        return;
    }

    // --- Effect ID 11: Glitch ---
    if (effectID == 11) {
        processGlitchEffect(vertex, paramGlitchSpeed, paramGlitchIntensity);
        APPLY_COLOR_OR_RAINBOW
        return;
    }

    // --- Rainbow Only (ID=3 or ID=0 with hasRainbow) ---
    if (hasRainbow) {
        processRainbowEffect(vertex, paramRainbowSpeed);
        return;
    }
}
