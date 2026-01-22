# TheSalt's Text Effects

Add dynamic text animations to your Minecraft world! This resource pack provides **9 customizable text effects**. Use with `/title`, `/tellraw`, Text Display entities, and similar text components.

> This resource pack is **not compatible** with other packs that use the `rendertype_text` core shader.

## How It Works

Use Minecraft default colors with a **B value offset** to trigger effects.

- **R, G**: Base Minecraft color
- **B + offset**: Effect trigger (Text Only)
- **Shadow Alpha**: Effect trigger (Shadow Only)

## Preview

![Image](https://github.com/user-attachments/assets/dcda77b8-dbae-4b31-b357-501d0124dad1)

---

## Effect List

| Offset | Effect         | Description              |
| ------ | -------------- | ------------------------ |
| +1     | Shake          | Random shaking           |
| +2     | Wavy           | Wave animation           |
| +3     | Rainbow        | Rainbow cycle            |
| +4     | Bouncy         | Bounce animation         |
| +5     | Blinking       | Blink on/off             |
| +6     | Pulse          | Grow/Shrink animation    |
| +7     | Spin           | Rotation                 |
| +8     | Delayed Spin   | Spin then wait then spin |
| +9     | Fade           | Fade in/out              |
| +10    | Wavy+Rainbow   | Wave + rainbow           |
| +11    | Bouncy+Rainbow | Bounce + rainbow         |

---

## Quick Reference

### Low B Colors (+1 to +11)

| Color                 | Shake | Wavy | Rainbow | Bouncy | Blink | Pulse | Spin | DelaySpin | Fade | W+R  | B+R  |
| --------------------- | ----- | ---- | ------- | ------ | ----- | ----- | ---- | --------- | ---- | ---- | ---- |
| Black `#000000`       | `01`  | `02` | `03`    | `04`   | `05`  | `06`  | `07` | `08`      | `09` | `0A` | `0B` |
| Dark Blue `#0000AA`   | `AB`  | `AC` | `AD`    | `AE`   | `AF`  | `B0`  | `B1` | `B2`      | `B3` | `B4` | `B5` |
| Dark Green `#00AA00`  | `01`  | `02` | `03`    | `04`   | `05`  | `06`  | `07` | `08`      | `09` | `0A` | `0B` |
| Dark Aqua `#00AAAA`   | `AB`  | `AC` | `AD`    | `AE`   | `AF`  | `B0`  | `B1` | `B2`      | `B3` | `B4` | `B5` |
| Dark Red `#AA0000`    | `01`  | `02` | `03`    | `04`   | `05`  | `06`  | `07` | `08`      | `09` | `0A` | `0B` |
| Dark Purple `#AA00AA` | `AB`  | `AC` | `AD`    | `AE`   | `AF`  | `B0`  | `B1` | `B2`      | `B3` | `B4` | `B5` |
| Gold `#FFAA00`        | `01`  | `02` | `03`    | `04`   | `05`  | `06`  | `07` | `08`      | `09` | `0A` | `0B` |
| Gray `#AAAAAA`        | `AB`  | `AC` | `AD`    | `AE`   | `AF`  | `B0`  | `B1` | `B2`      | `B3` | `B4` | `B5` |
| Dark Gray `#555555`   | `56`  | `57` | `58`    | `59`   | `5A`  | `5B`  | `5C` | `5D`      | `5E` | `5F` | `60` |
| Green `#55FF55`       | `56`  | `57` | `58`    | `59`   | `5A`  | `5B`  | `5C` | `5D`      | `5E` | `5F` | `60` |
| Red `#FF5555`         | `56`  | `57` | `58`    | `59`   | `5A`  | `5B`  | `5C` | `5D`      | `5E` | `5F` | `60` |
| Yellow `#FFFF55`      | `56`  | `57` | `58`    | `59`   | `5A`  | `5B`  | `5C` | `5D`      | `5E` | `5F` | `60` |

### High B Colors (-1 to -11)

| Color                  | Shake | Wavy | Rainbow | Bouncy | Blink | Pulse | Spin | DelaySpin | Fade | W+R  | B+R  |
| ---------------------- | ----- | ---- | ------- | ------ | ----- | ----- | ---- | --------- | ---- | ---- | ---- |
| Blue `#5555FF`         | `FE`  | `FD` | `FC`    | `FB`   | `FA`  | `F9`  | `F8` | `F7`      | `F6` | `F5` | `F4` |
| Aqua `#55FFFF`         | `FE`  | `FD` | `FC`    | `FB`   | `FA`  | `F9`  | `F8` | `F7`      | `F6` | `F5` | `F4` |
| Light Purple `#FF55FF` | `FE`  | `FD` | `FC`    | `FB`   | `FA`  | `F9`  | `F8` | `F7`      | `F6` | `F5` | `F4` |
| White `#FFFFFF`        | `FE`  | `FD` | `FC`    | `FB`   | `FA`  | `F9`  | `F8` | `F7`      | `F6` | `F5` | `F4` |

## Shadow Effects

Shadow effects are independent of text effects. Control them using the **Alpha** channel of the `shadow_color`.

### Quick Reference: Shadow Color (ARGB)

Use these hex values for `shadow_color` to apply effects to the shadow. Format: `0xAARRGGBB`

| Color              | Shake        | Wavy         | Rainbow      | Bouncy       | Pulse        | Spin         | Fade         |
| :----------------- | :----------- | :----------- | :----------- | :----------- | :----------- | :----------- | :----------- |
| Black `#000000`    | `0xFE000000` | `0xFD000000` | `0xFC000000` | `0xFB000000` | `0xF9000000` | `0xF8000000` | `0xF6000000` |
| D.Blue `#00002A`   | `0xFE00002A` | `0xFD00002A` | `0xFC00002A` | `0xFB00002A` | `0xF900002A` | `0xF800002A` | `0xF600002A` |
| D.Green `#002A00`  | `0xFE002A00` | `0xFD002A00` | `0xFC002A00` | `0xFB002A00` | `0xF9002A00` | `0xF8002A00` | `0xF6002A00` |
| D.Aqua `#002A2A`   | `0xFE002A2A` | `0xFD002A2A` | `0xFC002A2A` | `0xFB002A2A` | `0xF9002A2A` | `0xF8002A2A` | `0xF6002A2A` |
| D.Red `#2A0000`    | `0xFE2A0000` | `0xFD2A0000` | `0xFC2A0000` | `0xFB2A0000` | `0xF92A0000` | `0xF82A0000` | `0xF62A0000` |
| D.Purple `#2A002A` | `0xFE2A002A` | `0xFD2A002A` | `0xFC2A002A` | `0xFB2A002A` | `0xF92A002A` | `0xF82A002A` | `0xF62A002A` |
| Gold `#3F2A00`     | `0xFE3F2A00` | `0xFD3F2A00` | `0xFC3F2A00` | `0xFB3F2A00` | `0xF93F2A00` | `0xF83F2A00` | `0xF63F2A00` |
| Gray `#2A2A2A`     | `0xFE2A2A2A` | `0xFD2A2A2A` | `0xFC2A2A2A` | `0xFB2A2A2A` | `0xF92A2A2A` | `0xF82A2A2A` | `0xF62A2A2A` |
| D.Gray `#151515`   | `0xFE151515` | `0xFD151515` | `0xFC151515` | `0xFB151515` | `0xF9151515` | `0xF8151515` | `0xF6151515` |
| Green `#153F15`    | `0xFE153F15` | `0xFD153F15` | `0xFC153F15` | `0xFB153F15` | `0xF9153F15` | `0xF8153F15` | `0xF6153F15` |
| Red `#3F1515`      | `0xFE3F1515` | `0xFD3F1515` | `0xFC3F1515` | `0xFB3F1515` | `0xF93F1515` | `0xF83F1515` | `0xF63F1515` |
| Yellow `#3F3F15`   | `0xFE3F3F15` | `0xFD3F3F15` | `0xFC3F3F15` | `0xFB3F3F15` | `0xF93F3F15` | `0xF83F3F15` | `0xF63F3F15` |
| Blue `#15153F`     | `0xFE15153F` | `0xFD15153F` | `0xFC15153F` | `0xFB15153F` | `0xF915153F` | `0xF815153F` | `0xF615153F` |
| Aqua `#153F3F`     | `0xFE153F3F` | `0xFD153F3F` | `0xFC153F3F` | `0xFB153F3F` | `0xF9153F3F` | `0xF8153F3F` | `0xF6153F3F` |
| L.Purple `#3F153F` | `0xFE3F153F` | `0xFD3F153F` | `0xFC3F153F` | `0xFB3F153F` | `0xF93F153F` | `0xF83F153F` | `0xF63F153F` |
| White `#3F3F3F`    | `0xFE3F3F3F` | `0xFD3F3F3F` | `0xFC3F3F3F` | `0xFB3F3F3F` | `0xF93F3F3F` | `0xF83F3F3F` | `0xF63F3F3F` |

---

## Examples

#### Text Effect

Use color codes to trigger text effects.

```mcfunction
# Dark Red Text + Shake
/tellraw @a {"text":"Shaking Text","color":"#AA0001"}
```

#### Shadow Effect

Use `shadow_color` (ARGB) to trigger shadow effects. Shadow RGB should be ~25% of the base color.

```mcfunction
# White Text + Red Shaking Shadow
# Shadow Color: ARGB 0xFE3F0000 (Alpha FE=Shake, RGB 3F0000=25% Red)
/tellraw @a {"text":"Scary Shadow","color":"white","shadow_color":0xFE3F0000}

# Or use list format [R, G, B, A] (0.0~1.0):
/tellraw @a {"text":"Scary Shadow","color":"white","shadow_color":[0.25, 0.0, 0.0, 0.996]}
```

```mcfunction
# Gold Text (Wavy) + Blue Shadow (Spin)
# Text: Gold Wavy (#FFAA02)
# Shadow: Blue Spin (Alpha F8, RGB 00002A=25% Blue) -> 0xF800002A
/tellraw @a {"text":"Complex Effect","color":"#FFAA02","shadow_color":0xF800002A}
```

---

## Notes

- Effects apply to text only (unless Shadow Alpha is used)
- Main text transparency is not supported (Alpha used for logic)
- **Configuration**: Edit `assets/minecraft/shaders/include/config.glsl` to change speed, intensity, and wave frequency.

## License

This code is under MIT License

This project includes code from [Text-Effects-by-Akis](https://github.com/YeahAkis/Text-Effects-by-Akis).
