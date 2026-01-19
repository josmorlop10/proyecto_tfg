;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (Linux)
;--------------------------------------------------------
	.module Character
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _take_effect
	.globl _flip_direction
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
	.globl _set_direction
	.globl _character_init
	.globl _move_character
	.globl _canplayermove
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
;src/Character.c:14: void set_direction(Character* p,  int8_t x, int8_t y){
;	---------------------------------
; Function set_direction
; ---------------------------------
_set_direction::
	ld	c, a
;src/Character.c:15: p->dir_x = x;
	ld	hl, #0x0008
	add	hl, de
	ld	(hl), c
;src/Character.c:16: p->dir_y = y;
	ld	hl, #0x0009
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#2
	ld	a, (hl)
	ld	(bc), a
;src/Character.c:17: }
	pop	hl
	inc	sp
	jp	(hl)
;src/Character.c:20: void character_init(Character* p) {
;	---------------------------------
; Function character_init
; ---------------------------------
_character_init::
	dec	sp
;src/Character.c:22: get_init_point_from_map(global_colision_map);
	push	de
	ld	de, #_global_colision_map
	call	_get_init_point_from_map
	pop	de
;src/Character.c:23: uint8_t player_x = (global_init_point % 20) * 8 + 8; //columna
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
;src/Character.c:24: uint8_t player_y = (global_init_point / 20) * 8 + 16; //fila
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
;src/Character.c:26: p->x = player_x;
	ld	hl, #0x0004
	add	hl, de
	push	hl
	ldhl	sp,	#2
	ld	a, (hl)
	pop	hl
	ld	(hl), a
;src/Character.c:27: p->y = player_y;
	ld	hl, #0x0005
	add	hl, de
	ld	(hl), c
;src/Character.c:28: p->w = 16;
	ld	hl, #0x0006
	add	hl, de
	ld	(hl), #0x10
;src/Character.c:29: p->h = 16;
	ld	hl, #0x0007
	add	hl, de
	ld	(hl), #0x10
;src/Character.c:30: p->dir_x = 1;  
	ld	hl, #0x0008
	add	hl, de
	ld	(hl), #0x01
;src/Character.c:31: p->dir_y = 0; 
	ld	hl, #0x0009
	add	hl, de
	ld	(hl), #0x00
;src/Character.c:32: p->speed = 8;
	ld	hl, #0x000a
	add	hl, de
	ld	(hl), #0x08
;src/Character.c:33: for(uint8_t i = 0;i<=3;i++){
	ld	c, #0x00
00103$:
	ld	a, #0x03
	sub	a, c
	jr	C, 00101$
;src/Character.c:34: p->sprite_ids[i] = i;
	ld	l, c
	ld	h, #0x00
	add	hl, de
	ld	(hl), c
;src/Character.c:33: for(uint8_t i = 0;i<=3;i++){
	inc	c
	jr	00103$
00101$:
;src/Character.c:36: p->tileindexBR = 0;
	ld	hl, #0x000b
	add	hl, de
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/Character.c:37: p->next_tileindexBR = 0;
	ld	hl, #0x000d
	add	hl, de
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/Character.c:38: }
	inc	sp
	ret
;src/Character.c:40: void move_character(Character* p) {
;	---------------------------------
; Function move_character
; ---------------------------------
_move_character::
	dec	sp
	dec	sp
;src/Character.c:42: move_sprite(0, p->x-SPRITESIZE, p->y-SPRITESIZE);
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
;src/Character.c:43: move_sprite(1, p->x-SPRITESIZE, p->y);
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
;src/Character.c:44: move_sprite(2, p->x, p->y-SPRITESIZE);
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
;src/Character.c:45: move_sprite(3, p->x, p->y);
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
;src/Character.c:45: move_sprite(3, p->x, p->y);
;src/Character.c:47: }
	inc	sp
	inc	sp
	ret
;src/Character.c:49: void movement_step_by_step(Character* p){
;	---------------------------------
; Function movement_step_by_step
; ---------------------------------
_movement_step_by_step::
	add	sp, #-7
	ldhl	sp,	#4
	ld	a, e
	ld	(hl+), a
;src/Character.c:51: for(uint8_t i = 0; i < SPRITESIZE; i++) {
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
;src/Character.c:52: p->y += 1 * p->dir_y;
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
;src/Character.c:53: p->x += 1 * p->dir_x;
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
;src/Character.c:51: for(uint8_t i = 0; i < SPRITESIZE; i++) {
	ldhl	sp,	#6
	inc	(hl)
	jr	00103$
00105$:
;src/Character.c:55: }
	add	sp, #7
	ret
;src/Character.c:57: uint8_t canplayermove(Character* p){
;	---------------------------------
; Function canplayermove
; ---------------------------------
_canplayermove::
	add	sp, #-10
	ldhl	sp,	#8
	ld	a, e
	ld	(hl+), a
;src/Character.c:59: uint16_t tileindexBR = p->next_tileindexBR;
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
;src/Character.c:60: uint16_t tileindexTL = tileindexBR -21;
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
;src/Character.c:61: uint16_t tileindexTR = tileindexBR -20;
	ld	(hl+), a
	ld	a, c
	add	a, #0xec
	ld	e, a
	ld	a, b
	adc	a, #0xff
	ld	(hl), e
	inc	hl
;src/Character.c:62: uint16_t tileindexBL = tileindexBR -1;
	ld	(hl+), a
	dec	bc
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/Character.c:65: if ((global_colision_map[tileindexTL] == SOLID) || 
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
;src/Character.c:66: (global_colision_map[tileindexTR] == SOLID) || 
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
;src/Character.c:67: (global_colision_map[tileindexBL] == SOLID) ||
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
;src/Character.c:68: (global_colision_map[tileindexBR] == SOLID))
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
;src/Character.c:70: return 0;
	xor	a, a
	jr	00114$
00102$:
;src/Character.c:73: uint8_t event = player_tileBR_over_a_block(p->tileindexBR);
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
;src/Character.c:74: if(global_blocks_active){
	ld	a, (#_global_blocks_active)
	or	a, a
	jr	Z, 00113$
;src/Character.c:75: switch(event){
	ldhl	sp,	#7
	ld	a, (hl)
	sub	a, #0x06
	jr	Z, 00106$
	ldhl	sp,	#7
	ld	a, (hl)
	sub	a, #0x07
	jr	Z, 00107$
	ldhl	sp,	#7
	ld	a, (hl)
	sub	a, #0x08
	jr	Z, 00108$
	ldhl	sp,	#7
	ld	a, (hl)
	sub	a, #0x09
	jr	Z, 00109$
	jr	00113$
;src/Character.c:76: case RIGHT:
00106$:
;src/Character.c:77: set_direction(p, 1, 0);
	xor	a, a
	push	af
	inc	sp
	ld	a, #0x01
	ldhl	sp,	#9
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	call	_set_direction
;src/Character.c:78: break;
	jr	00113$
;src/Character.c:79: case LEFT:
00107$:
;src/Character.c:80: set_direction(p, -1, 0);
	xor	a, a
	push	af
	inc	sp
	ld	a, #0xff
	ldhl	sp,	#9
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	call	_set_direction
;src/Character.c:81: break;
	jr	00113$
;src/Character.c:82: case UP:
00108$:
;src/Character.c:83: set_direction(p, 0, -1);
	ld	a, #0xff
	push	af
	inc	sp
	xor	a, a
	ldhl	sp,	#9
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	call	_set_direction
;src/Character.c:84: break;
	jr	00113$
;src/Character.c:85: case DOWN:
00109$:
;src/Character.c:86: set_direction(p, 0, 1);
	ld	a, #0x01
	push	af
	inc	sp
	xor	a, a
	ldhl	sp,	#9
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	call	_set_direction
;src/Character.c:90: }
00113$:
;src/Character.c:93: return 1;
	ld	a, #0x01
00114$:
;src/Character.c:94: }
	add	sp, #10
	ret
;src/Character.c:96: void flip_direction(Character* p){
;	---------------------------------
; Function flip_direction
; ---------------------------------
_flip_direction::
;src/Character.c:97: p->dir_x = - p->dir_x;
	ld	hl, #0x0008
	add	hl, de
	xor	a, a
	sub	a, (hl)
	ld	(hl), a
;src/Character.c:98: p->dir_y = - p->dir_y;
	ld	hl, #0x0009
	add	hl, de
	xor	a, a
	sub	a, (hl)
	ld	(hl), a
;src/Character.c:99: }
	ret
;src/Character.c:101: void take_effect(uint8_t index){
;	---------------------------------
; Function take_effect
; ---------------------------------
_take_effect::
;src/Character.c:106: uint8_t type = global_object_information[index*3+2];
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
;src/Character.c:107: switch (type)
	cp	a, #0x08
	ret	C
	cp	a, #0x11
	ret	NC
	add	a, #0xf8
	ld	c, a
	ld	b, #0x00
	ld	hl, #00128$
	add	hl, bc
	add	hl, bc
	ld	c, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, c
	jp	(hl)
00128$:
	.dw	00101$
	.dw	00112$
	.dw	00112$
	.dw	00112$
	.dw	00112$
	.dw	00112$
	.dw	00112$
	.dw	00112$
	.dw	00109$
;src/Character.c:109: case NO_ACTION:
00101$:
;src/Character.c:110: global_blocks_active = 0;
	xor	a, a
	ld	(#_global_blocks_active),a
;src/Character.c:111: break;
	ret
;src/Character.c:141: case DEAD:
00109$:
;src/Character.c:142: update_game_state(STATE_GAME_OVER);
	ld	a, #0x05
	jp	_update_game_state
;src/Character.c:147: }
00112$:
;src/Character.c:148: }
	ret
;src/Character.c:150: void update_character(Character* p) { //devuelve las teclas actuales
;	---------------------------------
; Function update_character
; ---------------------------------
_update_character::
	add	sp, #-14
	ld	c, e
	ld	b, d
;src/Character.c:152: if(player_tileBR_over_destination(p->next_tileindexBR)){
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
;src/Character.c:153: update_game_state(STATE_GAME_OVER);
	ld	a, #0x05
	call	_update_game_state
;src/Character.c:154: return;
	jp	00110$
00102$:
;src/Character.c:157: if(player_over_fall(p->next_tileindexBR)){
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
;src/Character.c:158: p->speed = 0;
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
;src/Character.c:157: if(player_over_fall(p->next_tileindexBR)){
	ld	a, e
	or	a, a
	jr	Z, 00104$
;src/Character.c:158: p->speed = 0;
	dec	hl
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
;src/Character.c:159: return;
	jp	00110$
00104$:
;src/Character.c:162: uint8_t object_index_in_array = check_colision_with_object( p->x - (p->w >> 1), p->y - (p->h >> 1) , p->w, p->h );
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
;src/Character.c:163: if(object_index_in_array != 255){ 
	ld	a, e
	inc	a
	jr	Z, 00106$
;src/Character.c:164: take_effect(object_index_in_array);
	push	bc
	push	de
	ld	a, e
	call	_take_effect
	pop	de
;src/Character.c:165: hide_object(object_index_in_array);
	ld	a, e
	call	_hide_object
	pop	bc
00106$:
;src/Character.c:168: p->tileindexBR = tileindex_from_xy(p->x, p->y);
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
;src/Character.c:169: p->next_tileindexBR = tileindex_from_xy(p->x + SPRITESIZE * p->dir_x, p->y + SPRITESIZE * p->dir_y);
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
;src/Character.c:171: if(canplayermove(p)) {
	push	bc
	ld	e, c
	ld	d, b
	call	_canplayermove
	pop	bc
	or	a, a
	jr	Z, 00108$
;src/Character.c:172: p->x += p->speed * p->dir_x;
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
;src/Character.c:173: p->y += p->speed * p->dir_y;
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
;src/Character.c:175: flip_direction(p);
	push	bc
	ld	e, c
	ld	d, b
	call	_flip_direction
	pop	bc
00109$:
;src/Character.c:177: move_character(p);
	ld	e, c
	ld	d, b
	call	_move_character
00110$:
;src/Character.c:178: }
	add	sp, #14
	ret
	.area _CODE
	.area _INITIALIZER
__xinit__debug:
	.db #0x00	; 0
__xinit__global_blocks_active:
	.db #0x01	; 1
	.area _CABS (ABS)
