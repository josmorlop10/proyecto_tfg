;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (Linux)
;--------------------------------------------------------
	.module EventManagement
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _player_tileBR_over_a_block
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
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
