;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (Linux)
;--------------------------------------------------------
	.module HUD_button
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _hide_pointer
	.globl _change_win_tile_16x16
	.globl _init_level
	.globl _get_colision_from_map
	.globl _update_game_state
	.globl _global_game_hud_buttons
	.globl _draw_hud_button
	.globl _draw_game_hud_buttons
	.globl _update_game_hud_button_selection
	.globl _press_game_hud_button
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
;src/HUD_button.c:12: void draw_hud_button(const HUD_button* button, uint8_t selected) {
;	---------------------------------
; Function draw_hud_button
; ---------------------------------
_draw_hud_button::
	dec	sp
	ld	c, e
	ld	b, d
	ldhl	sp,	#0
	ld	(hl), a
;src/HUD_button.c:13: uint16_t tileindexBR = (button->y * 20) + button->x;
	ld	l, c
	ld	h, b
	inc	hl
	ld	l, (hl)
	ld	h, #0x00
	ld	e, l
	ld	d, h
	add	hl, hl
	add	hl, hl
	add	hl, de
	add	hl, hl
	add	hl, hl
	ld	a, (bc)
	ld	e, a
	ld	d, #0x00
	add	hl, de
	ld	e, l
	ld	d, h
;src/HUD_button.c:14: uint8_t tile_id_BR = selected ? button->selected_tile_BR : button->normal_tile_BR;
	ldhl	sp,	#0
	ld	a, (hl)
	or	a, a
	jr	Z, 00103$
	ld	hl, #0x0004
	add	hl, bc
	ld	a, (hl)
	jr	00104$
00103$:
	inc	bc
	inc	bc
	inc	bc
	ld	a, (bc)
00104$:
;src/HUD_button.c:16: change_win_tile_16x16(tileindexBR, tile_id_BR);
	inc	sp
	jp	_change_win_tile_16x16
;src/HUD_button.c:17: }
	inc	sp
	ret
_global_game_hud_buttons:
	.db #0x10	; 16
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x1f	; 31
	.db #0x23	; 35
	.db #0x12	; 18
	.db #0x02	; 2
	.db #0x01	; 1
	.db #0x27	; 39
	.db #0x2b	; 43
;src/HUD_button.c:19: void draw_game_hud_buttons(void) {
;	---------------------------------
; Function draw_game_hud_buttons
; ---------------------------------
_draw_game_hud_buttons::
;src/HUD_button.c:20: draw_hud_button(&global_game_hud_buttons[0], 0);
	xor	a, a
	ld	de, #_global_game_hud_buttons
	call	_draw_hud_button
;src/HUD_button.c:21: draw_hud_button(&global_game_hud_buttons[1], 0);
	xor	a, a
	ld	de, #(_global_game_hud_buttons + 5)
;src/HUD_button.c:22: }
	jp	_draw_hud_button
;src/HUD_button.c:24: void update_game_hud_button_selection(uint8_t previous, uint8_t current) {
;	---------------------------------
; Function update_game_hud_button_selection
; ---------------------------------
_update_game_hud_button_selection::
	ld	b, e
;src/HUD_button.c:25: if(previous == HUD_ITEM_RESET) {
	cp	a, #0x06
	jr	NZ, 00104$
;src/HUD_button.c:26: draw_hud_button(&global_game_hud_buttons[0], 0);
	push	bc
	xor	a, a
	ld	de, #_global_game_hud_buttons
	call	_draw_hud_button
	pop	bc
	jr	00105$
00104$:
;src/HUD_button.c:27: } else if(previous == HUD_ITEM_GO) {
	sub	a, #0x07
	jr	NZ, 00105$
;src/HUD_button.c:28: draw_hud_button(&global_game_hud_buttons[1], 0);
	ld	de, #(_global_game_hud_buttons + 5)
	push	bc
	xor	a, a
	call	_draw_hud_button
	pop	bc
00105$:
;src/HUD_button.c:31: if(current == HUD_ITEM_RESET) {
	ld	a, b
	sub	a, #0x06
	jr	NZ, 00109$
;src/HUD_button.c:32: draw_hud_button(&global_game_hud_buttons[0], 1);
	ld	a, #0x01
	ld	de, #_global_game_hud_buttons
	jp	_draw_hud_button
00109$:
;src/HUD_button.c:33: } else if(current == HUD_ITEM_GO) {
	ld	a, b
	sub	a, #0x07
	ret	NZ
;src/HUD_button.c:34: draw_hud_button(&global_game_hud_buttons[1], 1);
	ld	a, #0x01
	ld	de, #(_global_game_hud_buttons + 5)
;src/HUD_button.c:36: }
	jp	_draw_hud_button
;src/HUD_button.c:38: void press_game_hud_button(uint8_t selected_item) {
;	---------------------------------
; Function press_game_hud_button
; ---------------------------------
_press_game_hud_button::
;src/HUD_button.c:39: switch(selected_item) {
	cp	a, #0x06
	jr	Z, 00101$
	sub	a, #0x07
	jr	Z, 00102$
	ret
;src/HUD_button.c:40: case HUD_ITEM_RESET:
00101$:
;src/HUD_button.c:41: init_gfx();
	call	_init_gfx
;src/HUD_button.c:42: WY_REG = 120;
	ld	a, #0x78
	ldh	(_WY_REG + 0), a
;src/HUD_button.c:43: global_hud_selected = 0;
;src/HUD_button.c:44: global_selected_block = 0;
	xor	a, a
	ld	(#_global_hud_selected), a
	ld	(#_global_selected_block),a
;src/HUD_button.c:45: init_level(global_actual_level);
	ld	a, (_global_actual_level)
	call	_init_level
;src/HUD_button.c:46: get_colision_from_map(global_levels_array[global_actual_level], global_colision_map);
	ld	bc, #_global_colision_map+0
	ld	de, #_global_levels_array+0
	ld	a, (_global_actual_level)
	ld	l, a
	ld	h, #0x00
	add	hl, hl
	add	hl, de
	ld	a, (hl+)
	ld	l, (hl)
	ld	e, a
	ld	d, l
	call	_get_colision_from_map
;src/HUD_button.c:48: print_objects_in_screen();
;src/HUD_button.c:49: break;
	jp	_print_objects_in_screen
;src/HUD_button.c:51: case HUD_ITEM_GO:
00102$:
;src/HUD_button.c:52: hide_pointer();
	call	_hide_pointer
;src/HUD_button.c:53: update_game_state(STATE_GAME_RUNNING);
	ld	a, #0x03
;src/HUD_button.c:58: }
;src/HUD_button.c:59: }
	jp	_update_game_state
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
