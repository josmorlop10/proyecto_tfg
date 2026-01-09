;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (Linux)
;--------------------------------------------------------
	.module PointerSelector
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _joypad
	.globl _change_colision_map_BR
	.globl _change_colision_map_at
	.globl _tileindex_from_xy
	.globl _change_bkg_tile_xy
	.globl _pointer_init
	.globl _move_pointer
	.globl _place_object_at_pointer
	.globl _remove_object_at_pointer
	.globl _block_is_not_placed_below
	.globl _block_is_placed_below
	.globl _control_pointer
	.globl _update_pointer
	.globl _hide_pointer
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
;src/PointerSelector.c:7: void pointer_init(Pointer* s) {
;	---------------------------------
; Function pointer_init
; ---------------------------------
_pointer_init::
;src/PointerSelector.c:8: s->x = 80;
	ld	l, e
	ld	h, d
	ld	(hl), #0x50
;src/PointerSelector.c:9: s->y = 72;
	push	hl
	inc	hl
	ld	(hl), #0x48
;src/PointerSelector.c:10: for(uint8_t i = 4;i<=7;i++){
	pop	bc
	push	bc
	inc	bc
	inc	bc
	ld	e, #0x04
00103$:
	ld	a, #0x07
	sub	a, e
	jr	C, 00101$
;src/PointerSelector.c:11: s->sprite_ids[i] = i;
	ld	l, e
	ld	h, #0x00
	add	hl, bc
	ld	(hl), e
;src/PointerSelector.c:10: for(uint8_t i = 4;i<=7;i++){
	inc	e
	jr	00103$
00101$:
;src/PointerSelector.c:13: s->tileindexBR = 0;
	pop	de
	push	de
	ld	hl, #0x0006
	add	hl, de
	ld	c, l
	ld	b, h
	xor	a, a
	ld	(bc), a
	inc	bc
	ld	(bc), a
;src/PointerSelector.c:14: }
	inc	sp
	inc	sp
	ret
;src/PointerSelector.c:16: void move_pointer(Pointer* s) {
;	---------------------------------
; Function move_pointer
; ---------------------------------
_move_pointer::
	dec	sp
	dec	sp
;src/PointerSelector.c:17: move_sprite(4, s->x- SPRITESIZE, s->y-SPRITESIZE);
	ld	c, e
	ld	b, d
	inc	bc
	ld	a, (bc)
	add	a, #0xf8
	ldhl	sp,	#0
	ld	(hl+), a
	ld	a, (de)
	add	a, #0xf8
	ld	(hl), a
;/home/josem/gbdk/include/gb/gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 16)
;/home/josem/gbdk/include/gb/gb.h:1974: itm->y=y, itm->x=x;
	push	hl
	ldhl	sp,	#2
	ld	a, (hl)
	pop	hl
	ld	(hl+), a
	push	hl
	ldhl	sp,	#3
	ld	a, (hl)
	pop	hl
	ld	(hl), a
;src/PointerSelector.c:18: move_sprite(5, s->x- SPRITESIZE, s->y);
	ld	a, (bc)
	ldhl	sp,	#0
	ld	(hl+), a
	ld	a, (de)
	add	a, #0xf8
	ld	(hl), a
;/home/josem/gbdk/include/gb/gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 20)
;/home/josem/gbdk/include/gb/gb.h:1974: itm->y=y, itm->x=x;
	push	hl
	ldhl	sp,	#2
	ld	a, (hl)
	pop	hl
	ld	(hl+), a
	push	hl
	ldhl	sp,	#3
	ld	a, (hl)
	pop	hl
	ld	(hl), a
;src/PointerSelector.c:19: move_sprite(6, s->x, s->y-SPRITESIZE);
	ld	a, (bc)
	add	a, #0xf8
	ldhl	sp,	#0
	ld	(hl+), a
	ld	a, (de)
	ld	(hl), a
;/home/josem/gbdk/include/gb/gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 24)
;/home/josem/gbdk/include/gb/gb.h:1974: itm->y=y, itm->x=x;
	push	hl
	ldhl	sp,	#2
	ld	a, (hl)
	pop	hl
	ld	(hl+), a
	push	hl
	ldhl	sp,	#3
	ld	a, (hl)
	pop	hl
	ld	(hl), a
;src/PointerSelector.c:20: move_sprite(7, s->x, s->y);
	ld	a, (bc)
	ld	b, a
	ld	a, (de)
	ld	c, a
;/home/josem/gbdk/include/gb/gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 28)
;/home/josem/gbdk/include/gb/gb.h:1974: itm->y=y, itm->x=x;
	ld	a, b
	ld	(hl+), a
	ld	(hl), c
;src/PointerSelector.c:20: move_sprite(7, s->x, s->y);
;src/PointerSelector.c:22: }
	inc	sp
	inc	sp
	ret
