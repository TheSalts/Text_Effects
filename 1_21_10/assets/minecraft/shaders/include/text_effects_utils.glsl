#moj_import <minecraft:common.glsl>
#moj_import <minecraft:config.glsl>
#moj_import <minecraft:rainbow.glsl>
#moj_import <minecraft:wavy.glsl>
#moj_import <minecraft:bouncy.glsl>
#moj_import <minecraft:blinking.glsl>
#moj_import <minecraft:pulse.glsl>


#moj_import <minecraft:spin.glsl>
#moj_import <minecraft:shake.glsl>
#moj_import <minecraft:fade.glsl>
#moj_import <minecraft:typing.glsl>

// ============================================================
// TEXT EFFECTS - Minecraft Color Based System
// ============================================================
// Base: Minecraft default colors
// Effect: B value offset (+1 to +12) or (-1 to -12 for B=255 colors)
//
// Effect Offsets:
//   +1/-1 = Shake
//   +2/-2 = Wavy
//   +3/-3 = Rainbow (overrides color)
//   +4/-4 = Bouncy
//   +5/-5 = Blinking
//   +6/-6 = Pulse
//   +7/-7 = Spin
//   +8/-8 = Random Spin
//   +9/-9 = Fade
//   +10/-10 = Typing
//   +11/-11 = Wavy + Rainbow
//   +12/-12 = Bouncy + Rainbow
// ============================================================

// Check color match with tolerance for both main text and shadow
// Shadow color is approximately 25% of main color
bool colorMatchMain(ivec3 c, int r, int g) {
    // Check color match with tolerance
    // Allow small tolerance for rounding errors
    return abs(c.r - r) <= 2 && abs(c.g - g) <= 2;
}


int getEffectOffset(int actualB, int baseB) {
    int offset = actualB - baseB;
    if (offset >= 1 && offset <= 12) {
        return offset;
    }
    return 0;
}

int getEffectOffsetNegative(int actualB, int baseB) {
    // For colors with B=255, check negative offset
    int offset = baseB - actualB;
    if (offset >= 1 && offset <= 12) {
        return offset;
    }
    return 0;
}

#moj_import <minecraft:apply_effect.glsl>

