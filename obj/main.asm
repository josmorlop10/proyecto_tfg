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
	.globl _print_objects_in_screen
	.globl _hide_pointer
	.globl _update_pointer
	.globl _pointer_init
	.globl _init_level
	.globl _get_colision_from_map
	.globl _update_game_state
	.globl _update_character
	.globl _character_init
	.globl _performantdelay
	.globl _printf
	.globl _set_sprite_data
	.globl _set_win_tiles
	.globl _set_win_data
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
	.ds 15
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
;src/main.c:21: void init_gfx(void){
;	---------------------------------
; Function init_gfx
; ---------------------------------
_init_gfx::
;src/main.c:23: set_sprite_data(0, 4, duck);
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
;src/main.c:30: set_sprite_data(4, 4, selector);
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
;src/main.c:37: set_sprite_data(8,10,object_sprites);
	ld	de, #_object_sprites
	push	de
	ld	hl, #0xa08
	push	hl
	call	_set_sprite_data
	add	sp, #4
;/home/josem/gbdk/include/gb/gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 34)
	ld	(hl), #0x08
	ld	hl, #(_shadow_OAM + 38)
	ld	(hl), #0x09
	ld	hl, #(_shadow_OAM + 42)
	ld	(hl), #0x0a
	ld	hl, #(_shadow_OAM + 46)
	ld	(hl), #0x0b
	ld	hl, #(_shadow_OAM + 50)
	ld	(hl), #0x0c
	ld	hl, #(_shadow_OAM + 54)
	ld	(hl), #0x0d
	ld	hl, #(_shadow_OAM + 58)
	ld	(hl), #0x0e
	ld	hl, #(_shadow_OAM + 62)
	ld	(hl), #0x0f
	ld	hl, #(_shadow_OAM + 66)
	ld	(hl), #0x10
	ld	hl, #(_shadow_OAM + 70)
	ld	(hl), #0x11
;src/main.c:48: SHOW_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x02
	ldh	(_LCDC_REG + 0), a
;src/main.c:51: set_bkg_data(0, 56, map_tiles);
	ld	de, #_map_tiles
	push	de
	ld	hl, #0x3800
	push	hl
	call	_set_bkg_data
	add	sp, #4
;src/main.c:52: set_bkg_tiles(0,0,20,18,map1);
	ld	de, #_map1
	push	de
	ld	hl, #0x1214
	push	hl
	xor	a, a
	rrca
	push	af
	call	_set_bkg_tiles
	add	sp, #6
;src/main.c:53: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;src/main.c:57: set_win_data(56,17, hud_tiles);
	ld	de, #_hud_tiles
	push	de
	ld	hl, #0x1138
	push	hl
	call	_set_win_data
	add	sp, #4
;src/main.c:58: set_win_tiles(0,0,20,3, hud_selector);
	ld	de, #_hud_selector
	push	de
	ld	hl, #0x314
	push	hl
	xor	a, a
	rrca
	push	af
	call	_set_win_tiles
	add	sp, #6
;src/main.c:59: SHOW_WIN;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x20
	ldh	(_LCDC_REG + 0), a
;src/main.c:60: WX_REG = 7;      // SIEMPRE 7
	ld	a, #0x07
	ldh	(_WX_REG + 0), a
;src/main.c:61: WY_REG = 120;    // 144 - 24
	ld	a, #0x78
	ldh	(_WY_REG + 0), a
;src/main.c:62: }
	ret
;src/main.c:64: void main(void)
;	---------------------------------
; Function main
; ---------------------------------
_main::
;src/main.c:66: init_gfx();
	call	_init_gfx
;src/main.c:67: pointer_init(&s);
	ld	de, #_s
	call	_pointer_init
;src/main.c:69: global_game_state = STATE_GAME_SETTING;
	ld	hl, #_global_game_state
	ld	(hl), #0x02
