; ==================================================================================================
; === RENDER CURRENT VIEW
; ==================================================================================================

m6_render:
; This routine draws the 3D view of the map into the viewport buffer. It takes around 1.5 - 2 frames
; to execute. Interrupts can be left enabled, UNLESS the CPU is in interrupt mode 1, in which case
; interrupts must be disabled, since this routine uses the IY register.
; Handle animation offset
	ld a,(m6_render_core_tile_smc+1)
	add a,$20					; Advance to next frame of tileset
	ld (m6_render_core_tile_smc+1),a

; Initialise rendering variables
	ld hl,m6_render_iseg
	ld (m6_render_width),hl				; Store initial segment width

	ld hl,(m6_player_x)				; Get X coord of player
	ld de,m6_render_ox
	add hl,de					; Add left side offset
	ld (m6_render_x),hl				; Store rendering X value

	ld c,h						; Make copy of MSB for map pointer calc.

	ld hl,(m6_player_y)				; Get Y coord of player
	ld de,m6_render_oy
	add hl,de					; Add offset for bottom of screen
	ld (m6_render_y),hl				; Store rendering Y value

	ld a,13
	ld (m6_render_dy),a				; Store initial delta Y value

	ld iyh,m6_edgetab/256				; Set high byte of edge table pointer

	xor a
	ld (m6_render_row),a				; Initialise loop counter

; Calculate map pointer
	ld l,a
	ld a,h						; Retrieve Y value
	and 31
	ld h,a
	rr h
	rr l
	rr h
	rr l

	ld a,c						; Retrieve X value
	and 63						; Limit to acceptable range (0-63)
	add a,l
	ld l,a

	ld a,m6_map/256
	add a,h
	ld h,a
	ld (m6_render_map),hl

	exx
	ld hl,m6_gfxbuffer-1
	exx

m6_render_newline:
; We have reached a new line, so let's set up the registers for the next loop
	ld a,(m6_render_row)
	inc a						; Increment loop counter
	cp 41						; All rows rendered?
	ret nc						; ...then exit the renderer
	ld (m6_render_row),a

	ld l,a						; Make copy of row number
	ld a,(m6_render_dy)				; Get delta Y

	inc a						; Increment delta Y
	ld (m6_render_dy),a				; Store new delta Y in memory

m6_render_newline_l1:
; Keep delta Y in the shadow accumulator for now
	ex af,af'
	ld a,l
	exx						; LINE SET =================================
	push hl						; Save buffer address

; Now calculate graphics page
	ld l,a
	and 3
	add a,m6_tiledata/256
	ld ixh,a					; Calculate page for this line of graphics

; Add offset for the delta table
	ld a,l
	add a,0+(m6_centretab-1)%256
	ld l,a
	adc a,0+(m6_centretab-1)/256
	sub l
	ld h,a						; Form address to centre table

	ld e,(hl)					; Get delta from memory
	ld d,0						; Extend to 16-bit (could've optimised by
							; using 8 to 16 trick a few lines above)
	ld hl,(m6_render_x)
	ld a,h						; For later comparison
	add hl,de					; Add delta
	ld (m6_render_x),hl
	cp h						; Change?
	call nz,m6_render_map_left			; Adjust map pointer if so

; Now let's process our Y coord using our delta Y from the shadow accumulator
	ex af,af'

	ld hl,(m6_render_y)
	add a,l
	ld l,a
	call c,m6_render_map_up				; Adjust map pointer on overflow to MSB
	ld (m6_render_y),a				; Store LSB

; Prepare the line set
	pop hl						; Restore buffer address
	inc hl						; Move up a line
	ld (hl),d					; Zero out left-hand column
	ld de,$02ff

	exx						; MAP SET ==================================

; Now retrieve width
	ld hl,(m6_render_width)
	ld de,m6_render_dw
	add hl,de
	ex de,hl
	ld (m6_render_width),de

; Multiply the high byte of the width by the fractional component of X using the quarter-square
; multiplication technique. This routine has been adapted from an article in issue 92 of the
; "MSX Computer and Club Webmagazine"
	push de						; Make a copy of width
	ld a,(m6_render_x)				; Load LSB of camera position
	srl a
	srl a						; Truncate to 6 bits

	ld e,a						; Get inverted fractional part
	sub d						; Work out (a-b)

	ld h,m6_multab/256
	ld l,a						; Form address to quarter-square table
	ld c,(hl)
	inc h
	ld b,(hl)					; Load ((a-b)^2)/4 into BC

	ld a,e
	add a,d						; Work out (a+b)

	ld l,a
	ld e,(hl)
	dec h
	ld l,(hl)
	ld h,e						; Load ((a+b)^2)/4 into HL

; N.B. Ordinarily, OR A would be required to prevent a carry flag mishap. However, the carry was
; reset by the DEC H instruction a few lines ago
	sbc hl,bc					; Result = ((a+b)^2)/4 - ((a-b)^2)/4
	add hl,hl
	add hl,hl					; Scale back up to account for truncation

; Now add an extra bit of accuracy
	pop de						; Restore segment width
	ld a,(m6_render_x)
	bit 1,a
	jr z,m6_render_newline_l2

	ld a,l
	add a,d
	ld l,a
	adc a,h
	sub l
	ld h,a

m6_render_newline_l2:
; Initialise the other registers
	ld bc,(m6_render_map)				; Get current map address
	ld a,(bc)					; Get tile
	dec c						; Move to next tile - first tile guraranteed
							; to be a match
	ld (m6_render_core_comparison_smc+1),a		; Set current run for first tile of row

; Now prepare the map set. We must calculate the partial width

