#moj_import <minecraft:common.glsl>
#moj_import <minecraft:defaults.glsl>
#moj_import <minecraft:rainbow.glsl>
#moj_import <minecraft:wavy.glsl>
#moj_import <minecraft:bouncy.glsl>
#moj_import <minecraft:blinking.glsl>
#moj_import <minecraft:pulse.glsl>
#moj_import <minecraft:spin.glsl>
#moj_import <minecraft:shake.glsl>
#moj_import <minecraft:fade.glsl>
#moj_import <minecraft:iterating.glsl>
#moj_import <minecraft:glitch.glsl>
#moj_import <minecraft:text_effects_api.glsl>
#moj_import <minecraft:apply_effect.glsl>

// ============================================================
// TEXT EFFECTS - Config-based System
// ============================================================
// Edit _config.glsl to customize color-effect mappings
// ============================================================

// Helper function to check shadow match and update state
bool checkAndSetShadow(ivec3 c, int R, int G, int B) {
    // Check main color (exact match)
    if (c.r == R && c.g == G && c.b == B) {
        return true;
    }
    // Check shadow color (exact match, approx 25% of main)
    if (c.r == (R/4) && c.g == (G/4) && c.b == (B/4)) {
        currentIsShadow = true;
        return currentIsShadow;
    }
    return false;
}

// TEXT_EFFECT macro: matches RGB color only (exact match)
#define TEXT_EFFECT(R, G, B) \
    if (c.r == R && c.g == G && c.b == B)

// TEXT_EFFECT_WITH_SHADOW macro: matches RGB color AND its shadow (exact match)
#define TEXT_EFFECT_WITH_SHADOW(R, G, B) \
    if (checkAndSetShadow(c, R, G, B))

void applyTextEffects() {
    vec4 vertex = vec4(Position, 1.0);
    ivec3 c = ivec3(Color.rgb * 255.0 + 0.5);

    // Initialize global state
    currentEffectID = 0;
    currentVertex = vertex;
    currentBaseColor = Color;
    currentIsShadow = false;
    currentApplyToShadow = false;

    // ============================================
    // Config-based color-effect mappings
    // ============================================
    #moj_import <minecraft:_config.glsl>

    // If an effect was applied, execute it
    if (currentEffectID > 0 || currentHasRainbow) {
        applyEffect(currentVertex, currentEffectID, currentBaseColor, currentIsShadow, currentHasRainbow);
        return;
    }

    // === No effect matched, render normally ===
    applyProjection(vertex);
    applyColorTexture();
    finalize();
}
