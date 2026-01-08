;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (Linux)
;--------------------------------------------------------
	.module PointerSelector
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _joypad
	.globl _change_colision_map_at
	.globl _change_bkg_tile_xy
	.globl _pointer_init
	.globl _move_pointer
	.globl _place_object_at_pointer
	.globl _remove_object_at_pointer
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
;src/PointerSelector.c:8: void pointer_init(Pointer* s) {
;	---------------------------------
; Function pointer_init
; ---------------------------------
_pointer_init::
;src/PointerSelector.c:9: s->x = 80;
	ld	a, #0x50
	ld	(de), a
;src/PointerSelector.c:10: s->y = 72;
	ld	l, e
	ld	h, d
	inc	hl
	ld	(hl), #0x48
;src/PointerSelector.c:11: for(uint8_t i = 4;i<=7;i++){
	inc	de
	inc	de
	ld	c, #0x04
00103$:
	ld	a, #0x07
	sub	a, c
	ret	C
;src/PointerSelector.c:12: s->sprite_ids[i] = i;
	ld	l, c
	ld	h, #0x00
	add	hl, de
	ld	(hl), c
;src/PointerSelector.c:11: for(uint8_t i = 4;i<=7;i++){
	inc	c
;src/PointerSelector.c:14: }
	jr	00103$
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
;src/PointerSelector.c:24: void place_object_at_pointer(uint8_t x, uint8_t y){
;	---------------------------------
; Function place_object_at_pointer
; ---------------------------------
_place_object_at_pointer::
	add	sp, #-6
	ldhl	sp,	#5
	ld	(hl), e
;src/PointerSelector.c:25: uint8_t indexBRx = (x - 8) / 8; //señala la columna
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
;src/PointerSelector.c:26: uint8_t indexBRy = (y - 16) / 8; //señala la fila
	ldhl	sp,	#5
	ld	a, (hl)
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
;src/PointerSelector.c:27: uint16_t tileindexBR = 20 * indexBRy + indexBRx;
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
	ld	d, #0x00
	add	a, c
	ld	e, a
	ld	a, d
	adc	a, b
	ld	d, a
;src/PointerSelector.c:28: change_colision_map_at(tileindexBR, SOLID);
	push	de
	ld	a, #0x01
	call	_change_colision_map_at
	pop	de
;src/PointerSelector.c:29: change_bkg_tile_xy(tileindexBR, 3);
	ld	a, #0x03
	call	_change_bkg_tile_xy
;src/PointerSelector.c:30: }
	add	sp, #6
	ret
;src/PointerSelector.c:32: void remove_object_at_pointer(uint8_t x, uint8_t y){
;	---------------------------------
; Function remove_object_at_pointer
; ---------------------------------
_remove_object_at_pointer::
	add	sp, #-6
	ldhl	sp,	#5
	ld	(hl), e
;src/PointerSelector.c:33: uint8_t indexBRx = (x - 8) / 8; //señala la columna
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
;src/PointerSelector.c:34: uint8_t indexBRy = (y - 16) / 8; //señala la fila
	ldhl	sp,	#5
	ld	a, (hl)
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
;src/PointerSelector.c:35: uint16_t tileindexBR = 20 * indexBRy + indexBRx;
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
	ld	d, #0x00
	add	a, c
	ld	e, a
	ld	a, d
	adc	a, b
	ld	d, a
;src/PointerSelector.c:36: change_colision_map_at(tileindexBR, EMPTY);
	push	de
	xor	a, a
	call	_change_colision_map_at
	pop	de
;src/PointerSelector.c:37: change_bkg_tile_xy(tileindexBR, 0);
	xor	a, a
	call	_change_bkg_tile_xy
;src/PointerSelector.c:38: }
	add	sp, #6
	ret
;src/PointerSelector.c:41: void control_pointer(Pointer* s){
;	---------------------------------
; Function control_pointer
; ---------------------------------
_control_pointer::
	ld	c, e
	ld	b, d
;src/PointerSelector.c:43: if(joypad() & J_UP) {
	call	_joypad
;src/PointerSelector.c:44: s->y -= 8;
	ld	e, c
	ld	d, b
	inc	de
;src/PointerSelector.c:43: if(joypad() & J_UP) {
	bit	2, a
	jr	Z, 00116$
;src/PointerSelector.c:44: s->y -= 8;
	ld	a, (de)
	add	a, #0xf8
	ld	(de), a
	ret
00116$:
;src/PointerSelector.c:45: } else if(joypad() & J_DOWN) {
	push	de
	call	_joypad
	pop	de
	bit	3, a
	jr	Z, 00113$
;src/PointerSelector.c:46: s->y += 8;
	ld	a, (de)
	add	a, #0x08
	ld	(de), a
	ret
00113$:
;src/PointerSelector.c:47: } else if(joypad() & J_LEFT) {
	push	de
	call	_joypad
	pop	de
;src/PointerSelector.c:48: s->x -= 8;
;src/PointerSelector.c:47: } else if(joypad() & J_LEFT) {
	bit	1, a
	jr	Z, 00110$
;src/PointerSelector.c:48: s->x -= 8;
	ld	a, (bc)
	add	a, #0xf8
	ld	(bc), a
	ret
00110$:
;src/PointerSelector.c:49: } else if(joypad() & J_RIGHT) {
	push	de
	call	_joypad
	pop	de
	rrca
	jr	NC, 00107$
;src/PointerSelector.c:50: s->x += 8;
	ld	a, (bc)
	add	a, #0x08
	ld	(bc), a
	ret
00107$:
;src/PointerSelector.c:51: } else if(joypad() & J_A) {
	push	de
	call	_joypad
	pop	de
	bit	4, a
	jr	Z, 00104$
;src/PointerSelector.c:52: place_object_at_pointer(s->x, s->y);
	ld	a, (de)
	ld	e, a
	ld	a, (bc)
	jp	_place_object_at_pointer
00104$:
;src/PointerSelector.c:53: } else if(joypad() & J_B) {
	push	de
	call	_joypad
	pop	de
	bit	5, a
	ret	Z
;src/PointerSelector.c:54: remove_object_at_pointer(s->x, s->y);
	ld	a, (de)
	ld	e, a
	ld	a, (bc)
;src/PointerSelector.c:56: }
	jp	_remove_object_at_pointer
;src/PointerSelector.c:58: void update_pointer(Pointer* s) { 
;	---------------------------------
; Function update_pointer
; ---------------------------------
_update_pointer::
;src/PointerSelector.c:59: control_pointer(s);
	push	de
	call	_control_pointer
	pop	de
;src/PointerSelector.c:60: move_pointer(s);
;src/PointerSelector.c:61: }
	jp	_move_pointer
;src/PointerSelector.c:63: void hide_pointer(void){
;	---------------------------------
; Function hide_pointer
; ---------------------------------
_hide_pointer::
;src/PointerSelector.c:64: for(uint8_t i= 4; i<=7; i++){
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
;src/PointerSelector.c:64: for(uint8_t i= 4; i<=7; i++){
	inc	c
;src/PointerSelector.c:67: }
	jr	00104$
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
