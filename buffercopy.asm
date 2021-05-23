; ==================================================================================================
; === STACK MACROS
; ==================================================================================================

macro m6_popbuffer
	pop af						; 10
	pop bc						; 10
	pop de						; 10
	pop hl						; 10
	exx						;  4
	pop bc						; 10
	pop de						; 10
	pop hl						; 10
	pop ix						; 14
endm							; 88 total

macro m6_pushbuffer
	push ix						; 15
	push hl						; 11
	push de						; 11
	push bc						; 11
	exx						;  4
	push hl						; 11
	push de						; 11
	push bc						; 11
	push af						; 11
endm							; 96 total

; ==================================================================================================
; === COPY 3D BUFFER TO SCREEN
; ==================================================================================================

m6_buffercopy:
; Copies the contents of the view buffer to the screen.
; Timings given below do not account for memory contention.
; Thanks to Jonathan Cauldwell for the double-buffering chapter of his Spectrum programming
; tutorial, without which I probably would've wound up using a less efficient method.
	di						;  4

	ld (m6_buffercopy_sp+1),sp			; 20 - Preserve stack pointer for later use

; LINE 00 ==========================================================================================

	ld sp,m6_gfxbuffer+1248				; 10
	m6_popbuffer					; 88
	ld sp,m6_screen+seg1+c6+p0+h1			; 10
	m6_pushbuffer					; 96
	exx						;  4
	ld sp,m6_screen+seg1+c6+p1+h1			; 10
	m6_pushbuffer					; 96

	ld sp,m6_gfxbuffer+1248+16			; 10
	m6_popbuffer					; 88
	ld sp,m6_screen+seg1+c6+p0+h2			; 10
	m6_pushbuffer					; 96
	exx						;  4
	ld sp,m6_screen+seg1+c6+p1+h2			; 10
	m6_pushbuffer					; 96

; LINE 01 ==========================================================================================

	ld sp,m6_gfxbuffer+1216				; 10
	m6_popbuffer					; 88
	ld sp,m6_screen+seg1+c6+p2+h1			; 10
	m6_pushbuffer					; 96
	exx						;  4
	ld sp,m6_screen+seg1+c6+p3+h1			; 10
	m6_pushbuffer					; 96

	ld sp,m6_gfxbuffer+1216+16			; 10
	m6_popbuffer					; 88
	ld sp,m6_screen+seg1+c6+p2+h2			; 10
	m6_pushbuffer					; 96
	exx						;  4
	ld sp,m6_screen+seg1+c6+p3+h2			; 10
	m6_pushbuffer					; 96

; LINE 02 ==========================================================================================

	ld sp,m6_gfxbuffer+1184				; 10
	m6_popbuffer					; 88
	ld sp,m6_screen+seg1+c6+p4+h1			; 10
	m6_pushbuffer					; 96
	exx						;  4
	ld sp,m6_screen+seg1+c6+p5+h1			; 10
	m6_pushbuffer					; 96

	ld sp,m6_gfxbuffer+1184+16			; 10
	m6_popbuffer					; 88
	ld sp,m6_screen+seg1+c6+p4+h2			; 10
	m6_pushbuffer					; 96
	exx						;  4
	ld sp,m6_screen+seg1+c6+p5+h2			; 10
	m6_pushbuffer					; 96

; LINE 03 ==========================================================================================

	ld sp,m6_gfxbuffer+1152				; 10
	m6_popbuffer					; 88
	ld sp,m6_screen+seg1+c6+p6+h1			; 10
	m6_pushbuffer					; 96
	exx						;  4
	ld sp,m6_screen+seg1+c6+p7+h1			; 10
	m6_pushbuffer					; 96

	ld sp,m6_gfxbuffer+1152+16			; 10
	m6_popbuffer					; 88
	ld sp,m6_screen+seg1+c6+p6+h2			; 10
	m6_pushbuffer					; 96
	exx						;  4
	ld sp,m6_screen+seg1+c6+p7+h2			; 10
	m6_pushbuffer					; 96

