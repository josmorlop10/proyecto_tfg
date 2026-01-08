;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (Linux)
;--------------------------------------------------------
	.module Character
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _control_player
	.globl _flip_direction
	.globl _movement_step_by_step
	.globl _joypad
	.globl _get_init_point_from_map
	.globl _debug
	.globl _tile_index_BR
	.globl _next_tile_index_BR
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
;src/Character.c:10: uint16_t tile_index_BR(Character* p){
;	---------------------------------
; Function tile_index_BR
; ---------------------------------
_tile_index_BR::
	add	sp, #-7
	ldhl	sp,	#5
	ld	a, e
	ld	(hl+), a
;src/Character.c:11: uint8_t indexBRx = (p->x - 8) / 8; //señala la columna
	ld	a, d
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
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
;src/Character.c:12: uint8_t indexBRy = (p->y - 16) / 8; //señala la fila
	ldhl	sp,#5
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0005
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
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
;src/Character.c:13: uint16_t tileindexBR = 20 * (indexBRy) + (indexBRx);
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
;src/Character.c:15: return tileindexBR;
;src/Character.c:16: }
	add	sp, #7
	ret
;src/Character.c:18: uint16_t next_tile_index_BR(Character* p){
;	---------------------------------
; Function next_tile_index_BR
; ---------------------------------
_next_tile_index_BR::
	add	sp, #-3
	ldhl	sp,	#1
	ld	a, e
	ld	(hl+), a
;src/Character.c:19: uint8_t next_indexBRx = (p->x - 8 + SPRITESIZE * p->dir_x) / 8; //señala la columna
	ld	a, d
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ld	c, a
	ld	b, #0x00
	ld	a, c
	add	a, #0xf8
	ld	c, a
	ld	a, b
	adc	a, #0xff
	ld	b, a
	ldhl	sp,#1
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0006
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	ld	l, a
	rlca
	sbc	a, a
	ld	h, a
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, bc
	ld	c, l
	ld	b, h
	bit	7, h
	jr	Z, 00103$
	ld	bc, #0x7
	add	hl,bc
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
;src/Character.c:20: uint8_t next_indexBRy = (p->y - 16 + SPRITESIZE * p->dir_y) / 8; //señala la fila
	ld	a, c
	ld	(hl+), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0005
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ld	c, a
	ld	b, #0x00
	ld	a, c
	add	a, #0xf0
	ld	c, a
	ld	a, b
	adc	a, #0xff
	ld	b, a
	ldhl	sp,#1
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0007
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	ld	l, a
	rlca
	sbc	a, a
	ld	h, a
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, bc
	ld	c,l
	ld	b,h
	bit	7, b
	jr	Z, 00104$
	ld	hl, #0x0007
	add	hl, bc
00104$:
	sra	h
	rr	l
	sra	h
	rr	l
	sra	h
	rr	l
;src/Character.c:21: uint16_t next_tileindexBR = 20 * (next_indexBRy) + (next_indexBRx);
	ld	h, #0x00
	ld	c, l
	ld	b, h
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
;src/Character.c:23: return next_tileindexBR;
;src/Character.c:24: }
	add	sp, #3
	ret
;src/Character.c:26: void set_direction(Character* p,  int8_t x, int8_t y){
;	---------------------------------
; Function set_direction
; ---------------------------------
_set_direction::
	ld	c, a
;src/Character.c:27: p->dir_x = x;
	ld	hl, #0x0006
	add	hl, de
	ld	(hl), c
;src/Character.c:28: p->dir_y = y;
	ld	hl, #0x0007
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#2
	ld	a, (hl)
	ld	(bc), a
;src/Character.c:29: }
	pop	hl
	inc	sp
	jp	(hl)
