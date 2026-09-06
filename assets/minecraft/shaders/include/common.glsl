#define PI 3.14159265359
#define TAU 6.28318530718

float random(vec2 seed) {
    return fract(sin(dot(seed, vec2(12.9898, 78.233))) * 43758.5453);
}

float noise(float n) {
    float i = floor(n);
    float f = fract(n);
    return mix(random(vec2(i, 0.0)), random(vec2(i + 1.0, 0.0)), smoothstep(0.0, 1.0, f));
}

vec3 hue(float t) {
    t = fract(t);
    float r = abs(t * 6.0 - 3.0) - 1.0;
    float g = 2.0 - abs(t * 6.0 - 2.0);
    float b = 2.0 - abs(t * 6.0 - 4.0);
    return clamp(vec3(r, g, b), 0.0, 1.0);
}

void finalize() {
    vertexColor *= ColorModulator;
}

void applyProjection(inout vec4 vertex) {
    gl_Position = ProjMat * ModelViewMat * vertex;
}

void applyColorTexture() {
    vec4 texColor = texelFetch(Sampler2, UV2 / 16, 0);
    vertexColor = Color * texColor;
}
