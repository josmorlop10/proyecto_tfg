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
	.globl _update_pointer
	.globl _pointer_init
	.globl _update_game_over_screen
	.globl _init_game_over_screen
	.globl _update_start_selection_menu
	.globl _init_start_selection_menu
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
;src/main.c:29: void init_gfx(void){
;	---------------------------------
; Function init_gfx
; ---------------------------------
_init_gfx::
;src/main.c:31: set_sprite_data(0, 4, duck);
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
;src/main.c:38: set_sprite_data(4, 4, selector);
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
;src/main.c:45: set_sprite_data(8,8,object_sprites);
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
;src/main.c:56: set_sprite_data(16,1,block_pointer);
	ld	de, #_block_pointer
	push	de
	ld	hl, #0x110
	push	hl
	call	_set_sprite_data
	add	sp, #4
;/home/josem/gbdk/include/gb/gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 66)
	ld	(hl), #0x10
;src/main.c:59: SHOW_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x02
	ldh	(_LCDC_REG + 0), a
;src/main.c:62: set_bkg_data(0, 96, map_tiles_alt);
	ld	de, #_map_tiles_alt
	push	de
	ld	hl, #0x6000
	push	hl
	call	_set_bkg_data
	add	sp, #4
;src/main.c:63: set_bkg_tiles(0,0,20,16,global_levels_array[global_actual_level]);
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
	ld	hl, #0x1014
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
;src/main.c:68: set_win_data(96,44, hud_tiles);
	ld	de, #_hud_tiles
	push	de
	ld	hl, #0x2c60
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
;src/main.c:72: SHOW_WIN;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x20
	ldh	(_LCDC_REG + 0), a
;src/main.c:73: WX_REG = 7;      // SIEMPRE 7
	ld	a, #0x07
	ldh	(_WX_REG + 0), a
;src/main.c:74: WY_REG = 120;    // 144 - 24
	ld	a, #0x78
	ldh	(_WY_REG + 0), a
;src/main.c:76: }
	ret
;src/main.c:78: void main(void)
;	---------------------------------
; Function main
; ---------------------------------
_main::
;src/main.c:80: init_game_title();
	call	_init_game_title
