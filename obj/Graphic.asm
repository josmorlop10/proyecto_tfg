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
	.globl _move_sprite_block_pointer
	.globl _print_counter
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
;src/Graphic.c:11: void change_bkg_tile_xy(uint16_t tile_index, uint8_t tile_id){
;	---------------------------------
; Function change_bkg_tile_xy
; ---------------------------------
_change_bkg_tile_xy::
	dec	sp
	dec	sp
	ldhl	sp,	#1
	ld	(hl), a
;src/Graphic.c:20: uint8_t y = (tile_index / 20);
	push	de
	ld	bc, #0x0014
	call	__divuint
	pop	de
	ldhl	sp,	#0
	ld	(hl), c
;src/Graphic.c:21: uint8_t x = (tile_index % 20);
	ld	bc, #0x0014
	call	__moduint
;src/Graphic.c:23: set_bkg_tiles(x-1, y-1, 1, 1, &tile_id);
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
;src/Graphic.c:24: set_bkg_tiles(x, y-1, 1, 1, &tile_id);
	push	de
	push	de
	ld	de, #0x101
	push	de
	ld	l, c
	push	hl
	call	_set_bkg_tiles
	add	sp, #6
	pop	de
;src/Graphic.c:25: set_bkg_tiles(x-1, y, 1, 1, &tile_id);
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
;src/Graphic.c:26: set_bkg_tiles(x, y, 1, 1, &tile_id);
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
;src/Graphic.c:27: }
	add	sp, #8
	ret
;src/Graphic.c:29: void change_bkg_tile_16x16(uint16_t tile_index, uint8_t tile_id_BR){
;	---------------------------------
; Function change_bkg_tile_16x16
; ---------------------------------
_change_bkg_tile_16x16::
	add	sp, #-5
	ldhl	sp,	#4
	ld	(hl), a
;src/Graphic.c:40: uint8_t y = (tile_index / 20);
	push	de
	ld	bc, #0x0014
	call	__divuint
	pop	de
	ldhl	sp,	#3
	ld	(hl), c
;src/Graphic.c:41: uint8_t x = (tile_index % 20);
	ld	bc, #0x0014
	call	__moduint
	ld	e, c
;src/Graphic.c:43: uint8_t tile_id_TR = tile_id_BR - 0x01;
	ldhl	sp,	#4
	ld	c, (hl)
	ld	a, c
	dec	a
	ldhl	sp,	#0
;src/Graphic.c:44: uint8_t tile_id_BL = tile_id_BR - 0x02;
	ld	(hl+), a
	ld	a, c
	add	a, #0xfe
;src/Graphic.c:45: uint8_t tile_id_TL = tile_id_BR - 0x03;
	ld	(hl+), a
	ld	a, c
	add	a, #0xfd
	ld	(hl), a
;src/Graphic.c:47: set_bkg_tiles(x,y,1,1,&tile_id_BR);
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
;src/Graphic.c:48: set_bkg_tiles(x-1,y,1,1,&tile_id_BL);
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
;src/Graphic.c:49: set_bkg_tiles(x,y-1,1,1,&tile_id_TR);
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
;src/Graphic.c:50: set_bkg_tiles(x-1,y-1,1,1,&tile_id_TL);
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
;src/Graphic.c:51: }
	add	sp, #11
	ret
;src/Graphic.c:57: void move_sprite_block_pointer(uint8_t direction){
;	---------------------------------
; Function move_sprite_block_pointer
; ---------------------------------
_move_sprite_block_pointer::
	ld	c, a
;src/Graphic.c:64: move_sprite(16, 40 + direction * 16 , 144 - global_hud_selected * 4);
	ld	a, (_global_hud_selected)
	add	a, a
	add	a, a
	ld	b, a
	ld	a, #0x90
	sub	a, b
	ld	b, a
	ld	a, c
	swap	a
	and	a, #0xf0
	add	a, #0x28
	ld	c, a
;/home/josem/gbdk/include/gb/gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 64)
;/home/josem/gbdk/include/gb/gb.h:1974: itm->y=y, itm->x=x;
	ld	a, b
	ld	(hl+), a
	ld	(hl), c
;src/Graphic.c:64: move_sprite(16, 40 + direction * 16 , 144 - global_hud_selected * 4);
;src/Graphic.c:65: }
	ret
;src/Graphic.c:68: void print_counter(void){
;	---------------------------------
; Function print_counter
; ---------------------------------
_print_counter::
;src/Graphic.c:69: uint8_t tile_id = global_selected_block + 115;
	ld	a, (#_global_selected_block)
	add	a, #0x73
;src/Graphic.c:70: set_win_tile_xy(0, 0, tile_id);
	push	af
	inc	sp
	xor	a, a
	ld	e, a
	call	_set_win_tile_xy
;src/Graphic.c:71: }
	ret
;src/Graphic.c:73: void update_values_in_hud(uint8_t position, uint8_t new_value){
;	---------------------------------
; Function update_values_in_hud
; ---------------------------------
_update_values_in_hud::
;src/Graphic.c:80: uint8_t x = 0;
;src/Graphic.c:81: uint8_t y = 0;
	ld	bc, #0x0
;src/Graphic.c:83: switch (position)
	cp	a, #0x06
	jr	C, 00108$
	cp	a, #0x0c
	jr	NC, 00108$
	add	a, #0xfa
	ld	c, a
	ld	b, #0x00
	ld	hl, #00125$
	add	hl, bc
	add	hl, bc
	ld	c, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, c
	jp	(hl)
00125$:
	.dw	00101$
	.dw	00102$
	.dw	00103$
	.dw	00104$
	.dw	00105$
	.dw	00106$
;src/Graphic.c:85: case RIGHT:
00101$:
;src/Graphic.c:86: x = 4;
;src/Graphic.c:87: y = 2;
	ld	bc, #0x204
;src/Graphic.c:88: break;
	jr	00108$
;src/Graphic.c:89: case LEFT:
00102$:
;src/Graphic.c:90: x = 6;
;src/Graphic.c:91: y = 2;
	ld	bc, #0x206
;src/Graphic.c:92: break;
	jr	00108$
;src/Graphic.c:93: case UP:
00103$:
;src/Graphic.c:94: x = 8;
;src/Graphic.c:95: y = 2;
	ld	bc, #0x208
;src/Graphic.c:96: break;
	jr	00108$
;src/Graphic.c:97: case DOWN:
00104$:
;src/Graphic.c:98: x = 10;
;src/Graphic.c:99: y = 2;
	ld	bc, #0x20a
;src/Graphic.c:100: break;
	jr	00108$
;src/Graphic.c:101: case CLOCKWISE:
00105$:
;src/Graphic.c:102: x = 12;
;src/Graphic.c:103: y = 2;
	ld	bc, #0x20c
;src/Graphic.c:104: break;
	jr	00108$
;src/Graphic.c:105: case COUNTER_CLOCKWISE:
00106$:
;src/Graphic.c:106: x = 14;
;src/Graphic.c:107: y = 2;
	ld	bc, #0x20e
;src/Graphic.c:112: }
00108$:
;src/Graphic.c:114: set_win_tile_xy(x,y, new_value + hud_selectorTileOffset + 1);
	ld	a, e
	add	a, #0x61
	push	af
	inc	sp
	ld	e, b
	ld	a, c
	call	_set_win_tile_xy
;src/Graphic.c:115: }
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
