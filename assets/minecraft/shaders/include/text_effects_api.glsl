// ============================================================
// TEXT EFFECTS API
// ============================================================
// Functions to apply text effects in _config.glsl
// ============================================================

// Global state for current effect being processed
vec4 currentVertex;
vec4 currentBaseColor;
bool currentIsShadow = false;
bool currentApplyToShadow = false;

// Effect flags (multiple can be active simultaneously)
bool flagShake = false;
bool flagWavy = false;
bool flagRainbow = false;
bool flagBouncy = false;
bool flagBlinking = false;
bool flagPulse = false;
bool flagSpin = false;
bool flagSequentialSpin = false;
bool flagFade = false;
bool flagIterating = false;
bool flagGlitch = false;
bool flagScale = false;
bool flagGradient = false;
bool flagDynamicGradient = false;
bool flagAurora = false;
bool flagSplit = false;
bool flagOutline = false;
bool flagHatch = false;
bool flagNeon = false;
bool flagColorOverride = false;
bool flagChromatic = false;
bool flagExtrude = false;
bool flagNoise = false;
bool flagLiquid = false;
bool flagWater = false;

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
float paramScaleFactor = SCALE_FACTOR;
float paramScaleOffsetX = SCALE_OFFSET_X;
float paramScaleOffsetY = SCALE_OFFSET_Y;
vec3 paramGradientStart = GRADIENT_START;
float paramGradientStartA = 1.0;
vec3 paramGradientEnd = GRADIENT_END;
float paramGradientEndA = 1.0;
float paramGradientDirection = GRADIENT_DIRECTION;
vec3 paramDynGradientStart = DYN_GRADIENT_START;
float paramDynGradientStartA = 1.0;
vec3 paramDynGradientEnd = DYN_GRADIENT_END;
float paramDynGradientEndA = 1.0;
float paramDynGradientDirection = DYN_GRADIENT_DIRECTION;
float paramDynGradientSpeed = DYN_GRADIENT_SPEED;
vec3 paramAuroraColor1 = AURORA_COLOR_1;
float paramAuroraColor1A = 1.0;
vec3 paramAuroraColor2 = AURORA_COLOR_2;
float paramAuroraColor2A = 1.0;
vec3 paramAuroraColor3 = AURORA_COLOR_3;
float paramAuroraColor3A = 1.0;
float paramAuroraSpeed = AURORA_SPEED;
float paramSplitIntensity = SPLIT_INTENSITY;
float paramSplitSpeed = SPLIT_SPEED;
vec4 paramOutlineColor = OUTLINE_COLOR;
float paramOutlineThickness = OUTLINE_THICKNESS;
vec4 paramHatchColor = HATCH_COLOR;
float paramHatchSpeed = HATCH_SPEED;
float paramHatchDensity = HATCH_DENSITY;
vec4 paramNeonColor = NEON_COLOR;
float paramNeonIntensity = NEON_INTENSITY;
float paramNeonSpeed = NEON_SPEED;
float paramChromaticIntensity = CHROMATIC_INTENSITY;
float paramChromaticSpeed = CHROMATIC_SPEED;
float paramExtrudeDepth = EXTRUDE_DEPTH;
float paramExtrudeLayers = EXTRUDE_LAYERS;
vec4 paramExtrudeColor = EXTRUDE_COLOR;
vec4 paramExtrudeColor2 = EXTRUDE_COLOR2;
vec4 paramExtrudeColor3 = EXTRUDE_COLOR3;
float paramExtrudeUseColor = 0.0;
float paramNoiseIntensity = NOISE_INTENSITY;
float paramNoiseSpeed = NOISE_SPEED;
float paramLiquidIntensity = LIQUID_INTENSITY;
float paramLiquidSpeed = LIQUID_SPEED;
vec4  paramWaterColor     = WATER_COLOR;
float paramWaterLevel     = WATER_LEVEL;
float paramWaterAmplitude = WATER_AMPLITUDE;
float paramWaterSpeed     = WATER_SPEED;
float paramWaterFrequency = WATER_FREQUENCY;