;src/main.c:81: global_game_state = STATE_MENU;
	xor	a, a
	ld	(#_global_game_state),a
;src/main.c:83: while(1) {
00127$:
;src/main.c:84: switch (global_game_state)
	ld	a, #0x06
	ld	hl, #_global_game_state
	sub	a, (hl)
	jp	C, 00125$
	ld	c, (hl)
	ld	b, #0x00
	ld	hl, #00219$
	add	hl, bc
	add	hl, bc
	ld	c, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, c
	jp	(hl)
00219$:
	.dw	00101$
	.dw	00106$
	.dw	00109$
	.dw	00112$
	.dw	00125$
	.dw	00118$
	.dw	00121$
;src/main.c:87: case STATE_MENU:
00101$:
;src/main.c:88: if(last_state != STATE_MENU) {
	ld	a, (#_last_state)
	or	a, a
	jr	Z, 00103$
;src/main.c:89: init_game_title();
	call	_init_game_title
;src/main.c:90: last_state = STATE_MENU;
	xor	a, a
	ld	(#_last_state),a
00103$:
;src/main.c:93: if(joypad() & J_START){
	call	_joypad
	rlca
	jr	NC, 00105$
;src/main.c:94: update_game_state(STATE_SELECTION);
	ld	a, #0x01
	call	_update_game_state
00105$:
;src/main.c:97: performantdelay(5);
	ld	a, #0x05
	call	_performantdelay
;src/main.c:98: break;
	jp	00125$
;src/main.c:100: case STATE_SELECTION:
00106$:
;src/main.c:101: if(last_state != STATE_SELECTION) {
	ld	a, (#_last_state)
	dec	a
	jr	Z, 00108$
;src/main.c:102: init_start_selection_menu();
	call	_init_start_selection_menu
;src/main.c:103: last_state = STATE_SELECTION;
	ld	hl, #_last_state
	ld	(hl), #0x01
00108$:
;src/main.c:106: update_start_selection_menu();
	call	_update_start_selection_menu
;src/main.c:107: break;
	jp	00125$
;src/main.c:110: case STATE_GAME_SETTING:
00109$:
;src/main.c:111: if(last_state != STATE_GAME_SETTING) {
	ld	a, (#_last_state)
	sub	a, #0x02
	jr	Z, 00111$
;src/main.c:112: init_gfx();
	call	_init_gfx
;src/main.c:113: pointer_init(&s);
	ld	de, #_s
	call	_pointer_init
;src/main.c:114: init_level(global_actual_level);
	ld	a, (_global_actual_level)
	call	_init_level
;src/main.c:115: get_colision_from_map(global_levels_array[global_actual_level], global_colision_map);
	ld	bc, #_global_colision_map+0
	ld	a, (_global_actual_level)
	ld	h, #0x00
	ld	l, a
	add	hl, hl
	ld	de, #_global_levels_array
	add	hl, de
	ld	a, (hl+)
	ld	l, (hl)
	ld	e, a
	ld	d, l
	call	_get_colision_from_map
;src/main.c:117: print_objects_in_screen();
	call	_print_objects_in_screen
;src/main.c:118: last_state = STATE_GAME_SETTING;
	ld	hl, #_last_state
	ld	(hl), #0x02
00111$:
;src/main.c:120: update_pointer(&s);
	ld	de, #_s
	call	_update_pointer
;src/main.c:121: break;
	jr	00125$
;src/main.c:123: case STATE_GAME_RUNNING:
00112$:
;src/main.c:124: if(last_state != STATE_GAME_RUNNING) {
	ld	a, (#_last_state)
	sub	a, #0x03
	jr	Z, 00114$
;src/main.c:125: character_init(&p);
	ld	de, #_p
	call	_character_init
;src/main.c:126: last_state = STATE_GAME_RUNNING;
	ld	hl, #_last_state
	ld	(hl), #0x03
00114$:
;src/main.c:128: update_character(&p);
	ld	de, #_p
	call	_update_character
;src/main.c:131: if(joypad() & J_A){
	call	_joypad
	bit	4, a
	jr	Z, 00125$
;src/main.c:132: HIDE_WIN;
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xdf
	ldh	(_LCDC_REG + 0), a
;src/main.c:134: for(uint16_t i = 0; i<NUMBER_OF_TILES_IN_GRID; i++){
	ld	bc, #0x0000
00130$:
	ld	e, c
	ld	d, b
	ld	a, e
	sub	a, #0x2c
	ld	a, d
	sbc	a, #0x01
	jr	NC, 00125$
;src/main.c:135: printf("%d",global_colision_map[i]);
	ld	hl, #_global_colision_map
	add	hl, bc
	ld	e, (hl)
	xor	a, a
	push	bc
	ld	d, a
	push	de
	ld	de, #___str_0
	push	de
	call	_printf
	add	sp, #4
	pop	bc
;src/main.c:134: for(uint16_t i = 0; i<NUMBER_OF_TILES_IN_GRID; i++){
	inc	bc
	jr	00130$
;src/main.c:140: case STATE_GAME_OVER:
00118$:
;src/main.c:141: if(last_state != STATE_GAME_OVER) {
	ld	a, (#_last_state)
	sub	a, #0x05
	jr	Z, 00120$
;src/main.c:142: last_state = STATE_GAME_OVER;
	ld	hl, #_last_state
	ld	(hl), #0x05
00120$:
;src/main.c:145: init_game_over_screen();
	call	_init_game_over_screen
;src/main.c:146: update_game_over_screen();
	call	_update_game_over_screen
;src/main.c:147: break;
	jr	00125$
;src/main.c:149: case STATE_VICTORY:
00121$:
;src/main.c:150: if(last_state != STATE_VICTORY) {
	ld	a, (#_last_state)
	sub	a, #0x06
	jr	Z, 00123$
;src/main.c:151: last_state = STATE_VICTORY;
	ld	hl, #_last_state
	ld	(hl), #0x06
00123$:
;src/main.c:153: init_victory_screen();
	call	_init_victory_screen
;src/main.c:154: update_victory_screen();
	call	_update_victory_screen
;src/main.c:159: }
00125$:
;src/main.c:160: performantdelay(10);
	ld	a, #0x0a
	call	_performantdelay
;src/main.c:162: }
	jp	00127$
___str_0:
	.ascii "%d"
	.db 0x00
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
