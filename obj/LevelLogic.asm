;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (Linux)
;--------------------------------------------------------
	.module LevelLogic
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _set_win_tiles
	.globl _set_bkg_tiles
	.globl _set_bkg_data
	.globl _joypad
	.globl _move_win_screen
	.globl _update_values_in_hud
	.globl _update_menu_pointer
	.globl _hide_character
	.globl _global_option_selection_from_menu
	.globl _global_actual_level
	.globl _global_level_blocks_array
	.globl _global_level_objects_array
	.globl _global_levels_array
	.globl _global_first_y
	.globl _global_first_x
	.globl _global_selected_block
	.globl _global_blocks_available
	.globl _global_colision_map
	.globl _global_keyset
	.globl _global_init_point
	.globl _global_events
	.globl _global_game_state
	.globl _normalize_level_number
	.globl _init_game_title
	.globl _init_level
	.globl _update_game_state
	.globl _get_colision_from_map
	.globl _read_global_object_info_from_map
	.globl _read_global_block_info_from_map
	.globl _change_colision_map_at
	.globl _change_colision_map_BR
	.globl _check_colision_of_sprites
	.globl _get_init_point_from_map
	.globl _move_foward_block_id
	.globl _init_start_selection_menu
	.globl _update_start_selection_menu
	.globl _init_victory_screen
	.globl _update_victory_screen
	.globl _init_game_over_screen
	.globl _update_game_over_screen
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_global_game_state::
	.ds 1
_global_events::
	.ds 40
_global_init_point::
	.ds 2
_global_keyset::
	.ds 1
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
_global_colision_map::
	.ds 300
_global_blocks_available::
	.ds 6
_global_selected_block::
	.ds 1
_global_first_x::
	.ds 1
_global_first_y::
	.ds 1
_global_levels_array::
	.ds 6
_global_level_objects_array::
	.ds 6
_global_level_blocks_array::
	.ds 6
_global_actual_level::
	.ds 1