; LINE 04 ==========================================================================================

	ld sp,m6_gfxbuffer+1120				; 10
	m6_popbuffer					; 88
	ld sp,m6_screen+seg1+c7+p0+h1			; 10
	m6_pushbuffer					; 96
	exx						;  4
	ld sp,m6_screen+seg1+c7+p1+h1			; 10
	m6_pushbuffer					; 96

	ld sp,m6_gfxbuffer+1120+16			; 10
	m6_popbuffer					; 88
	ld sp,m6_screen+seg1+c7+p0+h2			; 10
	m6_pushbuffer					; 96
	exx						;  4
	ld sp,m6_screen+seg1+c7+p1+h2			; 10
	m6_pushbuffer					; 96

; LINE 05 ==========================================================================================

	ld sp,m6_gfxbuffer+1088				; 10
	m6_popbuffer					; 88
	ld sp,m6_screen+seg1+c7+p2+h1			; 10
	m6_pushbuffer					; 96
	exx						;  4
	ld sp,m6_screen+seg1+c7+p3+h1			; 10
	m6_pushbuffer					; 96

	ld sp,m6_gfxbuffer+1088+16			; 10
	m6_popbuffer					; 88
	ld sp,m6_screen+seg1+c7+p2+h2			; 10
	m6_pushbuffer					; 96
	exx						;  4
	ld sp,m6_screen+seg1+c7+p3+h2			; 10
	m6_pushbuffer					; 96

; LINE 06 ==========================================================================================

	ld sp,m6_gfxbuffer+1056				; 10
	m6_popbuffer					; 88
	ld sp,m6_screen+seg1+c7+p4+h1			; 10
	m6_pushbuffer					; 96
	exx						;  4
	ld sp,m6_screen+seg1+c7+p5+h1			; 10
	m6_pushbuffer					; 96

	ld sp,m6_gfxbuffer+1056+16			; 10
	m6_popbuffer					; 88
	ld sp,m6_screen+seg1+c7+p4+h2			; 10
	m6_pushbuffer					; 96
	exx						;  4
	ld sp,m6_screen+seg1+c7+p5+h2			; 10
	m6_pushbuffer					; 96

; LINE 07 ==========================================================================================

	ld sp,m6_gfxbuffer+1024				; 10
	m6_popbuffer					; 88
	ld sp,m6_screen+seg1+c7+p6+h1			; 10
	m6_pushbuffer					; 96
	exx						;  4
	ld sp,m6_screen+seg1+c7+p7+h1			; 10
	m6_pushbuffer					; 96

	ld sp,m6_gfxbuffer+1024+16			; 10
	m6_popbuffer					; 88
	ld sp,m6_screen+seg1+c7+p6+h2			; 10
	m6_pushbuffer					; 96
	exx						;  4
	ld sp,m6_screen+seg1+c7+p7+h2			; 10
	m6_pushbuffer					; 96

; LINE 08 ==========================================================================================

	ld sp,m6_gfxbuffer+992				; 10
	m6_popbuffer					; 88
	ld sp,m6_screen+seg2+c0+p0+h1			; 10
	m6_pushbuffer					; 96
	exx						;  4
	ld sp,m6_screen+seg2+c0+p1+h1			; 10
	m6_pushbuffer					; 96

	ld sp,m6_gfxbuffer+992+16			; 10
	m6_popbuffer					; 88
	ld sp,m6_screen+seg2+c0+p0+h2			; 10
	m6_pushbuffer					; 96
	exx						;  4
	ld sp,m6_screen+seg2+c0+p1+h2			; 10
	m6_pushbuffer					; 96

; LINE 09 ==========================================================================================

	ld sp,m6_gfxbuffer+960				; 10
	m6_popbuffer					; 88
	ld sp,m6_screen+seg2+c0+p2+h1			; 10
	m6_pushbuffer					; 96
	exx						;  4
	ld sp,m6_screen+seg2+c0+p3+h1			; 10
	m6_pushbuffer					; 96

	ld sp,m6_gfxbuffer+960+16			; 10
	m6_popbuffer					; 88
	ld sp,m6_screen+seg2+c0+p2+h2			; 10
	m6_pushbuffer					; 96
	exx						;  4
	ld sp,m6_screen+seg2+c0+p3+h2			; 10
	m6_pushbuffer					; 96

; LINE 10 ==========================================================================================

	ld sp,m6_gfxbuffer+928				; 10
	m6_popbuffer					; 88
	ld sp,m6_screen+seg2+c0+p4+h1			; 10
	m6_pushbuffer					; 96
	exx						;  4
	ld sp,m6_screen+seg2+c0+p5+h1			; 10
	m6_pushbuffer					; 96

	ld sp,m6_gfxbuffer+928+16			; 10
	m6_popbuffer					; 88
	ld sp,m6_screen+seg2+c0+p4+h2			; 10
	m6_pushbuffer					; 96
	exx						;  4
	ld sp,m6_screen+seg2+c0+p5+h2			; 10
	m6_pushbuffer					; 96