void applyTextEffects() {
    vec4 vertex = vec4(Position, 1.0);
    ivec3 c = ivec3(Color.rgb * 255.0 + 0.5);

    int effectID = 0;
    vec4 baseColor = vec4(1.0);
    bool isShadow = false;

    // --- Alpha-based Shadow Logic (for explicitly set shadow_color) ---
    // Alpha value is used for ID (243~254)
    // ID = 255 - Alpha
    int alpha = int(Color.a * 255.0 + 0.5);
    if (alpha >= 242 && alpha <= 254) {
        effectID = 255 - alpha;
        // Reconstruct base color: Input is shadow color, applyEffect expects Base (x4)
        baseColor = vec4(Color.rgb * 4.0, 1.0); 
        applyEffect(vertex, effectID, baseColor, true);
        return;
    }

    // ============================================
    // Colors with low B value (use positive offset)
    // ============================================

    // Black #000000 (0, 0, 0)
    if (colorMatchMain(c, 0, 0)) {
        effectID = getEffectOffset(c.b, 0);
        if (effectID > 0) {
            baseColor = vec4(0.0, 0.0, 0.0, Color.a);
            applyEffect(vertex, effectID, baseColor, false);
            return;
        }
    }

    // Dark Blue #0000AA (0, 0, 170)
    if (colorMatchMain(c, 0, 0)) {
        effectID = getEffectOffset(c.b, 170);
        if (effectID > 0) {
            baseColor = vec4(0.0, 0.0, 170.0/255.0, Color.a);
            applyEffect(vertex, effectID, baseColor, false);
            return;
        }
    }

    // Dark Green #00AA00 (0, 170, 0)
    if (colorMatchMain(c, 0, 170)) {
        effectID = getEffectOffset(c.b, 0);
        if (effectID > 0) {
            baseColor = vec4(0.0, 170.0/255.0, 0.0, Color.a);
            applyEffect(vertex, effectID, baseColor, false);
            return;
        }
    }

    // Dark Aqua #00AAAA (0, 170, 170)
    if (colorMatchMain(c, 0, 170)) {
        effectID = getEffectOffset(c.b, 170);
        if (effectID > 0) {
            baseColor = vec4(0.0, 170.0/255.0, 170.0/255.0, Color.a);
            applyEffect(vertex, effectID, baseColor, false);
            return;
        }
    }

    // Dark Red #AA0000 (170, 0, 0)
    if (colorMatchMain(c, 170, 0)) {
        effectID = getEffectOffset(c.b, 0);
        if (effectID > 0) {
            baseColor = vec4(170.0/255.0, 0.0, 0.0, Color.a);
            applyEffect(vertex, effectID, baseColor, false);
            return;
        }
    }

    // Dark Purple #AA00AA (170, 0, 170)
    if (colorMatchMain(c, 170, 0)) {
        effectID = getEffectOffset(c.b, 170);
        if (effectID > 0) {
            baseColor = vec4(170.0/255.0, 0.0, 170.0/255.0, Color.a);
            applyEffect(vertex, effectID, baseColor, false);
            return;
        }
    }

    // Gold #FFAA00 (255, 170, 0)
    if (colorMatchMain(c, 255, 170)) {
        effectID = getEffectOffset(c.b, 0);
        if (effectID > 0) {
            baseColor = vec4(1.0, 170.0/255.0, 0.0, Color.a);
            applyEffect(vertex, effectID, baseColor, false);
            return;
        }
    }

    // Gray #AAAAAA (170, 170, 170)
    if (colorMatchMain(c, 170, 170)) {
        effectID = getEffectOffset(c.b, 170);
        if (effectID > 0) {
            baseColor = vec4(170.0/255.0, 170.0/255.0, 170.0/255.0, Color.a);
            applyEffect(vertex, effectID, baseColor, false);
            return;
        }
    }

    // Dark Gray #555555 (85, 85, 85)
    if (colorMatchMain(c, 85, 85)) {
        effectID = getEffectOffset(c.b, 85);
        if (effectID > 0) {
            baseColor = vec4(85.0/255.0, 85.0/255.0, 85.0/255.0, Color.a);
            applyEffect(vertex, effectID, baseColor, false);
            return;
        }
    }

    // Green #55FF55 (85, 255, 85)
    if (colorMatchMain(c, 85, 255)) {
        effectID = getEffectOffset(c.b, 85);
        if (effectID > 0) {
            baseColor = vec4(85.0/255.0, 1.0, 85.0/255.0, Color.a);
            applyEffect(vertex, effectID, baseColor, false);
            return;
        }
    }

    // Red #FF5555 (255, 85, 85)
    if (colorMatchMain(c, 255, 85)) {
        effectID = getEffectOffset(c.b, 85);
        if (effectID > 0) {
            baseColor = vec4(1.0, 85.0/255.0, 85.0/255.0, Color.a);
            applyEffect(vertex, effectID, baseColor, false);
            return;
        }
    }

    // Yellow #FFFF55 (255, 255, 85)
    if (colorMatchMain(c, 255, 255)) {
        effectID = getEffectOffset(c.b, 85);
        if (effectID > 0) {
            baseColor = vec4(1.0, 1.0, 85.0/255.0, Color.a);
            applyEffect(vertex, effectID, baseColor, false);
            return;
        }
    }

    // ============================================
    // Colors with B=255 (use negative offset)
    // ============================================

    // Blue #5555FF (85, 85, 255)
    if (colorMatchMain(c, 85, 85) && c.b >= 243 && c.b <= 254) {
        effectID = 255 - c.b;
        baseColor = vec4(85.0/255.0, 85.0/255.0, 1.0, Color.a);
        applyEffect(vertex, effectID, baseColor, false);
        return;
    }

    // Aqua #55FFFF (85, 255, 255)
    if (colorMatchMain(c, 85, 255) && c.b >= 243 && c.b <= 254) {
        effectID = 255 - c.b;
        baseColor = vec4(85.0/255.0, 1.0, 1.0, Color.a);
        applyEffect(vertex, effectID, baseColor, false);
        return;
    }

    // Light Purple #FF55FF (255, 85, 255)
    if (colorMatchMain(c, 255, 85) && c.b >= 243 && c.b <= 254) {
        effectID = 255 - c.b;
        baseColor = vec4(1.0, 85.0/255.0, 1.0, Color.a);
        applyEffect(vertex, effectID, baseColor, false);
        return;
    }

    // White #FFFFFF (255, 255, 255)
    if (colorMatchMain(c, 255, 255) && c.b >= 243 && c.b <= 254) {
        effectID = 255 - c.b;
        baseColor = vec4(1.0, 1.0, 1.0, Color.a);
        applyEffect(vertex, effectID, baseColor, false);
        return;
    }

    // === No effect matched, render normally ===
    applyProjection(vertex);
    applyColorTexture();
    finalize();
}