;src/Character.c:32: void character_init(Character* p) {
;	---------------------------------
; Function character_init
; ---------------------------------
_character_init::
	dec	sp
;src/Character.c:34: get_init_point_from_map();
	push	de
	call	_get_init_point_from_map
	pop	de
;src/Character.c:35: uint8_t player_x = (global_init_point % 20) * 8 + 8; //columna
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
;src/Character.c:36: uint8_t player_y = (global_init_point / 20) * 8 + 16; //fila
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
;src/Character.c:38: p->x = player_x;
	ld	hl, #0x0004
	add	hl, de
	push	hl
	ldhl	sp,	#2
	ld	a, (hl)
	pop	hl
	ld	(hl), a
;src/Character.c:39: p->y = player_y;
	ld	hl, #0x0005
	add	hl, de
	ld	(hl), c
;src/Character.c:40: p->dir_x = 1;  
	ld	hl, #0x0006
	add	hl, de
	ld	(hl), #0x01
;src/Character.c:41: p->dir_y = 0; 
	ld	hl, #0x0007
	add	hl, de
	ld	(hl), #0x00
;src/Character.c:42: p->speed = 8;
	ld	hl, #0x0008
	add	hl, de
	ld	(hl), #0x08
;src/Character.c:43: for(uint8_t i = 0;i<=3;i++){
	ld	c, #0x00
00103$:
	ld	a, #0x03
	sub	a, c
	jr	C, 00105$
;src/Character.c:44: p->sprite_ids[i] = i;
	ld	l, c
	ld	h, #0x00
	add	hl, de
	ld	(hl), c
;src/Character.c:43: for(uint8_t i = 0;i<=3;i++){
	inc	c
	jr	00103$
00105$:
;src/Character.c:46: }
	inc	sp
	ret
;src/Character.c:48: void move_character(Character* p) {
;	---------------------------------
; Function move_character
; ---------------------------------
_move_character::
	dec	sp
	dec	sp
;src/Character.c:50: move_sprite(0, p->x-SPRITESIZE, p->y-SPRITESIZE);
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
;src/Character.c:51: move_sprite(1, p->x-SPRITESIZE, p->y);
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
;src/Character.c:52: move_sprite(2, p->x, p->y-SPRITESIZE);
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
;src/Character.c:53: move_sprite(3, p->x, p->y);
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
;src/Character.c:53: move_sprite(3, p->x, p->y);
;src/Character.c:55: }
	inc	sp
	inc	sp
	ret
;src/Character.c:57: void movement_step_by_step(Character* p){
;	---------------------------------
; Function movement_step_by_step
; ---------------------------------
_movement_step_by_step::
	add	sp, #-7
	ldhl	sp,	#4
	ld	a, e
	ld	(hl+), a
;src/Character.c:59: for(uint8_t i = 0; i < SPRITESIZE; i++) {
	ld	a, d
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0007
	add	hl, de
	inc	sp
	inc	sp
	push	hl
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0006
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
;src/Character.c:60: p->y += 1 * p->dir_y;
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
;src/Character.c:61: p->x += 1 * p->dir_x;
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
;src/Character.c:59: for(uint8_t i = 0; i < SPRITESIZE; i++) {
	ldhl	sp,	#6
	inc	(hl)
	jr	00103$
00105$:
;src/Character.c:63: }
	add	sp, #7
	ret
;src/Character.c:65: uint8_t canplayermove(Character* p){
;	---------------------------------
; Function canplayermove
; ---------------------------------
_canplayermove::
	add	sp, #-6
;src/Character.c:67: uint16_t tileindexBR = next_tile_index_BR(p);
	call	_next_tile_index_BR
	pop	hl
;src/Character.c:68: uint16_t tileindexTL = tileindexBR -21;
	push	bc
	ld	a, c
	add	a, #0xeb
	ld	e, a
	ld	a, b
	adc	a, #0xff
	ldhl	sp,	#2
	ld	(hl), e
	inc	hl
;src/Character.c:69: uint16_t tileindexTR = tileindexBR -20;
	ld	(hl+), a
	ld	a, c
	add	a, #0xec
	ld	e, a
	ld	a, b
	adc	a, #0xff
	ld	(hl), e
	inc	hl
	ld	(hl), a
;src/Character.c:70: uint16_t tileindexBL = tileindexBR -1;
	dec	bc
;src/Character.c:73: if ((global_colision_map[tileindexTL] == SOLID) || 
	ld	de, #_global_colision_map
	ldhl	sp,	#2
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	dec	a
	jr	Z, 00101$
;src/Character.c:74: (global_colision_map[tileindexTR] == SOLID) || 
	ld	de, #_global_colision_map
	ldhl	sp,	#4
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	dec	a
	jr	Z, 00101$
;src/Character.c:75: (global_colision_map[tileindexBL] == SOLID) ||
	ld	hl, #_global_colision_map
	add	hl, bc
	ld	a, (hl)
	dec	a
	jr	Z, 00101$
;src/Character.c:76: (global_colision_map[tileindexBR] == SOLID))
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
;src/Character.c:78: return 0;
	xor	a, a
	jr	00106$
00102$:
;src/Character.c:93: return 1;
	ld	a, #0x01
00106$:
;src/Character.c:94: }
	add	sp, #6
	ret
;src/Character.c:96: void flip_direction(Character* p){
;	---------------------------------
; Function flip_direction
; ---------------------------------
_flip_direction::
;src/Character.c:97: p->dir_x = - p->dir_x;
	ld	hl, #0x0006
	add	hl, de
	xor	a, a
	sub	a, (hl)
	ld	(hl), a
;src/Character.c:98: p->dir_y = - p->dir_y;
	ld	hl, #0x0007
	add	hl, de
	xor	a, a
	sub	a, (hl)
	ld	(hl), a
;src/Character.c:99: }
	ret
;src/Character.c:102: void control_player(Character* p){
;	---------------------------------
; Function control_player
; ---------------------------------
_control_player::
;src/Character.c:104: if(joypad() & J_UP) {
	push	de
	call	_joypad
	pop	de
	bit	2, a
	jr	Z, 00118$
;src/Character.c:105: set_direction(p, 0, -1);
	push	de
	ld	a, #0xff
	push	af
	inc	sp
	xor	a, a
	call	_set_direction
	pop	de
;src/Character.c:106: if(canplayermove(p)) {
	push	de
	call	_canplayermove
	pop	de
	or	a, a
	ret	Z
;src/Character.c:107: movement_step_by_step(p);
	jp	_movement_step_by_step
00118$:
;src/Character.c:109: } else if(joypad() & J_DOWN) {
	push	de
	call	_joypad
	pop	de
	bit	3, a
	jr	Z, 00115$
;src/Character.c:110: set_direction(p, 0, 1);
	push	de
	ld	a, #0x01
	push	af
	inc	sp
	xor	a, a
	call	_set_direction
	pop	de
;src/Character.c:111: if(canplayermove(p)) {
	push	de
	call	_canplayermove
	pop	de
	or	a, a
	ret	Z
;src/Character.c:112: movement_step_by_step(p);
	jp	_movement_step_by_step
00115$:
;src/Character.c:114: } else if(joypad() & J_LEFT) {
	push	de
	call	_joypad
	pop	de
	bit	1, a
	jr	Z, 00112$
;src/Character.c:115: set_direction(p, -1, 0);
	push	de
	xor	a, a
	push	af
	inc	sp
	ld	a, #0xff
	call	_set_direction
	pop	de
;src/Character.c:116: if(canplayermove(p)) {
	push	de
	call	_canplayermove
	pop	de
	or	a, a
	ret	Z
;src/Character.c:117: movement_step_by_step(p);
	jp	_movement_step_by_step
00112$:
;src/Character.c:119: } else if(joypad() & J_RIGHT) {
	push	de
	call	_joypad
	pop	de
	rrca
	ret	NC
;src/Character.c:120: set_direction(p, 1, 0);
	push	de
	xor	a, a
	push	af
	inc	sp
	ld	a, #0x01
	call	_set_direction
	pop	de
;src/Character.c:121: if(canplayermove(p)) {
	push	de
	call	_canplayermove
	pop	de
	or	a, a
;src/Character.c:122: movement_step_by_step(p);
	jp	NZ, _movement_step_by_step
;src/Character.c:125: }
	ret
;src/Character.c:127: void update_character(Character* p) { //devuelve las teclas actuales
;	---------------------------------
; Function update_character
; ---------------------------------
_update_character::
	add	sp, #-6
	ldhl	sp,	#4
	ld	a, e
	ld	(hl+), a
;src/Character.c:129: if(canplayermove(p)) {
	ld	a, d
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_canplayermove
	or	a, a
	jr	Z, 00102$
;src/Character.c:130: p->x += p->speed * p->dir_x;
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ldhl	sp,	#2
	ld	(hl), a
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0008
	add	hl, de
	inc	sp
	inc	sp
	ld	e, l
	ld	d, h
	push	de
	ld	a, (de)
	ldhl	sp,	#3
	ld	(hl+), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0006
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	push	bc
	ld	e, a
	ldhl	sp,	#5
	ld	a, (hl)
	call	__mulschar
	ld	a, c
	pop	bc
	ldhl	sp,	#2
	ld	e, (hl)
	add	a, e
	ld	(bc), a
;src/Character.c:131: p->y += p->speed * p->dir_y;
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0005
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ldhl	sp,	#2
	ld	(hl+), a
	pop	de
	push	de
	ld	a, (de)
	ld	(hl+), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0007
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	push	bc
	ld	e, a
	ldhl	sp,	#5
	ld	a, (hl)
	call	__mulschar
	ld	a, c
	pop	bc
	ldhl	sp,	#2
	ld	e, (hl)
	add	a, e
	ld	(bc), a
	jr	00103$
00102$:
;src/Character.c:133: flip_direction(p);
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_flip_direction
00103$:
;src/Character.c:135: control_player(p); //DEBUG
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_control_player
;src/Character.c:136: move_character(p);
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_move_character
;src/Character.c:137: }
	add	sp, #6
	ret
	.area _CODE
	.area _INITIALIZER
__xinit__debug:
	.db #0x00	; 0
	.area _CABS (ABS)
