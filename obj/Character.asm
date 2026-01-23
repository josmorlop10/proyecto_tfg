;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (Linux)
;--------------------------------------------------------
	.module Character
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _take_effect
	.globl _movement_step_by_step
	.globl _check_colision_with_object
	.globl _hide_object
	.globl _player_over_fall
	.globl _player_tileBR_over_destination
	.globl _player_tileBR_over_a_block
	.globl _tileindex_from_xy
	.globl _get_init_point_from_map
	.globl _update_game_state
	.globl _global_blocks_active
	.globl _debug
	.globl _character_init
	.globl _move_character
	.globl _canplayermove
	.globl _set_direction
	.globl _flip_direction
	.globl _rotate_direction
	.globl _update_character
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
_debug::
	.ds 1
_global_blocks_active::
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
;src/Character.c:15: void character_init(Character* p) {
;	---------------------------------
; Function character_init
; ---------------------------------
_character_init::
	dec	sp
;src/Character.c:17: get_init_point_from_map(global_colision_map);
	push	de
	ld	de, #_global_colision_map
	call	_get_init_point_from_map
	pop	de
;src/Character.c:18: uint8_t player_x = (global_init_point % 20) * 8 + 8; //columna
	ld	a, (_global_init_point)
	ld	l, a
	ld	a, (_global_init_point + 1)
	ld	h, a
	push	hl
	push	de
	ld	bc, #0x0014
	ld	e, l
	ld	d, h
	call	__moduint
	pop	de
	pop	hl
	ld	a, c
	add	a, a
	add	a, a
	add	a, a
	add	a, #0x08
	push	hl
	ldhl	sp,	#2
	ld	(hl), a
	pop	hl
;src/Character.c:19: uint8_t player_y = (global_init_point / 20) * 8 + 16; //fila
	push	de
	ld	bc, #0x0014
	ld	e, l
	ld	d, h
	call	__divuint
	pop	de
	ld	a, c
	add	a, a
	add	a, a
	add	a, a
	add	a, #0x10
	ld	c, a
;src/Character.c:21: p->x = player_x;
	ld	hl, #0x0004
	add	hl, de
	push	hl
	ldhl	sp,	#2
	ld	a, (hl)
	pop	hl
	ld	(hl), a
;src/Character.c:22: p->y = player_y;
	ld	hl, #0x0005
	add	hl, de
	ld	(hl), c
;src/Character.c:23: p->w = 16;
	ld	hl, #0x0006
	add	hl, de
	ld	(hl), #0x10
;src/Character.c:24: p->h = 16;
	ld	hl, #0x0007
	add	hl, de
	ld	(hl), #0x10
;src/Character.c:25: p->dir_x = 1;  
	ld	hl, #0x0008
	add	hl, de
	ld	(hl), #0x01
;src/Character.c:26: p->dir_y = 0; 
	ld	hl, #0x0009
	add	hl, de
	ld	(hl), #0x00
;src/Character.c:27: p->speed = 8;
	ld	hl, #0x000a
	add	hl, de
	ld	(hl), #0x08
;src/Character.c:28: for(uint8_t i = 0;i<=3;i++){
	ld	c, #0x00
00103$:
	ld	a, #0x03
	sub	a, c
	jr	C, 00101$
;src/Character.c:29: p->sprite_ids[i] = i;
	ld	l, c
	ld	h, #0x00
	add	hl, de
	ld	(hl), c
;src/Character.c:28: for(uint8_t i = 0;i<=3;i++){
	inc	c
	jr	00103$
00101$:
;src/Character.c:31: p->tileindexBR = 0;
	ld	hl, #0x000b
	add	hl, de
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/Character.c:32: p->next_tileindexBR = 0;
	ld	hl, #0x000d
	add	hl, de
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/Character.c:33: }
	inc	sp
	ret
;src/Character.c:35: void move_character(Character* p) {
;	---------------------------------
; Function move_character
; ---------------------------------
_move_character::
	dec	sp
	dec	sp
;src/Character.c:37: move_sprite(0, p->x-SPRITESIZE, p->y-SPRITESIZE);
	ld	hl, #0x0005
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	add	a, #0xf8
	ldhl	sp,	#0
	ld	(hl+), a
	inc	de
	inc	de
	inc	de
	inc	de
	ld	a, (de)
	add	a, #0xf8
	ld	(hl), a
;/home/josem/gbdk/include/gb/gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #_shadow_OAM
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
;src/Character.c:38: move_sprite(1, p->x-SPRITESIZE, p->y);
	ld	a, (bc)
	ldhl	sp,	#0
	ld	(hl+), a
	ld	a, (de)
	add	a, #0xf8
	ld	(hl), a
;/home/josem/gbdk/include/gb/gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 4)
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
;src/Character.c:39: move_sprite(2, p->x, p->y-SPRITESIZE);
	ld	a, (bc)
	add	a, #0xf8
	ldhl	sp,	#0
	ld	(hl+), a
	ld	a, (de)
	ld	(hl), a
;/home/josem/gbdk/include/gb/gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 8)
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
;src/Character.c:40: move_sprite(3, p->x, p->y);
	ld	a, (bc)
	ld	b, a
	ld	a, (de)
	ld	c, a
;/home/josem/gbdk/include/gb/gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 12)
;/home/josem/gbdk/include/gb/gb.h:1974: itm->y=y, itm->x=x;
	ld	a, b
	ld	(hl+), a
	ld	(hl), c
