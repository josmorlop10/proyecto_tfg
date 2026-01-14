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
;src/Object.c:7: void print_objects_in_screen(void){
;	---------------------------------
; Function print_objects_in_screen
; ---------------------------------
_print_objects_in_screen::
	dec	sp
	dec	sp
;src/Object.c:12: for(uint8_t e = 0; e<NUMBER_OF_OBJECTS; e++){
	ld	c, #0x00
00105$:
	ld	a, c
	sub	a, #0x02
	jr	NC, 00107$
;src/Object.c:13: obj_x = global_object_information[3*e];
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
;src/Object.c:14: obj_y = global_object_information[3*e + 1];
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
;src/Object.c:15: obj_type = global_object_information[3*e + 2];
	inc	b
	inc	b
	ld	l, b
	ld	h, #0x00
	ld	de, #_global_object_information
	add	hl, de
	ld	d, (hl)
;src/Object.c:17: set_sprite_tile(8+e,obj_type);
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
;src/Object.c:18: move_sprite(8+e, obj_x, obj_y);
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
;src/Object.c:12: for(uint8_t e = 0; e<NUMBER_OF_OBJECTS; e++){
	inc	c
	jr	00105$
00107$:
;src/Object.c:20: }
	inc	sp
	inc	sp
	ret
;src/Object.c:22: void hide_object(uint8_t i){
;	---------------------------------
; Function hide_object
; ---------------------------------
_hide_object::
	ld	c, a
;src/Object.c:23: global_object_information[i*NUMBER_OF_OBJECTS] = 0;
	ld	de, #_global_object_information+0
	ld	l, c
	xor	a, a
	ld	h, a
	add	hl, hl
	add	hl, de
	ld	(hl), #0x00
;src/Object.c:24: global_object_information[i*NUMBER_OF_OBJECTS+1] = 0;
	ld	a, c
	add	a, a
	inc	a
	ld	l, a
	rlca
	sbc	a, a
	ld	h, a
	add	hl, de
	ld	(hl), #0x00
;src/Object.c:25: move_sprite(8+i, 0, 0);
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
;src/Object.c:25: move_sprite(8+i, 0, 0);
;src/Object.c:26: }
	ret
;src/Object.c:28: uint8_t check_colision_with_object(uint8_t x, uint8_t y, uint8_t w, uint8_t h){
;	---------------------------------
; Function check_colision_with_object
; ---------------------------------
_check_colision_with_object::
	add	sp, #-12
	ldhl	sp,	#10
	ld	(hl-), a
	ld	(hl), e
;src/Object.c:32: uint8_t res = 0;
	ldhl	sp,	#0
;src/Object.c:34: for(uint8_t e = 0; e<NUMBER_OF_OBJECTS; e++){
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
	ldhl	sp,	#11
	ld	(hl), #0x00
00108$:
	ldhl	sp,	#11
	ld	a, (hl)
	sub	a, #0x02
	jp	NC, 00106$
;src/Object.c:35: obj_x = global_object_information[3*e];
	ld	c, (hl)
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, bc
	ld	de, #_global_object_information
	add	hl, de
	ld	c, (hl)
;src/Object.c:36: obj_y = global_object_information[3*e + 1];
	ldhl	sp,	#11
	ld	a, (hl)
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
	ldhl	sp,	#8
	ld	(hl), a
;src/Object.c:37: obj_type = global_object_information[3*e + 2];
	ld	l, b
	inc	l
	inc	l
	ld	h, #0x00
	ld	de, #_global_object_information
	add	hl, de
	ld	a, (hl)
	ldhl	sp,	#2
	ld	(hl), a
;src/Object.c:40: if( x < obj_x + OBJECT_SIZE && x + w > obj_x && y < obj_y + OBJECT_SIZE && y + h > obj_y ){
	ldhl	sp,	#4
	ld	a, c
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0008
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#10
	ld	a, (hl)
	ldhl	sp,	#6
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl+)
	sub	a, c
	ld	a, (hl)
	sbc	a, b
	jr	NC, 00109$
	ldhl	sp,	#14
	ld	c, (hl)
	ld	b, #0x00
	ldhl	sp,	#6
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#4
	ld	a, (hl+)
	sub	a, c
	ld	a, (hl)
	sbc	a, b
	jr	NC, 00109$
	ldhl	sp,	#8
	ld	a, (hl)
	ldhl	sp,	#3
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0008
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#9
	ld	a, (hl)
	ldhl	sp,	#5
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl+)
	sub	a, c
	ld	a, (hl)
	sbc	a, b
	jr	NC, 00109$
	ldhl	sp,	#15
	ld	c, (hl)
	ld	b, #0x00
	ldhl	sp,	#5
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#9
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#8
	ld	(hl), a
	ldhl	sp,	#3
	ld	e, l
	ld	d, h
	ldhl	sp,	#7
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jr	NC, 00109$
;src/Object.c:41: hide_object(e);
	ldhl	sp,	#1
	ld	a, (hl)
	call	_hide_object
;src/Object.c:42: res = obj_type;
	ldhl	sp,	#2
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
;src/Object.c:43: break;
	jr	00106$
00109$:
;src/Object.c:34: for(uint8_t e = 0; e<NUMBER_OF_OBJECTS; e++){
	ldhl	sp,	#11
	inc	(hl)
	ld	a, (hl)
	ldhl	sp,	#1
	ld	(hl), a
	jp	00108$
00106$:
;src/Object.c:47: return res;
	ldhl	sp,	#0
	ld	a, (hl)
;src/Object.c:48: }
	add	sp, #12
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
	.db #0x08	; 8
	.area _CABS (ABS)
