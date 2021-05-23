; Mode 6 pseudo-3D floor renderer
; Sample program, for use with 48K Spectrum and compatibles
; Assemble with PASMO:  pasmo --tapbas _example.asm _example.tap

org $8000
include 'multab.asm'

m6_tiledata:
	incbin 'tiledata.bin'

include 'edgetab.asm'

if (($%32 != 0))
	org (($/32)*32)+32				; Align to a 32 byte boundary
endif

m6_gfxbuffer:
	ds 1280

m6_map:
	incbin 'map.bin'

c_start:
; First, set up interrupt vector and stack pointers
	ld sp,$ffff
	ld hl,$4000
	ld de,$4001
	ld bc,$17ff
	ld (hl),l
	ldir

c_loop:
	ld hl,(m6_player_x)
	ld de,-3
	add hl,de
	ld (m6_player_x),hl

	ld hl,(m6_player_y)
	add hl,de
	ld (m6_player_y),hl

	di
	call m6_render					; Draw the scene into the graphics buffer
	ei
	ld iy,$5c3a					; Restore IY register destroyed by renderer

	call m6_buffercopy
	ld iy,$5c3a
	
	jr c_loop


include 'render.asm'
include 'buffercopy.asm'

m6_player_x:	dw 4096
m6_player_y:	dw 4099

end c_start
