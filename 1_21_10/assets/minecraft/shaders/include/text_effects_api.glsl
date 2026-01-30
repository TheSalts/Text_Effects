// ============================================================
// TEXT EFFECTS API
// ============================================================
// Functions to apply text effects in config.glsl
// ============================================================

// Global state for current effect being processed
int currentEffectID = 0;
vec4 currentVertex;
vec4 currentBaseColor;
bool currentIsShadow = false;
bool currentApplyToShadow = false;  // Flag for applying same effect to shadow color

// Effect parameters (overridable via apply_xxx functions)
float paramShakeSpeed = SHAKE_SPEED;
float paramShakeIntensity = SHAKE_INTENSITY;
float paramWaveSpeed = WAVE_SPEED;
float paramWaveAmplitude = WAVE_AMPLITUDE;
float paramWaveXFrequency = WAVE_X_FREQUENCY;
float paramRainbowSpeed = RAINBOW_SPEED;
float paramBounceSpeed = BOUNCE_SPEED;
float paramBounceAmplitude = BOUNCE_AMPLITUDE;
float paramBlinkSpeed = BLINK_SPEED;
float paramPulseSpeed = PULSE_SPEED;
float paramPulseSize = PULSE_SIZE;
float paramSpinSpeed = SPIN_SPEED;
float paramFadeSpeed = FADE_SPEED;
float paramIteratingSpeed = ITERATING_SPEED;
float paramIteratingSpace = ITERATING_SPACE;
float paramGlitchSpeed = GLITCH_SPEED;
float paramGlitchIntensity = GLITCH_INTENSITY;

// Helper function: rgb from 0-255 values
vec3 rgb(float r, float g, float b) {
    return vec3(r / 255.0, g / 255.0, b / 255.0);
}

vec4 rgba(float r, float g, float b, float a) {
    return vec4(r / 255.0, g / 255.0, b / 255.0, a);
}

// Set display color (different from trigger color)
void apply_color(vec3 color) {
    currentBaseColor.rgb = color;
}

void apply_color(float r, float g, float b) {
    currentBaseColor.rgb = vec3(r / 255.0, g / 255.0, b / 255.0);
}

// --- Shake Effect ---
void apply_shake() {
    currentEffectID = 1;
}

void apply_shake(float speed, float intensity) {
    currentEffectID = 1;
    paramShakeSpeed = speed;
    paramShakeIntensity = intensity;
}

// --- Wavy Effect ---
void apply_wavy() {
    currentEffectID = 2;
}

void apply_wavy(float speed) {
    currentEffectID = 2;
    paramWaveSpeed = speed;
}

void apply_wavy(float speed, float amplitude) {
    currentEffectID = 2;
    paramWaveSpeed = speed;
    paramWaveAmplitude = amplitude;
}

void apply_wavy(float speed, float amplitude, float xFrequency) {
    currentEffectID = 2;
    paramWaveSpeed = speed;
    paramWaveAmplitude = amplitude;
    paramWaveXFrequency = xFrequency;
}

// --- Rainbow Effect ---
void apply_rainbow() {
    currentEffectID = 3;
}

void apply_rainbow(float speed) {
    currentEffectID = 3;
    paramRainbowSpeed = speed;
}

// --- Bouncy Effect ---
void apply_bouncy() {
    currentEffectID = 4;
}

void apply_bouncy(float speed) {
    currentEffectID = 4;
    paramBounceSpeed = speed;
}

void apply_bouncy(float speed, float amplitude) {
    currentEffectID = 4;
    paramBounceSpeed = speed;
    paramBounceAmplitude = amplitude;
}

// --- Blinking Effect ---
void apply_blinking() {
    currentEffectID = 5;
}

void apply_blinking(float speed) {
    currentEffectID = 5;
    paramBlinkSpeed = speed;
}

// --- Pulse Effect ---
void apply_pulse() {
    currentEffectID = 6;
}

void apply_pulse(float speed) {
    currentEffectID = 6;
    paramPulseSpeed = speed;
}

void apply_pulse(float speed, float size) {
    currentEffectID = 6;
    paramPulseSpeed = speed;
    paramPulseSize = size;
}

// --- Spin Effect ---
void apply_spin() {
    currentEffectID = 7;
}

void apply_spin(float speed) {
    currentEffectID = 7;
    paramSpinSpeed = speed;
}

// --- Sequential Spin Effect ---
void apply_sequential_spin() {
    currentEffectID = 8;
}

void apply_sequential_spin(float speed) {
    currentEffectID = 8;
    paramSpinSpeed = speed;
}

// --- Fade Effect ---
void apply_fade() {
    currentEffectID = 9;
}

void apply_fade(float speed) {
    currentEffectID = 9;
    paramFadeSpeed = speed;
}

// --- Wavy + Rainbow Effect ---
void apply_wavy_rainbow() {
    currentEffectID = 10;
}

void apply_wavy_rainbow(float waveSpeed, float rainbowSpeed) {
    currentEffectID = 10;
    paramWaveSpeed = waveSpeed;
    paramRainbowSpeed = rainbowSpeed;
}

// --- Bouncy + Rainbow Effect ---
void apply_bouncy_rainbow() {
    currentEffectID = 11;
}

void apply_bouncy_rainbow(float bounceSpeed, float rainbowSpeed) {
    currentEffectID = 11;
    paramBounceSpeed = bounceSpeed;
    paramRainbowSpeed = rainbowSpeed;
}

// --- Iterating Effect ---
void apply_iterating() {
    currentEffectID = 12;
}

void apply_iterating(float speed) {
    currentEffectID = 12;
    paramIteratingSpeed = speed;
}

void apply_iterating(float speed, float space) {
    currentEffectID = 12;
    paramIteratingSpeed = speed;
    paramIteratingSpace = space;
}

// --- Shimmer Effect ---
void apply_shimmer() {
    currentEffectID = 13;
}

// --- Glitch Effect ---
void apply_glitch() {
    currentEffectID = 14;
}

void apply_glitch(float speed, float intensity) {
    currentEffectID = 14;
    paramGlitchSpeed = speed;
    paramGlitchIntensity = intensity;
}

// --- Glitch2 Effect ---
void apply_glitch2() {
    currentEffectID = 15;
}

// NOTE: To apply effect to both text and shadow, use TEXT_EFFECT_WITH_SHADOW(R, G, B) in config.glsl
// Shadow color is automatically calculated as RGB * 0.25
