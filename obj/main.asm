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
	.globl _update_pausa_screen
	.globl _update_victory_screen
	.globl _update_game_over_screen
	.globl _init_win_screen
	.globl _update_start_selection_menu
	.globl _init_level
	.globl _init_game_title
	.globl _normalize_level_number
	.globl _update_game_state
	.globl _move_character
	.globl _update_character
	.globl _character_init
	.globl _performantdelay
	.globl _set_sprite_data
	.globl _set_win_tiles
	.globl _set_win_data
	.globl _set_bkg_tiles
	.globl _set_bkg_data
	.globl _waitpadup
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
;src/main.c:34: void init_gfx(void){
;	---------------------------------
; Function init_gfx
; ---------------------------------
_init_gfx::
;src/main.c:36: set_sprite_data(0, 4, duck);
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
;src/main.c:43: set_sprite_data(4, 4, selector);
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
;src/main.c:50: set_sprite_data(8,8,object_sprites);
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
;src/main.c:61: set_sprite_data(16,1,block_pointer);
	ld	de, #_block_pointer
	push	de
	ld	hl, #0x110
	push	hl
	call	_set_sprite_data
	add	sp, #4
;/home/josem/gbdk/include/gb/gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 66)
	ld	(hl), #0x10
;src/main.c:65: global_actual_level = normalize_level_number(global_actual_level);
	ld	a, (_global_actual_level)
	call	_normalize_level_number
	ld	(#_global_actual_level),a
;src/main.c:66: set_bkg_data(0, 96, map_tiles_alt);
	ld	de, #_map_tiles_alt
	push	de
	ld	hl, #0x6000
	push	hl
	call	_set_bkg_data
	add	sp, #4
;src/main.c:67: set_bkg_tiles(0,0,20,15,global_levels_array[global_actual_level]);
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
;src/main.c:68: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;src/main.c:72: set_win_data(96,68, hud_tiles);
	ld	de, #_hud_tiles
	push	de
	ld	hl, #0x4460
	push	hl
	call	_set_win_data
	add	sp, #4
;src/main.c:73: set_win_tiles(0,0,20,4, hud_selector);
	ld	de, #_hud_selector
	push	de
	ld	hl, #0x414
	push	hl
	xor	a, a
	rrca
	push	af
	call	_set_win_tiles
	add	sp, #6
;src/main.c:74: draw_game_hud_buttons();
	call	_draw_game_hud_buttons
;src/main.c:76: WX_REG = 7;      // SIEMPRE 7
	ld	a, #0x07
	ldh	(_WX_REG + 0), a
;src/main.c:78: SHOW_WIN;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x20
	ldh	(_LCDC_REG + 0), a
;src/main.c:79: SHOW_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x02
	ldh	(_LCDC_REG + 0), a
;src/main.c:81: }
	ret
;src/main.c:83: void main(void)
;	---------------------------------
; Function main
; ---------------------------------
_main::
;src/main.c:85: init_game_title();
	call	_init_game_title
