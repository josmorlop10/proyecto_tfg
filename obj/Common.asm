;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (Linux)
;--------------------------------------------------------
	.module Common
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _set_bkg_tiles
	.globl _wait_vbl_done
	.globl _performantdelay
	.globl _tileindex_from_xy
	.globl _change_bkg_tile_xy
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;src/Common.c:5: void performantdelay(uint8_t numloops){
;	---------------------------------
; Function performantdelay
; ---------------------------------
_performantdelay::
	ld	c, a
;src/Common.c:7: for(i = 0; i < numloops; i++){
	ld	b, #0x00
00103$:
	ld	a, b
	sub	a, c
	ret	NC
;src/Common.c:8: wait_vbl_done();
	call	_wait_vbl_done
;src/Common.c:7: for(i = 0; i < numloops; i++){
	inc	b
;src/Common.c:10: }
	jr	00103$
;src/Common.c:12: uint16_t tileindex_from_xy(uint8_t x, uint8_t y){
;	---------------------------------
; Function tileindex_from_xy
; ---------------------------------
_tileindex_from_xy::
	add	sp, #-6
	ldhl	sp,	#5
	ld	(hl), e
;src/Common.c:21: uint8_t indexBRx = (x - 8) / 8; //señala la columna
	ldhl	sp,	#1
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0008
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#4
	ld	(hl-), a
	ld	(hl), e
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	bit	7, (hl)
	jr	Z, 00103$
	dec	hl
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0xffff
	add	hl, de
	ld	c, l
	ld	b, h
00103$:
	sra	b
	rr	c
	sra	b
	rr	c
	sra	b
	rr	c
	ldhl	sp,	#0
	ld	(hl), c
;src/Common.c:22: uint8_t indexBRy = (y - 16) / 8; //señala la fila
	ldhl	sp,	#5
	ld	a, (hl)
	ldhl	sp,	#1
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0010
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#4
	ld	(hl-), a
	ld	(hl), e
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	bit	7, (hl)
	jr	Z, 00104$
	dec	hl
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0xfff7
	add	hl, de
	ld	c, l
	ld	b, h
00104$:
	sra	b
	rr	c
	sra	b
	rr	c
	sra	b
	rr	c
;src/Common.c:23: uint16_t tileindexBR = 20 * indexBRy + indexBRx;
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, hl
	ld	c, l
	ld	b, h
	ldhl	sp,	#0
	ld	a, (hl)
	ld	e, #0x00
	add	a, c
	ld	c, a
	ld	a, e
	adc	a, b
	ld	b, a
;src/Common.c:25: return tileindexBR;
;src/Common.c:26: }
	add	sp, #6
	ret
;src/Common.c:29: void change_bkg_tile_xy(uint16_t tile_index, uint8_t tile_id){
;	---------------------------------
; Function change_bkg_tile_xy
; ---------------------------------
_change_bkg_tile_xy::
	dec	sp
	dec	sp
	ldhl	sp,	#1
	ld	(hl), a
;src/Common.c:38: uint8_t y = (tile_index / 20);
	push	de
	ld	bc, #0x0014
	call	__divuint
	pop	de
	ldhl	sp,	#0
	ld	(hl), c
;src/Common.c:39: uint8_t x = (tile_index % 20);
	ld	bc, #0x0014
	call	__moduint
;src/Common.c:40: set_bkg_tiles(x-1, y-1, 1, 1, &tile_id);
	ldhl	sp,	#1
	ld	e, l
	ld	d, h
	ldhl	sp,	#0
	ld	h, (hl)
	dec	h
	ld	b, c
	dec	b
	push	hl
	push	de
	push	de
	ld	de, #0x101
	push	de
	ld	l, b
	push	hl
	call	_set_bkg_tiles
	add	sp, #6
	pop	de
	pop	hl
;src/Common.c:41: set_bkg_tiles(x, y-1, 1, 1, &tile_id);
	push	de
	push	de
	ld	de, #0x101
	push	de
	ld	l, c
	push	hl
	call	_set_bkg_tiles
	add	sp, #6
	pop	de
;src/Common.c:42: set_bkg_tiles(x-1, y, 1, 1, &tile_id);
	push	de
	push	de
	ld	hl, #0x101
	push	hl
	ldhl	sp,	#6
	ld	a, (hl)
	push	af
	inc	sp
	push	bc
	inc	sp
	call	_set_bkg_tiles
	add	sp, #6
;src/Common.c:43: set_bkg_tiles(x, y, 1, 1, &tile_id);
	ld	hl, #0x101
	push	hl
	ldhl	sp,	#4
	ld	a, (hl)
	push	af
	inc	sp
	ld	a, c
	push	af
	inc	sp
	call	_set_bkg_tiles
;src/Common.c:44: }
	add	sp, #8
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
