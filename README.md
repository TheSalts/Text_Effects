# TheSalt's Text Effects

## How It Works

Use Minecraft default colors with a **B value offset** to trigger effects.

- **R, G**: Base Minecraft color
- **B + offset**: Effect trigger (Text Only)
- **Shadow Alpha**: Effect trigger (Shadow Only)

---

## Effect List

| Offset | Effect         | Description                  |
| ------ | -------------- | ---------------------------- |
| +1     | Shake          | Random shaking               |
| +2     | Wavy           | Wave animation               |
| +3     | Rainbow        | Rainbow cycle (no shadow)    |
| +4     | Bouncy         | Bounce animation             |
| +5     | Blinking       | Blink on/off                 |
| +6     | Pulse          | Grow/Shrink animation        |
| +7     | Spin           | Rotation                     |
| +8     | Delayed Spin   | Spin then wait then spin     |
| +9     | Fade           | Fade in/out                  |
| +10    | Typing         | Typewriter                   |
| +11    | Wavy+Rainbow   | Wave + rainbow (no shadow)   |
| +12    | Bouncy+Rainbow | Bounce + rainbow (no shadow) |

---

## Quick Reference

### Low B Colors (+1 to +12)

| Color                 | Shake | Wavy | Rainbow | Bouncy | Blink | Pulse | Spin | DelaySpin | Fade | Typing |
| --------------------- | ----- | ---- | ------- | ------ | ----- | ----- | ---- | --------- | ---- | ------ |
| Black `#000000`       | `01`  | `02` | `03`    | `04`   | `05`  | `06`  | `07` | `08`      | `09` | `0A`   |
| Dark Blue `#0000AA`   | `AB`  | `AC` | `AD`    | `AE`   | `AF`  | `B0`  | `B1` | `B2`      | `B3` | `B4`   |
| Dark Green `#00AA00`  | `01`  | `02` | `03`    | `04`   | `05`  | `06`  | `07` | `08`      | `09` | `0A`   |
| Dark Aqua `#00AAAA`   | `AB`  | `AC` | `AD`    | `AE`   | `AF`  | `B0`  | `B1` | `B2`      | `B3` | `B4`   |
| Dark Red `#AA0000`    | `01`  | `02` | `03`    | `04`   | `05`  | `06`  | `07` | `08`      | `09` | `0A`   |
| Dark Purple `#AA00AA` | `AB`  | `AC` | `AD`    | `AE`   | `AF`  | `B0`  | `B1` | `B2`      | `B3` | `B4`   |
| Gold `#FFAA00`        | `01`  | `02` | `03`    | `04`   | `05`  | `06`  | `07` | `08`      | `09` | `0A`   |
| Gray `#AAAAAA`        | `AB`  | `AC` | `AD`    | `AE`   | `AF`  | `B0`  | `B1` | `B2`      | `B3` | `B4`   |
| Dark Gray `#555555`   | `56`  | `57` | `58`    | `59`   | `5A`  | `5B`  | `5C` | `5D`      | `5E` | `5F`   |
| Green `#55FF55`       | `56`  | `57` | `58`    | `59`   | `5A`  | `5B`  | `5C` | `5D`      | `5E` | `5F`   |
| Red `#FF5555`         | `56`  | `57` | `58`    | `59`   | `5A`  | `5B`  | `5C` | `5D`      | `5E` | `5F`   |
| Yellow `#FFFF55`      | `56`  | `57` | `58`    | `59`   | `5A`  | `5B`  | `5C` | `5D`      | `5E` | `5F`   |

### High B Colors (-1 to -12)

| Color                  | Shake | Wavy | Rainbow | Bouncy | Blink | Pulse | Spin | DelaySpin | Fade | Typing |
| ---------------------- | ----- | ---- | ------- | ------ | ----- | ----- | ---- | --------- | ---- | ------ |
| Blue `#5555FF`         | `FE`  | `FD` | `FC`    | `FB`   | `FA`  | `F9`  | `F8` | `F7`      | `F6` | `F5`   |
| Aqua `#55FFFF`         | `FE`  | `FD` | `FC`    | `FB`   | `FA`  | `F9`  | `F8` | `F7`      | `F6` | `F5`   |
| Light Purple `#FF55FF` | `FE`  | `FD` | `FC`    | `FB`   | `FA`  | `F9`  | `F8` | `F7`      | `F6` | `F5`   |
| White `#FFFFFF`        | `FE`  | `FD` | `FC`    | `FB`   | `FA`  | `F9`  | `F8` | `F7`      | `F6` | `F5`   |

## Shadow Effects

Shadow effects are independent of text effects. Control them using the **Alpha** channel of the `shadow_color`.

### Quick Reference: Shadow Color (ARGB)

Use these hex values for `shadow_color` to apply effects to the shadow.