// Helper function: rgb from 0-255 values
vec3 rgb(float r, float g, float b) {
    return vec3(r / 255.0, g / 255.0, b / 255.0);
}

// rgb from hex number (uint, e.g. rgb(0xFF1400u))
vec3 rgb(uint rgb_v) {
    float r = float((rgb_v >> 16) & 0xFFu) / 255.0;
    float g = float((rgb_v >> 8)  & 0xFFu) / 255.0;
    float b = float( rgb_v        & 0xFFu) / 255.0;
    return vec3(r, g, b);
}

// rgb from hex number (int, e.g. rgb(0xFF1400))
vec3 rgb(int irgb_v) {
    return rgb(uint(irgb_v));
}

// rgba from 0-255 values and a decimal
vec4 rgba(float r, float g, float b, float a) {
    return vec4(r / 255.0, g / 255.0, b / 255.0, a);
}

// rgba from hex number (uint, e.g. rgba(0xFF1400FFu))
vec4 rgba(uint v) {
    float r = float((v >> 24) & 0xFFu) / 255.0;
    float g = float((v >> 16) & 0xFFu) / 255.0;
    float b = float((v >> 8)  & 0xFFu) / 255.0;
    float a = float( v        & 0xFFu) / 255.0;
    return vec4(r, g, b, a);
}

// rgba from hex number (int, e.g. rgba(0xFF1400FF))
vec4 rgba(int irgba_v) {
    return rgba(uint(irgba_v));
}

// argb from 0-255 values and a decimal
vec4 argb(float a, float r, float g, float b) {
    return vec4(r / 255.0, g / 255.0, b / 255.0, a);
}

// argb from hex number (uint, e.g. argb(0xFFFF1400u))
vec4 argb(uint v) {
    float a = float((v >> 24) & 0xFFu) / 255.0;
    float r = float((v >> 16) & 0xFFu) / 255.0;
    float g = float((v >> 8)  & 0xFFu) / 255.0;
    float b = float( v        & 0xFFu) / 255.0;
    return vec4(r, g, b, a);
}

// argb from hex number (int, e.g. argb(0xFFFF1400))
vec4 argb(int iargb_v) {
    return argb(uint(iargb_v));
}

// Set display color (different from trigger color)
void apply_color(vec3 color) {
    currentBaseColor.rgb = color;
    flagColorOverride = true;
}

// Override alpha. The text display's own opacity is applied separately at the
// end of the pipeline, so this alpha is multiplied on top of it
// (e.g. rgba(.., 0.5) halves the display opacity).
void apply_color(vec4 color) {
    currentBaseColor = color;
    flagColorOverride = true;
}

// Check if any effect flag is active
bool hasAnyEffect() {
    return flagShake || flagWavy || flagRainbow || flagBouncy || flagBlinking ||
           flagPulse || flagSpin || flagSequentialSpin || flagFade ||
           flagIterating || flagGlitch || flagScale || flagGradient || flagDynamicGradient ||
           flagAurora || flagSplit || flagOutline || flagHatch || flagNeon ||
           flagColorOverride || flagChromatic || flagExtrude || flagNoise || flagLiquid || flagWater;
}

// --- Shake Effect ---
void apply_shake() {
    flagShake = true;
}

void apply_shake(float speed, float intensity) {
    flagShake = true;
    paramShakeSpeed = speed;
    paramShakeIntensity = intensity;
}

// --- Wavy Effect ---
void apply_wavy() {
    flagWavy = true;
}

void apply_wavy(float speed) {
    flagWavy = true;
    paramWaveSpeed = speed;
}

void apply_wavy(float speed, float amplitude) {
    flagWavy = true;
    paramWaveSpeed = speed;
    paramWaveAmplitude = amplitude;
}

void apply_wavy(float speed, float amplitude, float xFrequency) {
    flagWavy = true;
    paramWaveSpeed = speed;
    paramWaveAmplitude = amplitude;
    paramWaveXFrequency = xFrequency;
}

// --- Rainbow Effect ---
void apply_rainbow() {
    flagRainbow = true;
}

void apply_rainbow(float speed) {
    flagRainbow = true;
    paramRainbowSpeed = speed;
}