_global_option_selection_from_menu::
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
;src/LevelLogic.c:46: uint8_t normalize_level_number(uint8_t level_number){
;	---------------------------------
; Function normalize_level_number
; ---------------------------------
_normalize_level_number::
;src/LevelLogic.c:47: if(level_number >= NUMBER_OF_LEVELS){
	cp	a, #0x03
	ret	C
;src/LevelLogic.c:48: level_number = level_number % NUMBER_OF_LEVELS;
	ld	e, #0x03
	call	__moduchar
	ld	a, c
;src/LevelLogic.c:51: return level_number;
;src/LevelLogic.c:52: }
	ret
;src/LevelLogic.c:54: void init_game_title(void){
;	---------------------------------
; Function init_game_title
; ---------------------------------
_init_game_title::
;src/LevelLogic.c:56: HIDE_WIN;
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xdf
	ldh	(_LCDC_REG + 0), a
;src/LevelLogic.c:57: HIDE_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xfd
	ldh	(_LCDC_REG + 0), a
;src/LevelLogic.c:58: set_bkg_data(0,232,png_prueba_tiles);
	ld	de, #_png_prueba_tiles
	push	de
	ld	hl, #0xe800
	push	hl
	call	_set_bkg_data
	add	sp, #4
;src/LevelLogic.c:59: set_bkg_tiles(0,0,20,18,png_prueba_map);
	ld	de, #_png_prueba_map
	push	de
	ld	hl, #0x1214
	push	hl
	xor	a, a
	rrca
	push	af
	call	_set_bkg_tiles
	add	sp, #6
;src/LevelLogic.c:60: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;src/LevelLogic.c:61: }
	ret
;src/LevelLogic.c:63: void init_level(uint8_t level_number){
;	---------------------------------
; Function init_level
; ---------------------------------
_init_level::
	dec	sp
	dec	sp
;src/LevelLogic.c:65: global_keyset = 0;
	ld	hl, #_global_keyset
	ld	(hl), #0x00
;src/LevelLogic.c:66: global_hud_selected = 0;
	ld	hl, #_global_hud_selected
	ld	(hl), #0x00
;src/LevelLogic.c:67: level_number = normalize_level_number(level_number);
	call	_normalize_level_number
	ld	c, a
;src/LevelLogic.c:68: global_actual_level = level_number;
	ld	hl, #_global_actual_level
	ld	(hl), c
;src/LevelLogic.c:71: for(uint16_t i = 0; i<NUMBER_OF_TILES_IN_GRID; i++){
	ld	de, #0x0000
00104$:
	ld	a, e
	ld	l, d
	sub	a, #0x2c
	ld	a, l
	sbc	a, #0x01
	jr	NC, 00101$
;src/LevelLogic.c:72: global_colision_map[i] = EMPTY;
	ld	hl, #_global_colision_map
	add	hl, de
	ld	(hl), #0x00
;src/LevelLogic.c:71: for(uint16_t i = 0; i<NUMBER_OF_TILES_IN_GRID; i++){
	inc	de
	jr	00104$
00101$:
;src/LevelLogic.c:75: get_colision_from_map(global_levels_array[level_number], global_colision_map);
	ld	de, #_global_levels_array+0
	ld	b, #0x00
	sla	c
	rl	b
	inc	sp
	inc	sp
	ld	l, c
	ld	h, b
	push	hl
	add	hl, de
	ld	a,	(hl+)
	ld	h, (hl)
	ld	e, a
	ld	bc, #_global_colision_map
	ld	d, h
	call	_get_colision_from_map
;src/LevelLogic.c:76: read_global_object_info_from_map(global_level_objects_array[level_number]);
	ld	bc, #_global_level_objects_array+0
	pop	hl
	push	hl
	add	hl, bc
	ld	a, (hl+)
	ld	c, a
	ld	a, (hl)
	ld	e, c
	ld	d, a
	call	_read_global_object_info_from_map
;src/LevelLogic.c:77: read_global_block_info_from_map(global_level_blocks_array[level_number]);
	ld	bc, #_global_level_blocks_array+0
	pop	hl
	push	hl
	add	hl, bc
	ld	a, (hl+)
	ld	c, a
	ld	a, (hl)
	ld	e, c
	ld	d, a
	call	_read_global_block_info_from_map
;src/LevelLogic.c:79: for(uint8_t e = 0; e < NUMBER_OF_BLOCKS; e++){
	ld	c, #0x00
00107$:
	ld	a, c
	sub	a, #0x06
	jr	NC, 00102$
;src/LevelLogic.c:80: update_values_in_hud(RIGHT+e, global_blocks_available[e]);
	ld	hl, #_global_blocks_available
	ld	b, #0x00
	add	hl, bc
	ld	e, (hl)
	ld	a, c
	add	a, #0x06
	push	bc
	call	_update_values_in_hud
	pop	bc
;src/LevelLogic.c:79: for(uint8_t e = 0; e < NUMBER_OF_BLOCKS; e++){
	inc	c
	jr	00107$
00102$:
;src/LevelLogic.c:83: get_init_point_from_map(global_colision_map);
	ld	de, #_global_colision_map
	inc	sp
	inc	sp
	jp	_get_init_point_from_map
;src/LevelLogic.c:85: }
	inc	sp
	inc	sp
	ret
;src/LevelLogic.c:87: void update_game_state(GameState new_value){
;	---------------------------------
; Function update_game_state
; ---------------------------------
_update_game_state::
	ld	(#_global_game_state),a
;src/LevelLogic.c:88: global_game_state = new_value;
;src/LevelLogic.c:89: }
	ret
;src/LevelLogic.c:92: void get_colision_from_map(const unsigned char in[], uint8_t out[]){
;	---------------------------------
; Function get_colision_from_map
; ---------------------------------
_get_colision_from_map::
	add	sp, #-5
	ldhl	sp,	#3
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
	ldhl	sp,	#1
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/LevelLogic.c:94: for(uint16_t i = 0; i<NUMBER_OF_TILES_IN_GRID; i++){
	ld	bc, #0x0000
00130$:
	ld	e, c
	ld	d, b
	ld	a, e
	sub	a, #0x2c
	ld	a, d
	sbc	a, #0x01
	jp	NC, 00132$
;src/LevelLogic.c:95: if(in[i] == 51){
	ldhl	sp,	#3
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	e, l
	ld	d, h
;src/LevelLogic.c:105: } else if(in[i] >= 21 && in[i] <= 29){
	ld	a, (de)
	ldhl	sp,	#0
;src/LevelLogic.c:96: out[i] = SOURCE_R;
	ld	(hl+), a
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	e, l
	ld	d, h
;src/LevelLogic.c:95: if(in[i] == 51){
	ldhl	sp,	#0
	ld	a, (hl)
	sub	a, #0x33
	jr	NZ, 00126$
;src/LevelLogic.c:96: out[i] = SOURCE_R;
	ld	a, #0x03
	ld	(de), a
	jr	00131$
00126$:
;src/LevelLogic.c:97: } else if(in[i] == 55){
	ldhl	sp,	#0
	ld	a, (hl)
	sub	a, #0x37
	jr	NZ, 00123$
;src/LevelLogic.c:98: out[i] = SOURCE_L;
	ld	a, #0x0e
	ld	(de), a
	jr	00131$
00123$:
;src/LevelLogic.c:99: } else if(in[i] == 59){
	ldhl	sp,	#0
	ld	a, (hl)
	sub	a, #0x3b
	jr	NZ, 00120$
;src/LevelLogic.c:100: out[i] = SOURCE_U;
	ld	a, #0x0f
	ld	(de), a
	jr	00131$
00120$:
;src/LevelLogic.c:101: } else if(in[i] == 63){
	ldhl	sp,	#0
	ld	a, (hl)
	sub	a, #0x3f
	jr	NZ, 00117$
;src/LevelLogic.c:102: out[i] = SOURCE_D;
	ld	a, #0x10
	ld	(de), a
	jr	00131$
00117$:
;src/LevelLogic.c:103: } else if(in[i] >= 64 && in[i] <= 67){
	ldhl	sp,	#0
	ld	a, (hl)
	sub	a, #0x40
	jr	C, 00113$
	ld	a, #0x43
	sub	a, (hl)
	jr	C, 00113$
;src/LevelLogic.c:104: out[i] = DESTINATION;
	ld	a, #0x04
	ld	(de), a
	jr	00131$
00113$:
;src/LevelLogic.c:105: } else if(in[i] >= 21 && in[i] <= 29){
	ldhl	sp,	#0
	ld	a, (hl)
	sub	a, #0x15
	jr	C, 00109$
	ld	a, #0x1d
	sub	a, (hl)
	jr	C, 00109$
;src/LevelLogic.c:106: out[i] = FALL;
	ld	a, #0x0c
	ld	(de), a
	jr	00131$
00109$:
;src/LevelLogic.c:107: } else if(in[i] >= UMBRAL_COLISION_UP && in[i] <= UMBRAL_COLISION_DOWN){
	ldhl	sp,	#0
	ld	a, (hl)
	sub	a, #0x05
	jr	C, 00105$
	ld	a, #0x14
	sub	a, (hl)
	jr	C, 00105$
;src/LevelLogic.c:108: out[i] = SOLID;
	ld	a, #0x01
	ld	(de), a
	jr	00131$
00105$:
;src/LevelLogic.c:109: } else if(in[i] >= 32 && in[i] <= 39){
	ldhl	sp,	#0
	ld	a, (hl)
	sub	a, #0x20
	jr	C, 00131$
	ld	a, #0x27
	sub	a, (hl)
	jr	C, 00131$
;src/LevelLogic.c:110: out[i] = DOOR;
	ld	a, #0x0d
	ld	(de), a
00131$:
;src/LevelLogic.c:94: for(uint16_t i = 0; i<NUMBER_OF_TILES_IN_GRID; i++){
	inc	bc
	jp	00130$
00132$:
;src/LevelLogic.c:113: }
	add	sp, #5
	ret
;src/LevelLogic.c:115: void read_global_object_info_from_map(const unsigned char* objects_map){
;	---------------------------------
; Function read_global_object_info_from_map
; ---------------------------------
_read_global_object_info_from_map::
	add	sp, #-6
	ldhl	sp,	#3
	ld	a, e
	ld	(hl+), a
;src/LevelLogic.c:116: for(uint8_t e=0; e<NUMBER_OF_OBJECTS; e++){
	ld	a, d
	ld	(hl+), a
	ld	(hl), #0x00
00103$:
	ldhl	sp,	#5
	ld	a, (hl)
	sub	a, #0x08
	jr	NC, 00105$
;src/LevelLogic.c:117: global_object_information[e*3] = objects_map[e*3];
	ld	c, (hl)
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	hl, #_global_object_information
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#3
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#2
	ld	(hl+), a
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	e, l
	ld	d, h
	ld	a, (de)
	ldhl	sp,	#1
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
;src/LevelLogic.c:118: global_object_information[e*3+1] = objects_map[e*3+1];
	ldhl	sp,	#5
	ld	a, (hl)
	ld	e, a
	add	a, a
	add	a, e
	ldhl	sp,	#0
	ld	(hl), a
	ld	e, (hl)
	inc	e
	ld	d, #0x00
	ld	hl, #_global_object_information
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#3
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#2
	ld	(hl+), a
	ld	e, c
	ld	d, b
	inc	de
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	ldhl	sp,	#1
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
;src/LevelLogic.c:119: global_object_information[e*3+2] = objects_map[e*3+2];
	ldhl	sp,	#0
	ld	a, (hl)
	inc	a
	inc	a
	add	a, #<(_global_object_information)
	ld	e, a
	ld	a, #0x00
	adc	a, #>(_global_object_information)
	ld	d, a
	inc	bc
	inc	bc
	ldhl	sp,	#3
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ld	(de), a
;src/LevelLogic.c:116: for(uint8_t e=0; e<NUMBER_OF_OBJECTS; e++){
	ldhl	sp,	#5
	inc	(hl)
	jr	00103$
00105$:
;src/LevelLogic.c:121: }
	add	sp, #6
	ret
;src/LevelLogic.c:123: void read_global_block_info_from_map(const unsigned char* blocks_map){
;	---------------------------------
; Function read_global_block_info_from_map
; ---------------------------------
_read_global_block_info_from_map::
	add	sp, #-1
	push	de
;src/LevelLogic.c:124: for(uint8_t e=0; e<NUMBER_OF_BLOCKS; e++){
	ldhl	sp,	#2
	ld	(hl), #0x00
00103$:
	ldhl	sp,	#2
	ld	a, (hl)
	sub	a, #0x06
	jr	NC, 00105$
;src/LevelLogic.c:125: global_blocks_available[e] = blocks_map[e];
	ld	de, #_global_blocks_available
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	c, l
	ld	b, h
	pop	de
	push	de
	ldhl	sp,	#2
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	ld	(bc), a
;src/LevelLogic.c:124: for(uint8_t e=0; e<NUMBER_OF_BLOCKS; e++){
	ldhl	sp,	#2
	inc	(hl)
	jr	00103$
00105$:
;src/LevelLogic.c:127: }
	add	sp, #3
	ret
;src/LevelLogic.c:129: void change_colision_map_at(uint16_t tileindexBR, uint8_t new_value){
;	---------------------------------
; Function change_colision_map_at
; ---------------------------------
_change_colision_map_at::
	dec	sp
	ldhl	sp,	#0
	ld	(hl), a
;src/LevelLogic.c:130: if(tileindexBR < NUMBER_OF_TILES_IN_GRID){
	ld	c, e
	ld	b, d
	ld	a, c
	sub	a, #0x2c
	ld	a, b
	sbc	a, #0x01
	jr	NC, 00103$
;src/LevelLogic.c:131: global_colision_map[tileindexBR] = new_value;
	ld	hl, #_global_colision_map
	add	hl, de
	ld	e, l
	ld	d, h
	ldhl	sp,	#0
	ld	a, (hl)
	ld	(de), a
;src/LevelLogic.c:132: global_colision_map[tileindexBR-1] = new_value;
	ld	e, c
	ld	d, b
	dec	de
	ld	hl, #_global_colision_map
	add	hl, de
	ld	e, l
	ld	d, h
	ldhl	sp,	#0
	ld	a, (hl)
	ld	(de), a
;src/LevelLogic.c:133: global_colision_map[tileindexBR-20] = new_value;
	ld	a, c
	add	a, #0xec
	ld	e, a
	ld	a, b
	adc	a, #0xff
	ld	d, a
	ld	hl, #_global_colision_map
	add	hl, de
	ld	e, l
	ld	d, h
	ldhl	sp,	#0
	ld	a, (hl)
	ld	(de), a
;src/LevelLogic.c:134: global_colision_map[tileindexBR-21] = new_value;
	ld	a, c
	add	a, #0xeb
	ld	c, a
	ld	a, b
	adc	a, #0xff
	ld	b, a
	ld	hl, #_global_colision_map
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#0
	ld	a, (hl)
	ld	(bc), a
00103$:
;src/LevelLogic.c:136: }
	inc	sp
	ret
;src/LevelLogic.c:138: void change_colision_map_BR(uint16_t tileindexBR, uint8_t new_value){
;	---------------------------------
; Function change_colision_map_BR
; ---------------------------------
_change_colision_map_BR::
	ld	c, a
;src/LevelLogic.c:139: if(tileindexBR < NUMBER_OF_TILES_IN_GRID){
	ld	a, e
	ld	l, d
	sub	a, #0x2c
	ld	a, l
	sbc	a, #0x01
	ret	NC
;src/LevelLogic.c:140: global_colision_map[tileindexBR] = new_value;
	ld	hl, #_global_colision_map
	add	hl, de
	ld	(hl), c
;src/LevelLogic.c:142: }
	ret
;src/LevelLogic.c:144: uint8_t check_colision_of_sprites(uint8_t ax, uint8_t ay, uint8_t aw, uint8_t ah, uint8_t bx, uint8_t by, uint8_t bw, uint8_t bh){
;	---------------------------------
; Function check_colision_of_sprites
; ---------------------------------
_check_colision_of_sprites::
	add	sp, #-6
	ld	c, a
	ldhl	sp,	#5
	ld	(hl), e
;src/LevelLogic.c:145: uint8_t res = 0; //no colision of sprites
	ldhl	sp,	#0
	ld	(hl), #0x00
;src/LevelLogic.c:147: if(ax < bx + bw &&
	ldhl	sp,	#10
	ld	a, (hl)
	ldhl	sp,	#1
	ld	(hl+), a
	ld	(hl), #0x00
	ldhl	sp,	#12
	ld	e, (hl)
	ld	d, #0x00
	ldhl	sp,	#1
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#5
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#4
	ld	(hl-), a
	ld	b, #0x00
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	jr	NC, 00102$
;src/LevelLogic.c:148: ax + aw > bx &&
	ldhl	sp,	#8
	ld	a, (hl)
	ld	e, #0x00
	add	a, c
	ld	c, a
	ld	a, e
	adc	a, b
	ld	b, a
	ldhl	sp,	#1
	ld	a, (hl+)
	sub	a, c
	ld	a, (hl)
	sbc	a, b
	jr	NC, 00102$
;src/LevelLogic.c:149: ay < by + bh &&
	ldhl	sp,	#11
	ld	a, (hl)
	ldhl	sp,	#1
	ld	(hl+), a
	ld	(hl), #0x00
	ldhl	sp,	#13
	ld	c, (hl)
	ld	b, #0x00
	ldhl	sp,	#1
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#5
	ld	a, (hl-)
	dec	hl
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl+)
	sub	a, c
	ld	a, (hl)
	sbc	a, b
	jr	NC, 00102$
;src/LevelLogic.c:150: ay + ah > by){
	ldhl	sp,	#9
	ld	c, (hl)
	ld	b, #0x00
	ldhl	sp,	#3
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#1
	ld	a, (hl+)
	sub	a, c
	ld	a, (hl)
	sbc	a, b
	jr	NC, 00102$
;src/LevelLogic.c:151: res = 1;
	dec	hl
	dec	hl
	ld	(hl), #0x01
00102$:
;src/LevelLogic.c:153: return res;
	ldhl	sp,	#0
	ld	a, (hl)
;src/LevelLogic.c:154: }
	add	sp, #6
	pop	hl
	add	sp, #6
	jp	(hl)
;src/LevelLogic.c:157: void get_init_point_from_map(uint8_t colision_map[NUMBER_OF_TILES_IN_GRID]){
;	---------------------------------
; Function get_init_point_from_map
; ---------------------------------
_get_init_point_from_map::
;src/LevelLogic.c:158: global_first_x = 0;
;src/LevelLogic.c:159: global_first_y = 0;
	xor	a, a
	ld	(#_global_first_x), a
	ld	(#_global_first_y),a
;src/LevelLogic.c:161: for(uint16_t i = 0; i<NUMBER_OF_TILES_IN_GRID; i++){
	ld	bc, #0x0000
00119$:
	ld	l, c
	ld	h, b
	ld	a, l
	sub	a, #0x2c
	ld	a, h
	sbc	a, #0x01
	ret	NC
;src/LevelLogic.c:162: if(colision_map[i] == SOURCE_L || colision_map[i] == SOURCE_R || colision_map[i] == SOURCE_U || colision_map[i] == SOURCE_D){
	ld	l, c
	ld	h, b
	add	hl, de
	ld	a, (hl)
	cp	a, #0x0e
	jr	Z, 00112$
	cp	a, #0x03
	jr	Z, 00112$
	cp	a, #0x0f
	jr	Z, 00112$
	sub	a, #0x10
	jr	NZ, 00120$
00112$:
;src/LevelLogic.c:163: global_init_point = i;
	ld	a, c
	ld	(_global_init_point), a
	ld	a, b
	ld	(_global_init_point + 1), a
;src/LevelLogic.c:164: if(colision_map[i]==SOURCE_L){
	ld	a, (hl)
	cp	a, #0x0e
	jr	NZ, 00110$
;src/LevelLogic.c:165: global_first_x = -1;
	ld	hl, #_global_first_x
	ld	(hl), #0xff
	jr	00120$
00110$:
;src/LevelLogic.c:166: } else if(colision_map[i]==SOURCE_R){
	cp	a, #0x03
	jr	NZ, 00107$
;src/LevelLogic.c:167: global_first_x = 1;
	ld	hl, #_global_first_x
	ld	(hl), #0x01
	jr	00120$
00107$:
;src/LevelLogic.c:168: }else if(colision_map[i]==SOURCE_U){
	cp	a, #0x0f
	jr	NZ, 00104$
;src/LevelLogic.c:169: global_first_y = -1;
	ld	hl, #_global_first_y
	ld	(hl), #0xff
	jr	00120$
00104$:
;src/LevelLogic.c:170: }else if(colision_map[i]==SOURCE_D){
	sub	a, #0x10
	jr	NZ, 00120$
;src/LevelLogic.c:171: global_first_y = 1;
	ld	hl, #_global_first_y
	ld	(hl), #0x01
00120$:
;src/LevelLogic.c:161: for(uint16_t i = 0; i<NUMBER_OF_TILES_IN_GRID; i++){
	inc	bc
;src/LevelLogic.c:175: }
	jr	00119$
;src/LevelLogic.c:177: void move_foward_block_id(uint8_t button_pressed){
;	---------------------------------
; Function move_foward_block_id
; ---------------------------------
_move_foward_block_id::
;src/LevelLogic.c:181: switch (button_pressed)
	or	a, a
	jr	Z, 00101$
	dec	a
	jr	Z, 00102$
	jr	00104$
;src/LevelLogic.c:183: case 0:
00101$:
;src/LevelLogic.c:184: global_selected_block ++;
	ld	hl, #_global_selected_block
	inc	(hl)
;src/LevelLogic.c:185: break;
	jr	00104$
;src/LevelLogic.c:187: case 1:
00102$:
;src/LevelLogic.c:188: global_selected_block --;
	ld	hl, #_global_selected_block
	dec	(hl)
;src/LevelLogic.c:193: }
00104$:
;src/LevelLogic.c:196: if(global_selected_block >= HUD_ITEM_COUNT) {
	ld	hl, #_global_selected_block
	ld	a, (hl)
	xor	a, #0x80
	sub	a, #0x88
	jr	C, 00108$
;src/LevelLogic.c:197: global_selected_block -= HUD_ITEM_COUNT;
	ld	a, (hl)
	add	a, #0xf8
	ld	(hl), a
	ret
00108$:
;src/LevelLogic.c:198: } else if(global_selected_block < 0) {
	ld	hl, #_global_selected_block
	bit	7, (hl)
	ret	Z
;src/LevelLogic.c:199: global_selected_block += HUD_ITEM_COUNT;
	ld	a, (hl)
	add	a, #0x08
	ld	(hl), a
;src/LevelLogic.c:201: }
	ret
;src/LevelLogic.c:203: void init_start_selection_menu(void){
;	---------------------------------
; Function init_start_selection_menu
; ---------------------------------
_init_start_selection_menu::
;src/LevelLogic.c:204: HIDE_WIN;
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xdf
	ldh	(_LCDC_REG + 0), a
;src/LevelLogic.c:205: HIDE_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xfd
	ldh	(_LCDC_REG + 0), a
;src/LevelLogic.c:206: set_bkg_data(0,232,map_tiles_alt);
	ld	de, #_map_tiles_alt
	push	de
	ld	hl, #0xe800
	push	hl
	call	_set_bkg_data
	add	sp, #4
;src/LevelLogic.c:207: set_bkg_tiles(0,0,20,18,selection_menu);
	ld	de, #_selection_menu
	push	de
	ld	hl, #0x1214
	push	hl
	xor	a, a
	rrca
	push	af
	call	_set_bkg_tiles
	add	sp, #6
;src/LevelLogic.c:208: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;src/LevelLogic.c:209: }
	ret
;src/LevelLogic.c:211: void update_start_selection_menu(void){
;	---------------------------------
; Function update_start_selection_menu
; ---------------------------------
_update_start_selection_menu::
;src/LevelLogic.c:212: if(joypad() & J_START){
	call	_joypad
	rlca
	ret	NC
;src/LevelLogic.c:213: update_game_state(STATE_GAME_SETTING);
	ld	a, #0x02
;src/LevelLogic.c:215: }
	jp	_update_game_state
;src/LevelLogic.c:217: void init_victory_screen(void){
;	---------------------------------
; Function init_victory_screen
; ---------------------------------
_init_victory_screen::
;src/LevelLogic.c:218: global_option_selection_from_menu = 0;
	xor	a, a
	ld	(#_global_option_selection_from_menu),a
;src/LevelLogic.c:219: HIDE_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xfd
	ldh	(_LCDC_REG + 0), a
;src/LevelLogic.c:220: hide_character();
	call	_hide_character
;src/LevelLogic.c:221: set_win_tiles(0,0,20,12,victory_screen);
	ld	de, #_victory_screen
	push	de
	ld	hl, #0xc14
	push	hl
	xor	a, a
	rrca
	push	af
	call	_set_win_tiles
	add	sp, #6
;src/LevelLogic.c:222: move_win_screen(-64);
	ld	a, #0xc0
	call	_move_win_screen
;src/LevelLogic.c:223: SHOW_WIN;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x20
	ldh	(_LCDC_REG + 0), a
;src/LevelLogic.c:224: }
	ret
;src/LevelLogic.c:226: void update_victory_screen(void){
;	---------------------------------
; Function update_victory_screen
; ---------------------------------
_update_victory_screen::
;src/LevelLogic.c:227: update_menu_pointer();
	call	_update_menu_pointer
;src/LevelLogic.c:228: if(joypad() & (J_START | J_A)){
	call	_joypad
	and	a, #0x90
	ret	Z
;src/LevelLogic.c:229: if(global_option_selection_from_menu == 0){
	ld	a, (#_global_option_selection_from_menu)
	or	a, a
	jr	NZ, 00102$
;src/LevelLogic.c:230: update_game_state(STATE_GAME_SETTING);
	ld	a, #0x02
	jp	_update_game_state
00102$:
;src/LevelLogic.c:232: update_game_state(STATE_SELECTION);
	ld	a, #0x01
;src/LevelLogic.c:235: }
	jp	_update_game_state
;src/LevelLogic.c:237: void init_game_over_screen(void){
;	---------------------------------
; Function init_game_over_screen
; ---------------------------------
_init_game_over_screen::
;src/LevelLogic.c:238: global_option_selection_from_menu = 0;
	xor	a, a
	ld	(#_global_option_selection_from_menu),a
;src/LevelLogic.c:239: HIDE_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xfd
	ldh	(_LCDC_REG + 0), a
;src/LevelLogic.c:240: hide_character();
	call	_hide_character
;src/LevelLogic.c:241: set_win_tiles(0,0,20,12,game_over_screen);
	ld	de, #_game_over_screen
	push	de
	ld	hl, #0xc14
	push	hl
	xor	a, a
	rrca
	push	af
	call	_set_win_tiles
	add	sp, #6
;src/LevelLogic.c:242: move_win_screen(-64);
	ld	a, #0xc0
	call	_move_win_screen
;src/LevelLogic.c:243: SHOW_WIN;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x20
	ldh	(_LCDC_REG + 0), a
;src/LevelLogic.c:244: }
	ret
;src/LevelLogic.c:246: void update_game_over_screen(void){
;	---------------------------------
; Function update_game_over_screen
; ---------------------------------
_update_game_over_screen::
;src/LevelLogic.c:247: update_menu_pointer();
	call	_update_menu_pointer
;src/LevelLogic.c:248: if(joypad() & (J_START | J_A)){
	call	_joypad
	and	a, #0x90
	ret	Z
;src/LevelLogic.c:249: if(global_option_selection_from_menu == 0){
	ld	a, (#_global_option_selection_from_menu)
	or	a, a
	jr	NZ, 00102$
;src/LevelLogic.c:250: update_game_state(STATE_GAME_SETTING);
	ld	a, #0x02
	jp	_update_game_state
00102$:
;src/LevelLogic.c:252: update_game_state(STATE_SELECTION);
	ld	a, #0x01
;src/LevelLogic.c:255: }
	jp	_update_game_state
	.area _CODE
	.area _INITIALIZER
__xinit__global_colision_map:
	.db #0x00	; 0
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
__xinit__global_blocks_available:
	.db #0x00	; 0
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
__xinit__global_selected_block:
	.db #0x00	;  0
__xinit__global_first_x:
	.db #0x00	;  0
__xinit__global_first_y:
	.db #0x00	;  0
__xinit__global_levels_array:
	.dw _map_test
	.dw _map1_alt
	.dw _map2
__xinit__global_level_objects_array:
	.dw _objects_map_test
	.dw _objects_map1_alt
	.dw _objects_map2
__xinit__global_level_blocks_array:
	.dw _blocks_map_test
	.dw _blocks_map1_alt
	.dw _blocks_map2
__xinit__global_actual_level:
	.db #0x00	; 0
__xinit__global_option_selection_from_menu:
	.db #0x00	; 0
	.area _CABS (ABS)
