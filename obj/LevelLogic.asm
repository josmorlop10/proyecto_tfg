;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (Linux)
;--------------------------------------------------------
	.module LevelLogic
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _global_game_state
	.globl _update_game_state
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
_global_game_state::
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
;src/LevelLogic.c:9: void update_game_state(GameState new_value){
;	---------------------------------
; Function update_game_state
; ---------------------------------
_update_game_state::
	ld	(#_global_game_state),a
;src/LevelLogic.c:10: global_game_state = new_value;
;src/LevelLogic.c:11: }
	ret
	.area _CODE
	.area _INITIALIZER
__xinit__global_game_state:
	.db #0x02	; 2
	.area _CABS (ABS)
