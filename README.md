# TheSalt's Text Effects

Add dynamic text animations to your Minecraft world! This resource pack provides **11 customizable text effects**. Use with `/title`, `/tellraw`, Text Display entities, and similar text components.

> This resource pack is **not compatible** with other packs that use the `rendertype_text` core shader.

## How It Works

Define color-to-effect mappings in `_config.glsl`. When text uses a matching RGB color, the configured effect is applied.

## Preview

![Image](https://github.com/user-attachments/assets/dcda77b8-dbae-4b31-b357-501d0124dad1)

---

## Available Effects

| Effect                    | Description               |
| ------------------------- | ------------------------- |
| `apply_shake()`           | Random shaking            |
| `apply_wavy()`            | Wave animation            |
| `apply_rainbow()`         | Rainbow color cycle       |
| `apply_bouncy()`          | Bounce animation          |
| `apply_blinking()`        | Blink on/off              |
| `apply_pulse()`           | Grow/Shrink animation     |
| `apply_spin()`            | Rotation                  |
| `apply_sequential_spin()` | Sequential character spin |
| `apply_fade()`            | Fade in/out               |
| `apply_iterating()`       | Sequential jump           |
| `apply_glitch()`          | Random displacement       |

---

## Configuration

Edit `assets/minecraft/shaders/include/_config.glsl` to customize effects.

### Basic Syntax

```glsl
TEXT_EFFECT(R, G, B) {
    apply_effect();
}
```

### Shadow Support

To apply the same effect to both text and shadow:

```glsl
TEXT_EFFECT_WITH_SHADOW(255, 255, 86) {
    apply_shake();
}
```

To apply different effects to text and shadow separately, register them as separate `TEXT_EFFECT` entries. Shadow color is calculated as `RGB / 4`:

```glsl
// Text effect (255, 255, 86)
TEXT_EFFECT(255, 255, 86) {
    apply_shake();
}

// Shadow effect (255/4, 255/4, 86/4) = (63, 63, 21)
TEXT_EFFECT(63, 63, 21) {
    apply_wavy();
}
```

### Examples

```glsl
// Yellow text (#FFFF56) triggers shake effect
TEXT_EFFECT(255, 255, 86) {
    apply_shake();
}

// Combining Wavy and Rainbow
TEXT_EFFECT(255, 255, 95) {
    apply_wavy();
    apply_rainbow();
}

// Custom color with fast shake
TEXT_EFFECT(200, 100, 50) {
    apply_shake(2.0, 1.5);
}
```

### Display Color

Use `apply_color()` to display a different color than the trigger color:

```glsl
// Trigger color: (200, 100, 50)
// Display color: white (255, 255, 255)
TEXT_EFFECT(200, 100, 50) {
    apply_shake();
    apply_color(255, 255, 255);
}
```

This is useful when you want to use a specific trigger color but display the text in a different color.

---

## Default Mappings

Pre-configured Yellow effects in `_config.glsl`:

| Color Code | Effect           |
| ---------- | ---------------- |
| `#FFFF56`  | Shake            |
| `#FFFF57`  | Wavy             |
| `#FFFF58`  | Rainbow          |
| `#FFFF59`  | Bouncy           |
| `#FFFF5A`  | Blinking         |
| `#FFFF5B`  | Pulse            |
| `#FFFF5C`  | Spin             |
| `#FFFF5D`  | Sequential Spin  |
| `#FFFF5E`  | Fade             |
| `#FFFF5F`  | Iterating        |
| `#FFFF60`  | Glitch           |
| `#FFFF61`  | Wavy + Rainbow   |
| `#FFFF62`  | Bouncy + Rainbow |

---

## Special Thanks

좌우반전 코드를 제공해 주신 @베스트견과류 님에게 감사를 표합니다.

## License

This code is under MIT License

This project includes code from [Text-Effects-by-Akis](https://github.com/YeahAkis/Text-Effects-by-Akis).