; LINE 11 ==========================================================================================

	ld sp,m6_gfxbuffer+896				; 10
	m6_popbuffer					; 88
	ld sp,m6_screen+seg2+c0+p6+h1			; 10
	m6_pushbuffer					; 96
	exx						;  4
	ld sp,m6_screen+seg2+c0+p7+h1			; 10
	m6_pushbuffer					; 96

	ld sp,m6_gfxbuffer+896+16			; 10
	m6_popbuffer					; 88
	ld sp,m6_screen+seg2+c0+p6+h2			; 10
	m6_pushbuffer					; 96
	exx						;  4
	ld sp,m6_screen+seg2+c0+p7+h2			; 10
	m6_pushbuffer					; 96

; LINE 12 ==========================================================================================

	ld sp,m6_gfxbuffer+864				; 10
	m6_popbuffer					; 88
	ld sp,m6_screen+seg2+c1+p0+h1			; 10
	m6_pushbuffer					; 96
	exx						;  4
	ld sp,m6_screen+seg2+c1+p1+h1			; 10
	m6_pushbuffer					; 96

	ld sp,m6_gfxbuffer+864+16			; 10
	m6_popbuffer					; 88
	ld sp,m6_screen+seg2+c1+p0+h2			; 10
	m6_pushbuffer					; 96
	exx						;  4
	ld sp,m6_screen+seg2+c1+p1+h2			; 10
	m6_pushbuffer					; 96

; LINE 13 ==========================================================================================

	ld sp,m6_gfxbuffer+832				; 10
	m6_popbuffer					; 88
	ld sp,m6_screen+seg2+c1+p2+h1			; 10
	m6_pushbuffer					; 96
	exx						;  4
	ld sp,m6_screen+seg2+c1+p3+h1			; 10
	m6_pushbuffer					; 96

	ld sp,m6_gfxbuffer+832+16			; 10
	m6_popbuffer					; 88
	ld sp,m6_screen+seg2+c1+p2+h2			; 10
	m6_pushbuffer					; 96
	exx						;  4
	ld sp,m6_screen+seg2+c1+p3+h2			; 10
	m6_pushbuffer					; 96

; LINE 14 ==========================================================================================

	ld sp,m6_gfxbuffer+800				; 10
	m6_popbuffer					; 88
	ld sp,m6_screen+seg2+c1+p4+h1			; 10
	m6_pushbuffer					; 96
	exx						;  4
	ld sp,m6_screen+seg2+c1+p5+h1			; 10
	m6_pushbuffer					; 96

	ld sp,m6_gfxbuffer+800+16			; 10
	m6_popbuffer					; 88
	ld sp,m6_screen+seg2+c1+p4+h2			; 10
	m6_pushbuffer					; 96
	exx						;  4
	ld sp,m6_screen+seg2+c1+p5+h2			; 10
	m6_pushbuffer					; 96

; LINE 15 ==========================================================================================

	ld sp,m6_gfxbuffer+768				; 10
	m6_popbuffer					; 88
	ld sp,m6_screen+seg2+c1+p6+h1			; 10
	m6_pushbuffer					; 96
	exx						;  4
	ld sp,m6_screen+seg2+c1+p7+h1			; 10
	m6_pushbuffer					; 96

	ld sp,m6_gfxbuffer+768+16			; 10
	m6_popbuffer					; 88
	ld sp,m6_screen+seg2+c1+p6+h2			; 10
	m6_pushbuffer					; 96
	exx						;  4
	ld sp,m6_screen+seg2+c1+p7+h2			; 10
	m6_pushbuffer					; 96

; LINE 16 ==========================================================================================

	ld sp,m6_gfxbuffer+736				; 10
	m6_popbuffer					; 88
	ld sp,m6_screen+seg2+c2+p0+h1			; 10
	m6_pushbuffer					; 96
	exx						;  4
	ld sp,m6_screen+seg2+c2+p1+h1			; 10
	m6_pushbuffer					; 96

	ld sp,m6_gfxbuffer+736+16			; 10
	m6_popbuffer					; 88
	ld sp,m6_screen+seg2+c2+p0+h2			; 10
	m6_pushbuffer					; 96
	exx						;  4
	ld sp,m6_screen+seg2+c2+p1+h2			; 10
	m6_pushbuffer					; 96

