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
	.globl _draw_game_hud_buttons
	.globl _print_objects_in_screen
	.globl _update_HUD
	.globl _update_pointer
	.globl _pointer_init
	.globl _update_victory_screen
	.globl _init_victory_screen
	.globl _update_game_over_screen
	.globl _init_game_over_screen
	.globl _update_start_selection_menu
	.globl _init_start_selection_menu
	.globl _init_level
	.globl _init_game_title
	.globl _normalize_level_number
	.globl _update_game_state
	.globl _hide_character
	.globl _update_character
	.globl _character_init
	.globl _performantdelay
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
;src/main.c:30: void init_gfx(void){
;	---------------------------------
; Function init_gfx
; ---------------------------------
_init_gfx::
;src/main.c:32: set_sprite_data(0, 4, duck);
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
;src/main.c:39: set_sprite_data(4, 4, selector);
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
;src/main.c:46: set_sprite_data(8,8,object_sprites);
	ld	de, #_object_sprites
	push	de
	ld	hl, #0x808
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
;src/main.c:57: set_sprite_data(16,1,block_pointer);
	ld	de, #_block_pointer
	push	de
	ld	hl, #0x110
	push	hl
	call	_set_sprite_data
	add	sp, #4
;/home/josem/gbdk/include/gb/gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 66)
	ld	(hl), #0x10
;src/main.c:61: global_actual_level = normalize_level_number(global_actual_level);
	ld	a, (_global_actual_level)
	call	_normalize_level_number
	ld	(#_global_actual_level),a
;src/main.c:62: set_bkg_data(0, 96, map_tiles_alt);
	ld	de, #_map_tiles_alt
	push	de
	ld	hl, #0x6000
	push	hl
	call	_set_bkg_data
	add	sp, #4
;src/main.c:63: set_bkg_tiles(0,0,20,15,global_levels_array[global_actual_level]);
	ld	bc, #_global_levels_array+0
	ld	a, (_global_actual_level)
	ld	h, #0x00
	ld	l, a
	add	hl, hl
	add	hl, bc
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	push	bc
	ld	hl, #0xf14
	push	hl
	xor	a, a
	rrca
	push	af
	call	_set_bkg_tiles
	add	sp, #6
;src/main.c:64: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;src/main.c:68: set_win_data(96,68, hud_tiles);
	ld	de, #_hud_tiles
	push	de
	ld	hl, #0x4460
	push	hl
	call	_set_win_data
	add	sp, #4
;src/main.c:69: set_win_tiles(0,0,20,4, hud_selector);
	ld	de, #_hud_selector
	push	de
	ld	hl, #0x414
	push	hl
	xor	a, a
	rrca
	push	af
	call	_set_win_tiles
	add	sp, #6
;src/main.c:70: draw_game_hud_buttons();
	call	_draw_game_hud_buttons
;src/main.c:72: WX_REG = 7;      // SIEMPRE 7
	ld	a, #0x07
	ldh	(_WX_REG + 0), a
;src/main.c:74: SHOW_WIN;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x20
	ldh	(_LCDC_REG + 0), a
;src/main.c:75: SHOW_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x02
	ldh	(_LCDC_REG + 0), a
;src/main.c:77: }
	ret
;src/main.c:79: void main(void)
;	---------------------------------
; Function main
; ---------------------------------
_main::
;src/main.c:81: init_game_title();
	call	_init_game_title