m6_render_core:
; This is the core rendering loop. Here, we keep checking map tiles until we hit a different tile.
; Then, we draw the segment representing that run of map tiles.
	ld a,(bc)					; Get map byte

m6_render_core_comparison_smc:
	cp 0						; Current byte? (self-modifying code)
	jr nz,m6_render_core_l2				; Exit loop if not

m6_render_core_l1:
; Bytes match, so add width to right edge.
	dec c						; Advance map pointer
	add hl,de					; Add width to segment
	jp nc,m6_render_core				; Jump back if no overflow

; The edge counter has overflowed, so we must have hit the end of this row. We need
; to draw the last segment, and then we can move up a row.
	ld h,255					; Clip right edge to screen boundary

m6_render_core_l2:
; Now we must get the pattern byte and draw the segment in question
	ld a,(m6_render_core_comparison_smc+1)	; Get run

m6_render_core_tile_smc:
	add a,0						; Add animation index (self-modifying code)
	ld ixl,a					; Store in IXL
	ld a,h						; Copy right edge to A
	exx						; LINE SET =================================

	ld c,a
	and 7						; Keep bit-wise position
	ld iyl,a					; Form address to edge table

	ld a,c
	rrca
	rrca
	rrca
	and 31						; Keep byte-wise portion
	ld b,a
	inc b						; This will set the carry flag for lines
	inc b						; with no run of bytes in the middle

	sub d						; Subtract left edge
	ld d,b						; Copy new edge to left edge
	jp c,m6_render_core_edge			; Jump ahead for edge handling

; We have worked out the width of the central run in bytes, so now to adjust the
; upcoming relative jump for the filling code
	add a,a						; Double run length
	cpl
	add a,63					; Equivalent to subtracting from 64
	ld (m6_render_core_jump_smc+1),a		; Store offset

	ld c,(ix+0)					; Load texture byte
	ld a,e						; Get old mask
	and c						; AND against texture byte
	or (hl)						; OR to the buffer
	ld (hl),a					; Store back in buffer

m6_render_core_jump_smc:
; This part is the filling stage, which copies the raw line graphic into the buffer
	jr $						; (self-modifying code)

rept 32
	inc l						; Next byte of buffer
	ld (hl),c					; Copy pattern byte into buffer
endm
	inc l
m6_render_core_l3:
	ld a,(iy+0)					; Get new edge mask
	ld e,a
	cpl						; Invert mask
	and c						; AND against graphic
	ld (hl),a					; Load into buffer

m6_render_core_endline:
; We have now plotted our line, so do some clean up work for the next one
	exx						; MAP SET ==================================

	ld a,(bc)					; Grab tile
	ld (m6_render_core_comparison_smc+1),a		; Store new tile into comparison
	ld a,255
	cp h						; End of screen?
	jp nz,m6_render_core_l1				; Not overflowed, so loop back

	jp m6_render_newline				; Now for next line of buffer

m6_render_core_edge:
; This branch handles lines made up of only two edges (16 - 9px)
	inc a						; Just a small edge case?
	jr nz,m6_render_core_edge_single

; This must be a double edge situation.
	ld c,(ix+0)					; Load texture byte
	ld a,e						; Get old mask
	and c						; AND against texture byte
	or (hl)						; OR to the buffer
	ld (hl),a					; Store back in buffer

	inc l

m6_render_core_edge_left:
	ld a,(iy+0)					; Get new edge mask
	ld e,a
	cpl						; Invert mask
	and c						; AND against graphic
	ld (hl),a					; Load into buffer
	jp m6_render_core_endline

m6_render_core_edge_single:
; This must be a single edge situation
	ld a,c
	ld c,(ix+0)					; Load texture byte
	inc a						; Check X coordinate of right edge
	jr nz,m6_render_core_edge_left			; Jump behind if byte is on left side

	ld a,e						; Get old mask
	and c						; AND against texture byte
	or (hl)						; OR to the buffer
	ld (hl),a					; Store back in buffer

	jp m6_render_core_endline


m6_render_map_up:
; The Y addition has overflowed, so we must adjust the map pointer
	inc h
	ld (m6_render_y),hl

	ld bc,(m6_render_map)				; Get map pointer
	ld a,c
	add a,64					; Move to next row of map pointer
	ld c,a
	adc a,b
	sub c
	cp 8+(m6_map/256)				; Out of bounds?
	jr nz,m6_render_map_up_l1

	ld a,m6_map/256					; Reset line counter

m6_render_map_up_l1:
	ld b,a
	ld (m6_render_map),bc				; Store map pointer

	ld a,l
	ret


m6_render_map_left:
; The X addition has overflowed, so we must adjust the map pointer
	ld bc,(m6_render_map)				; Get map pointer
	inc c
	ld (m6_render_map),bc				; Store map pointer
	ret

; ==================================================================================================
; === RENDERING VARIABLES
; ==================================================================================================

m6_render_x:		dw 0
m6_render_y:		dw 0
m6_render_dy:		dw 0
m6_render_row:		db 0
m6_render_map:		dw 0
m6_render_width:	dw 0

; ==================================================================================================
; === RENDERING EQUATES
; ==================================================================================================

m6_render_oy:		equ 0-265
m6_render_ox:		equ 650
m6_render_dw:		equ 0-174
m6_render_iseg:		equ 13107

; ==================================================================================================
; === RENDERING DATA
; ==================================================================================================

m6_centretab:
	db 0, 9, 9, 9, 9, 10, 10, 10
	db 10, 11, 11, 11, 12, 12, 13, 13
	db 13, 14, 14, 15, 15, 16, 17, 17
	db 18, 19, 19, 20, 21, 22, 23, 24
	db 25, 26, 28, 29, 30, 32, 34, 36