;src/PointerSelector.c:24: void place_object_at_pointer(Pointer* s, uint8_t block_type){
;	---------------------------------
; Function place_object_at_pointer
; ---------------------------------
_place_object_at_pointer::
	dec	sp
	ldhl	sp,	#0
	ld	(hl), a
;src/PointerSelector.c:25: change_colision_map_at(s->tileindexBR, BLOCK);
	ld	hl, #0x0006
	add	hl, de
	ld	c,l
	ld	b,h
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	push	bc
	ld	a, #0x05
	ld	e, l
	ld	d, h
	call	_change_colision_map_at
	pop	bc
;src/PointerSelector.c:26: change_colision_map_BR(s->tileindexBR, block_type);
	ld	l, c
	ld	h, b
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	push	bc
	push	hl
	ldhl	sp,	#4
	ld	a, (hl)
	pop	de
	call	_change_colision_map_BR
;src/PointerSelector.c:27: change_bkg_tile_xy(s->tileindexBR, 3);
	pop	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	a, #0x03
	ld	e, c
	ld	d, b
	inc	sp
	jp	_change_bkg_tile_xy
;src/PointerSelector.c:28: }
	inc	sp
	ret
;src/PointerSelector.c:30: void remove_object_at_pointer(Pointer* s){
;	---------------------------------
; Function remove_object_at_pointer
; ---------------------------------
_remove_object_at_pointer::
;src/PointerSelector.c:31: change_colision_map_at(s->tileindexBR, EMPTY);
	ld	hl, #0x0006
	add	hl, de
	ld	c,l
	ld	b,h
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	push	bc
	xor	a, a
	ld	e, l
	ld	d, h
	call	_change_colision_map_at
;src/PointerSelector.c:32: change_bkg_tile_xy(s->tileindexBR, 0);
	pop	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	xor	a, a
	ld	e, c
	ld	d, b
;src/PointerSelector.c:33: }
	jp	_change_bkg_tile_xy
;src/PointerSelector.c:35: uint8_t block_is_not_placed_below(Pointer* s){
;	---------------------------------
; Function block_is_not_placed_below
; ---------------------------------
_block_is_not_placed_below::
;src/PointerSelector.c:36: return (global_colision_map[s->tileindexBR] == EMPTY) 
	ld	bc, #_global_colision_map+0
	ld	hl, #0x0006
	add	hl, de
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	a, c
	ld	e, a
	ld	a, h
	adc	a, b
	ld	d, a
	ld	a, (de)
	or	a, a
	jr	NZ, 00103$
;src/PointerSelector.c:37: && (global_colision_map[s->tileindexBR-1] == EMPTY)
	ld	e,l
	ld	d,h
	dec	hl
	add	hl, bc
	ld	a, (hl)
	or	a, a
	jr	NZ, 00103$
;src/PointerSelector.c:38: && (global_colision_map[s->tileindexBR-20] == EMPTY)
	ld	a, e
	add	a, #0xec
	ld	l, a
	ld	a, d
	adc	a, #0xff
	ld	h, a
	add	hl, bc
	ld	a, (hl)
	or	a, a
	jr	NZ, 00103$
;src/PointerSelector.c:39: && (global_colision_map[s->tileindexBR-21] == EMPTY);
	ld	a, e
	add	a, #0xeb
	ld	l, a
	ld	a, d
	adc	a, #0xff
	ld	h, a
	add	hl, bc
	ld	a, (hl)
	or	a, a
	jr	Z, 00104$
00103$:
	xor	a, a
	ret
00104$:
	ld	a, #0x01
;src/PointerSelector.c:40: }
	ret
;src/PointerSelector.c:42: uint8_t block_is_placed_below(Pointer* s){
;	---------------------------------
; Function block_is_placed_below
; ---------------------------------
_block_is_placed_below::
;src/PointerSelector.c:47: return (global_colision_map[s->tileindexBR]>= RIGHT && global_colision_map[s->tileindexBR]<=DOWN) 
	ld	bc, #_global_colision_map+0
	ld	hl, #0x0006
	add	hl, de
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	a,c
	ld	e, a
	ld	a, b
	adc	a, h
	ld	d, a
	ld	a, (de)
	cp	a, #0x06
	jr	C, 00103$
	cp	a, #0x0a
	jr	NC, 00103$
;src/PointerSelector.c:48: && (global_colision_map[s->tileindexBR-1] != EMPTY)
	ld	e,l
	ld	d,h
	dec	hl
	add	hl, bc
	ld	a, (hl)
	or	a, a
	jr	Z, 00103$
;src/PointerSelector.c:49: && (global_colision_map[s->tileindexBR-20] != EMPTY)
	ld	a, e
	add	a, #0xec
	ld	l, a
	ld	a, d
	adc	a, #0xff
	ld	h, a
	add	hl, bc
	ld	a, (hl)
	or	a, a
	jr	Z, 00103$
;src/PointerSelector.c:50: && (global_colision_map[s->tileindexBR-21] != EMPTY);
	ld	a, e
	add	a, #0xeb
	ld	l, a
	ld	a, d
	adc	a, #0xff
	ld	h, a
	add	hl, bc
	ld	a, (hl)
	or	a, a
	jr	NZ, 00104$
00103$:
	xor	a, a
	ret
00104$:
	ld	a, #0x01
;src/PointerSelector.c:51: }
	ret