; LINE 17 ==========================================================================================

	ld sp,m6_gfxbuffer+704				; 10
	m6_popbuffer					; 88
	ld sp,m6_screen+seg2+c2+p2+h1			; 10
	m6_pushbuffer					; 96
	exx						;  4
	ld sp,m6_screen+seg2+c2+p3+h1			; 10
	m6_pushbuffer					; 96

	ld sp,m6_gfxbuffer+704+16			; 10
	m6_popbuffer					; 88
	ld sp,m6_screen+seg2+c2+p2+h2			; 10
	m6_pushbuffer					; 96
	exx						;  4
	ld sp,m6_screen+seg2+c2+p3+h2			; 10
	m6_pushbuffer					; 96

; LINE 18 ==========================================================================================

	ld sp,m6_gfxbuffer+672				; 10
	m6_popbuffer					; 88
	ld sp,m6_screen+seg2+c2+p4+h1			; 10
	m6_pushbuffer					; 96
	exx						;  4
	ld sp,m6_screen+seg2+c2+p5+h1			; 10
	m6_pushbuffer					; 96

	ld sp,m6_gfxbuffer+672+16			; 10
	m6_popbuffer					; 88
	ld sp,m6_screen+seg2+c2+p4+h2			; 10
	m6_pushbuffer					; 96
	exx						;  4
	ld sp,m6_screen+seg2+c2+p5+h2			; 10
	m6_pushbuffer					; 96

; LINE 19 ==========================================================================================

	ld sp,m6_gfxbuffer+640				; 10
	m6_popbuffer					; 88
	ld sp,m6_screen+seg2+c2+p6+h1			; 10
	m6_pushbuffer					; 96
	exx						;  4
	ld sp,m6_screen+seg2+c2+p7+h1			; 10
	m6_pushbuffer					; 96

	ld sp,m6_gfxbuffer+640+16			; 10
	m6_popbuffer					; 88
	ld sp,m6_screen+seg2+c2+p6+h2			; 10
	m6_pushbuffer					; 96
	exx						;  4
	ld sp,m6_screen+seg2+c2+p7+h2			; 10
	m6_pushbuffer					; 96

; LINE 20 ==========================================================================================

	ld sp,m6_gfxbuffer+608				; 10
	m6_popbuffer					; 88
	ld sp,m6_screen+seg2+c3+p0+h1			; 10
	m6_pushbuffer					; 96
	exx						;  4
	ld sp,m6_screen+seg2+c3+p1+h1			; 10
	m6_pushbuffer					; 96

	ld sp,m6_gfxbuffer+608+16			; 10
	m6_popbuffer					; 88
	ld sp,m6_screen+seg2+c3+p0+h2			; 10
	m6_pushbuffer					; 96
	exx						;  4
	ld sp,m6_screen+seg2+c3+p1+h2			; 10
	m6_pushbuffer					; 96

; LINE 21 ==========================================================================================

	ld sp,m6_gfxbuffer+576				; 10
	m6_popbuffer					; 88
	ld sp,m6_screen+seg2+c3+p2+h1			; 10
	m6_pushbuffer					; 96
	exx						;  4
	ld sp,m6_screen+seg2+c3+p3+h1			; 10
	m6_pushbuffer					; 96

	ld sp,m6_gfxbuffer+576+16			; 10
	m6_popbuffer					; 88
	ld sp,m6_screen+seg2+c3+p2+h2			; 10
	m6_pushbuffer					; 96
	exx						;  4
	ld sp,m6_screen+seg2+c3+p3+h2			; 10
	m6_pushbuffer					; 96

; LINE 22 ==========================================================================================

	ld sp,m6_gfxbuffer+544				; 10
	m6_popbuffer					; 88
	ld sp,m6_screen+seg2+c3+p4+h1			; 10
	m6_pushbuffer					; 96
	exx						;  4
	ld sp,m6_screen+seg2+c3+p5+h1			; 10
	m6_pushbuffer					; 96

	ld sp,m6_gfxbuffer+544+16			; 10
	m6_popbuffer					; 88
	ld sp,m6_screen+seg2+c3+p4+h2			; 10
	m6_pushbuffer					; 96
	exx						;  4
	ld sp,m6_screen+seg2+c3+p5+h2			; 10
	m6_pushbuffer					; 96

