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
| D.Blue `#0000AA`   | `0xFE0000AA` | `0xFD0000AA` | `0xFC0000AA` | `0xFB0000AA` | `0xF90000AA` | `0xF80000AA` | `0xF60000AA` |
| D.Green `#00AA00`  | `0xFE00AA00` | `0xFD00AA00` | `0xFC00AA00` | `0xFB00AA00` | `0xF900AA00` | `0xF800AA00` | `0xF600AA00` |
| D.Aqua `#00AAAA`   | `0xFE00AAAA` | `0xFD00AAAA` | `0xFC00AAAA` | `0xFB00AAAA` | `0xF900AAAA` | `0xF800AAAA` | `0xF600AAAA` |
| D.Red `#AA0000`    | `0xFEAA0000` | `0xFDAA0000` | `0xFCAA0000` | `0xFBAA0000` | `0xF9AA0000` | `0xF8AA0000` | `0xF6AA0000` |
| D.Purple `#AA00AA` | `0xFEAA00AA` | `0xFDAA00AA` | `0xFCAA00AA` | `0xFBAA00AA` | `0xF9AA00AA` | `0xF8AA00AA` | `0xF6AA00AA` |
| Gold `#FFAA00`     | `0xFEFFAA00` | `0xFDFFAA00` | `0xFCFFAA00` | `0xFBFFAA00` | `0xF9FFAA00` | `0xF8FFAA00` | `0xF6FFAA00` |
| Gray `#AAAAAA`     | `0xFEAAAAAA` | `0xFDAAAAAA` | `0xFCAAAAAA` | `0xFBAAAAAA` | `0xF9AAAAAA` | `0xF8AAAAAA` | `0xF6AAAAAA` |
| D.Gray `#555555`   | `0xFE555555` | `0xFD555555` | `0xFC555555` | `0xFB555555` | `0xF9555555` | `0xF8555555` | `0xF6555555` |
| Green `#55FF55`    | `0xFE55FF55` | `0xFD55FF55` | `0xFC55FF55` | `0xFB55FF55` | `0xF955FF55` | `0xF855FF55` | `0xF655FF55` |
| Red `#FF5555`      | `0xFEFF5555` | `0xFDFF5555` | `0xFCFF5555` | `0xFBFF5555` | `0xF9FF5555` | `0xF8FF5555` | `0xF6FF5555` |
| Yellow `#FFFF55`   | `0xFEFFFF55` | `0xFDFFFF55` | `0xFCFFFF55` | `0xFBFFFF55` | `0xF9FFFF55` | `0xF8FFFF55` | `0xF6FFFF55` |
| Blue `#5555FF`     | `0xFE5555FF` | `0xFD5555FF` | `0xFC5555FF` | `0xFB5555FF` | `0xF95555FF` | `0xF85555FF` | `0xF65555FF` |
| Aqua `#55FFFF`     | `0xFE55FFFF` | `0xFD55FFFF` | `0xFC55FFFF` | `0xFB55FFFF` | `0xF955FFFF` | `0xF855FFFF` | `0xF655FFFF` |
| L.Purple `#FF55FF` | `0xFEFF55FF` | `0xFDFF55FF` | `0xFCFF55FF` | `0xFBFF55FF` | `0xF9FF55FF` | `0xF8FF55FF` | `0xF6FF55FF` |
| White `#FFFFFF`    | `0xFEFFFFFF` | `0xFDFFFFFF` | `0xFCFFFFFF` | `0xFBFFFFFF` | `0xF9FFFFFF` | `0xF8FFFFFF` | `0xF6FFFFFF` |

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
