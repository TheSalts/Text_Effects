# TheSalt's Text Effects

Add dynamic text animations to your Minecraft world! This resource pack provides **15 customizable text effects**. Use with `/title`, `/tellraw`, Text Display entities, and similar text components.

> This resource pack is **not compatible** with other packs that use the `rendertype_text` core shader.

## How It Works

Define color-to-effect mappings in `config.glsl`. When text uses a matching RGB color, the configured effect is applied.

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
| `apply_wavy_rainbow()`    | Wave + rainbow            |
| `apply_bouncy_rainbow()`  | Bounce + rainbow          |
| `apply_iterating()`       | Sequential jump           |
| `apply_shimmer()`         | Diagonal shimmer          |
| `apply_glitch()`          | Random displacement       |
| `apply_glitch2()`         | RGB channel split effect  |

---

## Configuration

Edit `assets/minecraft/shaders/include/config.glsl` to customize effects.

### Basic Syntax

```glsl
TEXT_EFFECT(R, G, B) {
    apply_effect();
}
```

### Examples

```glsl
// Yellow text (#FFFF56) triggers shake effect
TEXT_EFFECT(255, 255, 86) {
    apply_shake();
}

// Custom color with fast shake
TEXT_EFFECT(200, 100, 50) {
    apply_shake(2.0, 1.5);
}

// Rainbow effect with custom speed
TEXT_EFFECT(50, 50, 50) {
    apply_rainbow(1000.0);
}
```

### Effect Parameters

| Effect                                    | Parameters                  |
| ----------------------------------------- | --------------------------- |
| `apply_shake(speed, intensity)`           | Default: 1.0, 1.0           |
| `apply_wavy(speed, amplitude, frequency)` | Default: 12000.0, 0.5, 0.35 |
| `apply_rainbow(speed)`                    | Default: 500.0              |
| `apply_bouncy(speed, amplitude)`          | Default: 3000.0, 1.0        |
| `apply_blinking(speed)`                   | Default: 0.5                |
| `apply_pulse(speed, size)`                | Default: 20.0, 0.4          |
| `apply_spin(speed)`                       | Default: 2500.0             |
| `apply_fade(speed)`                       | Default: 1.0                |
| `apply_iterating(speed, space)`           | Default: 1.0, 1.0           |
| `apply_glitch(speed, intensity)`          | Default: 1.0, 2.0           |

---

## Quick Start

1. Open `config.glsl`
2. Add your color-effect mapping:
    ```glsl
    TEXT_EFFECT(255, 0, 0) {
        apply_shake();
    }
    ```
3. Use the color in game:
    ```mcfunction
    /tellraw @a {"text":"Shaking!","color":"#FF0000"}
    ```

---

## Default Mappings

Pre-configured Yellow effects (modify or add more in `config.glsl`):

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
| `#FFFF5F`  | Wavy + Rainbow   |
| `#FFFF60`  | Bouncy + Rainbow |
| `#FFFF61`  | Iterating        |
| `#FFFF62`  | Shimmer          |
| `#FFFF63`  | Glitch           |
| `#FFFF64`  | Glitch2          |

---

## Special Thanks

좌우반전 코드를 제공해 주신 @베스트견과류 님에게 감사를 표합니다.

## License

This code is under MIT License

This project includes code from [Text-Effects-by-Akis](https://github.com/YeahAkis/Text-Effects-by-Akis).