;src/main.c:86: global_game_state = STATE_MENU;
	xor	a, a
	ld	(#_global_game_state),a
;src/main.c:88: while(1) {
00137$:
;src/main.c:89: switch (global_game_state)
	ld	a, #0x07
	ld	hl, #_global_game_state
	sub	a, (hl)
	jp	C, 00135$
;src/main.c:114: if(last_state != STATE_GAME_SETTING) {
	ld	a, (#_last_state)
	sub	a, #0x02
	ld	a, #0x01
	jr	Z, 00240$
	xor	a, a
00240$:
	ld	b, a
;src/main.c:129: } else if(last_state == STATE_GAME_PAUSED) {
	ld	a, (#_last_state)
	sub	a, #0x04
	ld	a, #0x01
	jr	Z, 00242$
	xor	a, a
00242$:
	ld	c, a
;src/main.c:89: switch (global_game_state)
	ld	a, (_global_game_state)
	ld	e, a
	ld	d, #0x00
	ld	hl, #00243$
	add	hl, de
	add	hl, de
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	jp	(hl)
00243$:
	.dw	00101$
	.dw	00106$
	.dw	00109$
	.dw	00112$
	.dw	00131$
	.dw	00120$
	.dw	00123$
	.dw	00126$
;src/main.c:92: case STATE_MENU:
00101$:
;src/main.c:93: if(last_state != STATE_MENU) {
	ld	a, (#_last_state)
	or	a, a
	jr	Z, 00103$
;src/main.c:94: init_game_title();
	call	_init_game_title
;src/main.c:95: last_state = STATE_MENU;
	xor	a, a
	ld	(#_last_state),a
00103$:
;src/main.c:98: if(joypad() & J_START){
	call	_joypad
	rlca
	jp	NC, 00135$
;src/main.c:99: update_game_state(STATE_SELECTION);
	ld	a, #0x01
	call	_update_game_state
;src/main.c:101: break;
	jp	00135$
;src/main.c:103: case STATE_SELECTION:
00106$:
;src/main.c:104: if(last_state != STATE_SELECTION) {
	ld	a, (#_last_state)
	dec	a
	jr	Z, 00108$
;src/main.c:105: set_win_data(96,68, hud_tiles);
	ld	de, #_hud_tiles
	push	de
	ld	hl, #0x4460
	push	hl
	call	_set_win_data
	add	sp, #4
;src/main.c:106: init_win_screen(selection_menu, 7, 0, 20, 18, 0);
	ld	hl, #0x12
	push	hl
	ld	hl, #0x1400
	push	hl
	ld	a, #0x07
	ld	de, #_selection_menu
	call	_init_win_screen
;src/main.c:107: last_state = STATE_SELECTION;
	ld	hl, #_last_state
	ld	(hl), #0x01
;src/main.c:108: performantdelay(30);
	ld	a, #0x1e
	call	_performantdelay
00108$:
;src/main.c:110: update_start_selection_menu();
	call	_update_start_selection_menu
;src/main.c:111: break;
	jp	00135$
;src/main.c:113: case STATE_GAME_SETTING:
00109$:
;src/main.c:114: if(last_state != STATE_GAME_SETTING) {
	bit	0, b
	jr	NZ, 00111$
;src/main.c:115: init_gfx();
	call	_init_gfx
;src/main.c:116: WY_REG = 120;
	ld	a, #0x78
	ldh	(_WY_REG + 0), a
;src/main.c:117: pointer_init(&s);
	ld	de, #_s
	call	_pointer_init
;src/main.c:118: init_level(global_actual_level);
	ld	a, (_global_actual_level)
	call	_init_level
;src/main.c:119: print_objects_in_screen();
	call	_print_objects_in_screen
;src/main.c:120: last_state = STATE_GAME_SETTING;
	ld	hl, #_last_state
	ld	(hl), #0x02
00111$:
;src/main.c:122: update_pointer(&s);
	ld	de, #_s
	call	_update_pointer
;src/main.c:123: update_HUD();
	call	_update_HUD
;src/main.c:124: break;
	jp	00135$
;src/main.c:126: case STATE_GAME_RUNNING:
00112$:
;src/main.c:127: if(last_state == STATE_GAME_SETTING) {
	ld	a, b
	or	a, a
	jr	Z, 00116$
;src/main.c:128: character_init(&p);
	ld	de, #_p
	call	_character_init
	jr	00117$
00116$:
;src/main.c:129: } else if(last_state == STATE_GAME_PAUSED) {
	ld	a, c
	or	a, a
	jr	Z, 00117$
;src/main.c:130: WX_REG = 7;
	ld	a, #0x07
	ldh	(_WX_REG + 0), a
;src/main.c:131: WY_REG = 120;
	ld	a, #0x78
	ldh	(_WY_REG + 0), a
;src/main.c:132: set_win_tiles(0,0,20,4,hud_selector);
	ld	de, #_hud_selector
	push	de
	ld	hl, #0x414
	push	hl
	xor	a, a
	rrca
	push	af
	call	_set_win_tiles
	add	sp, #6
;src/main.c:133: draw_game_hud_buttons();
	call	_draw_game_hud_buttons
;src/main.c:134: move_character(&p);
	ld	de, #_p
	call	_move_character
;src/main.c:135: SHOW_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x02
	ldh	(_LCDC_REG + 0), a
;src/main.c:136: waitpadup();
	call	_waitpadup
00117$:
;src/main.c:139: last_state = STATE_GAME_RUNNING;
	ld	hl, #_last_state
	ld	(hl), #0x03
;src/main.c:140: update_character(&p);
	ld	de, #_p
	call	_update_character
;src/main.c:141: if(joypad() & J_START){
	call	_joypad
	rlca
	jp	NC, 00135$
;src/main.c:142: update_game_state(STATE_GAME_PAUSED);
	ld	a, #0x04
	call	_update_game_state
;src/main.c:145: break;
	jp	00135$
;src/main.c:147: case STATE_GAME_OVER:
00120$:
;src/main.c:148: if(last_state != STATE_GAME_OVER) {
	ld	a, (#_last_state)
	sub	a, #0x05
	jr	Z, 00122$
;src/main.c:149: last_state = STATE_GAME_OVER;
	ld	hl, #_last_state
	ld	(hl), #0x05
;src/main.c:150: global_option_selection_from_menu = 0;
	xor	a, a
	ld	(#_global_option_selection_from_menu),a
;src/main.c:151: init_win_screen(game_over_screen, 7, 120, 20, 12, -72);
	ld	hl, #0xb80c
	push	hl
	ld	hl, #0x1478
	push	hl
	ld	a, #0x07
	ld	de, #_game_over_screen
	call	_init_win_screen
00122$:
;src/main.c:153: update_game_over_screen();
	call	_update_game_over_screen
;src/main.c:154: break;
	jr	00135$
;src/main.c:156: case STATE_VICTORY:
00123$:
;src/main.c:157: if(last_state != STATE_VICTORY) {
	ld	a, (#_last_state)
	sub	a, #0x06
	jr	Z, 00125$
;src/main.c:158: last_state = STATE_VICTORY;
	ld	hl, #_last_state
	ld	(hl), #0x06
;src/main.c:159: global_option_selection_from_menu = 0;
	xor	a, a
	ld	(#_global_option_selection_from_menu),a
;src/main.c:160: init_win_screen(victory_screen, 7, 120, 20, 12, -72);
	ld	hl, #0xb80c
	push	hl
	ld	hl, #0x1478
	push	hl
	ld	a, #0x07
	ld	de, #_victory_screen
	call	_init_win_screen
00125$:
;src/main.c:162: update_victory_screen();
	call	_update_victory_screen
;src/main.c:163: break;
	jr	00135$
;src/main.c:165: case STATE_FINAL_MESSAGE:
00126$:
;src/main.c:166: if(last_state != STATE_FINAL_MESSAGE) {
	ld	a, (#_last_state)
	sub	a, #0x07
	jr	Z, 00128$
;src/main.c:167: last_state = STATE_FINAL_MESSAGE;
	ld	hl, #_last_state
	ld	(hl), #0x07
;src/main.c:168: init_win_screen(final_message, 0, 0, 20, 18, 0);
	ld	hl, #0x12
	push	hl
	ld	hl, #0x1400
	push	hl
	xor	a, a
	ld	de, #_final_message
	call	_init_win_screen
00128$:
;src/main.c:170: if(joypad() & (J_START | J_A)){
	call	_joypad
	and	a, #0x90
	jr	Z, 00135$
;src/main.c:171: global_actual_level = 0;
;src/main.c:172: update_game_state(STATE_MENU);
	xor	a, a
	ld	(#_global_actual_level), a
	call	_update_game_state
;src/main.c:174: break;
	jr	00135$
;src/main.c:176: case STATE_GAME_PAUSED:
00131$:
;src/main.c:177: if(last_state != STATE_GAME_PAUSED) {
	bit	0, c
	jr	NZ, 00133$
;src/main.c:178: last_state = STATE_GAME_PAUSED;
	ld	hl, #_last_state
	ld	(hl), #0x04
;src/main.c:179: global_option_selection_from_menu = 0;
	xor	a, a
	ld	(#_global_option_selection_from_menu),a
;src/main.c:180: init_win_screen(pausa, 7, 120, 20, 12, -72);
	ld	hl, #0xb80c
	push	hl
	ld	hl, #0x1478
	push	hl
	ld	a, #0x07
	ld	de, #_pausa
	call	_init_win_screen
00133$:
;src/main.c:182: update_pausa_screen();
	call	_update_pausa_screen
;src/main.c:187: }
00135$:
;src/main.c:188: performantdelay(10);
	ld	a, #0x0a
	call	_performantdelay
;src/main.c:190: }
	jp	00137$
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