; LINE 23 ==========================================================================================

	ld sp,m6_gfxbuffer+512				; 10
	m6_popbuffer					; 88
	ld sp,m6_screen+seg2+c3+p6+h1			; 10
	m6_pushbuffer					; 96
	exx						;  4
	ld sp,m6_screen+seg2+c3+p7+h1			; 10
	m6_pushbuffer					; 96

	ld sp,m6_gfxbuffer+512+16			; 10
	m6_popbuffer					; 88
	ld sp,m6_screen+seg2+c3+p6+h2			; 10
	m6_pushbuffer					; 96
	exx						;  4
	ld sp,m6_screen+seg2+c3+p7+h2			; 10
	m6_pushbuffer					; 96

; LINE 24 ==========================================================================================

	ld sp,m6_gfxbuffer+480				; 10
	m6_popbuffer					; 88
	ld sp,m6_screen+seg2+c4+p0+h1			; 10
	m6_pushbuffer					; 96
	exx						;  4
	ld sp,m6_screen+seg2+c4+p1+h1			; 10
	m6_pushbuffer					; 96

	ld sp,m6_gfxbuffer+480+16			; 10
	m6_popbuffer					; 88
	ld sp,m6_screen+seg2+c4+p0+h2			; 10
	m6_pushbuffer					; 96
	exx						;  4
	ld sp,m6_screen+seg2+c4+p1+h2			; 10
	m6_pushbuffer					; 96

; LINE 25 ==========================================================================================

	ld sp,m6_gfxbuffer+448				; 10
	m6_popbuffer					; 88
	ld sp,m6_screen+seg2+c4+p2+h1			; 10
	m6_pushbuffer					; 96
	exx						;  4
	ld sp,m6_screen+seg2+c4+p3+h1			; 10
	m6_pushbuffer					; 96

	ld sp,m6_gfxbuffer+448+16			; 10
	m6_popbuffer					; 88
	ld sp,m6_screen+seg2+c4+p2+h2			; 10
	m6_pushbuffer					; 96
	exx						;  4
	ld sp,m6_screen+seg2+c4+p3+h2			; 10
	m6_pushbuffer					; 96

; LINE 26 ==========================================================================================

	ld sp,m6_gfxbuffer+416				; 10
	m6_popbuffer					; 88
	ld sp,m6_screen+seg2+c4+p4+h1			; 10
	m6_pushbuffer					; 96
	exx						;  4
	ld sp,m6_screen+seg2+c4+p5+h1			; 10
	m6_pushbuffer					; 96

	ld sp,m6_gfxbuffer+416+16			; 10
	m6_popbuffer					; 88
	ld sp,m6_screen+seg2+c4+p4+h2			; 10
	m6_pushbuffer					; 96
	exx						;  4
	ld sp,m6_screen+seg2+c4+p5+h2			; 10
	m6_pushbuffer					; 96

; LINE 27 ==========================================================================================

	ld sp,m6_gfxbuffer+384				; 10
	m6_popbuffer					; 88
	ld sp,m6_screen+seg2+c4+p6+h1			; 10
	m6_pushbuffer					; 96
	exx						;  4
	ld sp,m6_screen+seg2+c4+p7+h1			; 10
	m6_pushbuffer					; 96

	ld sp,m6_gfxbuffer+384+16			; 10
	m6_popbuffer					; 88
	ld sp,m6_screen+seg2+c4+p6+h2			; 10
	m6_pushbuffer					; 96
	exx						;  4
	ld sp,m6_screen+seg2+c4+p7+h2			; 10
	m6_pushbuffer					; 96

; LINE 28 ==========================================================================================

	ld sp,m6_gfxbuffer+352				; 10
	m6_popbuffer					; 88
	ld sp,m6_screen+seg2+c5+p0+h1			; 10
	m6_pushbuffer					; 96
	exx						;  4
	ld sp,m6_screen+seg2+c5+p1+h1			; 10
	m6_pushbuffer					; 96

	ld sp,m6_gfxbuffer+352+16			; 10
	m6_popbuffer					; 88
	ld sp,m6_screen+seg2+c5+p0+h2			; 10
	m6_pushbuffer					; 96
	exx						;  4
	ld sp,m6_screen+seg2+c5+p1+h2			; 10
	m6_pushbuffer					; 96