;src/PointerSelector.c:53: void control_pointer(Pointer* s){
;	---------------------------------
; Function control_pointer
; ---------------------------------
_control_pointer::
	ld	c, e
	ld	b, d
;src/PointerSelector.c:55: if(joypad() & J_UP) {
	call	_joypad
;src/PointerSelector.c:56: s->y -= 8;
	ld	e, c
	ld	d, b
	inc	de
;src/PointerSelector.c:55: if(joypad() & J_UP) {
	bit	2, a
	jr	Z, 00121$
;src/PointerSelector.c:56: s->y -= 8;
	ld	a, (de)
	add	a, #0xf8
	ld	(de), a
	ret
00121$:
;src/PointerSelector.c:57: } else if(joypad() & J_DOWN) {
	push	de
	call	_joypad
	pop	de
	bit	3, a
	jr	Z, 00118$
;src/PointerSelector.c:58: s->y += 8;
	ld	a, (de)
	add	a, #0x08
	ld	(de), a
	ret
00118$:
;src/PointerSelector.c:59: } else if(joypad() & J_LEFT) {
	call	_joypad
;src/PointerSelector.c:60: s->x -= 8;
	ld	l, c
	ld	h, b
;src/PointerSelector.c:59: } else if(joypad() & J_LEFT) {
	bit	1, a
	jr	Z, 00115$
;src/PointerSelector.c:60: s->x -= 8;
	ld	a, (hl)
	add	a, #0xf8
	ld	(hl), a
	ret
00115$:
;src/PointerSelector.c:61: } else if(joypad() & J_RIGHT) {
	call	_joypad
	rrca
	jr	NC, 00112$
;src/PointerSelector.c:62: s->x += 8;
	ld	a, (hl)
	add	a, #0x08
	ld	(hl), a
	ret
00112$:
;src/PointerSelector.c:63: } else if(joypad() & J_A) {
	call	_joypad
	bit	4, a
	jr	Z, 00109$
;src/PointerSelector.c:64: if(block_is_not_placed_below(s) 
	push	bc
	ld	e, c
	ld	d, b
	call	_block_is_not_placed_below
	pop	bc
	or	a, a
	ret	Z
;src/PointerSelector.c:65: && (global_blocks_available[global_selected_block]>0)){
	ld	a, #<(_global_blocks_available)
	ld	hl, #_global_selected_block
	add	a, (hl)
	ld	e, a
	ld	a, #>(_global_blocks_available)
	adc	a, #0x00
	ld	d, a
	ld	a, (de)
	or	a, a
	ret	Z
;src/PointerSelector.c:66: place_object_at_pointer(s, global_selected_block + 6);
	ld	a, (hl)
	add	a, #0x06
	ld	e, c
	ld	d, b
	jp	_place_object_at_pointer
00109$:
;src/PointerSelector.c:68: } else if(joypad() & J_B) {
	call	_joypad
	bit	5, a
	ret	Z
;src/PointerSelector.c:69: if(block_is_placed_below(s)){
	push	bc
	ld	e, c
	ld	d, b
	call	_block_is_placed_below
	pop	bc
	or	a, a
	ret	Z
;src/PointerSelector.c:70: remove_object_at_pointer(s);
	ld	e, c
	ld	d, b
;src/PointerSelector.c:73: }
	jp	_remove_object_at_pointer
;src/PointerSelector.c:75: void update_pointer(Pointer* s) { 
;	---------------------------------
; Function update_pointer
; ---------------------------------
_update_pointer::
	ld	c, e
	ld	b, d
;src/PointerSelector.c:76: s->tileindexBR = tileindex_from_xy(s->x, s->y);
	ld	hl, #0x0006
	add	hl, bc
	ld	e, c
	ld	d, b
	inc	de
	ld	a, (de)
	ld	e, a
	ld	a, (bc)
	push	hl
	push	bc
	call	_tileindex_from_xy
	ld	e, c
	ld	d, b
	pop	bc
	pop	hl
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;src/PointerSelector.c:77: control_pointer(s);
	push	bc
	ld	e, c
	ld	d, b
	call	_control_pointer
;src/PointerSelector.c:78: move_pointer(s);
	pop	de
;src/PointerSelector.c:79: }
	jp	_move_pointer
;src/PointerSelector.c:81: void hide_pointer(void){
;	---------------------------------
; Function hide_pointer
; ---------------------------------
_hide_pointer::
;src/PointerSelector.c:82: for(uint8_t i= 4; i<=7; i++){
	ld	c, #0x04
00104$:
	ld	a, #0x07
	sub	a, c
	ret	C
;/home/josem/gbdk/include/gb/gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	de, #_shadow_OAM+0
	ld	l, c
	xor	a, a
	ld	h, a
	add	hl, hl
	add	hl, hl
	add	hl, de
;/home/josem/gbdk/include/gb/gb.h:1974: itm->y=y, itm->x=x;
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/PointerSelector.c:82: for(uint8_t i= 4; i<=7; i++){
	inc	c
;src/PointerSelector.c:85: }
	jr	00104$
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