// --- Bouncy Effect ---
void apply_bouncy() {
    flagBouncy = true;
}

void apply_bouncy(float speed) {
    flagBouncy = true;
    paramBounceSpeed = speed;
}

void apply_bouncy(float speed, float amplitude) {
    flagBouncy = true;
    paramBounceSpeed = speed;
    paramBounceAmplitude = amplitude;
}

// --- Blinking Effect ---
void apply_blinking() {
    flagBlinking = true;
}

void apply_blinking(float speed) {
    flagBlinking = true;
    paramBlinkSpeed = speed;
}

// --- Pulse Effect ---
void apply_pulse() {
    flagPulse = true;
}

void apply_pulse(float speed) {
    flagPulse = true;
    paramPulseSpeed = speed;
}

void apply_pulse(float speed, float size) {
    flagPulse = true;
    paramPulseSpeed = speed;
    paramPulseSize = size;
}

// --- Spin Effect ---
void apply_spin() {
    flagSpin = true;
}

void apply_spin(float speed) {
    flagSpin = true;
    paramSpinSpeed = speed;
}

// --- Sequential Spin Effect ---
void apply_sequential_spin() {
    flagSequentialSpin = true;
}

void apply_sequential_spin(float speed) {
    flagSequentialSpin = true;
    paramSpinSpeed = speed;
}

// --- Fade Effect ---
void apply_fade() {
    flagFade = true;
}

void apply_fade(float speed) {
    flagFade = true;
    paramFadeSpeed = speed;
}

// --- Iterating Effect ---
void apply_iterating() {
    flagIterating = true;
}

void apply_iterating(float speed) {
    flagIterating = true;
    paramIteratingSpeed = speed;
}

void apply_iterating(float speed, float space) {
    flagIterating = true;
    paramIteratingSpeed = speed;
    paramIteratingSpace = space;
}

// --- Scale Effect ---
void apply_scale(float scale) {
    flagScale = true;
    paramScaleFactor = scale;
}

void apply_scale(float scale, float offsetX, float offsetY) {
    flagScale = true;
    paramScaleFactor = scale;
    paramScaleOffsetX = offsetX;
    paramScaleOffsetY = offsetY;
}

void apply_offset(float offsetX, float offsetY) {
    if (!flagScale) {
        paramScaleFactor = 1.0;
    }
    flagScale = true;
    paramScaleFactor = 0.0;
    paramScaleOffsetX = offsetX;
    paramScaleOffsetY = offsetY;
}

// --- Glitch Effect ---
void apply_glitch() {
    flagGlitch = true;
}

void apply_glitch(float speed, float intensity) {
    flagGlitch = true;
    paramGlitchSpeed = speed;
    paramGlitchIntensity = intensity;
}

// --- Gradient Effect ---
void apply_gradient(vec3 start, vec3 end, float direction) {
    flagGradient = true;
    paramGradientStart = start;
    paramGradientEnd = end;
    paramGradientDirection = direction;
}

void apply_gradient(vec4 start, vec4 end, float direction) {
    flagGradient = true;
    paramGradientStart = start.rgb;
    paramGradientStartA = start.a;
    paramGradientEnd = end.rgb;
    paramGradientEndA = end.a;
    paramGradientDirection = direction;
}

void apply_gradient(vec3 start, vec3 end) {
    apply_gradient(start, end, GRADIENT_DIRECTION);
}

void apply_gradient() {
    flagGradient = true;
}

// --- Dynamic Gradient Effect ---
void apply_dynamic_gradient(vec3 start, vec3 end, float direction, float speed) {
    flagDynamicGradient = true;
    paramDynGradientStart = start;
    paramDynGradientEnd = end;
    paramDynGradientDirection = direction;
    paramDynGradientSpeed = speed;
}

void apply_dynamic_gradient(vec4 start, vec4 end, float direction, float speed) {
    flagDynamicGradient = true;
    paramDynGradientStart = start.rgb;
    paramDynGradientStartA = start.a;
    paramDynGradientEnd = end.rgb;
    paramDynGradientEndA = end.a;
    paramDynGradientDirection = direction;
    paramDynGradientSpeed = speed;
}