; LINE 29 ==========================================================================================

	ld sp,m6_gfxbuffer+320				; 10
	m6_popbuffer					; 88
	ld sp,m6_screen+seg2+c5+p2+h1			; 10
	m6_pushbuffer					; 96
	exx						;  4
	ld sp,m6_screen+seg2+c5+p3+h1			; 10
	m6_pushbuffer					; 96

	ld sp,m6_gfxbuffer+320+16			; 10
	m6_popbuffer					; 88
	ld sp,m6_screen+seg2+c5+p2+h2			; 10
	m6_pushbuffer					; 96
	exx						;  4
	ld sp,m6_screen+seg2+c5+p3+h2			; 10
	m6_pushbuffer					; 96

; LINE 30 ==========================================================================================

	ld sp,m6_gfxbuffer+288				; 10
	m6_popbuffer					; 88
	ld sp,m6_screen+seg2+c5+p4+h1			; 10
	m6_pushbuffer					; 96
	exx						;  4
	ld sp,m6_screen+seg2+c5+p5+h1			; 10
	m6_pushbuffer					; 96

	ld sp,m6_gfxbuffer+288+16			; 10
	m6_popbuffer					; 88
	ld sp,m6_screen+seg2+c5+p4+h2			; 10
	m6_pushbuffer					; 96
	exx						;  4
	ld sp,m6_screen+seg2+c5+p5+h2			; 10
	m6_pushbuffer					; 96

; LINE 31 ==========================================================================================

	ld sp,m6_gfxbuffer+256				; 10
	m6_popbuffer					; 88
	ld sp,m6_screen+seg2+c5+p6+h1			; 10
	m6_pushbuffer					; 96
	exx						;  4
	ld sp,m6_screen+seg2+c5+p7+h1			; 10
	m6_pushbuffer					; 96

	ld sp,m6_gfxbuffer+256+16			; 10
	m6_popbuffer					; 88
	ld sp,m6_screen+seg2+c5+p6+h2			; 10
	m6_pushbuffer					; 96
	exx						;  4
	ld sp,m6_screen+seg2+c5+p7+h2			; 10
	m6_pushbuffer					; 96

; LINE 32 ==========================================================================================

	ld sp,m6_gfxbuffer+224				; 10
	m6_popbuffer					; 88
	ld sp,m6_screen+seg2+c6+p0+h1			; 10
	m6_pushbuffer					; 96
	exx						;  4
	ld sp,m6_screen+seg2+c6+p1+h1			; 10
	m6_pushbuffer					; 96

	ld sp,m6_gfxbuffer+224+16			; 10
	m6_popbuffer					; 88
	ld sp,m6_screen+seg2+c6+p0+h2			; 10
	m6_pushbuffer					; 96
	exx						;  4
	ld sp,m6_screen+seg2+c6+p1+h2			; 10
	m6_pushbuffer					; 96

; LINE 33 ==========================================================================================

	ld sp,m6_gfxbuffer+192				; 10
	m6_popbuffer					; 88
	ld sp,m6_screen+seg2+c6+p2+h1			; 10
	m6_pushbuffer					; 96
	exx						;  4
	ld sp,m6_screen+seg2+c6+p3+h1			; 10
	m6_pushbuffer					; 96

	ld sp,m6_gfxbuffer+192+16			; 10
	m6_popbuffer					; 88
	ld sp,m6_screen+seg2+c6+p2+h2			; 10
	m6_pushbuffer					; 96
	exx						;  4
	ld sp,m6_screen+seg2+c6+p3+h2			; 10
	m6_pushbuffer					; 96

; LINE 34 ==========================================================================================

	ld sp,m6_gfxbuffer+160				; 10
	m6_popbuffer					; 88
	ld sp,m6_screen+seg2+c6+p4+h1			; 10
	m6_pushbuffer					; 96
	exx						;  4
	ld sp,m6_screen+seg2+c6+p5+h1			; 10
	m6_pushbuffer					; 96

	ld sp,m6_gfxbuffer+160+16			; 10
	m6_popbuffer					; 88
	ld sp,m6_screen+seg2+c6+p4+h2			; 10
	m6_pushbuffer					; 96
	exx						;  4
	ld sp,m6_screen+seg2+c6+p5+h2			; 10
	m6_pushbuffer					; 96

