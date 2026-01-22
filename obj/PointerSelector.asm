;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (Linux)
;--------------------------------------------------------
	.module PointerSelector
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _can_pointer_move
	.globl _set_win_tile_xy
	.globl _joypad
	.globl _move_sprite_block_pointer
	.globl _update_values_in_hud
	.globl _change_bkg_tile_16x16
	.globl _change_bkg_tile_xy
	.globl _check_colision_with_object
	.globl _move_foward_block_id
	.globl _change_colision_map_BR
	.globl _change_colision_map_at
	.globl _tileindex_from_xy
	.globl _selection_of_block_active
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
_selection_of_block_active::
	.ds 1
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
;src/PointerSelector.c:11: void pointer_init(Pointer* s) {
;	---------------------------------
; Function pointer_init
; ---------------------------------
_pointer_init::
;src/PointerSelector.c:12: s->x = 80;
	ld	l, e
	ld	h, d
	ld	(hl), #0x50
;src/PointerSelector.c:13: s->y = 72;
	push	hl
	inc	hl
	ld	(hl), #0x48
;src/PointerSelector.c:14: for(uint8_t i = 4;i<=7;i++){
	pop	bc
	push	bc
	inc	bc
	inc	bc
	ld	e, #0x04
00103$:
	ld	a, #0x07
	sub	a, e
	jr	C, 00101$
;src/PointerSelector.c:15: s->sprite_ids[i] = i;
	ld	l, e
	ld	h, #0x00
	add	hl, bc
	ld	(hl), e
;src/PointerSelector.c:14: for(uint8_t i = 4;i<=7;i++){
	inc	e
	jr	00103$
00101$:
;src/PointerSelector.c:17: s->tileindexBR = 0;
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
;src/PointerSelector.c:18: move_sprite_block_pointer(global_selected_block);
	ld	a, (_global_selected_block)
	inc	sp
	inc	sp
	jp	_move_sprite_block_pointer
;src/PointerSelector.c:19: }
	inc	sp
	inc	sp
	ret
;src/PointerSelector.c:21: void move_pointer(Pointer* s) {
;	---------------------------------
; Function move_pointer
; ---------------------------------
_move_pointer::
	dec	sp
	dec	sp
;src/PointerSelector.c:22: move_sprite(4, s->x- SPRITESIZE, s->y-SPRITESIZE);
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
;src/PointerSelector.c:23: move_sprite(5, s->x- SPRITESIZE, s->y);
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
;src/PointerSelector.c:24: move_sprite(6, s->x, s->y-SPRITESIZE);
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
;src/PointerSelector.c:25: move_sprite(7, s->x, s->y);
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
;src/PointerSelector.c:25: move_sprite(7, s->x, s->y);
;src/PointerSelector.c:27: }
	inc	sp
	inc	sp
	ret
;src/PointerSelector.c:29: uint8_t can_pointer_move(Pointer* s, int8_t dir_x, int8_t dir_y){
;	---------------------------------
; Function can_pointer_move
; ---------------------------------
_can_pointer_move::
	ld	l, e
	ld	h, d
;src/PointerSelector.c:30: uint8_t new_x = s->x + dir_x*SPRITESIZE;
	ld	c, (hl)
;src/PointerSelector.c:31: uint8_t new_y = s->y + dir_y*SPRITESIZE;
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
;src/PointerSelector.c:33: if(new_x < 20 || new_x > 156 || new_y < 32 || new_y > 120){
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
;src/PointerSelector.c:34: return 0;
	xor	a, a
	jr	00106$
00102$:
;src/PointerSelector.c:36: return 1;
	ld	a, #0x01
00106$:
;src/PointerSelector.c:38: }
	pop	hl
	inc	sp
	jp	(hl)
;src/PointerSelector.c:40: void place_object_at_pointer(Pointer* s, uint8_t block_type){
;	---------------------------------
; Function place_object_at_pointer
; ---------------------------------
_place_object_at_pointer::
	dec	sp
	dec	sp
	ldhl	sp,	#1
	ld	(hl), a
;src/PointerSelector.c:41: change_colision_map_at(s->tileindexBR, BLOCK);
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
;src/PointerSelector.c:42: change_colision_map_BR(s->tileindexBR, block_type);
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
;src/PointerSelector.c:43: change_bkg_tile_16x16(s->tileindexBR, global_selected_block * 4 + UMBRAL_BLOCKS);
	ld	a, (_global_selected_block)
	add	a, a
	add	a, a
	add	a, #0x47
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
;src/PointerSelector.c:44: global_blocks_available[global_selected_block]--;
	ld	a, (_global_selected_block)
	ld	c, a
	rlca
	sbc	a, a
	ld	b, a
	ld	hl, #_global_blocks_available
	add	hl, bc
	dec	(hl)
;src/PointerSelector.c:45: update_values_in_hud(block_type, global_blocks_available[global_selected_block]);
	ld	a, (_global_selected_block)
	ld	l, a
	rlca
	sbc	a, a
	ld	h, a
	ld	de, #_global_blocks_available
	add	hl, de
	ld	e, (hl)
	ldhl	sp,	#1
	ld	a, (hl)
	inc	sp
	inc	sp
	jp	_update_values_in_hud
;src/PointerSelector.c:46: }
	inc	sp
	inc	sp
	ret
;src/PointerSelector.c:48: void remove_object_at_pointer(Pointer* s, uint8_t block_type){
;	---------------------------------
; Function remove_object_at_pointer
; ---------------------------------
_remove_object_at_pointer::
	dec	sp
	dec	sp
	ldhl	sp,	#1
;src/PointerSelector.c:50: uint8_t block_index = block_type - RIGHT;
	ld	(hl-), a
	add	a, #0xfa
	ld	(hl), a
;src/PointerSelector.c:51: change_colision_map_at(s->tileindexBR, EMPTY);
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
;src/PointerSelector.c:52: change_bkg_tile_xy(s->tileindexBR, 0);
	pop	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	xor	a, a
	ld	e, c
	ld	d, b
	call	_change_bkg_tile_xy
;src/PointerSelector.c:53: global_blocks_available[block_index]++;
	ld	de, #_global_blocks_available
	ldhl	sp,	#0
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	inc	a
	ld	(bc), a
;src/PointerSelector.c:54: update_values_in_hud(block_type, global_blocks_available[block_index]);
	ld	e, a
	ldhl	sp,	#1
	ld	a, (hl)
	inc	sp
	inc	sp
	jp	_update_values_in_hud
;src/PointerSelector.c:55: }
	inc	sp
	inc	sp
	ret
;src/PointerSelector.c:57: uint8_t block_is_not_placed_below(Pointer* s){
;	---------------------------------
; Function block_is_not_placed_below
; ---------------------------------
_block_is_not_placed_below::
;src/PointerSelector.c:58: return (global_colision_map[s->tileindexBR] == EMPTY) 
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
;src/PointerSelector.c:59: && (global_colision_map[s->tileindexBR-1] == EMPTY)
	ld	e,l
	ld	d,h
	dec	hl
	add	hl, bc
	ld	a, (hl)
	or	a, a
	jr	NZ, 00103$
;src/PointerSelector.c:60: && (global_colision_map[s->tileindexBR-20] == EMPTY)
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
;src/PointerSelector.c:61: && (global_colision_map[s->tileindexBR-21] == EMPTY);
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
;src/PointerSelector.c:62: }
	ret
;src/PointerSelector.c:64: uint8_t block_is_placed_below(Pointer* s){
;	---------------------------------
; Function block_is_placed_below
; ---------------------------------
_block_is_placed_below::
	add	sp, #-3
;src/PointerSelector.c:70: uint8_t res = 0;
	ld	c, #0x00
;src/PointerSelector.c:71: if ((global_colision_map[s->tileindexBR]>= RIGHT && global_colision_map[s->tileindexBR]<=LEFT_DOWN) 
	ld	hl, #0x0006
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	ldhl	sp,	#0
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	ld	de, #_global_colision_map
	pop	hl
	push	hl
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	ldhl	sp,	#2
	ld	(hl), a
	sub	a, #0x06
	jr	C, 00102$
	ld	a, #0x0d
	sub	a, (hl)
	jr	C, 00102$
;src/PointerSelector.c:72: && (global_colision_map[s->tileindexBR-1] == BLOCK)
	pop	de
	push	de
	ld	l, e
	ld	h, d
	dec	hl
	push	de
	ld	de, #_global_colision_map
	add	hl, de
	pop	de
	ld	a, (hl)
	sub	a, #0x05
	jr	NZ, 00102$
;src/PointerSelector.c:73: && (global_colision_map[s->tileindexBR-20] == BLOCK)
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
	jr	NZ, 00102$
;src/PointerSelector.c:74: && (global_colision_map[s->tileindexBR-21] == BLOCK)){
	ld	a, e
	add	a, #0xeb
	ld	l, a
	ld	a, d
	adc	a, #0xff
	ld	h, a
	ld	de, #_global_colision_map
	add	hl, de
	ld	a, (hl)
	sub	a, #0x05
	jr	NZ, 00102$
;src/PointerSelector.c:75: res = global_colision_map[s->tileindexBR];
	ldhl	sp,	#2
	ld	c, (hl)
00102$:
;src/PointerSelector.c:77: return res;
	ld	a, c
;src/PointerSelector.c:78: }
	add	sp, #3
	ret
;src/PointerSelector.c:80: void control_pointer(Pointer* s){
;	---------------------------------
; Function control_pointer
; ---------------------------------
_control_pointer::
	push	de
;src/PointerSelector.c:82: if(selection_of_block_active==0){
	ld	a, (#_selection_of_block_active)
	or	a, a
	jp	NZ, 00150$
;src/PointerSelector.c:83: if(joypad() & J_UP) {
	call	_joypad
;src/PointerSelector.c:85: s->y -= 8;
	pop	bc
	push	bc
	inc	bc
;src/PointerSelector.c:83: if(joypad() & J_UP) {
	bit	2, a
	jr	Z, 00133$
;src/PointerSelector.c:84: if (can_pointer_move(s, 0, -1)){
	push	bc
	ld	a, #0xff
	push	af
	inc	sp
	xor	a, a
	ldhl	sp,	#3
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	call	_can_pointer_move
	pop	bc
	or	a, a
	jp	Z, 00152$
;src/PointerSelector.c:85: s->y -= 8;
	ld	a, (bc)
	add	a, #0xf8
	ld	(bc), a
	jp	00152$
00133$:
;src/PointerSelector.c:87: } else if(joypad() & J_DOWN) {
	call	_joypad
	bit	3, a
	jr	Z, 00130$
;src/PointerSelector.c:88: if (can_pointer_move(s, 0, 1)){
	push	bc
	ld	a, #0x01
	push	af
	inc	sp
	xor	a, a
	ldhl	sp,	#3
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	call	_can_pointer_move
	pop	bc
	or	a, a
	jp	Z, 00152$
;src/PointerSelector.c:89: s->y += 8;
	ld	a, (bc)
	add	a, #0x08
	ld	(bc), a
	jp	00152$
00130$:
;src/PointerSelector.c:91: } else if(joypad() & J_LEFT) {
	call	_joypad
;src/PointerSelector.c:93: s->x -= 8;
	pop	de
	push	de
;src/PointerSelector.c:91: } else if(joypad() & J_LEFT) {
	bit	1, a
	jr	Z, 00127$
;src/PointerSelector.c:92: if (can_pointer_move(s, -1, 0)){
	push	de
	xor	a, a
	push	af
	inc	sp
	ld	a, #0xff
	ldhl	sp,	#3
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	call	_can_pointer_move
	pop	de
	or	a, a
	jp	Z, 00152$
;src/PointerSelector.c:93: s->x -= 8;
	ld	a, (de)
	add	a, #0xf8
	ld	(de), a
	jp	00152$
00127$:
;src/PointerSelector.c:95: } else if(joypad() & J_RIGHT) {
	push	de
	call	_joypad
	pop	de
	rrca
	jr	NC, 00124$
;src/PointerSelector.c:96: if (can_pointer_move(s, 1, 0)){
	push	de
	xor	a, a
	push	af
	inc	sp
	ld	a, #0x01
	ldhl	sp,	#3
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	call	_can_pointer_move
	pop	de
	or	a, a
	jp	Z, 00152$
;src/PointerSelector.c:97: s->x += 8;
	ld	a, (de)
	add	a, #0x08
	ld	(de), a
	jp	00152$
00124$:
;src/PointerSelector.c:99: } else if(joypad() & J_A) {
	push	de
	call	_joypad
	pop	de
	bit	4, a
	jr	Z, 00121$
;src/PointerSelector.c:100: if(block_is_not_placed_below(s) 
	push	bc
	push	de
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_block_is_not_placed_below
	pop	de
	pop	bc
	or	a, a
	jp	Z, 00152$
;src/PointerSelector.c:101: && (global_blocks_available[global_selected_block]>0)
	ld	a, (_global_selected_block)
	ld	l, a
	rlca
	sbc	a, a
	ld	h, a
	push	de
	ld	de, #_global_blocks_available
	add	hl, de
	pop	de
	ld	a, (hl)
	or	a, a
	jp	Z, 00152$
;src/PointerSelector.c:102: && check_colision_with_object(s->x - (16 >> 1), s->y - (16 >> 1) , 16, 16) == 255){
	ld	a, (bc)
	add	a, #0xf8
	ld	c, a
	ld	a, (de)
	add	a, #0xf8
	ld	h, #0x10
	push	hl
	inc	sp
	ld	h, #0x10
	push	hl
	inc	sp
	ld	e, c
	call	_check_colision_with_object
	inc	a
	jp	NZ, 00152$
;src/PointerSelector.c:103: place_object_at_pointer(s, global_selected_block + 6);
	ld	a, (#_global_selected_block)
	add	a, #0x06
	pop	de
	jp	_place_object_at_pointer
	jp	00152$
00121$:
;src/PointerSelector.c:105: } else if(joypad() & J_B) {
	call	_joypad
	bit	5, a
	jr	Z, 00118$
;src/PointerSelector.c:106: uint8_t block = block_is_placed_below(s);
	pop	de
	push	de
	call	_block_is_placed_below
;src/PointerSelector.c:107: if(block>=6){
	cp	a, #0x06
	jp	C, 00152$
;src/PointerSelector.c:108: remove_object_at_pointer(s, block);
	pop	de
	jp	_remove_object_at_pointer
	jp	00152$
00118$:
;src/PointerSelector.c:110: } else if(joypad() & J_SELECT) {
	call	_joypad
	bit	6, a
	jp	Z, 00152$
;src/PointerSelector.c:111: selection_of_block_active = !selection_of_block_active;
	ld	hl, #_selection_of_block_active
	ld	a, (hl)
	sub	a, #0x01
	ld	a, #0x00
	rla
	ld	(hl), a
;src/PointerSelector.c:112: set_win_tile_xy(0,1,130);
	ld	a, #0x82
	push	af
	inc	sp
	ld	e, #0x01
	xor	a, a
	call	_set_win_tile_xy
	jr	00152$
00150$:
;src/PointerSelector.c:116: if(joypad() & J_UP) {
	call	_joypad
	bit	2, a
	jr	Z, 00147$
;src/PointerSelector.c:117: move_foward_block_id(2);
	ld	a, #0x02
	call	_move_foward_block_id
;src/PointerSelector.c:118: move_sprite_block_pointer(global_selected_block);
	ld	a, (_global_selected_block)
	inc	sp
	inc	sp
	jp	_move_sprite_block_pointer
	jr	00152$
00147$:
;src/PointerSelector.c:120: } else if(joypad() & J_DOWN) {
	call	_joypad
	bit	3, a
	jr	Z, 00144$
;src/PointerSelector.c:121: move_foward_block_id(3);
	ld	a, #0x03
	call	_move_foward_block_id
;src/PointerSelector.c:122: move_sprite_block_pointer(global_selected_block);
	ld	a, (_global_selected_block)
	inc	sp
	inc	sp
	jp	_move_sprite_block_pointer
	jr	00152$
00144$:
;src/PointerSelector.c:123: } else if(joypad() & J_LEFT) {
	call	_joypad
	bit	1, a
	jr	Z, 00141$
;src/PointerSelector.c:124: move_foward_block_id(1);
	ld	a, #0x01
	call	_move_foward_block_id
;src/PointerSelector.c:125: move_sprite_block_pointer(global_selected_block);
	ld	a, (_global_selected_block)
	inc	sp
	inc	sp
	jp	_move_sprite_block_pointer
	jr	00152$
00141$:
;src/PointerSelector.c:126: } else if(joypad() & J_RIGHT) {
	call	_joypad
	rrca
	jr	NC, 00138$
;src/PointerSelector.c:127: move_foward_block_id(0);
	xor	a, a
	call	_move_foward_block_id
;src/PointerSelector.c:128: move_sprite_block_pointer(global_selected_block);
	ld	a, (_global_selected_block)
	inc	sp
	inc	sp
	jp	_move_sprite_block_pointer
	jr	00152$
00138$:
;src/PointerSelector.c:130: } else if(joypad() & J_SELECT) {
	call	_joypad
	bit	6, a
	jr	Z, 00152$
;src/PointerSelector.c:131: selection_of_block_active = !selection_of_block_active;
	ld	hl, #_selection_of_block_active
	ld	a, (hl)
	sub	a, #0x01
	ld	a, #0x00
	rla
	ld	(hl), a
;src/PointerSelector.c:132: set_win_tile_xy(0,1,131);
	ld	a, #0x83
	push	af
	inc	sp
	ld	e, #0x01
	xor	a, a
	call	_set_win_tile_xy
00152$:
;src/PointerSelector.c:135: }
	inc	sp
	inc	sp
	ret
;src/PointerSelector.c:137: void update_pointer(Pointer* s) { 
;	---------------------------------
; Function update_pointer
; ---------------------------------
_update_pointer::
	ld	c, e
	ld	b, d
;src/PointerSelector.c:138: s->tileindexBR = tileindex_from_xy(s->x, s->y);
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
;src/PointerSelector.c:139: control_pointer(s);
	push	bc
	ld	e, c
	ld	d, b
	call	_control_pointer
;src/PointerSelector.c:140: move_pointer(s);
	pop	de
;src/PointerSelector.c:141: }
	jp	_move_pointer
;src/PointerSelector.c:143: void hide_pointer(void){
;	---------------------------------
; Function hide_pointer
; ---------------------------------
_hide_pointer::
;src/PointerSelector.c:144: for(uint8_t i= 4; i<=7; i++){
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
;src/PointerSelector.c:144: for(uint8_t i= 4; i<=7; i++){
	inc	c
;src/PointerSelector.c:147: }
	jr	00104$
	.area _CODE
	.area _INITIALIZER
__xinit__selection_of_block_active:
	.db #0x00	; 0
	.area _CABS (ABS)