;src/Character.c:40: move_sprite(3, p->x, p->y);
;src/Character.c:42: }
	inc	sp
	inc	sp
	ret
;src/Character.c:44: void movement_step_by_step(Character* p){
;	---------------------------------
; Function movement_step_by_step
; ---------------------------------
_movement_step_by_step::
	add	sp, #-7
	ldhl	sp,	#4
	ld	a, e
	ld	(hl+), a
;src/Character.c:46: for(uint8_t i = 0; i < SPRITESIZE; i++) {
	ld	a, d
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0009
	add	hl, de
	inc	sp
	inc	sp
	push	hl
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0008
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#4
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#3
	ld	(hl), a
	ldhl	sp,	#6
	ld	(hl), #0x00
00103$:
	ldhl	sp,	#6
	ld	a, (hl)
	sub	a, #0x08
	jr	NC, 00105$
;src/Character.c:47: p->y += 1 * p->dir_y;
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0005
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	pop	de
	push	de
	push	af
	ld	a, (de)
	ld	l, a
	pop	af
	add	a, l
	ld	(bc), a
;src/Character.c:48: p->x += 1 * p->dir_x;
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ldhl	sp,#2
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	push	af
	ld	a, (de)
	ld	l, a
	pop	af
	add	a, l
	ld	(bc), a
;src/Character.c:46: for(uint8_t i = 0; i < SPRITESIZE; i++) {
	ldhl	sp,	#6
	inc	(hl)
	jr	00103$
00105$:
;src/Character.c:50: }
	add	sp, #7
	ret
;src/Character.c:52: uint8_t canplayermove(Character* p){
;	---------------------------------
; Function canplayermove
; ---------------------------------
_canplayermove::
	add	sp, #-10
	ldhl	sp,	#8
	ld	a, e
	ld	(hl+), a
;src/Character.c:54: uint16_t tileindexBR = p->next_tileindexBR;
	ld	a, d
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000d
	add	hl, de
	ld	c, l
	ld	b, h
	ld	e, c
	ld	d, b
	ld	a, (de)
	ldhl	sp,	#0
	ld	(hl+), a
	inc	de
	ld	a, (de)
;src/Character.c:55: uint16_t tileindexTL = tileindexBR -21;
	ld	(hl+), a
	pop	bc
	push	bc
	ld	a, c
	add	a, #0xeb
	ld	e, a
	ld	a, b
	adc	a, #0xff
	ld	(hl), e
	inc	hl
;src/Character.c:56: uint16_t tileindexTR = tileindexBR -20;
	ld	(hl+), a
	ld	a, c
	add	a, #0xec
	ld	e, a
	ld	a, b
	adc	a, #0xff
	ld	(hl), e
	inc	hl
;src/Character.c:57: uint16_t tileindexBL = tileindexBR -1;
	ld	(hl+), a
	dec	bc
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/Character.c:60: if ((global_colision_map[tileindexTL] == SOLID) || 
	ld	de, #_global_colision_map
	ldhl	sp,	#2
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	dec	a
	jr	Z, 00101$
;src/Character.c:61: (global_colision_map[tileindexTR] == SOLID) || 
	ld	de, #_global_colision_map
	ldhl	sp,	#4
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	dec	a
	jr	Z, 00101$
;src/Character.c:62: (global_colision_map[tileindexBL] == SOLID) ||
	ld	de, #_global_colision_map
	ldhl	sp,	#6
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	dec	a
	jr	Z, 00101$
;src/Character.c:63: (global_colision_map[tileindexBR] == SOLID))
	ld	de, #_global_colision_map
	pop	hl
	push	hl
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	dec	a
	jr	NZ, 00102$
00101$:
;src/Character.c:65: return 0;
	xor	a, a
	jp	00116$
00102$:
;src/Character.c:68: uint8_t event = player_tileBR_over_a_block(p->tileindexBR);
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000b
	add	hl, de
	ld	a, (hl+)
	ld	c, a
	ld	a, (hl)
	ld	e, c
	ld	d, a
	call	_player_tileBR_over_a_block
	ldhl	sp,	#7
	ld	(hl), a
;src/Character.c:69: if(global_blocks_active){
	ld	a, (#_global_blocks_active)
	or	a, a
	jr	Z, 00115$
;src/Character.c:70: switch(event){
	ldhl	sp,	#7
	ld	a, (hl)
	sub	a, #0x06
	jr	C, 00115$
	ld	a, #0x0b
	sub	a, (hl)
	jr	C, 00115$
	ld	a, (hl)
	add	a, #0xfa
	ld	c, a
	ld	b, #0x00
	ld	hl, #00165$
	add	hl, bc
	add	hl, bc
	ld	c, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, c
	jp	(hl)
00165$:
	.dw	00106$
	.dw	00107$
	.dw	00108$
	.dw	00109$
	.dw	00110$
	.dw	00111$
;src/Character.c:71: case RIGHT:
00106$:
;src/Character.c:72: set_direction(p, 1, 0);
	xor	a, a
	push	af
	inc	sp
	ld	a, #0x01
	ldhl	sp,	#9
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	call	_set_direction
;src/Character.c:73: break;
	jr	00115$
;src/Character.c:74: case LEFT:
00107$:
;src/Character.c:75: set_direction(p, -1, 0);
	xor	a, a
	push	af
	inc	sp
	ld	a, #0xff
	ldhl	sp,	#9
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	call	_set_direction
;src/Character.c:76: break;
	jr	00115$
;src/Character.c:77: case UP:
00108$:
;src/Character.c:78: set_direction(p, 0, -1);
	ld	a, #0xff
	push	af
	inc	sp
	xor	a, a
	ldhl	sp,	#9
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	call	_set_direction
;src/Character.c:79: break;
	jr	00115$
;src/Character.c:80: case DOWN:
00109$:
;src/Character.c:81: set_direction(p, 0, 1);
	ld	a, #0x01
	push	af
	inc	sp
	xor	a, a
	ldhl	sp,	#9
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	call	_set_direction
;src/Character.c:82: break;
	jr	00115$
;src/Character.c:83: case CLOCKWISE:
00110$:
;src/Character.c:84: rotate_direction(p, 1);
	ld	a, #0x01
	ldhl	sp,	#8
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	call	_rotate_direction
;src/Character.c:85: break;
	jr	00115$
;src/Character.c:86: case COUNTER_CLOCKWISE:
00111$:
;src/Character.c:87: rotate_direction(p, 0);
	xor	a, a
	ldhl	sp,	#8
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	call	_rotate_direction
;src/Character.c:92: }
00115$:
;src/Character.c:95: return 1;
	ld	a, #0x01
00116$:
;src/Character.c:96: }
	add	sp, #10
	ret
;src/Character.c:100: void set_direction(Character* p,  int8_t x, int8_t y){
;	---------------------------------
; Function set_direction
; ---------------------------------
_set_direction::
	ld	c, a
;src/Character.c:101: p->dir_x = x;
	ld	hl, #0x0008
	add	hl, de
	ld	(hl), c
;src/Character.c:102: p->dir_y = y;
	ld	hl, #0x0009
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#2
	ld	a, (hl)
	ld	(bc), a
;src/Character.c:103: }
	pop	hl
	inc	sp
	jp	(hl)
;src/Character.c:105: void flip_direction(Character* p){
;	---------------------------------
; Function flip_direction
; ---------------------------------
_flip_direction::
;src/Character.c:106: p->dir_x = - p->dir_x;
	ld	hl, #0x0008
	add	hl, de
	xor	a, a
	sub	a, (hl)
	ld	(hl), a
;src/Character.c:107: p->dir_y = - p->dir_y;
	ld	hl, #0x0009
	add	hl, de
	xor	a, a
	sub	a, (hl)
	ld	(hl), a
;src/Character.c:108: }
	ret
;src/Character.c:110: void rotate_direction(Character*p, uint8_t sentido){
;	---------------------------------
; Function rotate_direction
; ---------------------------------
_rotate_direction::
	dec	sp
	ld	l, a
;src/Character.c:113: uint8_t aux_x = p->dir_x;
	ld	a, e
	add	a, #0x08
	ld	c, a
	ld	a, d
	adc	a, #0x00
	ld	b, a
	ld	a, (bc)
	push	hl
	ldhl	sp,	#2
	ld	(hl), a
	pop	hl
;src/Character.c:117: p->dir_x = -p->dir_y;
	ld	a, e
	add	a, #0x09
	ld	e, a
	jr	NC, 00113$
	inc	d
00113$:
	ld	a, (de)
	ld	h, a
;src/Character.c:115: if(sentido){
	ld	a, l
	or	a, a
	jr	Z, 00102$
;src/Character.c:117: p->dir_x = -p->dir_y;
	xor	a, a
	sub	a, h
	ld	(bc), a
;src/Character.c:118: p->dir_y = aux_x;
	ldhl	sp,	#0
	ld	a, (hl)
	ld	(de), a
	jr	00104$
00102$:
;src/Character.c:121: p->dir_x = p->dir_y;
	ld	a, h
	ld	(bc), a
;src/Character.c:122: p->dir_y = aux_x;
	ldhl	sp,	#0
	ld	a, (hl)
	ld	(de), a
00104$:
;src/Character.c:125: }
	inc	sp
	ret
;src/Character.c:127: void take_effect(uint8_t index){
;	---------------------------------
; Function take_effect
; ---------------------------------
_take_effect::
;src/Character.c:132: uint8_t type = global_object_information[index*3+2];
	ld	c, a
	add	a, a
	add	a, c
	add	a, #0x02
	ld	c, a
	rlca
	sbc	a, a
	ld	b, a
	ld	hl, #_global_object_information
	add	hl, bc
	ld	a, (hl)
;src/Character.c:133: switch (type)
	cp	a, #0x08
	ret	C
	cp	a, #0x10
	ret	NC
	add	a, #0xf8
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
	.dw	00111$
	.dw	00111$
	.dw	00111$
	.dw	00111$
	.dw	00111$
	.dw	00101$
	.dw	00111$
	.dw	00111$
;src/Character.c:135: case NO_ACTION:
00101$:
;src/Character.c:136: global_blocks_active = 0;
	xor	a, a
	ld	(#_global_blocks_active),a
;src/Character.c:168: }
00111$:
;src/Character.c:169: }
	ret
;src/Character.c:171: void update_character(Character* p) { //devuelve las teclas actuales
;	---------------------------------
; Function update_character
; ---------------------------------
_update_character::
	add	sp, #-14
	ld	c, e
	ld	b, d
;src/Character.c:173: if(player_tileBR_over_destination(p->next_tileindexBR)){
	ld	hl, #0x000d
	add	hl, bc
	inc	sp
	inc	sp
	ld	e, l
	ld	d, h
	push	de
	ld	a, (de)
	ld	l, a
	inc	de
	ld	a, (de)
	push	bc
	ld	e, l
	ld	d, a
	call	_player_tileBR_over_destination
	pop	bc
	or	a, a
	jr	Z, 00102$
;src/Character.c:174: update_game_state(STATE_GAME_OVER);
	ld	a, #0x05
	call	_update_game_state
;src/Character.c:175: return;
	jp	00110$
00102$:
;src/Character.c:178: if(player_over_fall(p->next_tileindexBR)){
	pop	de
	push	de
	ld	a, (de)
	ld	l, a
	inc	de
	ld	a, (de)
	push	bc
	ld	e, l
	ld	d, a
	call	_player_over_fall
	ld	e, a
	pop	bc
;src/Character.c:179: p->speed = 0;
	ld	hl, #0x000a
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#4
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#3
	ld	(hl), a
;src/Character.c:178: if(player_over_fall(p->next_tileindexBR)){
	ld	a, e
	or	a, a
	jr	Z, 00104$
;src/Character.c:179: p->speed = 0;
	dec	hl
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
;src/Character.c:180: return;
	jp	00110$
00104$:
;src/Character.c:183: uint8_t object_index_in_array = check_colision_with_object( p->x - (p->w >> 1), p->y - (p->h >> 1) , p->w, p->h );
	ld	hl, #0x0007
	add	hl, bc
	ld	a, (hl)
	ldhl	sp,	#11
	ld	(hl), a
	ld	hl, #0x0006
	add	hl, bc
	ld	a, (hl)
	ldhl	sp,	#12
	ld	(hl), a
	ld	hl, #0x0005
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#6
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#5
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#11
	ld	e, (hl)
	inc	hl
	inc	hl
	srl	e
	sub	a, e
	ld	(hl), a
	ld	hl, #0x0004
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#8
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#7
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#12
	ld	e, (hl)
	dec	hl
	srl	e
	sub	a, e
	push	bc
	ld	h, (hl)
	push	hl
	inc	sp
	ldhl	sp,	#15
	ld	h, (hl)
	push	hl
	inc	sp
	ldhl	sp,	#17
	ld	e, (hl)
	call	_check_colision_with_object
	ld	e, a
	pop	bc
;src/Character.c:184: if(object_index_in_array != 255){ 
	ld	a, e
	inc	a
	jr	Z, 00106$
;src/Character.c:185: take_effect(object_index_in_array);
	push	bc
	push	de
	ld	a, e
	call	_take_effect
	pop	de
;src/Character.c:186: hide_object(object_index_in_array);
	ld	a, e
	call	_hide_object
	pop	bc
00106$:
;src/Character.c:189: p->tileindexBR = tileindex_from_xy(p->x, p->y);
	ld	hl, #0x000b
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#12
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#11
	ld	(hl), a
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (de)
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	push	af
	ld	a, (de)
	ld	l, a
	pop	af
	push	bc
	ld	e, a
	ld	a, l
	call	_tileindex_from_xy
	ldhl	sp,	#14
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	pop	bc
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
;src/Character.c:190: p->next_tileindexBR = tileindex_from_xy(p->x + SPRITESIZE * p->dir_x, p->y + SPRITESIZE * p->dir_y);
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#13
	ld	(hl), a
	ld	hl, #0x0009
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#10
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#9
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#13
	ld	e, (hl)
	add	a, e
	ldhl	sp,	#10
	ld	(hl), a
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#11
	ld	(hl), a
	ld	hl, #0x0008
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#14
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#13
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl-)
	dec	hl
	ld	d, a
	ld	a, (de)
	add	a, a
	add	a, a
	add	a, a
	ld	e, (hl)
	dec	hl
	add	a, e
	push	bc
	ld	e, (hl)
	call	_tileindex_from_xy
	ldhl	sp,	#12
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	pop	bc
	pop	de
	push	de
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
;src/Character.c:192: if(canplayermove(p)) {
	push	bc
	ld	e, c
	ld	d, b
	call	_canplayermove
	pop	bc
	or	a, a
	jr	Z, 00108$
;src/Character.c:193: p->x += p->speed * p->dir_x;
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#11
	ld	(hl), a
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,#12
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	push	af
	ld	a, (de)
	ld	l, a
	pop	af
	push	bc
	ld	e, l
	call	__mulschar
	ld	a, c
	pop	bc
	ldhl	sp,	#11
	ld	e, (hl)
	add	a, e
	ldhl	sp,	#6
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
;src/Character.c:194: p->y += p->speed * p->dir_y;
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#13
	ld	(hl), a
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,#8
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	push	af
	ld	a, (de)
	ld	l, a
	pop	af
	push	bc
	ld	e, l
	call	__mulschar
	ld	a, c
	pop	bc
	ldhl	sp,	#13
	ld	e, (hl)
	add	a, e
	ldhl	sp,	#4
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
	jr	00109$
00108$:
;src/Character.c:196: flip_direction(p);
	push	bc
	ld	e, c
	ld	d, b
	call	_flip_direction
	pop	bc
00109$:
;src/Character.c:198: move_character(p);
	ld	e, c
	ld	d, b
	call	_move_character
00110$:
;src/Character.c:199: }
	add	sp, #14
	ret
	.area _CODE
	.area _INITIALIZER
__xinit__debug:
	.db #0x00	; 0
__xinit__global_blocks_active:
	.db #0x01	; 1
	.area _CABS (ABS)