; LINE 35 ==========================================================================================

	ld sp,m6_gfxbuffer+128				; 10
	m6_popbuffer					; 88
	ld sp,m6_screen+seg2+c6+p6+h1			; 10
	m6_pushbuffer					; 96
	exx						;  4
	ld sp,m6_screen+seg2+c6+p7+h1			; 10
	m6_pushbuffer					; 96

	ld sp,m6_gfxbuffer+128+16			; 10
	m6_popbuffer					; 88
	ld sp,m6_screen+seg2+c6+p6+h2			; 10
	m6_pushbuffer					; 96
	exx						;  4
	ld sp,m6_screen+seg2+c6+p7+h2			; 10
	m6_pushbuffer					; 96

; LINE 36 ==========================================================================================

	ld sp,m6_gfxbuffer+96 				; 10
	m6_popbuffer					; 88
	ld sp,m6_screen+seg2+c7+p0+h1			; 10
	m6_pushbuffer					; 96
	exx						;  4
	ld sp,m6_screen+seg2+c7+p1+h1			; 10
	m6_pushbuffer					; 96



	ld sp,m6_gfxbuffer+96+16				; 10
	m6_popbuffer					; 88
	ld sp,m6_screen+seg2+c7+p0+h2			; 10
	m6_pushbuffer					; 96
	exx						;  4
	ld sp,m6_screen+seg2+c7+p1+h2			; 10
	m6_pushbuffer					; 96

; LINE 37 ==========================================================================================

	ld sp,m6_gfxbuffer+64				; 10
	m6_popbuffer					; 88
	ld sp,m6_screen+seg2+c7+p2+h1			; 10
	m6_pushbuffer					; 96
	exx						;  4
	ld sp,m6_screen+seg2+c7+p3+h1			; 10
	m6_pushbuffer					; 96

	ld sp,m6_gfxbuffer+64+16				; 10
	m6_popbuffer					; 88
	ld sp,m6_screen+seg2+c7+p2+h2			; 10
	m6_pushbuffer					; 96
	exx						;  4
	ld sp,m6_screen+seg2+c7+p3+h2			; 10
	m6_pushbuffer					; 96

; LINE 38 ==========================================================================================

	ld sp,m6_gfxbuffer+32				; 10
	m6_popbuffer					; 88
	ld sp,m6_screen+seg2+c7+p4+h1			; 10
	m6_pushbuffer					; 96
	exx						;  4
	ld sp,m6_screen+seg2+c7+p5+h1			; 10
	m6_pushbuffer					; 96

	ld sp,m6_gfxbuffer+32+16				; 10
	m6_popbuffer					; 88
	ld sp,m6_screen+seg2+c7+p4+h2			; 10
	m6_pushbuffer					; 96
	exx						;  4
	ld sp,m6_screen+seg2+c7+p5+h2			; 10
	m6_pushbuffer					; 96

; LINE 39 ==========================================================================================

	ld sp,m6_gfxbuffer				; 10
	m6_popbuffer					; 88
	ld sp,m6_screen+seg2+c7+p6+h1			; 10
	m6_pushbuffer					; 96
	exx						;  4
	ld sp,m6_screen+seg2+c7+p7+h1			; 10
	m6_pushbuffer					; 96

	ld sp,m6_gfxbuffer+16				; 10
	m6_popbuffer					; 88
	ld sp,m6_screen+seg2+c7+p6+h2			; 10
	m6_pushbuffer					; 96
	exx						;  4
	ld sp,m6_screen+seg2+c7+p7+h2			; 10
	m6_pushbuffer					; 96

m6_buffercopy_sp:
	ld sp,0						; 10 - Restore stack pointer
	ei						;  4
	ret						; 10
	
							; 25168 T-states total (w/o contention)

; ==================================================================================================
; === BUFFER COPY CONSTANTS
; ==================================================================================================

m6_screen:	equ 16384
seg0:		equ 0
seg1:		equ 2048
seg2:		equ 4096
c0:		equ 0
c1:		equ 32
c2:		equ 64
c3:		equ 96
c4:		equ 128
c5:		equ 160
c6:		equ 192
c7:		equ 224
p0:		equ 0
p1:		equ 256
p2:		equ 512
p3:		equ 768
p4:		equ 1024
p5:		equ 1280
p6:		equ 1536
p7:		equ 1792
h1:		equ 16
h2:		equ 32
