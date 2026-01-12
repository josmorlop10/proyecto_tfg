;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (Linux)
;--------------------------------------------------------
	.module LevelLogic
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
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
	.globl _change_colision_map_at
	.globl _change_colision_map_BR
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
	.ds 360
_global_blocks_available::
	.ds 4
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
;src/LevelLogic.c:19: void init_level(uint8_t level_number){
;	---------------------------------
; Function init_level
; ---------------------------------
_init_level::
;src/LevelLogic.c:21: if(level_number >= sizeof(global_levels_array)){
	ld	c, a
	sub	a, #0x02
	jr	C, 00111$
;src/LevelLogic.c:22: level_number = level_number % sizeof(global_levels_array);
	ld	a, c
	and	a, #0x01
	ld	c, a
;src/LevelLogic.c:25: for(uint16_t i = 0; i<360; i++){
00111$:
	ld	de, #0x0000
00105$:
	ld	a, e
	ld	l, d
	sub	a, #0x68
	ld	a, l
	sbc	a, #0x01
	jr	NC, 00103$
;src/LevelLogic.c:26: global_colision_map[i] = EMPTY;
	ld	hl, #_global_colision_map
	add	hl, de
	ld	(hl), #0x00
;src/LevelLogic.c:25: for(uint16_t i = 0; i<360; i++){
	inc	de
	jr	00105$
00103$:
;src/LevelLogic.c:29: get_colision_from_map(global_levels_array[level_number], global_colision_map);
	xor	a, a
	ld	l, c
	ld	h, a
	add	hl, hl
	ld	de, #_global_levels_array
	add	hl, de
	ld	a, (hl+)
	ld	l, (hl)
	ld	bc, #_global_colision_map
	ld	e, a
	ld	d, l
	call	_get_colision_from_map
;src/LevelLogic.c:30: get_init_point_from_map(global_colision_map);
	ld	de, #_global_colision_map
;src/LevelLogic.c:32: }
	jp	_get_init_point_from_map
;src/LevelLogic.c:34: void update_game_state(GameState new_value){
;	---------------------------------
; Function update_game_state
; ---------------------------------
_update_game_state::
	ld	(#_global_game_state),a
;src/LevelLogic.c:35: global_game_state = new_value;
;src/LevelLogic.c:36: }
	ret
;src/LevelLogic.c:39: void get_colision_from_map(const unsigned char in[], uint8_t out[]){
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
;src/LevelLogic.c:41: for(uint16_t i = 0; i<360; i++){
	ld	bc, #0x0000
00113$:
	ld	e, c
	ld	d, b
	ld	a, e
	sub	a, #0x68
	ld	a, d
	sbc	a, #0x01
	jr	NC, 00115$
;src/LevelLogic.c:42: if(in[i] == 27){
	ldhl	sp,	#3
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	e, l
	ld	d, h
	ld	a, (de)
	ldhl	sp,	#0
;src/LevelLogic.c:43: out[i] = SOURCE;
	ld	(hl+), a
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	e, l
	ld	d, h
;src/LevelLogic.c:42: if(in[i] == 27){
	ldhl	sp,	#0
	ld	a, (hl)
	sub	a, #0x1b
	jr	NZ, 00109$
;src/LevelLogic.c:43: out[i] = SOURCE;
	ld	a, #0x03
	ld	(de), a
	jr	00114$
00109$:
;src/LevelLogic.c:44: } else if(in[i] >= 20 && in[i] <= 23){
	ldhl	sp,	#0
	ld	a, (hl)
	sub	a, #0x14
	jr	C, 00105$
	ld	a, #0x17
	sub	a, (hl)
	jr	C, 00105$
;src/LevelLogic.c:45: out[i] = DESTINATION;
	ld	a, #0x04
	ld	(de), a
	jr	00114$
00105$:
;src/LevelLogic.c:46: } else if(in[i] >= UMBRAL_COLISION_UP && in[i] <= UMBRAL_COLISION_DOWN){
	ldhl	sp,	#0
	ld	a, (hl)
	sub	a, #0x03
	jr	C, 00114$
	ld	a, #0x0f
	sub	a, (hl)
	jr	C, 00114$
;src/LevelLogic.c:47: out[i] = SOLID;
	ld	a, #0x01
	ld	(de), a
00114$:
;src/LevelLogic.c:41: for(uint16_t i = 0; i<360; i++){
	inc	bc
	jr	00113$
00115$:
;src/LevelLogic.c:50: }
	add	sp, #5
	ret
;src/LevelLogic.c:52: void change_colision_map_at(uint16_t tileindexBR, uint8_t new_value){
;	---------------------------------
; Function change_colision_map_at
; ---------------------------------
_change_colision_map_at::
	dec	sp
	ldhl	sp,	#0
	ld	(hl), a
;src/LevelLogic.c:53: if(tileindexBR < 360){
	ld	c, e
	ld	b, d
	ld	a, c
	sub	a, #0x68
	ld	a, b
	sbc	a, #0x01
	jr	NC, 00103$
;src/LevelLogic.c:54: global_colision_map[tileindexBR] = new_value;
	ld	hl, #_global_colision_map
	add	hl, de
	ld	e, l
	ld	d, h
	ldhl	sp,	#0
	ld	a, (hl)
	ld	(de), a
;src/LevelLogic.c:55: global_colision_map[tileindexBR-1] = new_value;
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
;src/LevelLogic.c:56: global_colision_map[tileindexBR-20] = new_value;
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
;src/LevelLogic.c:57: global_colision_map[tileindexBR-21] = new_value;
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
;src/LevelLogic.c:59: }
	inc	sp
	ret
;src/LevelLogic.c:61: void change_colision_map_BR(uint16_t tileindexBR, uint8_t new_value){
;	---------------------------------
; Function change_colision_map_BR
; ---------------------------------
_change_colision_map_BR::
	ld	c, a
;src/LevelLogic.c:62: if(tileindexBR < 360){
	ld	a, e
	ld	l, d
	sub	a, #0x68
	ld	a, l
	sbc	a, #0x01
	ret	NC
;src/LevelLogic.c:63: global_colision_map[tileindexBR] = new_value;
	ld	hl, #_global_colision_map
	add	hl, de
	ld	(hl), c
;src/LevelLogic.c:65: }
	ret
;src/LevelLogic.c:68: void get_init_point_from_map(uint8_t colision_map[360]){
;	---------------------------------
; Function get_init_point_from_map
; ---------------------------------
_get_init_point_from_map::
	dec	sp
	dec	sp
;src/LevelLogic.c:69: for(uint16_t i = 0; i<360; i++){
	xor	a, a
	ldhl	sp,	#0
	ld	(hl+), a
	ld	(hl), a
	ld	bc, #0x0000
00105$:
	ld	l, c
	ld	h, b
	ld	a, l
	sub	a, #0x68
	ld	a, h
	sbc	a, #0x01
	jr	NC, 00107$
;src/LevelLogic.c:70: if(colision_map[i] == SOURCE){
	ld	l, c
	ld	h, b
	add	hl, de
	ld	a, (hl)
	sub	a, #0x03
	jr	NZ, 00106$
;src/LevelLogic.c:71: global_init_point = i;
	ldhl	sp,	#0
	ld	a, (hl)
	ld	(#_global_init_point),a
	ldhl	sp,	#1
	ld	a, (hl)
	ld	(#_global_init_point + 1),a
;src/LevelLogic.c:72: break;
	jr	00107$
00106$:
;src/LevelLogic.c:69: for(uint16_t i = 0; i<360; i++){
	inc	bc
	inc	sp
	inc	sp
	push	bc
	jr	00105$
00107$:
;src/LevelLogic.c:75: }
	inc	sp
	inc	sp
	ret
;src/LevelLogic.c:77: void move_foward_block_id(void){
;	---------------------------------
; Function move_foward_block_id
; ---------------------------------
_move_foward_block_id::
;src/LevelLogic.c:78: global_selected_block++;
	ld	hl, #_global_selected_block
	inc	(hl)
;src/LevelLogic.c:79: if(global_selected_block >= 4){
	ld	a, (hl)
	sub	a, #0x04
	ret	C
;src/LevelLogic.c:80: global_selected_block = 0;
	ld	(hl), #0x00
;src/LevelLogic.c:82: }
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
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
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
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
__xinit__global_selected_block:
	.db #0x00	; 0
__xinit__global_levels_array:
	.dw _map1
	.area _CABS (ABS)
