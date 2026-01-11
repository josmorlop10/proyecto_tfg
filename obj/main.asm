;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (Linux)
;--------------------------------------------------------
	.module main
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _init_gfx
	.globl _hide_pointer
	.globl _update_pointer
	.globl _pointer_init
	.globl _get_colision_from_map
	.globl _update_game_state
	.globl _update_character
	.globl _character_init
	.globl _performantdelay
	.globl _printf
	.globl _set_sprite_data
	.globl _set_bkg_tiles
	.globl _set_bkg_data
	.globl _joypad
	.globl _last_state
	.globl _s
	.globl _p
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_p::
	.ds 13
_s::
	.ds 8
_last_state::
	.ds 1
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
;src/main.c:17: void init_gfx(void){
;	---------------------------------
; Function init_gfx
; ---------------------------------
_init_gfx::
;src/main.c:19: set_sprite_data(0, 4, duck);
	ld	de, #_duck
	push	de
	ld	hl, #0x400
	push	hl
	call	_set_sprite_data
	add	sp, #4
;/home/josem/gbdk/include/gb/gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 2)
	ld	(hl), #0x00
	ld	hl, #(_shadow_OAM + 6)
	ld	(hl), #0x01
	ld	hl, #(_shadow_OAM + 10)
	ld	(hl), #0x02
	ld	hl, #(_shadow_OAM + 14)
	ld	(hl), #0x03
;src/main.c:26: set_sprite_data(4, 4, selector);
	ld	de, #_selector
	push	de
	ld	hl, #0x404
	push	hl
	call	_set_sprite_data
	add	sp, #4
;/home/josem/gbdk/include/gb/gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 18)
	ld	(hl), #0x04
	ld	hl, #(_shadow_OAM + 22)
	ld	(hl), #0x05
	ld	hl, #(_shadow_OAM + 26)
	ld	(hl), #0x06
	ld	hl, #(_shadow_OAM + 30)
	ld	(hl), #0x07
;src/main.c:33: SHOW_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x02
	ldh	(_LCDC_REG + 0), a
;src/main.c:36: set_bkg_data(0, 44, map_tiles);
	ld	de, #_map_tiles
	push	de
	ld	hl, #0x2c00
	push	hl
	call	_set_bkg_data
	add	sp, #4
;src/main.c:37: set_bkg_tiles(0,0,20,18,map1);
	ld	de, #_map1+0
	push	de
	push	de
	ld	hl, #0x1214
	push	hl
	xor	a, a
	rrca
	push	af
	call	_set_bkg_tiles
	add	sp, #6
	pop	de
;src/main.c:38: get_colision_from_map(map1, global_colision_map);
	ld	bc, #_global_colision_map
	call	_get_colision_from_map
;src/main.c:39: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;src/main.c:40: }
	ret
;src/main.c:42: void main(void)
;	---------------------------------
; Function main
; ---------------------------------
_main::
;src/main.c:44: init_gfx();
	call	_init_gfx
;src/main.c:45: pointer_init(&s);
	ld	de, #_s
	call	_pointer_init
;src/main.c:46: global_game_state = STATE_GAME_SETTING;
	ld	hl, #_global_game_state
	ld	(hl), #0x02
;src/main.c:48: while(1) {
00117$:
;src/main.c:49: switch (global_game_state)
	ld	a,(#_global_game_state)
	cp	a,#0x02
	jr	Z, 00101$
	cp	a,#0x03
	jr	Z, 00106$
	sub	a, #0x05
	jr	Z, 00109$
	jr	00115$
;src/main.c:51: case STATE_GAME_SETTING:
00101$:
;src/main.c:52: if(last_state != STATE_GAME_SETTING) {
	ld	a, (#_last_state)
	sub	a, #0x02
	jr	Z, 00103$
;src/main.c:53: init_gfx();
	call	_init_gfx
;src/main.c:54: last_state = STATE_GAME_SETTING;
	ld	hl, #_last_state
	ld	(hl), #0x02
00103$:
;src/main.c:56: update_pointer(&s);
	ld	de, #_s
	call	_update_pointer
;src/main.c:57: if(joypad() & J_START){
	call	_joypad
	rlca
	jr	NC, 00115$
;src/main.c:58: hide_pointer();
	call	_hide_pointer
;src/main.c:59: update_game_state(STATE_GAME_RUNNING);
	ld	a, #0x03
	call	_update_game_state
;src/main.c:61: break;
	jr	00115$
;src/main.c:63: case STATE_GAME_RUNNING:
00106$:
;src/main.c:64: if(last_state != STATE_GAME_RUNNING) {
	ld	a, (#_last_state)
	sub	a, #0x03
	jr	Z, 00108$
;src/main.c:65: character_init(&p);
	ld	de, #_p
	call	_character_init
;src/main.c:66: last_state = STATE_GAME_RUNNING;
	ld	hl, #_last_state
	ld	(hl), #0x03
00108$:
;src/main.c:68: update_character(&p);
	ld	de, #_p
	call	_update_character
;src/main.c:80: break;
	jr	00115$
;src/main.c:82: case STATE_GAME_OVER:
00109$:
;src/main.c:83: if(last_state != STATE_GAME_OVER) {
	ld	a, (#_last_state)
	sub	a, #0x05
	jr	Z, 00111$
;src/main.c:84: last_state = STATE_GAME_OVER;
	ld	hl, #_last_state
	ld	(hl), #0x05
;src/main.c:85: printf("You WIN!\nPress start to try again");
	ld	de, #___str_0
	push	de
	call	_printf
	pop	hl
00111$:
;src/main.c:87: if(joypad() & J_START){
	call	_joypad
	rlca
	jr	NC, 00115$
;src/main.c:88: update_game_state(STATE_GAME_SETTING);
	ld	a, #0x02
	call	_update_game_state
;src/main.c:94: }
00115$:
;src/main.c:95: performantdelay(10);
	ld	a, #0x0a
	call	_performantdelay
;src/main.c:97: }
	jr	00117$
___str_0:
	.ascii "You WIN!"
	.db 0x0a
	.ascii "Press start to try again"
	.db 0x00
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
