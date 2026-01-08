;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (Linux)
;--------------------------------------------------------
	.module PointerSelector
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _joypad
	.globl _pointer_init
	.globl _move_pointer
	.globl _control_pointer
	.globl _update_pointer
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
;src/PointerSelector.c:6: void pointer_init(Pointer* s) {
;	---------------------------------
; Function pointer_init
; ---------------------------------
_pointer_init::
;src/PointerSelector.c:7: s->x = 80;
	ld	a, #0x50
	ld	(de), a
;src/PointerSelector.c:8: s->y = 72;
	ld	l, e
	ld	h, d
	inc	hl
	ld	(hl), #0x48
;src/PointerSelector.c:10: for(uint8_t i = 4;i<=7;i++){
	inc	de
	inc	de
	ld	c, #0x04
00103$:
	ld	a, #0x07
	sub	a, c
	ret	C
;src/PointerSelector.c:11: s->sprite_ids[i] = i;
	ld	l, c
	ld	h, #0x00
	add	hl, de
	ld	(hl), c
;src/PointerSelector.c:10: for(uint8_t i = 4;i<=7;i++){
	inc	c
;src/PointerSelector.c:13: }
	jr	00103$
;src/PointerSelector.c:15: void move_pointer(Pointer* s) {
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
;src/PointerSelector.c:24: void control_pointer(Pointer* s){
;	---------------------------------
; Function control_pointer
; ---------------------------------
_control_pointer::
	ld	c, e
	ld	b, d
;src/PointerSelector.c:26: if(joypad() & J_UP) {
	call	_joypad
;src/PointerSelector.c:27: s->y -= 8;
	ld	e, c
	ld	d, b
	inc	de
;src/PointerSelector.c:26: if(joypad() & J_UP) {
	bit	2, a
	jr	Z, 00110$
;src/PointerSelector.c:27: s->y -= 8;
	ld	a, (de)
	add	a, #0xf8
	ld	(de), a
	ret
00110$:
;src/PointerSelector.c:28: } else if(joypad() & J_DOWN) {
	push	de
	call	_joypad
	pop	de
	bit	3, a
	jr	Z, 00107$
;src/PointerSelector.c:29: s->y += 8;
	ld	a, (de)
	add	a, #0x08
	ld	(de), a
	ret
00107$:
;src/PointerSelector.c:30: } else if(joypad() & J_LEFT) {
	call	_joypad
;src/PointerSelector.c:31: s->x -= 8;
;src/PointerSelector.c:30: } else if(joypad() & J_LEFT) {
	bit	1, a
	jr	Z, 00104$
;src/PointerSelector.c:31: s->x -= 8;
	ld	a, (bc)
	add	a, #0xf8
	ld	(bc), a
	ret
00104$:
;src/PointerSelector.c:32: } else if(joypad() & J_RIGHT) {
	call	_joypad
	rrca
	ret	NC
;src/PointerSelector.c:33: s->x += 8;
	ld	a, (bc)
	add	a, #0x08
	ld	(bc), a
;src/PointerSelector.c:35: }
	ret
;src/PointerSelector.c:37: void update_pointer(Pointer* s) { 
;	---------------------------------
; Function update_pointer
; ---------------------------------
_update_pointer::
;src/PointerSelector.c:38: control_pointer(s);
	push	de
	call	_control_pointer
	pop	de
;src/PointerSelector.c:39: move_pointer(s);
;src/PointerSelector.c:40: }
	jp	_move_pointer
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
