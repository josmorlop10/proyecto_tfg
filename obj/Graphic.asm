;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (Linux)
;--------------------------------------------------------
	.module Graphic
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _set_win_tile_xy
	.globl _set_win_tiles
	.globl _set_bkg_tiles
	.globl _delay
	.globl _change_bkg_tile_xy
	.globl _change_bkg_tile_16x16
	.globl _change_all_block_tiles
	.globl _restore_all_block_tiles
	.globl _change_win_tile_16x16
	.globl _move_sprite_block_pointer
	.globl _print_counter
	.globl _update_values_in_hud
	.globl _move_win_screen
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
;src/Graphic.c:53: void change_all_block_tiles(uint8_t tile_id_BR){
;	---------------------------------
; Function change_all_block_tiles
; ---------------------------------
_change_all_block_tiles::
	dec	sp
	ldhl	sp,	#0
	ld	(hl), a
;src/Graphic.c:57: for(uint16_t i = 0; i < NUMBER_OF_TILES_IN_GRID; i++){
	ld	bc, #0x0000
00111$:
	ld	e, c
	ld	d, b
	ld	a, e
	sub	a, #0x2c
	ld	a, d
	sbc	a, #0x01
	jr	NC, 00113$
;src/Graphic.c:58: block_type = global_colision_map[i];
	ld	hl, #_global_colision_map
	add	hl, bc
	ld	l, (hl)
;src/Graphic.c:60: if(i >= 21 && block_type >= RIGHT && block_type < RIGHT + NUMBER_OF_BLOCKS){
	ld	a, e
	sub	a, #0x15
	ld	a, d
	sbc	a, #0x00
	jr	C, 00112$
	ld	a,l
	cp	a,#0x06
	jr	C, 00112$
	sub	a, #0x0c
	jr	NC, 00112$
;src/Graphic.c:61: if(global_colision_map[i-1] == BLOCK &&
	ld	l, e
	ld	h, d
	dec	hl
	push	de
	ld	de, #_global_colision_map
	add	hl, de
	pop	de
	ld	a, (hl)
	sub	a, #0x05
	jr	NZ, 00112$
;src/Graphic.c:62: global_colision_map[i-20] == BLOCK &&
	ld	a, e
	add	a, #0xec
	ld	l, a
	ld	a, d
	adc	a, #0xff
	ld	h, a
	push	de
	ld	de, #_global_colision_map
	add	hl, de
	pop	de
	ld	a, (hl)
	sub	a, #0x05
	jr	NZ, 00112$
;src/Graphic.c:63: global_colision_map[i-21] == BLOCK){
	ld	a, e
	add	a, #0xeb
	ld	e, a
	ld	a, d
	adc	a, #0xff
	ld	d, a
	ld	hl, #_global_colision_map
	add	hl, de
	ld	a, (hl)
	sub	a, #0x05
	jr	NZ, 00112$
;src/Graphic.c:64: change_bkg_tile_16x16(i, tile_id_BR);
	push	bc
	ldhl	sp,	#2
	ld	a, (hl)
	ld	e, c
	ld	d, b
	call	_change_bkg_tile_16x16
	pop	bc
00112$:
;src/Graphic.c:57: for(uint16_t i = 0; i < NUMBER_OF_TILES_IN_GRID; i++){
	inc	bc
	jr	00111$
00113$:
;src/Graphic.c:68: }
	inc	sp
	ret
;src/Graphic.c:70: void restore_all_block_tiles(void){
;	---------------------------------
; Function restore_all_block_tiles
; ---------------------------------
_restore_all_block_tiles::
	dec	sp
;src/Graphic.c:74: for(uint16_t i = 0; i < NUMBER_OF_TILES_IN_GRID; i++){
	ld	bc, #0x0000
00111$:
	ld	e, c
	ld	d, b
	ld	a, e
	sub	a, #0x2c
	ld	a, d
	sbc	a, #0x01
	jr	NC, 00113$
;src/Graphic.c:75: block_type = global_colision_map[i];
	ld	hl, #_global_colision_map
	add	hl, bc
	ld	a, (hl)
	ldhl	sp,	#0
	ld	(hl), a
;src/Graphic.c:77: if(i >= 21 && block_type >= RIGHT && block_type < RIGHT + NUMBER_OF_BLOCKS){
	ld	a, e
	sub	a, #0x15
	ld	a, d
	sbc	a, #0x00
	jr	C, 00112$
	ldhl	sp,	#0
	ld	a,(hl)
	cp	a,#0x06
	jr	C, 00112$
	sub	a, #0x0c
	jr	NC, 00112$
;src/Graphic.c:78: if(global_colision_map[i-1] == BLOCK &&
	ld	l, e
	ld	h, d
	dec	hl
	push	de
	ld	de, #_global_colision_map
	add	hl, de
	pop	de
	ld	a, (hl)
	sub	a, #0x05
	jr	NZ, 00112$
;src/Graphic.c:79: global_colision_map[i-20] == BLOCK &&
	ld	a, e
	add	a, #0xec
	ld	l, a
	ld	a, d
	adc	a, #0xff
	ld	h, a
	push	de
	ld	de, #_global_colision_map
	add	hl, de
	pop	de
	ld	a, (hl)
	sub	a, #0x05
	jr	NZ, 00112$
;src/Graphic.c:80: global_colision_map[i-21] == BLOCK){
	ld	a, e
	add	a, #0xeb
	ld	e, a
	ld	a, d
	adc	a, #0xff
	ld	d, a
	ld	hl, #_global_colision_map
	add	hl, de
	ld	a, (hl)
	sub	a, #0x05
	jr	NZ, 00112$
;src/Graphic.c:81: tile_id_BR = (block_type - RIGHT) * 4 + UMBRAL_BLOCKS;
	ldhl	sp,	#0
	ld	a, (hl)
	add	a, #0xfa
	add	a, a
	add	a, a
	add	a, #0x47
;src/Graphic.c:82: change_bkg_tile_16x16(i, tile_id_BR);
	push	bc
	ld	e, c
	ld	d, b
	call	_change_bkg_tile_16x16
	pop	bc
00112$:
;src/Graphic.c:74: for(uint16_t i = 0; i < NUMBER_OF_TILES_IN_GRID; i++){
	inc	bc
	jr	00111$
00113$:
;src/Graphic.c:86: }
	inc	sp
	ret
;src/Graphic.c:90: void change_win_tile_16x16(uint16_t tile_index, uint8_t tile_id_BR){
;	---------------------------------
; Function change_win_tile_16x16
; ---------------------------------
_change_win_tile_16x16::
	add	sp, #-5
	ldhl	sp,	#4
;src/Graphic.c:100: tile_id_BR = tile_id_BR + hud_selectorTileOffset;
	ld	(hl), a
	add	a, #0x60
	ld	(hl), a
;src/Graphic.c:102: uint8_t y = (tile_index / 20);
	push	de
	ld	bc, #0x0014
	call	__divuint
	pop	de
	ldhl	sp,	#3
	ld	(hl), c
;src/Graphic.c:103: uint8_t x = (tile_index % 20);
	ld	bc, #0x0014
	call	__moduint
	ld	e, c
;src/Graphic.c:105: uint8_t tile_id_TR = tile_id_BR - 0x01;
	ldhl	sp,	#4
	ld	c, (hl)
	ld	a, c
	dec	a
	ldhl	sp,	#0
;src/Graphic.c:106: uint8_t tile_id_BL = tile_id_BR - 0x02;
	ld	(hl+), a
	ld	a, c
	add	a, #0xfe
;src/Graphic.c:107: uint8_t tile_id_TL = tile_id_BR - 0x03;
	ld	(hl+), a
	ld	a, c
	add	a, #0xfd
	ld	(hl), a
;src/Graphic.c:109: set_win_tiles(x,y,1,1,&tile_id_BR);
	ld	hl, #4
	add	hl, sp
	push	de
	push	hl
	ld	hl, #0x101
	push	hl
	ldhl	sp,	#9
	ld	d, (hl)
	push	de
	call	_set_win_tiles
	add	sp, #6
	pop	de
;src/Graphic.c:110: set_win_tiles(x-1,y,1,1,&tile_id_BL);
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
	call	_set_win_tiles
	add	sp, #6
	pop	de
;src/Graphic.c:111: set_win_tiles(x,y-1,1,1,&tile_id_TR);
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
	call	_set_win_tiles
	add	sp, #6
;src/Graphic.c:112: set_win_tiles(x-1,y-1,1,1,&tile_id_TL);
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
	call	_set_win_tiles
;src/Graphic.c:113: }
	add	sp, #11
	ret
;src/Graphic.c:115: void move_sprite_block_pointer(uint8_t direction){
;	---------------------------------
; Function move_sprite_block_pointer
; ---------------------------------
_move_sprite_block_pointer::
;src/Graphic.c:123: if(direction<6){
	ld	c, a
	sub	a, #0x06
	jr	NC, 00102$
;src/Graphic.c:124: move_sprite(16, 24 + direction * 16 , 144 - global_hud_selected * 4);
	ld	a, (_global_hud_selected)
	add	a, a
	add	a, a
	ld	b, a
	ld	a, #0x90
	sub	a, b
	ld	e, a
	ld	a, c
	swap	a
	and	a, #0xf0
	add	a, #0x18
	ld	c, a
;/home/josem/gbdk/include/gb/gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 64)
;/home/josem/gbdk/include/gb/gb.h:1974: itm->y=y, itm->x=x;
	ld	a, e
	ld	(hl+), a
	ld	(hl), c
;src/Graphic.c:124: move_sprite(16, 24 + direction * 16 , 144 - global_hud_selected * 4);
	ret
00102$:
;/home/josem/gbdk/include/gb/gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 64)
;/home/josem/gbdk/include/gb/gb.h:1974: itm->y=y, itm->x=x;
	ld	a, #0xa0
	ld	(hl+), a
	ld	(hl), #0x00
;src/Graphic.c:126: move_sprite(16, 0 , 160);
;src/Graphic.c:129: }
	ret
;src/Graphic.c:132: void print_counter(void){
;	---------------------------------
; Function print_counter
; ---------------------------------
_print_counter::
;src/Graphic.c:133: uint8_t tile_id = global_selected_block + 115;
	ld	a, (#_global_selected_block)
	add	a, #0x73
;src/Graphic.c:134: set_win_tile_xy(0, 0, tile_id);
	push	af
	inc	sp
	xor	a, a
	ld	e, a
	call	_set_win_tile_xy
;src/Graphic.c:135: }
	ret
;src/Graphic.c:137: void update_values_in_hud(uint8_t position, uint8_t new_value){
;	---------------------------------
; Function update_values_in_hud
; ---------------------------------
_update_values_in_hud::
;src/Graphic.c:144: uint8_t x = 0;
;src/Graphic.c:145: uint8_t y = 0;
	ld	bc, #0x0
;src/Graphic.c:147: switch (position)
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
;src/Graphic.c:149: case RIGHT:
00101$:
;src/Graphic.c:150: x = 2;
;src/Graphic.c:151: y = 2;
	ld	bc, #0x202
;src/Graphic.c:152: break;
	jr	00108$
;src/Graphic.c:153: case LEFT:
00102$:
;src/Graphic.c:154: x = 4;
;src/Graphic.c:155: y = 2;
	ld	bc, #0x204
;src/Graphic.c:156: break;
	jr	00108$
;src/Graphic.c:157: case UP:
00103$:
;src/Graphic.c:158: x = 6;
;src/Graphic.c:159: y = 2;
	ld	bc, #0x206
;src/Graphic.c:160: break;
	jr	00108$
;src/Graphic.c:161: case DOWN:
00104$:
;src/Graphic.c:162: x = 8;
;src/Graphic.c:163: y = 2;
	ld	bc, #0x208
;src/Graphic.c:164: break;
	jr	00108$
;src/Graphic.c:165: case CLOCKWISE:
00105$:
;src/Graphic.c:166: x = 10;
;src/Graphic.c:167: y = 2;
	ld	bc, #0x20a
;src/Graphic.c:168: break;
	jr	00108$
;src/Graphic.c:169: case COUNTER_CLOCKWISE:
00106$:
;src/Graphic.c:170: x = 12;
;src/Graphic.c:171: y = 2;
	ld	bc, #0x20c
;src/Graphic.c:176: }
00108$:
;src/Graphic.c:178: set_win_tile_xy(x,y, new_value + hud_selectorTileOffset + 1);
	ld	a, e
	add	a, #0x61
	push	af
	inc	sp
	ld	e, b
	ld	a, c
	call	_set_win_tile_xy
;src/Graphic.c:179: }
	ret
;src/Graphic.c:181: void move_win_screen(int8_t pixeles){
;	---------------------------------
; Function move_win_screen
; ---------------------------------
_move_win_screen::
	ld	c, a
;src/Graphic.c:183: if(pixeles < 0){
	bit	7, c
	jr	Z, 00118$
;src/Graphic.c:184: pixeles = -pixeles;
	xor	a, a
	sub	a, c
	ld	c, a
;src/Graphic.c:185: for(uint8_t i = 1;i<=pixeles;i++){
	ld	b, #0x01
00107$:
	ld	e, b
	ld	d, c
	ld	a, d
	sub	a, e
	ret	C
;src/Graphic.c:186: WY_REG = WY_REG - 1;
	ldh	a, (_WY_REG + 0)
	dec	a
	ldh	(_WY_REG + 0), a
;src/Graphic.c:187: delay(10);
	push	bc
	ld	de, #0x000a
	call	_delay
	pop	bc
;src/Graphic.c:185: for(uint8_t i = 1;i<=pixeles;i++){
	inc	b
	jr	00107$
;src/Graphic.c:190: for(uint8_t i = 1;i<=pixeles;i++){
00118$:
	ld	b, #0x01
00110$:
	ld	e, b
	ld	d, c
	ld	a, d
	sub	a, e
	ret	C
;src/Graphic.c:191: WY_REG = WY_REG + 1;
	ldh	a, (_WY_REG + 0)
	inc	a
	ldh	(_WY_REG + 0), a
;src/Graphic.c:192: delay(10);
	push	bc
	ld	de, #0x000a
	call	_delay
	pop	bc
;src/Graphic.c:190: for(uint8_t i = 1;i<=pixeles;i++){
	inc	b
;src/Graphic.c:195: } 
	jr	00110$
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