;src/main.c:71: while(1) {
00120$:
;src/main.c:72: switch (global_game_state)
	ld	a,(#_global_game_state)
	cp	a,#0x02
	jr	Z, 00101$
	cp	a,#0x03
	jr	Z, 00106$
	sub	a, #0x05
	jr	Z, 00112$
	jp	00118$
;src/main.c:74: case STATE_GAME_SETTING:
00101$:
;src/main.c:75: if(last_state != STATE_GAME_SETTING) {
	ld	a, (#_last_state)
	sub	a, #0x02
	jr	Z, 00103$
;src/main.c:76: init_gfx();
	call	_init_gfx
;src/main.c:77: init_level(0);
	xor	a, a
	call	_init_level
;src/main.c:78: get_colision_from_map(map1, global_colision_map);
	ld	bc, #_global_colision_map
	ld	de, #_map1
	call	_get_colision_from_map
;src/main.c:80: print_objects_in_screen();
	call	_print_objects_in_screen
;src/main.c:81: last_state = STATE_GAME_SETTING;
	ld	hl, #_last_state
	ld	(hl), #0x02
00103$:
;src/main.c:83: update_pointer(&s);
	ld	de, #_s
	call	_update_pointer
;src/main.c:84: if(joypad() & J_START){
	call	_joypad
	rlca
	jr	NC, 00118$
;src/main.c:85: hide_pointer();
	call	_hide_pointer
;src/main.c:86: update_game_state(STATE_GAME_RUNNING);
	ld	a, #0x03
	call	_update_game_state
;src/main.c:88: break;
	jr	00118$
;src/main.c:90: case STATE_GAME_RUNNING:
00106$:
;src/main.c:91: if(last_state != STATE_GAME_RUNNING) {
	ld	a, (#_last_state)
	sub	a, #0x03
	jr	Z, 00108$
;src/main.c:92: character_init(&p);
	ld	de, #_p
	call	_character_init
;src/main.c:93: last_state = STATE_GAME_RUNNING;
	ld	hl, #_last_state
	ld	(hl), #0x03
00108$:
;src/main.c:95: update_character(&p);
	ld	de, #_p
	call	_update_character
;src/main.c:98: if(joypad() & J_A){
	call	_joypad
	bit	4, a
	jr	Z, 00118$
;src/main.c:99: for(uint16_t i = 0; i<360; i++){
	ld	bc, #0x0000
00123$:
	ld	e, c
	ld	d, b
	ld	a, e
	sub	a, #0x68
	ld	a, d
	sbc	a, #0x01
	jr	NC, 00118$
;src/main.c:100: printf("%d",global_colision_map[i]);
	ld	hl, #_global_colision_map
	add	hl, bc
	ld	e, (hl)
	ld	d, #0x00
	ld	hl, #___str_0
	push	bc
	push	de
	push	hl
	call	_printf
	add	sp, #4
	pop	bc
;src/main.c:99: for(uint16_t i = 0; i<360; i++){
	inc	bc
	jr	00123$
;src/main.c:107: case STATE_GAME_OVER:
00112$:
;src/main.c:108: if(last_state != STATE_GAME_OVER) {
	ld	a, (#_last_state)
	sub	a, #0x05
	jr	Z, 00114$
;src/main.c:109: last_state = STATE_GAME_OVER;
	ld	hl, #_last_state
	ld	(hl), #0x05
;src/main.c:110: printf("You WIN!\nPress start to try again");
	ld	de, #___str_1
	push	de
	call	_printf
	pop	hl
00114$:
;src/main.c:112: if(joypad() & J_START){
	call	_joypad
	rlca
	jr	NC, 00118$
;src/main.c:113: update_game_state(STATE_GAME_SETTING);
	ld	a, #0x02
	call	_update_game_state
;src/main.c:119: }
00118$:
;src/main.c:120: performantdelay(10);
	ld	a, #0x0a
	call	_performantdelay
;src/main.c:122: }
	jp	00120$
___str_0:
	.ascii "%d"
	.db 0x00
___str_1:
	.ascii "You WIN!"
	.db 0x0a
	.ascii "Press start to try again"
	.db 0x00
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