void apply_dynamic_gradient(vec3 start, vec3 end, float direction) {
    apply_dynamic_gradient(start, end, direction, DYN_GRADIENT_SPEED);
}

void apply_dynamic_gradient(vec3 start, vec3 end) {
    apply_dynamic_gradient(start, end, DYN_GRADIENT_DIRECTION, DYN_GRADIENT_SPEED);
}

void apply_dynamic_gradient() {
    flagDynamicGradient = true;
}

void apply_lava(float speed) {
    apply_dynamic_gradient(rgb(255, 20, 0), rgb(255, 200, 0), 2.0, speed);
}

void apply_lava() {
    apply_lava(300.0);
}

// --- Aurora Effect ---
void apply_aurora(vec4 c1, vec4 c2, vec4 c3, float speed) {
    flagAurora = true;
    paramAuroraColor1 = c1.rgb; paramAuroraColor1A = c1.a;
    paramAuroraColor2 = c2.rgb; paramAuroraColor2A = c2.a;
    paramAuroraColor3 = c3.rgb; paramAuroraColor3A = c3.a;
    paramAuroraSpeed = speed;
}

void apply_aurora(vec3 c1, vec3 c2, vec3 c3, float speed) {
    flagAurora = true;
    paramAuroraColor1 = c1;
    paramAuroraColor2 = c2;
    paramAuroraColor3 = c3;
    paramAuroraSpeed = speed;
}

void apply_aurora(float speed) {
    flagAurora = true;
    paramAuroraSpeed = speed;
}

void apply_aurora() {
    flagAurora = true;
}

// --- Split Effect ---
void apply_split(float intensity, float speed) {
    flagSplit = true;
    paramSplitIntensity = intensity;
    paramSplitSpeed = speed;
}

void apply_split(float intensity) {
    flagSplit = true;
    paramSplitIntensity = intensity;
}

void apply_split() {
    flagSplit = true;
}

// --- Outline Effect (fragment-side) ---
void apply_outline(vec4 color, float thickness) {
    flagOutline = true;
    paramOutlineColor = color;
    paramOutlineThickness = thickness;
}

void apply_outline(vec3 color, float thickness) {
    flagOutline = true;
    paramOutlineColor = vec4(color, 1.0);
    paramOutlineThickness = thickness;
}

void apply_outline(vec3 color) {
    flagOutline = true;
    paramOutlineColor = vec4(color, 1.0);
}

void apply_outline() {
    flagOutline = true;
}

// --- Hatch Effect (fragment-side) ---
void apply_hatch(vec4 color, float speed, float density) {
    flagHatch = true;
    paramHatchColor = color;
    paramHatchSpeed = speed;
    paramHatchDensity = density;
}

void apply_hatch(vec3 color, float speed, float density) {
    flagHatch = true;
    paramHatchColor = vec4(color, 1.0);
    paramHatchSpeed = speed;
    paramHatchDensity = density;
}

void apply_hatch(float speed) {
    flagHatch = true;
    paramHatchSpeed = speed;
}

void apply_hatch() {
    flagHatch = true;
}

// --- Neon Effect (fragment-side) ---
void apply_neon(vec4 color, float intensity, float speed) {
    flagNeon = true;
    paramNeonColor = color;
    paramNeonIntensity = intensity;
    paramNeonSpeed = speed;
}

void apply_neon(vec3 color, float intensity) {
    flagNeon = true;
    paramNeonColor = vec4(color, 1.0);
    paramNeonIntensity = intensity;
}

void apply_neon(vec3 color) {
    flagNeon = true;
    paramNeonColor = vec4(color, 1.0);
}

void apply_neon() {
    flagNeon = true;
}

// --- Chromatic Aberration Effect (fragment-side) ---
void apply_chromatic() {
    flagChromatic = true;
}

void apply_chromatic(float intensity) {
    flagChromatic = true;
    paramChromaticIntensity = intensity;
}

void apply_chromatic(float intensity, float speed) {
    flagChromatic = true;
    paramChromaticIntensity = intensity;
    paramChromaticSpeed = speed;
}

