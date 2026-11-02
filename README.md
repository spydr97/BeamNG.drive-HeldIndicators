# Stalk Bindings for BeamNG.drive

A small BeamNG.drive mod for **multi-function stalks**, made with the MOZA Multi-function Stalks in mind. It makes the
indicators, lights and cruise control follow the stalk the way they would in a real car.

It changes nothing on the wheel or in its software (MOZA Pit House etc.). It only adds controls to bind in the game.

## Why

BeamNG's own controls assume buttons that spring back. The MOZA indicator stalk latches instead: its button stays
pressed for as long as the indicator is on and is released when you cancel it. With the game's "Toggle left turn
signal", signalling turns the indicator on and cancelling does nothing, so you have to flick the stalk again.

## What it adds

Everything is under **Options** → **Controls** → **Bindings** → **Vehicle**, named **Stalk: ...**

**Indicators**

| Control | Does |
| --- | --- |
| Left signal (held) / Right signal (held) | On while the button is held, off when it's released. A quick flick (back within 0.6 s) is a lane change: 3 flashes, then off. |
| Signal cancel | The stalk's middle position, if yours presses a button there: stops the indicator. |

**Lights.** The light switch and the high beam stalk are kept apart, as on a real car: the high beam only lights while
the lights are on, and a flash lights it whatever the switch says.

| Control | Does |
| --- | --- |
| Lights off / Lights on / Lights toggle | The light switch. |
| High beam (held) | High beam while the button is held. |
| High beam on / High beam off | For stalks that press one button pushed forward and another coming back. |
| High beam toggle | For stalks that press a button each way. |
| High beam flash | High beam while held. On the MOZA stalk this is already bound to BTN5 (see below). |
| Fog lights (held) / Fog lights toggle | The fog lights. |

**Cruise control**

| Control | Does |
| --- | --- |
| Cruise on / off | Holds the current speed (above 30 km/h), or switches cruise off and forgets the set speed. |
| Cruise resume / + | Not engaged: goes back to the set speed (or holds the current one if none is set). Engaged: a tap adds 1 km/h (1 mph with imperial units), and holding steps on to the next 5. |
| Cruise set / - | Not engaged: holds the current speed. Engaged: a tap takes off 1, and holding steps down to the next 5. |
| Cruise cancel | Pauses cruise control and keeps the set speed for resume. Braking does the same. |

Hazards are unchanged. Keep using the game's **Toggle hazard signal**.

## Install

1. Download `stalk_bindings.zip` from the [latest release](../../releases/latest).
2. Put the zip, as it is, into BeamNG's mods folder:
   `%LOCALAPPDATA%\BeamNG\BeamNG.drive\current\mods` (or `current\mods` in the user folder you've set in the launcher).
3. Start the game and check it's enabled under **Mods** → **My mods**.

## Binding a MOZA Multi-function Stalk

In MOZA Pit House, set the stalks' connection mode to **Direct Connection**, so they show up in the game as their own
device with a button for each position. Then bind the controls you want. This layout is a good place to start:

| Stalk | Button | Control |
| --- | --- | --- |
| Indicator left | BTN9 | Left signal (held) |
| Indicator middle | BTN8 | Signal cancel |
| Indicator right | BTN7 | Right signal (held) |
| Light switch off | BTN0 | Lights off |
| Light switch on | BTN1 | Lights on |
| High beam | BTN2, BTN3 | High beam toggle |
| Flash | BTN5 | High beam flash (already bound) |
| Fog | BTN6 | Fog lights toggle |
| Cruise on / off | BTN24 | Cruise on / off |
| Cruise down | BTN25 | Cruise set / - |
| Cruise up | BTN26 | Cruise resume / + |
| Cruise cancel | BTN27 | Cruise cancel |

Remove anything else bound to those buttons first, such as the game's **Toggle left turn signal**, or the two will
fight each other.

### Why the flash is already bound

Pulling the flash sends BTN5 down, then BTN4 down, then BTN5 up. The game's binding screen only accepts a button when
its press and release arrive one right after the other, so it never picks up BTN5. The mod ships a default binding of
BTN5 to **High beam flash** for the MOZA Multi-function Stalk (`settings/inputmaps/0024346e_stalkBindings.json`). You
can remove it in Controls like any other default.

## Building a release

The mod is the `mod` folder, zipped with its contents at the root of the zip.

- Locally: `pwsh scripts/package.ps1` writes `dist/stalk_bindings.zip`.
- On GitHub: pushing a tag like `v1.0.0` runs `.github/workflows/release.yml`, which zips the mod and publishes it
  as a release.

## Credits

The feature set follows ACM's [Advanced Bindings for MOZA Multi-function Stalks](https://www.beamng.com/resources/advanced-bindings-for-moza-multi-function-stalks.39034/).
This is a separate implementation.

## License

MIT, see [LICENSE](LICENSE).
