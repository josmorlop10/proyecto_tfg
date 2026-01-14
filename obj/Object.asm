;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (Linux)
;--------------------------------------------------------
	.module Object
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _global_object_information
	.globl _print_objects_in_screen
	.globl _hide_object
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
;src/Object.c:7: void print_objects_in_screen(void){
;	---------------------------------
; Function print_objects_in_screen
; ---------------------------------
_print_objects_in_screen::
	dec	sp
	dec	sp
;src/Object.c:14: for(uint8_t e = 0; e<NUMBER_OF_OBJECTS; e++){
	ld	c, #0x00
00105$:
	ld	a, c
	sub	a, #0x02
	jr	NC, 00107$
;src/Object.c:15: obj_x = global_object_information[3*e];
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
;src/Object.c:16: obj_y = global_object_information[3*e + 1];
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
;src/Object.c:17: obj_type = global_object_information[3*e + 2];
	inc	b
	inc	b
	ld	l, b
	ld	h, #0x00
	ld	de, #_global_object_information
	add	hl, de
	ld	d, (hl)
;src/Object.c:19: set_sprite_tile(8+e,obj_type);
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
;src/Object.c:20: move_sprite(8+e, obj_x, obj_y);
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
;src/Object.c:14: for(uint8_t e = 0; e<NUMBER_OF_OBJECTS; e++){
	inc	c
	jr	00105$
00107$:
;src/Object.c:22: }
	inc	sp
	inc	sp
	ret
;src/Object.c:24: void hide_object(uint8_t i){
;	---------------------------------
; Function hide_object
; ---------------------------------
_hide_object::
	ld	e, a
;src/Object.c:25: global_object_information[i*NUMBER_OF_OBJECTS] = 0;
	ld	bc, #_global_object_information+0
	ld	l, e
	xor	a, a
	ld	h, a
	add	hl, hl
	add	hl, bc
	ld	(hl), #0x00
;src/Object.c:26: global_object_information[i*NUMBER_OF_OBJECTS+1] = 0;
	ld	a, e
	add	a, a
	inc	a
	ld	l, a
	rlca
	sbc	a, a
	ld	h, a
	add	hl, bc
	ld	(hl), #0x00
;src/Object.c:27: }
	ret
	.area _CODE
	.area _INITIALIZER
__xinit__global_object_information:
	.db #0x54	; 84	'T'
	.db #0x1c	; 28
	.db #0x08	; 8
	.db #0x5c	; 92
	.db #0x1c	; 28
	.db #0x08	; 8
	.area _CABS (ABS)