| Color              | Shake `0xFE` | Wavy `0xFD`  | Rainbow `0xFC` | Bouncy `0xFB` | Pulse `0xF9` | Spin `0xF8`  | Fade `0xF6`  | Typing `0xF5` |
| :----------------- | :----------- | :----------- | :------------- | :------------ | :----------- | :----------- | :----------- | :------------ |
| Black `#000000`    | `0xFE000000` | `0xFD000000` | `0xFC000000`   | `0xFB000000`  | `0xF9000000` | `0xF8000000` | `0xF6000000` | `0xF5000000`  |
| D.Blue `#0000AA`   | `0xFE0000AA` | `0xFD0000AA` | `0xFC0000AA`   | `0xFB0000AA`  | `0xF90000AA` | `0xF80000AA` | `0xF60000AA` | `0xF50000AA`  |
| D.Green `#00AA00`  | `0xFE00AA00` | `0xFD00AA00` | `0xFC00AA00`   | `0xFB00AA00`  | `0xF900AA00` | `0xF800AA00` | `0xF600AA00` | `0xF500AA00`  |
| D.Aqua `#00AAAA`   | `0xFE00AAAA` | `0xFD00AAAA` | `0xFC00AAAA`   | `0xFB00AAAA`  | `0xF900AAAA` | `0xF800AAAA` | `0xF600AAAA` | `0xF500AAAA`  |
| D.Red `#AA0000`    | `0xFEAA0000` | `0xFDAA0000` | `0xFCAA0000`   | `0xFBAA0000`  | `0xF9AA0000` | `0xF8AA0000` | `0xF6AA0000` | `0xF5AA0000`  |
| D.Purple `#AA00AA` | `0xFEAA00AA` | `0xFDAA00AA` | `0xFCAA00AA`   | `0xFBAA00AA`  | `0xF9AA00AA` | `0xF8AA00AA` | `0xF6AA00AA` | `0xF5AA00AA`  |
| Gold `#FFAA00`     | `0xFEFFAA00` | `0xFDFFAA00` | `0xFCFFAA00`   | `0xFBFFAA00`  | `0xF9FFAA00` | `0xF8FFAA00` | `0xF6FFAA00` | `0xF5FFAA00`  |
| Gray `#AAAAAA`     | `0xFEAAAAAA` | `0xFDAAAAAA` | `0xFCAAAAAA`   | `0xFBAAAAAA`  | `0xF9AAAAAA` | `0xF8AAAAAA` | `0xF6AAAAAA` | `0xF5AAAAAA`  |
| D.Gray `#555555`   | `0xFE555555` | `0xFD555555` | `0xFC555555`   | `0xFB555555`  | `0xF9555555` | `0xF8555555` | `0xF6555555` | `0xF5555555`  |
| Green `#55FF55`    | `0xFE55FF55` | `0xFD55FF55` | `0xFC55FF55`   | `0xFB55FF55`  | `0xF955FF55` | `0xF855FF55` | `0xF655FF55` | `0xF555FF55`  |
| Red `#FF5555`      | `0xFEFF5555` | `0xFDFF5555` | `0xFCFF5555`   | `0xFBFF5555`  | `0xF9FF5555` | `0xF8FF5555` | `0xF6FF5555` | `0xF5FF5555`  |
| Yellow `#FFFF55`   | `0xFEFFFF55` | `0xFDFFFF55` | `0xFCFFFF55`   | `0xFBFFFF55`  | `0xF9FFFF55` | `0xF8FFFF55` | `0xF6FFFF55` | `0xF5FFFF55`  |
| Blue `#5555FF`     | `0xFE5555FF` | `0xFD5555FF` | `0xFC5555FF`   | `0xFB5555FF`  | `0xF95555FF` | `0xF85555FF` | `0xF65555FF` | `0xF55555FF`  |
| Aqua `#55FFFF`     | `0xFE55FFFF` | `0xFD55FFFF` | `0xFC55FFFF`   | `0xFB55FFFF`  | `0xF955FFFF` | `0xF855FFFF` | `0xF655FFFF` | `0xF555FFFF`  |
| L.Purple `#FF55FF` | `0xFEFF55FF` | `0xFDFF55FF` | `0xFCFF55FF`   | `0xFBFF55FF`  | `0xF9FF55FF` | `0xF8FF55FF` | `0xF6FF55FF` | `0xF5FF55FF`  |
| White `#FFFFFF`    | `0xFEFFFFFF` | `0xFDFFFFFF` | `0xFCFFFFFF`   | `0xFBFFFFFF`  | `0xF9FFFFFF` | `0xF8FFFFFF` | `0xF6FFFFFF` | `0xF5FFFFFF`  |

---

## Examples

#### Text Effect

Use color codes to trigger text effects.

```mcfunction
# Dark Red Text + Shake
/tellraw @a {"text":"Shaking Text","color":"#AA0001"}
```

#### Shadow Effect

Use `shadow_color` (ARGB) to trigger shadow effects.

```mcfunction
# White Text + Red Shaking Shadow
# Shadow Color: ARGB 0xFEFF0000 (Alpha FE=Shake, RGB FF0000=Red)
/tellraw @a {"text":"Scary Shadow","color":"white","shadow_color":-16842752}
# Note: JSON sometimes requires signed integer. 0xFEFF0000 = -16842752
# Or use list format:
/tellraw @a {"text":"Scary Shadow","color":"white","shadow_color":[1.0, 0.0, 0.0, 0.996]}
```

```mcfunction
# Gold Text (Wavy) + Blue Shadow (Spin)
# Text: Gold Wavy (#FFAA02)
# Shadow: Blue Spin (Alpha F8, RGB 0000AA) -> 0xF80000AA
/tellraw @a {"text":"Complex Effect","color":"#FFAA02","shadow_color":-134217558}
```

---

## Notes

- Effects apply to text only (unless Shadow Alpha is used)
- Main text transparency is not supported (Alpha used for logic)
- **Configuration**: Edit `assets/minecraft/shaders/include/config.glsl` to change speed, intensity, and wave frequency.

## License

This Code is under MIT License
