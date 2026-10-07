#ifndef TEXT_EFFECTS_26_3_DEFAULTS_GLSL
#define TEXT_EFFECTS_26_3_DEFAULTS_GLSL

// ============================================================
// TEXT EFFECTS - DEFAULT VALUES
// ============================================================
// These are the default parameter values for each effect.
// You can override these by passing parameters directly to
// apply_xxx() functions in config.glsl
// ============================================================

// --- Shake Effect ---
#define SHAKE_SPEED 1.0
#define SHAKE_INTENSITY 1.0

// --- Pulse Effect ---
#define PULSE_SPEED 20.0
#define PULSE_SIZE 0.4

// --- Wave Effect ---
#define WAVE_SPEED 12000.0
#define WAVE_AMPLITUDE 0.5
// Higher value = shorter wave (more difference between characters)
// Lower value = longer wave (less difference)
#define WAVE_X_FREQUENCY 0.35

// --- Rainbow Effect ---
#define RAINBOW_SPEED 500.0

// --- Bouncy Effect ---
#define BOUNCE_SPEED 3000.0
#define BOUNCE_AMPLITUDE 1.0

// --- Blinking Effect ---
#define BLINK_SPEED 0.5

// --- Spin Effect ---
#define SPIN_SPEED 2500.0
#define ONCE_SPIN_SPEED 5000.0

// --- Fade Effect ---
#define FADE_SPEED 1.0

// --- Iterating Effect ---
#define ITERATING_SPEED 1.0
#define ITERATING_SPACE 1.0

// --- Glitch Effect ---
#define GLITCH_SPEED 1.0
#define GLITCH_INTENSITY 2.0

// --- Glitch2 Effect (Chromatic Aberration) ---
#define GLITCH2_SPEED 1.0
#define GLITCH2_INTENSITY 1.0

// --- Scale Effect ---
#define SCALE_FACTOR 1.5
#define SCALE_OFFSET_X 0.0
#define SCALE_OFFSET_Y 0.0

// --- Gradient Effect ---
#define GRADIENT_START vec3(1.0, 0.0, 0.0)
#define GRADIENT_END vec3(0.0, 0.0, 1.0)
#define GRADIENT_DIRECTION 0.0

// --- Dynamic Gradient Effect ---
#define DYN_GRADIENT_START vec3(1.0, 0.0, 0.0)
#define DYN_GRADIENT_END vec3(0.0, 0.0, 1.0)
#define DYN_GRADIENT_DIRECTION 0.0
#define DYN_GRADIENT_SPEED 500.0

// --- Aurora Effect ---
#define AURORA_SPEED 500.0
#define AURORA_COLOR_1 vec3(1.0, 0.3, 0.7)   // pink
#define AURORA_COLOR_2 vec3(0.3, 1.0, 0.6)   // green
#define AURORA_COLOR_3 vec3(0.4, 0.6, 1.0)   // light blue

// --- Split Effect ---
#define SPLIT_INTENSITY 1.5
#define SPLIT_SPEED 1.0

// --- Outline Effect (fragment-side) ---
#define OUTLINE_COLOR vec4(0.0, 0.0, 0.0, 1.0)
#define OUTLINE_THICKNESS 1.0

// --- Hatch Effect (fragment-side) ---
#define HATCH_COLOR vec4(1.0, 1.0, 1.0, 1.0)
#define HATCH_SPEED 1000.0
#define HATCH_DENSITY 1.5

// --- Neon Effect (fragment-side) ---
#define NEON_COLOR vec4(0.5, 0.9, 1.0, 1.0)
#define NEON_INTENSITY 1.5
#define NEON_SPEED 1.0

// --- Chromatic Aberration Effect (fragment-side) ---
#define CHROMATIC_INTENSITY 1.5
#define CHROMATIC_SPEED 1.0

// --- 3D Extrude Effect (fragment-side) ---
#define EXTRUDE_DEPTH 1.0
#define EXTRUDE_LAYERS 3.0
#define EXTRUDE_COLOR vec4(0.0, 0.0, 0.0, 1.0)
#define EXTRUDE_COLOR2 vec4(0.0, 0.0, 0.0, 1.0)
#define EXTRUDE_COLOR3 vec4(0.0, 0.0, 0.0, 1.0)

// --- Noise / Static Effect (fragment-side) ---
#define NOISE_INTENSITY 1.0
#define NOISE_SPEED 1.0

// --- Liquid Morph Effect (fragment-side) ---
#define LIQUID_INTENSITY 1.0
#define LIQUID_SPEED 1.0

// --- Water Effect (fragment-side) ---
#define WATER_COLOR vec4(0.2, 0.6, 0.95, 1.0)
#define WATER_LEVEL 0.55       // 55% filled
#define WATER_AMPLITUDE 1.0
#define WATER_SPEED 1.0
#define WATER_FREQUENCY 1.5

#endif // TEXT_EFFECTS_26_3_DEFAULTS_GLSL
