;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (Linux)
;--------------------------------------------------------
	.module LevelLogic
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _update_values_in_hud
	.globl _global_levels_array
	.globl _global_selected_block
	.globl _global_blocks_available
	.globl _global_colision_map
	.globl _global_init_point
	.globl _global_events
	.globl _global_game_state
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
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
_global_colision_map::
	.ds 300
_global_blocks_available::
	.ds 8
_global_selected_block::
	.ds 1
_global_levels_array::
	.ds 2
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
;src/LevelLogic.c:21: void init_level(uint8_t level_number){
;	---------------------------------
; Function init_level
; ---------------------------------
_init_level::
;src/LevelLogic.c:23: if(level_number >= sizeof(global_levels_array)){
	ld	c, a
	sub	a, #0x02
	jr	C, 00115$
;src/LevelLogic.c:24: level_number = level_number % sizeof(global_levels_array);
	ld	a, c
	and	a, #0x01
	ld	c, a
;src/LevelLogic.c:27: for(uint16_t i = 0; i<NUMBER_OF_TILES_IN_GRID; i++){
00115$:
	ld	de, #0x0000
00106$:
	ld	a, e
	ld	l, d
	sub	a, #0x2c
	ld	a, l
	sbc	a, #0x01
	jr	NC, 00103$
;src/LevelLogic.c:28: global_colision_map[i] = EMPTY;
	ld	hl, #_global_colision_map
	add	hl, de
	ld	(hl), #0x00
;src/LevelLogic.c:27: for(uint16_t i = 0; i<NUMBER_OF_TILES_IN_GRID; i++){
	inc	de
	jr	00106$
00103$:
;src/LevelLogic.c:31: get_colision_from_map(global_levels_array[level_number], global_colision_map);
	ld	de, #_global_levels_array+0
	xor	a, a
	ld	l, c
	ld	h, a
	add	hl, hl
	add	hl, de
	ld	a, (hl+)
	ld	l, (hl)
	ld	bc, #_global_colision_map
	ld	e, a
	ld	d, l
	call	_get_colision_from_map
;src/LevelLogic.c:34: read_global_object_info_from_map(objects_map1_alt);
	ld	de, #_objects_map1_alt
	call	_read_global_object_info_from_map
;src/LevelLogic.c:35: read_global_block_info_from_map(blocks_map1_alt);
	ld	de, #_blocks_map1_alt
	call	_read_global_block_info_from_map
;src/LevelLogic.c:37: for(uint8_t e = 0; e < NUMBER_OF_BLOCKS; e++){
	ld	c, #0x00
00109$:
	ld	a, c
	sub	a, #0x08
	jr	NC, 00104$
;src/LevelLogic.c:38: update_values_in_hud(RIGHT+e, global_blocks_available[e]+1);
	ld	hl, #_global_blocks_available
	ld	b, #0x00
	add	hl, bc
	ld	e, (hl)
	inc	e
	ld	a, c
	add	a, #0x06
	push	bc
	call	_update_values_in_hud
	pop	bc
;src/LevelLogic.c:37: for(uint8_t e = 0; e < NUMBER_OF_BLOCKS; e++){
	inc	c
	jr	00109$
00104$:
;src/LevelLogic.c:41: get_init_point_from_map(global_colision_map);
	ld	de, #_global_colision_map
;src/LevelLogic.c:43: }
	jp	_get_init_point_from_map
;src/LevelLogic.c:45: void update_game_state(GameState new_value){
;	---------------------------------
; Function update_game_state
; ---------------------------------
_update_game_state::
	ld	(#_global_game_state),a
;src/LevelLogic.c:46: global_game_state = new_value;
;src/LevelLogic.c:47: }
	ret
;src/LevelLogic.c:50: void get_colision_from_map(const unsigned char in[], uint8_t out[]){
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
;src/LevelLogic.c:52: for(uint16_t i = 0; i<NUMBER_OF_TILES_IN_GRID; i++){
	ld	bc, #0x0000
00117$:
	ld	e, c
	ld	d, b
	ld	a, e
	sub	a, #0x2c
	ld	a, d
	sbc	a, #0x01
	jr	NC, 00119$
;src/LevelLogic.c:53: if(in[i] == 51){
	ldhl	sp,	#3
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	e, l
	ld	d, h
;src/LevelLogic.c:57: } else if(in[i] >= 21 && in[i] <= 29){
	ld	a, (de)
	ldhl	sp,	#0
;src/LevelLogic.c:54: out[i] = SOURCE;
	ld	(hl+), a
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	e, l
	ld	d, h
;src/LevelLogic.c:53: if(in[i] == 51){
	ldhl	sp,	#0
	ld	a, (hl)
	sub	a, #0x33
	jr	NZ, 00113$
;src/LevelLogic.c:54: out[i] = SOURCE;
	ld	a, #0x03
	ld	(de), a
	jr	00118$
00113$:
;src/LevelLogic.c:55: } else if(in[i] >= 64 && in[i] <= 67){
	ldhl	sp,	#0
	ld	a, (hl)
	sub	a, #0x40
	jr	C, 00109$
	ld	a, #0x43
	sub	a, (hl)
	jr	C, 00109$
;src/LevelLogic.c:56: out[i] = DESTINATION;
	ld	a, #0x04
	ld	(de), a
	jr	00118$
00109$:
;src/LevelLogic.c:57: } else if(in[i] >= 21 && in[i] <= 29){
	ldhl	sp,	#0
	ld	a, (hl)
	sub	a, #0x15
	jr	C, 00105$
	ld	a, #0x1d
	sub	a, (hl)
	jr	C, 00105$
;src/LevelLogic.c:58: out[i] = FALL;
	ld	a, #0x0e
	ld	(de), a
	jr	00118$
00105$:
;src/LevelLogic.c:59: } else if(in[i] >= UMBRAL_COLISION_UP && in[i] <= UMBRAL_COLISION_DOWN){
	ldhl	sp,	#0
	ld	a, (hl)
	sub	a, #0x05
	jr	C, 00118$
	ld	a, #0x14
	sub	a, (hl)
	jr	C, 00118$
;src/LevelLogic.c:60: out[i] = SOLID;
	ld	a, #0x01
	ld	(de), a
00118$:
;src/LevelLogic.c:52: for(uint16_t i = 0; i<NUMBER_OF_TILES_IN_GRID; i++){
	inc	bc
	jr	00117$
00119$:
;src/LevelLogic.c:63: }
	add	sp, #5
	ret
;src/LevelLogic.c:65: void read_global_object_info_from_map(unsigned char* objects_map){
;	---------------------------------
; Function read_global_object_info_from_map
; ---------------------------------
_read_global_object_info_from_map::
	add	sp, #-6
	ldhl	sp,	#3
	ld	a, e
	ld	(hl+), a
;src/LevelLogic.c:66: for(uint8_t e=0; e<NUMBER_OF_OBJECTS; e++){
	ld	a, d
	ld	(hl+), a
	ld	(hl), #0x00
00103$:
	ldhl	sp,	#5
	ld	a, (hl)
	sub	a, #0x08
	jr	NC, 00105$
;src/LevelLogic.c:67: global_object_information[e*3] = objects_map[e*3];
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
;src/LevelLogic.c:68: global_object_information[e*3+1] = objects_map[e*3+1];
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
;src/LevelLogic.c:69: global_object_information[e*3+2] = objects_map[e*3+2];
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
;src/LevelLogic.c:66: for(uint8_t e=0; e<NUMBER_OF_OBJECTS; e++){
	ldhl	sp,	#5
	inc	(hl)
	jr	00103$
00105$:
;src/LevelLogic.c:71: }
	add	sp, #6
	ret
;src/LevelLogic.c:73: void read_global_block_info_from_map(unsigned char* blocks_map){
;	---------------------------------
; Function read_global_block_info_from_map
; ---------------------------------
_read_global_block_info_from_map::
	add	sp, #-1
	push	de
;src/LevelLogic.c:74: for(uint8_t e=0; e<NUMBER_OF_BLOCKS; e++){
	ldhl	sp,	#2
	ld	(hl), #0x00
00103$:
	ldhl	sp,	#2
	ld	a, (hl)
	sub	a, #0x08
	jr	NC, 00105$
;src/LevelLogic.c:75: global_blocks_available[e] = blocks_map[e];
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
;src/LevelLogic.c:74: for(uint8_t e=0; e<NUMBER_OF_BLOCKS; e++){
	ldhl	sp,	#2
	inc	(hl)
	jr	00103$
00105$:
;src/LevelLogic.c:77: }
	add	sp, #3
	ret
;src/LevelLogic.c:79: void change_colision_map_at(uint16_t tileindexBR, uint8_t new_value){
;	---------------------------------
; Function change_colision_map_at
; ---------------------------------
_change_colision_map_at::
	dec	sp
	ldhl	sp,	#0
	ld	(hl), a
;src/LevelLogic.c:80: if(tileindexBR < NUMBER_OF_TILES_IN_GRID){
	ld	c, e
	ld	b, d
	ld	a, c
	sub	a, #0x2c
	ld	a, b
	sbc	a, #0x01
	jr	NC, 00103$
;src/LevelLogic.c:81: global_colision_map[tileindexBR] = new_value;
	ld	hl, #_global_colision_map
	add	hl, de
	ld	e, l
	ld	d, h
	ldhl	sp,	#0
	ld	a, (hl)
	ld	(de), a
;src/LevelLogic.c:82: global_colision_map[tileindexBR-1] = new_value;
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
;src/LevelLogic.c:83: global_colision_map[tileindexBR-20] = new_value;
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
;src/LevelLogic.c:84: global_colision_map[tileindexBR-21] = new_value;
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
;src/LevelLogic.c:86: }
	inc	sp
	ret
;src/LevelLogic.c:88: void change_colision_map_BR(uint16_t tileindexBR, uint8_t new_value){
;	---------------------------------
; Function change_colision_map_BR
; ---------------------------------
_change_colision_map_BR::
	ld	c, a
;src/LevelLogic.c:89: if(tileindexBR < NUMBER_OF_TILES_IN_GRID){
	ld	a, e
	ld	l, d
	sub	a, #0x2c
	ld	a, l
	sbc	a, #0x01
	ret	NC
;src/LevelLogic.c:90: global_colision_map[tileindexBR] = new_value;
	ld	hl, #_global_colision_map
	add	hl, de
	ld	(hl), c
;src/LevelLogic.c:92: }
	ret
;src/LevelLogic.c:94: uint8_t check_colision_of_sprites(uint8_t ax, uint8_t ay, uint8_t aw, uint8_t ah, uint8_t bx, uint8_t by, uint8_t bw, uint8_t bh){
;	---------------------------------
; Function check_colision_of_sprites
; ---------------------------------
_check_colision_of_sprites::
	add	sp, #-6
	ld	c, a
	ldhl	sp,	#5
	ld	(hl), e
;src/LevelLogic.c:95: uint8_t res = 0; //no colision of sprites
	ldhl	sp,	#0
	ld	(hl), #0x00
;src/LevelLogic.c:97: if(ax < bx + bw &&
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
;src/LevelLogic.c:98: ax + aw > bx &&
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
;src/LevelLogic.c:99: ay < by + bh &&
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
;src/LevelLogic.c:100: ay + ah > by){
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
;src/LevelLogic.c:101: res = 1;
	dec	hl
	dec	hl
	ld	(hl), #0x01
00102$:
;src/LevelLogic.c:103: return res;
	ldhl	sp,	#0
	ld	a, (hl)
;src/LevelLogic.c:104: }
	add	sp, #6
	pop	hl
	add	sp, #6
	jp	(hl)
;src/LevelLogic.c:107: void get_init_point_from_map(uint8_t colision_map[NUMBER_OF_TILES_IN_GRID]){
;	---------------------------------
; Function get_init_point_from_map
; ---------------------------------
_get_init_point_from_map::
	dec	sp
	dec	sp
;src/LevelLogic.c:108: for(uint16_t i = 0; i<NUMBER_OF_TILES_IN_GRID; i++){
	xor	a, a
	ldhl	sp,	#0
	ld	(hl+), a
	ld	(hl), a
	ld	bc, #0x0000
00105$:
	ld	l, c
	ld	h, b
	ld	a, l
	sub	a, #0x2c
	ld	a, h
	sbc	a, #0x01
	jr	NC, 00107$
;src/LevelLogic.c:109: if(colision_map[i] == SOURCE){
	ld	l, c
	ld	h, b
	add	hl, de
	ld	a, (hl)
	sub	a, #0x03
	jr	NZ, 00106$
;src/LevelLogic.c:110: global_init_point = i;
	ldhl	sp,	#0
	ld	a, (hl)
	ld	(#_global_init_point),a
	ldhl	sp,	#1
	ld	a, (hl)
	ld	(#_global_init_point + 1),a
;src/LevelLogic.c:111: break;
	jr	00107$
00106$:
;src/LevelLogic.c:108: for(uint16_t i = 0; i<NUMBER_OF_TILES_IN_GRID; i++){
	inc	bc
	inc	sp
	inc	sp
	push	bc
	jr	00105$
00107$:
;src/LevelLogic.c:114: }
	inc	sp
	inc	sp
	ret
;src/LevelLogic.c:116: void move_foward_block_id(void){
;	---------------------------------
; Function move_foward_block_id
; ---------------------------------
_move_foward_block_id::
;src/LevelLogic.c:117: global_selected_block++;
	ld	hl, #_global_selected_block
	inc	(hl)
;src/LevelLogic.c:118: if(global_selected_block >= NUMBER_OF_BLOCKS){
	ld	a, (hl)
	sub	a, #0x08
	ret	C
;src/LevelLogic.c:119: global_selected_block = 0;
	ld	(hl), #0x00
;src/LevelLogic.c:121: }
	ret
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
	.db 0x00
	.db 0x00
__xinit__global_selected_block:
	.db #0x00	; 0
__xinit__global_levels_array:
	.dw _map1_alt
	.area _CABS (ABS)