// --- 3D Extrude Effect (fragment-side) ---
void apply_extrude() {
    flagExtrude = true;
    paramExtrudeUseColor = 0.0;
}

void apply_extrude(float depth) {
    flagExtrude = true;
    paramExtrudeDepth = depth;
    paramExtrudeUseColor = 0.0;
}

void apply_extrude(float depth, float layers) {
    flagExtrude = true;
    paramExtrudeDepth = depth;
    paramExtrudeLayers = layers;
    paramExtrudeUseColor = 0.0;
}

void apply_extrude(float depth, float layers, vec3 endColor) {
    flagExtrude = true;
    paramExtrudeDepth = depth;
    paramExtrudeLayers = layers;
    paramExtrudeColor = vec4(endColor, 1.0);
    paramExtrudeUseColor = 1.0;
}

void apply_extrude(float depth, float layers, vec4 endColor) {
    flagExtrude = true;
    paramExtrudeDepth = depth;
    paramExtrudeLayers = layers;
    paramExtrudeColor = endColor;
    paramExtrudeUseColor = 1.0;
}

void apply_extrude(float depth, float layers, vec3 c1, vec3 c2, vec3 c3) {
    flagExtrude = true;
    paramExtrudeDepth = depth;
    paramExtrudeLayers = layers;
    paramExtrudeColor  = vec4(c1, 1.0);
    paramExtrudeColor2 = vec4(c2, 1.0);
    paramExtrudeColor3 = vec4(c3, 1.0);
    paramExtrudeUseColor = 2.0;
}

void apply_extrude(float depth, float layers, vec4 c1, vec4 c2, vec4 c3) {
    flagExtrude = true;
    paramExtrudeDepth = depth;
    paramExtrudeLayers = layers;
    paramExtrudeColor  = c1;
    paramExtrudeColor2 = c2;
    paramExtrudeColor3 = c3;
    paramExtrudeUseColor = 2.0;
}

// --- Noise / Static Effect (fragment-side) ---
void apply_noise() {
    flagNoise = true;
}

void apply_noise(float intensity) {
    flagNoise = true;
    paramNoiseIntensity = intensity;
}

void apply_noise(float intensity, float speed) {
    flagNoise = true;
    paramNoiseIntensity = intensity;
    paramNoiseSpeed = speed;
}

// --- Liquid Morph Effect (fragment-side) ---
void apply_liquid() {
    flagLiquid = true;
}

void apply_liquid(float intensity) {
    flagLiquid = true;
    paramLiquidIntensity = intensity;
}

void apply_liquid(float intensity, float speed) {
    flagLiquid = true;
    paramLiquidIntensity = intensity;
    paramLiquidSpeed = speed;
}

// --- Water Effect (fragment-side) ---
void apply_water() {
    flagWater = true;
}
void apply_water(vec3 color) {
    flagWater = true;
    paramWaterColor = vec4(color, 1.0);
}
void apply_water(vec4 color) {
    flagWater = true;
    paramWaterColor = color;
}
void apply_water(vec3 color, float level) {
    flagWater = true;
    paramWaterColor = vec4(color, 1.0);
    paramWaterLevel = level;
}
void apply_water(vec3 color, float level, float amplitude, float speed) {
    flagWater = true;
    paramWaterColor = vec4(color, 1.0);
    paramWaterLevel = level;
    paramWaterAmplitude = amplitude;
    paramWaterSpeed = speed;
}
void apply_water(vec4 color, float level, float amplitude, float speed) {
    flagWater = true;
    paramWaterColor = color;
    paramWaterLevel = level;
    paramWaterAmplitude = amplitude;
    paramWaterSpeed = speed;
}
void apply_water(vec3 color, float level, float amplitude, float speed, float frequency) {
    flagWater = true;
    paramWaterColor = vec4(color, 1.0);
    paramWaterLevel = level;
    paramWaterAmplitude = amplitude;
    paramWaterSpeed = speed;
    paramWaterFrequency = frequency;
}

// NOTE: To apply effect to both text and shadow, use TEXT_EFFECT_WITH_SHADOW(rgb(R, G, B)) in _config.glsl
// Shadow color is automatically calculated as RGB * 0.25
