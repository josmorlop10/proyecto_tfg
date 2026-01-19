;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (Linux)
;--------------------------------------------------------
	.module Graphic
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _set_win_tile_xy
	.globl _set_bkg_tiles
	.globl _change_bkg_tile_xy
	.globl _change_bkg_tile_16x16
	.globl _update_values_in_hud
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
;src/Graphic.c:10: void change_bkg_tile_xy(uint16_t tile_index, uint8_t tile_id){
;	---------------------------------
; Function change_bkg_tile_xy
; ---------------------------------
_change_bkg_tile_xy::
	dec	sp
	dec	sp
	ldhl	sp,	#1
	ld	(hl), a
;src/Graphic.c:19: uint8_t y = (tile_index / 20);
	push	de
	ld	bc, #0x0014
	call	__divuint
	pop	de
	ldhl	sp,	#0
	ld	(hl), c
;src/Graphic.c:20: uint8_t x = (tile_index % 20);
	ld	bc, #0x0014
	call	__moduint
;src/Graphic.c:22: set_bkg_tiles(x-1, y-1, 1, 1, &tile_id);
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
;src/Graphic.c:23: set_bkg_tiles(x, y-1, 1, 1, &tile_id);
	push	de
	push	de
	ld	de, #0x101
	push	de
	ld	l, c
	push	hl
	call	_set_bkg_tiles
	add	sp, #6
	pop	de
;src/Graphic.c:24: set_bkg_tiles(x-1, y, 1, 1, &tile_id);
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
;src/Graphic.c:25: set_bkg_tiles(x, y, 1, 1, &tile_id);
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
;src/Graphic.c:26: }
	add	sp, #8
	ret
;src/Graphic.c:28: void change_bkg_tile_16x16(uint16_t tile_index, uint8_t tile_id_BR){
;	---------------------------------
; Function change_bkg_tile_16x16
; ---------------------------------
_change_bkg_tile_16x16::
	add	sp, #-5
	ldhl	sp,	#4
	ld	(hl), a
;src/Graphic.c:39: uint8_t y = (tile_index / 20);
	push	de
	ld	bc, #0x0014
	call	__divuint
	pop	de
	ldhl	sp,	#3
	ld	(hl), c
;src/Graphic.c:40: uint8_t x = (tile_index % 20);
	ld	bc, #0x0014
	call	__moduint
	ld	e, c
;src/Graphic.c:42: uint8_t tile_id_TR = tile_id_BR - 0x01;
	ldhl	sp,	#4
	ld	c, (hl)
	ld	a, c
	dec	a
	ldhl	sp,	#0
;src/Graphic.c:43: uint8_t tile_id_BL = tile_id_BR - 0x02;
	ld	(hl+), a
	ld	a, c
	add	a, #0xfe
;src/Graphic.c:44: uint8_t tile_id_TL = tile_id_BR - 0x03;
	ld	(hl+), a
	ld	a, c
	add	a, #0xfd
	ld	(hl), a
;src/Graphic.c:46: set_bkg_tiles(x,y,1,1,&tile_id_BR);
	ld	hl, #4
	add	hl, sp
	push	de
	push	hl
	ld	hl, #0x101
	push	hl
	ldhl	sp,	#9
	ld	d, (hl)
	push	de
	call	_set_bkg_tiles
	add	sp, #6
	pop	de
;src/Graphic.c:47: set_bkg_tiles(x-1,y,1,1,&tile_id_BL);
	ld	c, e
	dec	c
	push	de
	ld	hl, #3
	add	hl, sp
	push	hl
	ld	hl, #0x101
	push	hl
	ldhl	sp,	#9
	ld	b, (hl)
	push	bc
	call	_set_bkg_tiles
	add	sp, #6
	pop	de
;src/Graphic.c:48: set_bkg_tiles(x,y-1,1,1,&tile_id_TR);
	ldhl	sp,	#3
	ld	b, (hl)
	dec	b
	ld	hl, #0
	add	hl, sp
	push	hl
	ld	hl, #0x101
	push	hl
	push	bc
	inc	sp
	ld	a, e
	push	af
	inc	sp
	call	_set_bkg_tiles
	add	sp, #6
;src/Graphic.c:49: set_bkg_tiles(x-1,y-1,1,1,&tile_id_TL);
	ld	hl, #2
	add	hl, sp
	push	hl
	ld	hl, #0x101
	push	hl
	push	bc
	inc	sp
	ld	a, c
	push	af
	inc	sp
	call	_set_bkg_tiles
;src/Graphic.c:50: }
	add	sp, #11
	ret
;src/Graphic.c:53: void update_values_in_hud(uint8_t position, uint8_t new_value){
;	---------------------------------
; Function update_values_in_hud
; ---------------------------------
_update_values_in_hud::
	ld	c, e
;src/Graphic.c:60: uint8_t x = 0;
;src/Graphic.c:61: uint8_t y = 0;
	ld	b, #0x00
	ld	e, b
;src/Graphic.c:63: switch (position)
	cp	a, #0x06
	jr	Z, 00101$
	cp	a, #0x07
	jr	Z, 00102$
	cp	a, #0x08
	jr	Z, 00103$
	sub	a, #0x09
	jr	Z, 00104$
	jr	00106$
;src/Graphic.c:65: case RIGHT:
00101$:
;src/Graphic.c:66: x = 3;
	ld	b, #0x03
;src/Graphic.c:67: y = 1;
	ld	e, #0x01
;src/Graphic.c:68: break;
	jr	00106$
;src/Graphic.c:69: case LEFT:
00102$:
;src/Graphic.c:70: x = 3;
	ld	b, #0x03
;src/Graphic.c:71: y = 2;
	ld	e, #0x02
;src/Graphic.c:72: break;
	jr	00106$
;src/Graphic.c:73: case UP:
00103$:
;src/Graphic.c:74: x = 7;
	ld	b, #0x07
;src/Graphic.c:75: y = 1;
	ld	e, #0x01
;src/Graphic.c:76: break;
	jr	00106$
;src/Graphic.c:77: case DOWN:
00104$:
;src/Graphic.c:78: x = 7;
	ld	b, #0x07
;src/Graphic.c:79: y = 2;
	ld	e, #0x02
;src/Graphic.c:83: }
00106$:
;src/Graphic.c:85: set_win_tile_xy(x,y,new_value + hud_selectorTileOffset);
	ld	a, c
	add	a, #0x2c
	push	af
	inc	sp
	ld	a, b
	call	_set_win_tile_xy
;src/Graphic.c:86: }
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
