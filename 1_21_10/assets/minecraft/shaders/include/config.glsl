// ============================================================
// TEXT EFFECTS - Color to Effect Mappings
// ============================================================
// Define which colors trigger which effects
// Use rgb(r, g, b) for color values (0-255)
// Available effects:
//   apply_shake()
//   apply_wavy()
//   apply_rainbow()
//   apply_bouncy()
//   apply_blinking()
//   apply_pulse()
//   apply_spin()
//   apply_sequential_spin()
//   apply_fade()
//   apply_wavy_rainbow()
//   apply_bouncy_rainbow()
//   apply_iterating()
//   apply_shimmer()
//   apply_glitch()
//   apply_glitch2()
//   override_text_color(rgb(r, g, b))
// ============================================================

// --- Yellow Effects (#FFFF5X) ---
TEXT_EFFECT(255, 255, 86) {
    apply_shake();
}

TEXT_EFFECT(255, 255, 87) {
    apply_wavy();
}

TEXT_EFFECT(255, 255, 88) {
    apply_rainbow();
}

TEXT_EFFECT(255, 255, 89) {
    apply_bouncy();
}

TEXT_EFFECT(255, 255, 90) {
    apply_blinking();
}

TEXT_EFFECT(255, 255, 91) {
    apply_pulse();
}

TEXT_EFFECT(255, 255, 92) {
    apply_spin();
}

TEXT_EFFECT(255, 255, 93) {
    apply_sequential_spin();
}

TEXT_EFFECT(255, 255, 94) {
    apply_fade();
}

TEXT_EFFECT(255, 255, 95) {
    apply_wavy_rainbow();
}

TEXT_EFFECT(255, 255, 96) {
    apply_bouncy_rainbow();
}

TEXT_EFFECT(255, 255, 97) {
    apply_iterating();
}

TEXT_EFFECT(255, 255, 98) {
    apply_shimmer();
}

TEXT_EFFECT(255, 255, 99) {
    apply_glitch();
}

TEXT_EFFECT(255, 255, 100) {
    apply_glitch2();
}

// --- Red Effects (#FF555X) ---
TEXT_EFFECT(255, 85, 86) {
    apply_shake();
}

TEXT_EFFECT(255, 85, 88) {
    apply_rainbow();
}

// --- Green Effects (#55FF5X) ---
TEXT_EFFECT(85, 255, 86) {
    apply_shake();
}

TEXT_EFFECT(85, 255, 88) {
    apply_rainbow();
}

// --- Custom Examples ---

// Example: Fast shake with custom color display
TEXT_EFFECT(200, 100, 50) {
    apply_shake(2.0, 1.5);
    apply_color(255, 255, 85);
}

// Example: Slow wavy with high amplitude
TEXT_EFFECT(100, 100, 100) {
    apply_wavy(8000.0, 1.0, 0.5);
    apply_color(rgb(85, 255, 85));
}

// Example: Fast rainbow
TEXT_EFFECT(50, 50, 50) {
    apply_rainbow(1000.0);
}

// Example: Multiple triggers for same Yellow color with different effects
// Use slightly different trigger colors, but display same color
TEXT_EFFECT(254, 254, 85) {
    apply_bouncy(5000.0, 2.0);
    apply_color(255, 255, 85);
}

// Add more color-effect mappings below...
