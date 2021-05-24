# Mode 6
Pseudo-3D floor renderer for the ZX Spectrum (adaptable to other Z80-based systems)

## How to use within your own program
The rendering routine is stored in render.asm, and contains most of the data, equates and variable definitions necessary. multab.asm and edgetab.asm must also be included for the renderer to work - their contents are not included in render.asm because they need to be aligned to a 256-byte boundary, so they are separate so that you may organise them within your memory map in a way that wastes as little space as possible. You will have to define a buffer in memory to hold the rendered image. With the standard 40 line setting, a buffer of 1280 bytes is required, aligned to a 32-byte boundary. In addition, player coordinates must be provided in 16-bit variables named m6_player_x and m6_player_y.

You will also need to provide your own tile set and map data. The source code for a C utility to rearrange a ZX-Paint CHR file into a Mode 6 tile set is included. By default, the map data must have the dimensions 64x32, and can only use tile indexes between 0-31 (this can of course be altered by rewriting sections of the code). The tile set and map data must also be aligned to a 256-byte boundary.

A sample program (main.asm) is included to demonstrate how to use the Mode 6 renderer within your own programs.

## Quirks
Garbage data may be displayed if the left edge of the map becomes visible. This is because the core rendition loop does not check for wraparound of the map pointer, hence it can run off into data that is not part of the map. This glitch can be mitigated by hardcoding limits to the camera movement, or by adding your own code to fix the bug (bearing in mind that this may slow down the rendering due to the extra checks involved).

## How does it work?
You can read a write-up of the renderer on my website: https://www.connosoft.com/articles/mode6/mode6.html
