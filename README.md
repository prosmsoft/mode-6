# Mode 6
Pseudo-3D floor renderer for the ZX Spectrum (adaptable to other Z80-based systems)

## How to use within your own program
The rendering routine is stored in render.asm, and contains most of the data, equates and variable definitions necessary. multab.asm and edgetab.asm must also be included for the renderer to work - their contents are not included in render.asm because they need to be aligned to a 256-byte boundary, thus they are separate so that you may organise them within your memory map in a way that wastes as little space as possible. You will have to define a buffer in memory to hold the rendered image. With the standard 40 line setting, a buffer of 1280 bytes is required. In addition, player coordinates must be provided in 16-bit variables named m6_player_x and m6_player_y.

For speed, the starting addresses of certain data are required to be aligned to powers of 2. Below is a list of such data and the multiples their addresses must be aligned to. All other data may be placed at any address.
- m6_multab: address must be **multiple of 256**
- m6_edgetab: address must be **multiple of 256**
- m6_tiledata: address must be **multiple of 256**
- m6_map: address must be **multiple of 256**
- m6_gfxbuffer: address must be **multiple of 32**

You will also need to provide your own tile set and map data (see "Providing your own tile set"). The source code for a C utility to rearrange a ZX-Paint CHR file into a Mode 6 tile set is included. By default, the map data must have the dimensions 64x32, and can only use tile indices between 0-31 (this can of course be altered by rewriting sections of the code).

A sample program (main.asm) is included to demonstrate how to use the Mode 6 renderer within your own programs.

## Providing your own tile set

The tile set provides the patterns which are used to fill in the rendered tiles of your Mode 6 3D environment. It occupies 1024 bytes of memory, and consists of 32 8x4 1bpp textures, each of which has 8 frames of animation. To access a given byte of texture, the address must be calculated as follows:
```
yynnnnnaaa
||||||||||
|||||||+++-- Animation frame (0-7)
||+++++----- Tile ID (0-31)
++---------- Y coordinate (0-3)
```
The included C utility converts a ZX-Paint CHR file (of 2048 bytes in length) to a Mode 6 tile set. The CHR file must be laid out as 2 rows of 16 columns, each column containing the 8 frames of animation at 2x vertical scale (i.e. the 8x4 texture is shown and stored as 8x8). Note that using this conversion utility produces a tile set which appears upside-down when rendered. To fix this, you can either invert your tile set manually, or modify the utility to do it for you. Of course, you may wish to write your own conversion utility if you are working with a different image format.

## Quirks
Garbage data may be displayed if the left edge of the map becomes visible. This is because the core rendition loop does not check for wraparound of the map pointer, hence it can run off into data that is not part of the map. This glitch can be mitigated by hardcoding limits to the camera movement, or by adding your own code to fix the bug (bearing in mind that this may slow down the rendering due to the extra checks involved).

Tile indices are retrieved from the map as-is by the core rendition loop; no masking is performed to clip them to the 0-31 range. This can either be a hindrance or a neat effect - the upper 3 bits essentially act as an offset for that particular tile's animation cycle. You might use this to add a few touches of detail to your environment. However, if you want to use the upper 3 bits for data, then you will either have to put up with the animation offset effect (which may not be desirable), or you will have to add the masking code in yourself (which will add a slight processing overhead for every unique run of tiles).

## How does it work?
You can read a write-up of the renderer on my website: https://www.connosoft.com/articles/mode6/mode6.html
