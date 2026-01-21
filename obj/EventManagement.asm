;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (Linux)
;--------------------------------------------------------
	.module EventManagement
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _player_tileBR_over_a_block
	.globl _player_tileBR_over_destination
	.globl _player_over_fall
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
;src/EventManagement.c:7: uint8_t player_tileBR_over_a_block(uint16_t tileindexBR){
;	---------------------------------
; Function player_tileBR_over_a_block
; ---------------------------------
_player_tileBR_over_a_block::
;src/EventManagement.c:9: if(global_colision_map[tileindexBR]>= RIGHT && global_colision_map[tileindexBR]<=DOWN){
	ld	hl, #_global_colision_map
	add	hl, de
	ld	a, (hl)
	cp	a, #0x06
	jr	C, 00102$
	cp	a, #0x0a
;src/EventManagement.c:10: return global_colision_map[tileindexBR];
	ret	C
00102$:
;src/EventManagement.c:12: return 0;
	xor	a, a
;src/EventManagement.c:14: }
	ret
;src/EventManagement.c:16: uint8_t player_tileBR_over_destination(uint16_t tileindexBR){
;	---------------------------------
; Function player_tileBR_over_destination
; ---------------------------------
_player_tileBR_over_destination::
;src/EventManagement.c:17: if(global_colision_map[tileindexBR] == DESTINATION &&
	ld	bc, #_global_colision_map+0
	ld	l, c
	ld	h, b
	add	hl, de
	ld	a, (hl)
	sub	a, #0x04
	jr	NZ, 00102$
;src/EventManagement.c:18: global_colision_map[tileindexBR-1] == DESTINATION &&
	ld	l, e
	ld	h, d
	dec	hl
	add	hl, bc
	ld	a, (hl)
	sub	a, #0x04
	jr	NZ, 00102$
;src/EventManagement.c:19: global_colision_map[tileindexBR-20] == DESTINATION &&
	ld	a, e
	add	a, #0xec
	ld	l, a
	ld	a, d
	adc	a, #0xff
	ld	h, a
	add	hl, bc
	ld	a, (hl)
	sub	a, #0x04
	jr	NZ, 00102$
;src/EventManagement.c:20: global_colision_map[tileindexBR-21] == DESTINATION){
	ld	a, e
	add	a, #0xeb
	ld	l, a
	ld	a, d
	adc	a, #0xff
	ld	h, a
	add	hl, bc
	ld	a, (hl)
	sub	a, #0x04
;src/EventManagement.c:21: return 1;
;src/EventManagement.c:23: return 0;
	ld	a, #0x01
	ret	Z
00102$:
	xor	a, a
;src/EventManagement.c:25: }
	ret
;src/EventManagement.c:27: uint8_t player_over_fall(uint16_t tileindexBR){
;	---------------------------------
; Function player_over_fall
; ---------------------------------
_player_over_fall::
;src/EventManagement.c:28: if(global_colision_map[tileindexBR] == FALL &&
	ld	bc, #_global_colision_map+0
	ld	l, c
	ld	h, b
	add	hl, de
	ld	a, (hl)
	sub	a, #0x05
	jr	NZ, 00102$
;src/EventManagement.c:29: global_colision_map[tileindexBR-1] == FALL &&
	ld	l, e
	ld	h, d
	dec	hl
	add	hl, bc
	ld	a, (hl)
	sub	a, #0x05
	jr	NZ, 00102$
;src/EventManagement.c:30: global_colision_map[tileindexBR-20] == FALL &&
	ld	a, e
	add	a, #0xec
	ld	l, a
	ld	a, d
	adc	a, #0xff
	ld	h, a
	add	hl, bc
	ld	a, (hl)
	sub	a, #0x05
	jr	NZ, 00102$
;src/EventManagement.c:31: global_colision_map[tileindexBR-21] == FALL){
	ld	a, e
	add	a, #0xeb
	ld	l, a
	ld	a, d
	adc	a, #0xff
	ld	h, a
	add	hl, bc
	ld	a, (hl)
	sub	a, #0x05
;src/EventManagement.c:32: return 1;
;src/EventManagement.c:34: return 0;
	ld	a, #0x01
	ret	Z
00102$:
	xor	a, a
;src/EventManagement.c:36: }
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
