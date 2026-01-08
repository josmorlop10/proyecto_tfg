;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (Linux)
;--------------------------------------------------------
	.module Character
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _flip_direction
	.globl _movement_step_by_step
	.globl _tileindex_from_xy
	.globl _get_init_point_from_map
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
;src/Character.c:9: void set_direction(Character* p,  int8_t x, int8_t y){
;	---------------------------------
; Function set_direction
; ---------------------------------
_set_direction::
	ld	c, a
;src/Character.c:10: p->dir_x = x;
	ld	hl, #0x0006
	add	hl, de
	ld	(hl), c
;src/Character.c:11: p->dir_y = y;
	ld	hl, #0x0007
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#2
	ld	a, (hl)
	ld	(bc), a
;src/Character.c:12: }
	pop	hl
	inc	sp
	jp	(hl)
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
;src/Character.c:23: p->dir_x = 1;  
	ld	hl, #0x0006
	add	hl, de
	ld	(hl), #0x01
;src/Character.c:24: p->dir_y = 0; 
	ld	hl, #0x0007
	add	hl, de
	ld	(hl), #0x00
;src/Character.c:25: p->speed = 8;
	ld	hl, #0x0008
	add	hl, de
	ld	(hl), #0x08
;src/Character.c:26: for(uint8_t i = 0;i<=3;i++){
	ld	c, #0x00
00103$:
	ld	a, #0x03
	sub	a, c
	jr	C, 00101$
;src/Character.c:27: p->sprite_ids[i] = i;
	ld	l, c
	ld	h, #0x00
	add	hl, de
	ld	(hl), c
;src/Character.c:26: for(uint8_t i = 0;i<=3;i++){
	inc	c
	jr	00103$
00101$:
;src/Character.c:29: p->tileindexBR = 0;
	ld	hl, #0x0009
	add	hl, de
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/Character.c:30: p->next_tileindexBR = 0;
	ld	hl, #0x000b
	add	hl, de
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/Character.c:31: }
	inc	sp
	ret
;src/Character.c:33: void move_character(Character* p) {
;	---------------------------------
; Function move_character
; ---------------------------------
_move_character::
	dec	sp
	dec	sp
;src/Character.c:35: move_sprite(0, p->x-SPRITESIZE, p->y-SPRITESIZE);
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
;src/Character.c:36: move_sprite(1, p->x-SPRITESIZE, p->y);
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
;src/Character.c:37: move_sprite(2, p->x, p->y-SPRITESIZE);
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
;src/Character.c:38: move_sprite(3, p->x, p->y);
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
;src/Character.c:38: move_sprite(3, p->x, p->y);
;src/Character.c:40: }
	inc	sp
	inc	sp
	ret
;src/Character.c:42: void movement_step_by_step(Character* p){
;	---------------------------------
; Function movement_step_by_step
; ---------------------------------
_movement_step_by_step::
	add	sp, #-7
	ldhl	sp,	#4
	ld	a, e
	ld	(hl+), a
;src/Character.c:44: for(uint8_t i = 0; i < SPRITESIZE; i++) {
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
;src/Character.c:45: p->y += 1 * p->dir_y;
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
;src/Character.c:46: p->x += 1 * p->dir_x;
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
;src/Character.c:44: for(uint8_t i = 0; i < SPRITESIZE; i++) {
	ldhl	sp,	#6
	inc	(hl)
	jr	00103$
00105$:
;src/Character.c:48: }
	add	sp, #7
	ret
;src/Character.c:50: uint8_t canplayermove(Character* p){
;	---------------------------------
; Function canplayermove
; ---------------------------------
_canplayermove::
	add	sp, #-6
;src/Character.c:52: uint16_t tileindexBR = p->next_tileindexBR;
	ld	hl, #0x000b
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	ldhl	sp,	#0
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/Character.c:53: uint16_t tileindexTL = tileindexBR -21;
	pop	bc
	push	bc
	ld	a, c
	add	a, #0xeb
	ld	e, a
	ld	a, b
	adc	a, #0xff
	ldhl	sp,	#2
	ld	(hl), e
	inc	hl
;src/Character.c:54: uint16_t tileindexTR = tileindexBR -20;
	ld	(hl+), a
	ld	a, c
	add	a, #0xec
	ld	e, a
	ld	a, b
	adc	a, #0xff
	ld	(hl), e
	inc	hl
	ld	(hl), a
;src/Character.c:55: uint16_t tileindexBL = tileindexBR -1;
	dec	bc
;src/Character.c:58: if ((global_colision_map[tileindexTL] == SOLID) || 
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
;src/Character.c:59: (global_colision_map[tileindexTR] == SOLID) || 
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
;src/Character.c:60: (global_colision_map[tileindexBL] == SOLID) ||
	ld	hl, #_global_colision_map
	add	hl, bc
	ld	a, (hl)
	dec	a
	jr	Z, 00101$
;src/Character.c:61: (global_colision_map[tileindexBR] == SOLID))
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
;src/Character.c:63: return 0;
	xor	a, a
	jr	00106$
00102$:
;src/Character.c:78: return 1;
	ld	a, #0x01
00106$:
;src/Character.c:79: }
	add	sp, #6
	ret
;src/Character.c:81: void flip_direction(Character* p){
;	---------------------------------
; Function flip_direction
; ---------------------------------
_flip_direction::
;src/Character.c:82: p->dir_x = - p->dir_x;
	ld	hl, #0x0006
	add	hl, de
	xor	a, a
	sub	a, (hl)
	ld	(hl), a
;src/Character.c:83: p->dir_y = - p->dir_y;
	ld	hl, #0x0007
	add	hl, de
	xor	a, a
	sub	a, (hl)
	ld	(hl), a
;src/Character.c:84: }
	ret
;src/Character.c:86: void update_character(Character* p) { //devuelve las teclas actuales
;	---------------------------------
; Function update_character
; ---------------------------------
_update_character::
	add	sp, #-13
	ldhl	sp,	#11
	ld	a, e
	ld	(hl+), a
;src/Character.c:88: p->tileindexBR = tileindex_from_xy(p->x, p->y);
	ld	a, d
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0009
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,#11
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0005
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#4
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#3
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#10
	ld	(hl+), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
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
	push	bc
	ldhl	sp,	#12
	ld	e, (hl)
	call	_tileindex_from_xy
	ld	e, c
	ld	d, b
	pop	bc
	ld	a, e
	ld	(bc), a
	inc	bc
	ld	a, d
	ld	(bc), a
;src/Character.c:89: p->next_tileindexBR = tileindex_from_xy(p->x + SPRITESIZE * p->dir_x, p->y + SPRITESIZE * p->dir_y);
	ldhl	sp,#11
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000b
	add	hl, de
	inc	sp
	inc	sp
	push	hl
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	ldhl	sp,#11
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0007
	add	hl, de
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
	ld	a, (hl-)
	dec	hl
	dec	hl
	ld	d, a
	ld	a, (de)
	add	a, a
	add	a, a
	add	a, a
	add	a, c
	ld	c, a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	b, a
	ldhl	sp,#11
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0006
	add	hl, de
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
	add	a, b
	ld	e, c
	call	_tileindex_from_xy
	pop	hl
	push	hl
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/Character.c:91: if(canplayermove(p)) {
	ldhl	sp,	#11
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_canplayermove
	or	a, a
	jr	Z, 00102$
;src/Character.c:92: p->x += p->speed * p->dir_x;
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#10
	ld	(hl+), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0008
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
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
	ldhl	sp,	#10
	ld	e, (hl)
	add	a, e
	ldhl	sp,	#4
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
;src/Character.c:93: p->y += p->speed * p->dir_y;
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#10
	ld	(hl), a
	ld	a, (bc)
	ld	c, a
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	e, a
	ld	a, c
	call	__mulschar
	ldhl	sp,	#10
	ld	a, (hl)
	add	a, c
	ldhl	sp,	#2
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
	jr	00103$
00102$:
;src/Character.c:95: flip_direction(p);
	ldhl	sp,	#11
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_flip_direction
00103$:
;src/Character.c:97: move_character(p);
	ldhl	sp,	#11
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_move_character
;src/Character.c:98: }
	add	sp, #13
	ret
	.area _CODE
	.area _INITIALIZER
__xinit__debug:
	.db #0x00	; 0
	.area _CABS (ABS)
