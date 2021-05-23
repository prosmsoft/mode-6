/* TileOrder - converts .CHR files to Mode 6 tile sets.
Apologies for the poor quality - this was a quick bodge */

#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[])
{
    if (argc != 3)
    {
        printf("Usage: tileorder input output\n");
        printf("Input must be .CHR file (2048 bytes)\n");
        exit(1);
    }

    char *chrbuffer, *outbuffer;
    chrbuffer = malloc(2048);
    if (!chrbuffer)
    {
        printf("No memory for CHR buffer!\n");
        exit(1);
    }

    outbuffer = malloc(1024);
    if (!outbuffer)
    {
        printf("No memory for output buffer!\n");
        exit(1);
    }

    FILE *chrfile, *outfile;
    chrfile = fopen(argv[1], "rb");
    if (!chrfile)
    {
        printf("Could not open %s for reading!\n", argv[1]);
        exit(1);
    }

    outfile = fopen(argv[2], "wb");
    if (!outfile)
    {
        printf("Could not open %s for writing!\n", argv[2]);
        exit(1);
    }

    if (fread(chrbuffer, 1, 2048, chrfile) != 2048)
    {
        printf("Could not read 2048 bytes from %s!\n", argv[1]);
        exit(1);
    }

    for (int chr = 0; chr < 32; chr++)
    {
        for (int frame = 0; frame < 8; frame++)
        {
            for (int row = 0; row < 4; row++)
            {
                *(outbuffer+chr+(row*256)+(frame*32)) = *(chrbuffer+((chr%16)*8)+((chr/16)*1024)+(frame*128)+(row*2));
            }
        }
    }

    fwrite(outbuffer, 1024, 1, outfile);
    printf("Tile data written to %s\n", argv[2]);
    fflush(outfile);
    fclose(outfile);
    fclose(chrfile);

    free(chrbuffer);
    free(outbuffer);
}
