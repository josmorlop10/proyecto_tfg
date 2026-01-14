;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (Linux)
;--------------------------------------------------------
	.module Object
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _check_colision_of_sprites
	.globl _global_object_information
	.globl _print_objects_in_screen
	.globl _hide_object
	.globl _check_colision_with_object
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
_global_object_information::
	.ds 6
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
;src/Object.c:8: void print_objects_in_screen(void){
;	---------------------------------
; Function print_objects_in_screen
; ---------------------------------
_print_objects_in_screen::
	dec	sp
	dec	sp
;src/Object.c:13: for(uint8_t e = 0; e<NUMBER_OF_OBJECTS; e++){
	ld	c, #0x00
00105$:
	ld	a, c
	sub	a, #0x02
	jr	NC, 00107$
;src/Object.c:14: obj_x = global_object_information[3*e];
	ld	l, c
	ld	h, #0x00
	ld	e, l
	ld	d, h
	add	hl, hl
	add	hl, de
	ld	de, #_global_object_information
	add	hl, de
	ld	a, (hl)
	ldhl	sp,	#0
	ld	(hl), a
;src/Object.c:15: obj_y = global_object_information[3*e + 1];
	ld	a, c
	ld	e, a
	add	a, a
	add	a, e
	ld	b, a
	ld	l, b
	inc	l
	ld	h, #0x00
	ld	de, #_global_object_information
	add	hl, de
	ld	a, (hl)
	ldhl	sp,	#1
	ld	(hl), a
;src/Object.c:16: obj_type = global_object_information[3*e + 2];
	inc	b
	inc	b
	ld	l, b
	ld	h, #0x00
	ld	de, #_global_object_information
	add	hl, de
	ld	d, (hl)
;src/Object.c:18: set_sprite_tile(8+e,obj_type);
	ld	a, c
	add	a, #0x08
	ld	e, a
	ld	b, e
;/home/josem/gbdk/include/gb/gb.h:1887: shadow_OAM[nb].tile=tile;
	xor	a, a
	ld	l, b
	ld	h, a
	add	hl, hl
	add	hl, hl
	ld	a, #<(_shadow_OAM)
	add	a, l
	ld	l, a
	ld	a, #>(_shadow_OAM)
	adc	a, h
	ld	h, a
	inc	hl
	inc	hl
	ld	(hl), d
;src/Object.c:19: move_sprite(8+e, obj_x, obj_y);
;/home/josem/gbdk/include/gb/gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	xor	a, a
	ld	l, e
	ld	h, a
	add	hl, hl
	add	hl, hl
	ld	a, l
	add	a, #<(_shadow_OAM)
	ld	e, a
	ld	a, h
	adc	a, #>(_shadow_OAM)
	ld	d, a
;/home/josem/gbdk/include/gb/gb.h:1974: itm->y=y, itm->x=x;
	ldhl	sp,	#1
	ld	a, (hl-)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
;src/Object.c:13: for(uint8_t e = 0; e<NUMBER_OF_OBJECTS; e++){
	inc	c
	jr	00105$
00107$:
;src/Object.c:21: }
	inc	sp
	inc	sp
	ret
;src/Object.c:23: void hide_object(uint8_t i){
;	---------------------------------
; Function hide_object
; ---------------------------------
_hide_object::
	ld	c, a
;src/Object.c:24: global_object_information[i*NUMBER_OF_OBJECTS] = 0;
	ld	de, #_global_object_information+0
	ld	l, c
	xor	a, a
	ld	h, a
	add	hl, hl
	add	hl, de
	ld	(hl), #0x00
;src/Object.c:25: global_object_information[i*NUMBER_OF_OBJECTS+1] = 0;
	ld	a, c
	add	a, a
	inc	a
	ld	l, a
	rlca
	sbc	a, a
	ld	h, a
	add	hl, de
	ld	(hl), #0x00
;src/Object.c:26: move_sprite(8+i, 0, 0);
	ld	a, c
	add	a, #0x08
	ld	e, a
;/home/josem/gbdk/include/gb/gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	bc, #_shadow_OAM+0
	xor	a, a
	ld	l, e
	ld	h, a
	add	hl, hl
	add	hl, hl
	add	hl, bc
;/home/josem/gbdk/include/gb/gb.h:1974: itm->y=y, itm->x=x;
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/Object.c:26: move_sprite(8+i, 0, 0);
;src/Object.c:27: }
	ret
;src/Object.c:29: uint8_t check_colision_with_object(uint8_t x, uint8_t y, uint8_t w, uint8_t h){
;	---------------------------------
; Function check_colision_with_object
; ---------------------------------
_check_colision_with_object::
	add	sp, #-4
	ldhl	sp,	#3
	ld	(hl-), a
	ld	(hl), e
;src/Object.c:33: uint8_t res = 0;
;src/Object.c:35: for(uint8_t e = 0; e<NUMBER_OF_OBJECTS; e++){
	ld	bc, #0x0
00105$:
	ld	a, b
	sub	a, #0x02
	jr	NC, 00103$
;src/Object.c:36: obj_x = global_object_information[3*e];
	ld	l, b
	ld	h, #0x00
	ld	e, l
	ld	d, h
	add	hl, hl
	add	hl, de
	ld	de, #_global_object_information
	add	hl, de
	ld	a, (hl)
	ldhl	sp,	#0
	ld	(hl), a
;src/Object.c:37: obj_y = global_object_information[3*e + 1];
	ld	l, b
	ld	e, l
	add	hl, hl
	add	hl, de
	ld	a, l
	inc	a
	add	a, #<(_global_object_information)
	ld	e, a
	ld	a, #0x00
	adc	a, #>(_global_object_information)
	ld	d, a
	ld	a, (de)
	ld	e, a
;src/Object.c:38: obj_type = global_object_information[3*e + 2];
	ld	a, l
	inc	a
	inc	a
	add	a, #<(_global_object_information)
	ld	l, a
	ld	a, #0x00
	adc	a, #>(_global_object_information)
	ld	h, a
	ld	a, (hl)
	ldhl	sp,	#1
	ld	(hl), a
;src/Object.c:41: if(check_colision_of_sprites(obj_x,obj_y,OBJECT_SIZE, OBJECT_SIZE,
	push	bc
	ldhl	sp,	#9
	ld	a, (hl-)
	ld	b, a
	ld	c, (hl)
	push	bc
	ldhl	sp,	#6
	ld	a, (hl+)
	push	af
	inc	sp
	ld	h, (hl)
	ld	l, #0x08
	push	hl
	ld	a, #0x08
	push	af
	inc	sp
	ldhl	sp,	#8
	ld	a, (hl)
	call	_check_colision_of_sprites
	pop	bc
	or	a, a
	jr	Z, 00106$
;src/Object.c:43: res = obj_type;
	ldhl	sp,	#1
	ld	c, (hl)
;src/Object.c:44: break;
	jr	00103$
00106$:
;src/Object.c:35: for(uint8_t e = 0; e<NUMBER_OF_OBJECTS; e++){
	inc	b
	jr	00105$
00103$:
;src/Object.c:47: return res;
	ld	a, c
;src/Object.c:48: }
	add	sp, #4
	pop	hl
	pop	bc
	jp	(hl)
	.area _CODE
	.area _INITIALIZER
__xinit__global_object_information:
	.db #0x54	; 84	'T'
	.db #0x1c	; 28
	.db #0x08	; 8
	.db #0x5c	; 92
	.db #0x1c	; 28
	.db #0x09	; 9
	.area _CABS (ABS)