;src/main.c:82: global_game_state = STATE_MENU;
	xor	a, a
	ld	(#_global_game_state),a
;src/main.c:84: while(1) {
00129$:
;src/main.c:85: switch (global_game_state)
	ld	a, #0x07
	ld	hl, #_global_game_state
	sub	a, (hl)
	jp	C, 00127$
	ld	c, (hl)
	ld	b, #0x00
	ld	hl, #00210$
	add	hl, bc
	add	hl, bc
	ld	c, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, c
	jp	(hl)
00210$:
	.dw	00101$
	.dw	00106$
	.dw	00109$
	.dw	00112$
	.dw	00127$
	.dw	00115$
	.dw	00118$
	.dw	00121$
;src/main.c:88: case STATE_MENU:
00101$:
;src/main.c:89: if(last_state != STATE_MENU) {
	ld	a, (#_last_state)
	or	a, a
	jr	Z, 00103$
;src/main.c:90: init_game_title();
	call	_init_game_title
;src/main.c:91: last_state = STATE_MENU;
	xor	a, a
	ld	(#_last_state),a
00103$:
;src/main.c:94: if(joypad() & J_START){
	call	_joypad
	rlca
	jp	NC, 00127$
;src/main.c:95: update_game_state(STATE_SELECTION);
	ld	a, #0x01
	call	_update_game_state
;src/main.c:97: break;
	jp	00127$
;src/main.c:99: case STATE_SELECTION:
00106$:
;src/main.c:100: if(last_state != STATE_SELECTION) {
	ld	a, (#_last_state)
	dec	a
	jr	Z, 00108$
;src/main.c:101: init_start_selection_menu();
	call	_init_start_selection_menu
;src/main.c:102: last_state = STATE_SELECTION;
	ld	hl, #_last_state
	ld	(hl), #0x01
00108$:
;src/main.c:104: update_start_selection_menu();
	call	_update_start_selection_menu
;src/main.c:105: break;
	jp	00127$
;src/main.c:107: case STATE_GAME_SETTING:
00109$:
;src/main.c:108: if(last_state != STATE_GAME_SETTING) {
	ld	a, (#_last_state)
	sub	a, #0x02
	jr	Z, 00111$
;src/main.c:109: init_gfx();
	call	_init_gfx
;src/main.c:110: WY_REG = 120;
	ld	a, #0x78
	ldh	(_WY_REG + 0), a
;src/main.c:111: pointer_init(&s);
	ld	de, #_s
	call	_pointer_init
;src/main.c:112: init_level(global_actual_level);
	ld	a, (_global_actual_level)
	call	_init_level
;src/main.c:113: print_objects_in_screen();
	call	_print_objects_in_screen
;src/main.c:114: last_state = STATE_GAME_SETTING;
	ld	hl, #_last_state
	ld	(hl), #0x02
00111$:
;src/main.c:116: update_pointer(&s);
	ld	de, #_s
	call	_update_pointer
;src/main.c:117: update_HUD();
	call	_update_HUD
;src/main.c:118: break;
	jp	00127$
;src/main.c:120: case STATE_GAME_RUNNING:
00112$:
;src/main.c:121: if(last_state != STATE_GAME_RUNNING) {
	ld	a, (#_last_state)
	sub	a, #0x03
	jr	Z, 00114$
;src/main.c:122: character_init(&p);
	ld	de, #_p
	call	_character_init
;src/main.c:123: last_state = STATE_GAME_RUNNING;
	ld	hl, #_last_state
	ld	(hl), #0x03
00114$:
;src/main.c:125: update_character(&p);
	ld	de, #_p
	call	_update_character
;src/main.c:126: break;
	jr	00127$
;src/main.c:128: case STATE_GAME_OVER:
00115$:
;src/main.c:129: if(last_state != STATE_GAME_OVER) {
	ld	a, (#_last_state)
	sub	a, #0x05
	jr	Z, 00117$
;src/main.c:130: last_state = STATE_GAME_OVER;
	ld	hl, #_last_state
	ld	(hl), #0x05
;src/main.c:131: init_game_over_screen();
	call	_init_game_over_screen
00117$:
;src/main.c:133: update_game_over_screen();
	call	_update_game_over_screen
;src/main.c:134: break;
	jr	00127$
;src/main.c:136: case STATE_VICTORY:
00118$:
;src/main.c:137: if(last_state != STATE_VICTORY) {
	ld	a, (#_last_state)
	sub	a, #0x06
	jr	Z, 00120$
;src/main.c:138: last_state = STATE_VICTORY;
	ld	hl, #_last_state
	ld	(hl), #0x06
;src/main.c:139: init_victory_screen();
	call	_init_victory_screen
00120$:
;src/main.c:141: update_victory_screen();
	call	_update_victory_screen
;src/main.c:142: break;
	jr	00127$
;src/main.c:144: case STATE_FINAL_MESSAGE:
00121$:
;src/main.c:145: if(last_state != STATE_FINAL_MESSAGE) {
	ld	a, (#_last_state)
	sub	a, #0x07
	jr	Z, 00123$
;src/main.c:146: last_state = STATE_FINAL_MESSAGE;
	ld	hl, #_last_state
	ld	(hl), #0x07
;src/main.c:147: HIDE_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xfd
	ldh	(_LCDC_REG + 0), a
;src/main.c:148: hide_character();
	call	_hide_character
;src/main.c:149: WX_REG = 0;
	xor	a, a
	ldh	(_WX_REG + 0), a
;src/main.c:150: WY_REG = 0;
	xor	a, a
	ldh	(_WY_REG + 0), a
;src/main.c:151: set_win_tiles(0,0,20,18,final_message);
	ld	de, #_final_message
	push	de
	ld	hl, #0x1214
	push	hl
	xor	a, a
	rrca
	push	af
	call	_set_win_tiles
	add	sp, #6
;src/main.c:152: SHOW_WIN;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x20
	ldh	(_LCDC_REG + 0), a
00123$:
;src/main.c:154: if(joypad() & (J_START | J_A)){
	call	_joypad
	and	a, #0x90
	jr	Z, 00127$
;src/main.c:155: global_actual_level = 0;
;src/main.c:156: update_game_state(STATE_MENU);
	xor	a, a
	ld	(#_global_actual_level), a
	call	_update_game_state
;src/main.c:162: }
00127$:
;src/main.c:163: performantdelay(10);
	ld	a, #0x0a
	call	_performantdelay
;src/main.c:165: }
	jp	00129$
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
