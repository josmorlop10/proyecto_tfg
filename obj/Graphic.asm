;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (Linux)
;--------------------------------------------------------
	.module Graphic
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _print_counter
	.globl _set_win_tile_xy
	.globl _set_bkg_tiles
	.globl _change_bkg_tile_xy
	.globl _change_bkg_tile_16x16
	.globl _move_sprite_block_pointer
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
;src/Graphic.c:54: void move_sprite_block_pointer(uint8_t direction){
;	---------------------------------
; Function move_sprite_block_pointer
; ---------------------------------
_move_sprite_block_pointer::
;src/Graphic.c:63: uint8_t offset_x = direction%4 * 8*4;
	ld	l, a
	ld	h, #0x00
	ld	a, l
	and	a, #0x03
	ld	e, a
	swap	a
	rlca
	and	a, #0xe0
	ld	c, a
;src/Graphic.c:64: uint8_t offset_y = direction/4 * 8;
	sra	h
	rr	l
	sra	h
	rr	l
	ld	a, l
	add	a, a
	add	a, a
	add	a, a
	ld	b, a
;src/Graphic.c:65: if(direction%4 >= 2){
	ld	a, e
	sub	a, #0x02
	jr	C, 00102$
;src/Graphic.c:66: offset_x = offset_x + 8;
	ld	a, c
	add	a, #0x08
	ld	c, a
00102$:
;src/Graphic.c:68: move_sprite(16, 24 + offset_x , 144 + offset_y);
	ld	a, b
	add	a, #0x90
	ld	b, a
	ld	a, c
	add	a, #0x18
	ld	c, a
;/home/josem/gbdk/include/gb/gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 64)
;/home/josem/gbdk/include/gb/gb.h:1974: itm->y=y, itm->x=x;
	ld	a, b
	ld	(hl+), a
	ld	(hl), c
;src/Graphic.c:68: move_sprite(16, 24 + offset_x , 144 + offset_y);
;src/Graphic.c:69: }
	ret
;src/Graphic.c:72: void print_counter(void){
;	---------------------------------
; Function print_counter
; ---------------------------------
_print_counter::
;src/Graphic.c:73: uint8_t tile_id = global_selected_block + 115;
	ld	a, (#_global_selected_block)
	add	a, #0x73
;src/Graphic.c:74: set_win_tile_xy(0, 0, tile_id);
	push	af
	inc	sp
	xor	a, a
	ld	e, a
	call	_set_win_tile_xy
;src/Graphic.c:75: }
	ret
;src/Graphic.c:77: void update_values_in_hud(uint8_t position, uint8_t new_value){
;	---------------------------------
; Function update_values_in_hud
; ---------------------------------
_update_values_in_hud::
;src/Graphic.c:84: uint8_t x = 0;
;src/Graphic.c:85: uint8_t y = 0;
	ld	bc, #0x0
;src/Graphic.c:87: switch (position)
	cp	a, #0x06
	jr	C, 00110$
	cp	a, #0x0e
	jr	NC, 00110$
	add	a, #0xfa
	ld	c, a
	ld	b, #0x00
	ld	hl, #00127$
	add	hl, bc
	add	hl, bc
	ld	c, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, c
	jp	(hl)
00127$:
	.dw	00101$
	.dw	00102$
	.dw	00103$
	.dw	00104$
	.dw	00105$
	.dw	00106$
	.dw	00107$
	.dw	00108$
;src/Graphic.c:89: case RIGHT:
00101$:
;src/Graphic.c:90: x = 4;
;src/Graphic.c:91: y = 1;
	ld	bc, #0x104
;src/Graphic.c:92: break;
	jr	00110$
;src/Graphic.c:93: case LEFT:
00102$:
;src/Graphic.c:94: x = 8;
;src/Graphic.c:95: y = 1;
	ld	bc, #0x108
;src/Graphic.c:96: break;
	jr	00110$
;src/Graphic.c:97: case UP:
00103$:
;src/Graphic.c:98: x = 13;
;src/Graphic.c:99: y = 1;
	ld	bc, #0x10d
;src/Graphic.c:100: break;
	jr	00110$
;src/Graphic.c:101: case DOWN:
00104$:
;src/Graphic.c:102: x = 17;
;src/Graphic.c:103: y = 1;
	ld	bc, #0x111
;src/Graphic.c:104: break;
	jr	00110$
;src/Graphic.c:105: case RIGHT_UP:
00105$:
;src/Graphic.c:106: x = 4;
;src/Graphic.c:107: y = 2;
	ld	bc, #0x204
;src/Graphic.c:108: break;
	jr	00110$
;src/Graphic.c:109: case RIGHT_DOWN:
00106$:
;src/Graphic.c:110: x = 8;
;src/Graphic.c:111: y = 2;
	ld	bc, #0x208
;src/Graphic.c:112: break;
	jr	00110$
;src/Graphic.c:113: case LEFT_UP:
00107$:
;src/Graphic.c:114: x = 13; 
;src/Graphic.c:115: y = 2;
	ld	bc, #0x20d
;src/Graphic.c:116: break;
	jr	00110$
;src/Graphic.c:117: case LEFT_DOWN:
00108$:
;src/Graphic.c:118: x = 17; 
;src/Graphic.c:119: y = 2;
	ld	bc, #0x211
;src/Graphic.c:123: }
00110$:
;src/Graphic.c:125: set_win_tile_xy(x,y, new_value + hud_selectorTileOffset + 1);
	ld	a, e
	add	a, #0x69
	push	af
	inc	sp
	ld	e, b
	ld	a, c
	call	_set_win_tile_xy
;src/Graphic.c:126: }
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
