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
#moj_import <minecraft:shimmer.glsl>
#moj_import <minecraft:glitch2.glsl>
#moj_import <minecraft:text_effects_api.glsl>
#moj_import <minecraft:apply_effect.glsl>

// ============================================================
// TEXT EFFECTS - Config-based System
// ============================================================
// Edit config.glsl to customize color-effect mappings
// ============================================================

// TEXT_EFFECT macro: matches RGB color only
#define TEXT_EFFECT(R, G, B) \
    if (abs(c.r - R) <= 2 && abs(c.g - G) <= 2 && abs(c.b - B) <= 2)

// TEXT_EFFECT_WITH_SHADOW macro: matches RGB color AND its shadow (RGB * 0.25)
#define TEXT_EFFECT_WITH_SHADOW(R, G, B) \
    if ((abs(c.r - R) <= 2 && abs(c.g - G) <= 2 && abs(c.b - B) <= 2) || \
        (abs(c.r - (R/4)) <= 2 && abs(c.g - (G/4)) <= 2 && abs(c.b - (B/4)) <= 2))
#define IS_SHADOW_OF(R, G, B) (abs(c.r - (R/4)) <= 2 && abs(c.g - (G/4)) <= 2 && abs(c.b - (B/4)) <= 2)

void applyTextEffects() {
    vec4 vertex = vec4(Position, 1.0);
    ivec3 c = ivec3(Color.rgb * 255.0 + 0.5);

    // Initialize global state
    currentEffectID = 0;
    currentVertex = vertex;
    currentBaseColor = Color;
    currentIsShadow = false;
    currentApplyToShadow = false;

    // --- Alpha-based Shadow Logic (for explicitly set shadow_color) ---
    // Alpha value is used for ID (243~254)
    // ID = 255 - Alpha
    int alpha = int(Color.a * 255.0 + 0.5);
    if (alpha >= 242 && alpha <= 254) {
        int effectID = 255 - alpha;
        // Reconstruct base color: Input is shadow color, applyEffect expects Base (x4)
        vec4 baseColor = vec4(Color.rgb * 4.0, 1.0);
        applyEffect(vertex, effectID, baseColor, true);
        return;
    }

    // ============================================
    // Config-based color-effect mappings
    // ============================================
    #moj_import <minecraft:config.glsl>

    // If an effect was applied, execute it
    if (currentEffectID > 0) {
        applyEffect(currentVertex, currentEffectID, currentBaseColor, currentIsShadow);
        return;
    }

    // === No effect matched, render normally ===
    applyProjection(vertex);
    applyColorTexture();
    finalize();
}
