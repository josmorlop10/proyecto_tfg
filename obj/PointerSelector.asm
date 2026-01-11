;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (Linux)
;--------------------------------------------------------
	.module PointerSelector
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _can_pointer_move
	.globl _set_bkg_tiles
	.globl _joypad
	.globl _move_foward_block_id
	.globl _change_colision_map_BR
	.globl _change_colision_map_at
	.globl _tileindex_from_xy
	.globl _change_bkg_tile_16x16
	.globl _change_bkg_tile_xy
	.globl _pointer_init
	.globl _move_pointer
	.globl _place_object_at_pointer
	.globl _remove_object_at_pointer
	.globl _block_is_not_placed_below
	.globl _block_is_placed_below
	.globl _control_pointer
	.globl _print_counter
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
;src/PointerSelector.c:24: uint8_t can_pointer_move(Pointer* s, int8_t dir_x, int8_t dir_y){
;	---------------------------------
; Function can_pointer_move
; ---------------------------------
_can_pointer_move::
	ld	l, e
	ld	h, d
;src/PointerSelector.c:25: uint8_t new_x = s->x + dir_x*SPRITESIZE;
	ld	c, (hl)
;src/PointerSelector.c:26: uint8_t new_y = s->y + dir_y*SPRITESIZE;
	inc	hl
	add	a, a
	add	a, a
	add	a, a
	add	a, c
	ld	c, a
	ld	e, (hl)
	ldhl	sp,	#2
	ld	a, (hl)
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ld	b, a
;src/PointerSelector.c:28: if(new_x < 20 || new_x > 156 || new_y < 32 || new_y > 120){
	ld	a, c
	sub	a, #0x14
	jr	C, 00101$
	ld	a, #0x9c
	sub	a, c
	jr	C, 00101$
	ld	a, b
	sub	a, #0x20
	jr	C, 00101$
	ld	a, #0x78
	sub	a, b
	jr	NC, 00102$
00101$:
;src/PointerSelector.c:29: return 0;
	xor	a, a
	jr	00106$
00102$:
;src/PointerSelector.c:31: return 1;
	ld	a, #0x01
00106$:
;src/PointerSelector.c:33: }
	pop	hl
	inc	sp
	jp	(hl)
;src/PointerSelector.c:35: void place_object_at_pointer(Pointer* s, uint8_t block_type){
;	---------------------------------
; Function place_object_at_pointer
; ---------------------------------
_place_object_at_pointer::
	dec	sp
	dec	sp
	ldhl	sp,	#1
	ld	(hl), a
;src/PointerSelector.c:36: change_colision_map_at(s->tileindexBR, BLOCK);
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
;src/PointerSelector.c:37: change_colision_map_BR(s->tileindexBR, block_type);
	ld	l, c
	ld	h, b
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	push	bc
	push	hl
	ldhl	sp,	#5
	ld	a, (hl)
	pop	de
	call	_change_colision_map_BR
	pop	bc
;src/PointerSelector.c:38: change_bkg_tile_16x16(s->tileindexBR, global_selected_block * 4 + 31);
	ld	a, (_global_selected_block)
	add	a, a
	add	a, a
	add	a, #0x1f
	ldhl	sp,	#0
	ld	(hl), a
	ld	l, c
	ld	h, b
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#0
	ld	a, (hl)
	ld	e, c
	ld	d, b
	call	_change_bkg_tile_16x16
;src/PointerSelector.c:39: global_blocks_available[global_selected_block]--;
	ld	a, #<(_global_blocks_available)
	ld	hl, #_global_selected_block
	add	a, (hl)
	ld	c, a
	ld	a, #>(_global_blocks_available)
	adc	a, #0x00
	ld	b, a
	ld	a, (bc)
	dec	a
	ld	(bc), a
;src/PointerSelector.c:40: }
	inc	sp
	inc	sp
	ret
;src/PointerSelector.c:42: void remove_object_at_pointer(Pointer* s, uint8_t block_type){
;	---------------------------------
; Function remove_object_at_pointer
; ---------------------------------
_remove_object_at_pointer::
	dec	sp
	ldhl	sp,	#0
	ld	(hl), a
;src/PointerSelector.c:44: change_colision_map_at(s->tileindexBR, EMPTY);
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
;src/PointerSelector.c:45: change_bkg_tile_xy(s->tileindexBR, 0);
	pop	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	xor	a, a
	ld	e, c
	ld	d, b
	call	_change_bkg_tile_xy
;src/PointerSelector.c:46: global_blocks_available[block_type]++;
	ld	bc, #_global_blocks_available+0
	ldhl	sp,	#0
	ld	l, (hl)
	ld	h, #0x00
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	a, (bc)
	inc	a
	ld	(bc), a
;src/PointerSelector.c:47: }
	inc	sp
	ret
;src/PointerSelector.c:49: uint8_t block_is_not_placed_below(Pointer* s){
;	---------------------------------
; Function block_is_not_placed_below
; ---------------------------------
_block_is_not_placed_below::
;src/PointerSelector.c:50: return (global_colision_map[s->tileindexBR] == EMPTY) 
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
;src/PointerSelector.c:51: && (global_colision_map[s->tileindexBR-1] == EMPTY)
	ld	e,l
	ld	d,h
	dec	hl
	add	hl, bc
	ld	a, (hl)
	or	a, a
	jr	NZ, 00103$
;src/PointerSelector.c:52: && (global_colision_map[s->tileindexBR-20] == EMPTY)
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
;src/PointerSelector.c:53: && (global_colision_map[s->tileindexBR-21] == EMPTY);
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
;src/PointerSelector.c:54: }
	ret
;src/PointerSelector.c:56: uint8_t block_is_placed_below(Pointer* s){
;	---------------------------------
; Function block_is_placed_below
; ---------------------------------
_block_is_placed_below::
;src/PointerSelector.c:62: uint8_t res = 0;
	ld	c, #0x00
;src/PointerSelector.c:63: if ((global_colision_map[s->tileindexBR]>= RIGHT && global_colision_map[s->tileindexBR]<=DOWN) 
	ld	hl, #0x0006
	add	hl, de
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	a,#<(_global_colision_map)
	ld	e, a
	ld	a, #>(_global_colision_map)
	adc	a, h
	ld	d, a
	ld	a, (de)
	ld	e, a
	sub	a, #0x06
	jr	C, 00102$
	ld	a, #0x09
	sub	a, e
	jr	C, 00102$
;src/PointerSelector.c:64: && (global_colision_map[s->tileindexBR-1] != EMPTY)
	ld	b, l
	ld	d,h
	dec	hl
	push	de
	ld	de, #_global_colision_map
	add	hl, de
	pop	de
	ld	a, (hl)
	or	a, a
	jr	Z, 00102$
;src/PointerSelector.c:65: && (global_colision_map[s->tileindexBR-20] != EMPTY)
	ld	a, b
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
	or	a, a
	jr	Z, 00102$
;src/PointerSelector.c:66: && (global_colision_map[s->tileindexBR-21] != EMPTY)){
	ld	a, b
	add	a, #0xeb
	ld	l, a
	ld	a, d
	adc	a, #0xff
	ld	h, a
	push	de
	ld	de, #_global_colision_map
	add	hl, de
	pop	de
	ld	a, (hl)
	or	a, a
	jr	Z, 00102$
;src/PointerSelector.c:67: res = global_colision_map[s->tileindexBR];
	ld	c, e
00102$:
;src/PointerSelector.c:69: return res;
	ld	a, c
;src/PointerSelector.c:70: }
	ret
;src/PointerSelector.c:72: void control_pointer(Pointer* s){
;	---------------------------------
; Function control_pointer
; ---------------------------------
_control_pointer::
;src/PointerSelector.c:74: if(joypad() & J_UP) {
	push	de
	call	_joypad
	pop	de
;src/PointerSelector.c:76: s->y -= 8;
	ld	c, e
	ld	b, d
	inc	bc
;src/PointerSelector.c:74: if(joypad() & J_UP) {
	bit	2, a
	jr	Z, 00132$
;src/PointerSelector.c:75: if (can_pointer_move(s, 0, -1)){
	push	bc
	ld	a, #0xff
	push	af
	inc	sp
	xor	a, a
	call	_can_pointer_move
	pop	bc
	or	a, a
	ret	Z
;src/PointerSelector.c:76: s->y -= 8;
	ld	a, (bc)
	add	a, #0xf8
	ld	(bc), a
	ret
00132$:
;src/PointerSelector.c:78: } else if(joypad() & J_DOWN) {
	push	de
	call	_joypad
	pop	de
	bit	3, a
	jr	Z, 00129$
;src/PointerSelector.c:79: if (can_pointer_move(s, 0, 1)){
	push	bc
	ld	a, #0x01
	push	af
	inc	sp
	xor	a, a
	call	_can_pointer_move
	pop	bc
	or	a, a
	ret	Z
;src/PointerSelector.c:80: s->y += 8;
	ld	a, (bc)
	add	a, #0x08
	ld	(bc), a
	ret
00129$:
;src/PointerSelector.c:82: } else if(joypad() & J_LEFT) {
	push	de
	call	_joypad
	pop	de
;src/PointerSelector.c:84: s->x -= 8;
	ld	l, e
	ld	h, d
;src/PointerSelector.c:82: } else if(joypad() & J_LEFT) {
	bit	1, a
	jr	Z, 00126$
;src/PointerSelector.c:83: if (can_pointer_move(s, -1, 0)){
	push	hl
	xor	a, a
	push	af
	inc	sp
	ld	a, #0xff
	call	_can_pointer_move
	pop	hl
	or	a, a
	ret	Z
;src/PointerSelector.c:84: s->x -= 8;
	ld	a, (hl)
	add	a, #0xf8
	ld	(hl), a
	ret
00126$:
;src/PointerSelector.c:86: } else if(joypad() & J_RIGHT) {
	push	de
	call	_joypad
	pop	de
	rrca
	jr	NC, 00123$
;src/PointerSelector.c:87: if (can_pointer_move(s, 1, 0)){
	push	hl
	xor	a, a
	push	af
	inc	sp
	ld	a, #0x01
	call	_can_pointer_move
	pop	hl
	or	a, a
	ret	Z
;src/PointerSelector.c:88: s->x += 8;
	ld	a, (hl)
	add	a, #0x08
	ld	(hl), a
	ret
00123$:
;src/PointerSelector.c:90: } else if(joypad() & J_A) {
	push	de
	call	_joypad
	pop	de
	bit	4, a
	jr	Z, 00120$
;src/PointerSelector.c:91: if(block_is_not_placed_below(s) 
	push	de
	call	_block_is_not_placed_below
	pop	de
	or	a, a
	ret	Z
;src/PointerSelector.c:92: && (global_blocks_available[global_selected_block]>0)){
	ld	a, #<(_global_blocks_available)
	ld	hl, #_global_selected_block
	add	a, (hl)
	ld	c, a
	ld	a, #>(_global_blocks_available)
	adc	a, #0x00
	ld	b, a
	ld	a, (bc)
	or	a, a
	ret	Z
;src/PointerSelector.c:93: place_object_at_pointer(s, global_selected_block + 6);
	ld	a, (hl)
	add	a, #0x06
	jp	_place_object_at_pointer
00120$:
;src/PointerSelector.c:95: } else if(joypad() & J_B) {
	push	de
	call	_joypad
	pop	de
	bit	5, a
	jr	Z, 00117$
;src/PointerSelector.c:96: uint8_t block = block_is_placed_below(s);
	push	de
	call	_block_is_placed_below
	pop	de
;src/PointerSelector.c:97: if(block>=6){
	cp	a, #0x06
	ret	C
;src/PointerSelector.c:98: remove_object_at_pointer(s, block - 6);
	add	a, #0xfa
	jp	_remove_object_at_pointer
00117$:
;src/PointerSelector.c:100: } else if(joypad() & J_SELECT) {
	call	_joypad
	bit	6, a
	ret	Z
;src/PointerSelector.c:101: move_foward_block_id();
	call	_move_foward_block_id
;src/PointerSelector.c:102: print_counter();
;src/PointerSelector.c:104: }
	jp	_print_counter
;src/PointerSelector.c:107: void print_counter(void){
;	---------------------------------
; Function print_counter
; ---------------------------------
_print_counter::
	dec	sp
;src/PointerSelector.c:108: uint8_t tile_id = global_selected_block + 16;
	ld	a, (_global_selected_block)
	add	a, #0x10
;src/PointerSelector.c:109: set_bkg_tiles(1, 1, 1, 1, &tile_id);
	ldhl	sp,#0
	ld	(hl), a
	push	hl
	ld	hl, #0x101
	push	hl
	push	hl
	call	_set_bkg_tiles
;src/PointerSelector.c:110: }
	add	sp, #7
	ret
;src/PointerSelector.c:112: void update_pointer(Pointer* s) { 
;	---------------------------------
; Function update_pointer
; ---------------------------------
_update_pointer::
	ld	c, e
	ld	b, d
;src/PointerSelector.c:113: s->tileindexBR = tileindex_from_xy(s->x, s->y);
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
;src/PointerSelector.c:114: control_pointer(s);
	push	bc
	ld	e, c
	ld	d, b
	call	_control_pointer
;src/PointerSelector.c:115: move_pointer(s);
	pop	de
;src/PointerSelector.c:116: }
	jp	_move_pointer
;src/PointerSelector.c:118: void hide_pointer(void){
;	---------------------------------
; Function hide_pointer
; ---------------------------------
_hide_pointer::
;src/PointerSelector.c:119: for(uint8_t i= 4; i<=7; i++){
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
;src/PointerSelector.c:119: for(uint8_t i= 4; i<=7; i++){
	inc	c
;src/PointerSelector.c:122: }
	jr	00104$
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
