# Held Indicators for BeamNG.drive

A tiny BeamNG.drive mod for **latching indicator stalks**, such as Moza's: stalks that hold their button down for as
long as the indicator is on and release it when the indicator is cancelled.

BeamNG's own "Toggle left/right turn signal" controls flip the indicator each time the button is pressed. With a
latching stalk, that means signalling turns it on and cancelling does nothing, so you have to flick the stalk again
to turn it off.

This mod adds two controls that follow the button instead:

| Control | Button pressed | Button released |
| --- | --- | --- |
| **Left signal (held)** | Left indicator on | Left indicator off |
| **Right signal (held)** | Right indicator on | Right indicator off |

They use the game's own `electrics.set_left_signal` / `set_right_signal`, so the dash lights and indicator sounds
work as usual. The game's auto-cancel is left off for these, so the indicator never turns off while your stalk is
still on. It changes nothing on the wheel or in its software (Moza Pit House etc.); it's only an input binding.

## Install

1. Download `held_indicators.zip` from the [latest release](../../releases/latest).
2. Put the zip, as it is, into BeamNG's mods folder:
   `%LOCALAPPDATA%\BeamNG\BeamNG.drive\current\mods` (or the user folder you've set in the launcher, then `current\mods`).
3. Start the game and check it's enabled under **Mods** → **My mods**.

## Bind the stalk

In **Options** → **Controls** → **Bindings** → **Vehicle**:

1. Remove the stalk from **Toggle left turn signal** and **Toggle right turn signal**. If they stay bound, the
   stock toggle fights the held controls.
2. Bind the left stalk position to **Left signal (held)** and the right stalk position to **Right signal (held)**.

Hazards are unchanged; keep using **Toggle hazard signal**.

## Building a release

The mod is the `mod` folder, zipped with its contents at the root of the zip.

- Locally: `pwsh scripts/package.ps1` writes `dist/held_indicators.zip`.
- On GitHub: pushing a tag like `v1.0.0` runs `.github/workflows/release.yml`, which zips the mod and publishes it
  as a release.

## License

MIT, see [LICENSE](LICENSE).
