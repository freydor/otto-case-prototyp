 
# OTTO Prototyp
*This is a work-in-progress*
This Repository contains a 3D-printable model for an OTTO Synthesizer.
The design is still in development!


The files can be viewed with OpenSCAD.
The case is spilt in multiple parts so they can be reused.

## Hardware

The table below shows the parts used in this OTTO Prototyp

| Part             | Model                 | Quantity | Price | Link |
| PCB              |                       |        5 |       |      |
| Button           | 12x12mm               |  24 + 18 |       |      |
| Button caps      | 10x10mm               |       42 |       |      |
| Rotary encoder   |                       |  4 + (2) |       |      |
| Wire             |                       |          |       |      |
| Header           | 2.54mm Connector male |          |       |      |
| Raspberry Pi     |                       |          |       |      |
| I²S Codec        | PCM5102               |        1 |       |      |
| Screw            | M3                    |       30 |       |      |
| Nut              | M3                    |       30 |       |      |
| Battery          | 18650                 |      1-4 |       |      |
| Microcontroller  | STM32F4               |        1 |       |      |
| IO Port extender | MCP23017              |      0-3 |       |      |
| Screen           |                       |          |       |      |


Some of the Links contain more parts the needed for this project and depending on how you want to build it some won't be needed at all.

### Keyboard matrix

The STM32F4 has enough GPIOs to connect all buttons directly.
If you want to use a other µC like an Arduino Nano you can either build a keymatrix or use some MCP23017 to get more GPIOs.
Each button needs one GPIO and each encoder 3 which are together 60 Pins.

## 3D parts

There are a few parts that can be reused.
The Layout of buttons is based on standard prototyp PCBs which are available cheaply on ebay or aliexpress.
In the file buttons.scad there some predefined layouts for some common PCB sizes.

After placing the buttons on a PCB it should fit in the printed part.
The boards can be screwed to the case.
If something breaks you can un-screw and replace/fix it.

There is a cut-out for the Raspberry Pi 3 in the bottom of the case.

## Renders and pictures






