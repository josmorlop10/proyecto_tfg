#include "Headers/PointerSelector.h"
#include "Headers/Common.h"
#include "Headers/LevelLogic.h"
#include <gb/gb.h>
#include <stdio.h>

void pointer_init(Pointer* s) {
    s->x = 80;
    s->y = 72;
    for(uint8_t i = 4;i<=7;i++){
        s->sprite_ids[i] = i;
    }
    s->tileindexBR = 0;
}

void move_pointer(Pointer* s) {
    move_sprite(4, s->x- SPRITESIZE, s->y-SPRITESIZE);
    move_sprite(5, s->x- SPRITESIZE, s->y);
    move_sprite(6, s->x, s->y-SPRITESIZE);
    move_sprite(7, s->x, s->y);

}

uint8_t can_pointer_move(Pointer* s, int8_t dir_x, int8_t dir_y){
    uint8_t new_x = s->x + dir_x*SPRITESIZE;
    uint8_t new_y = s->y + dir_y*SPRITESIZE;

    if(new_x < 28 || new_x > 148 || new_y < 40 || new_y > 136){
        return 0;
    }
    return 1;

}

void place_object_at_pointer(Pointer* s, uint8_t block_type){
    change_colision_map_at(s->tileindexBR, BLOCK);
    change_colision_map_BR(s->tileindexBR, block_type);
    change_bkg_tile_16x16(s->tileindexBR, global_selected_block * 4 + 31);
    global_blocks_available[global_selected_block]--;
}

void remove_object_at_pointer(Pointer* s, uint8_t block_type){
  
    change_colision_map_at(s->tileindexBR, EMPTY);
    change_bkg_tile_xy(s->tileindexBR, 0);
    global_blocks_available[block_type]++;
}

uint8_t block_is_not_placed_below(Pointer* s){
    return (global_colision_map[s->tileindexBR] == EMPTY) 
           && (global_colision_map[s->tileindexBR-1] == EMPTY)
           && (global_colision_map[s->tileindexBR-20] == EMPTY)
           && (global_colision_map[s->tileindexBR-21] == EMPTY);
}

uint8_t block_is_placed_below(Pointer* s){

    //comprobar que, abajo a la derecha, el numero está entre 5 (der) y 9(abajo) ambos incluidos
    //comprobar que el resto es distinto de EMPTY
    //devuelbe el bloque si es que hay un bloque. 
    //Si no devuelve 0
    uint8_t res = 0;
    if ((global_colision_map[s->tileindexBR]>= RIGHT && global_colision_map[s->tileindexBR]<=DOWN) 
           && (global_colision_map[s->tileindexBR-1] != EMPTY)
           && (global_colision_map[s->tileindexBR-20] != EMPTY)
           && (global_colision_map[s->tileindexBR-21] != EMPTY)){
                res = global_colision_map[s->tileindexBR];
           }
    return res;
}

void control_pointer(Pointer* s){

    if(joypad() & J_UP) {
        if (can_pointer_move(s, 0, -1)){
            s->y -= 8;
        }
    } else if(joypad() & J_DOWN) {
        if (can_pointer_move(s, 0, 1)){
            s->y += 8;
        }
    } else if(joypad() & J_LEFT) {
        if (can_pointer_move(s, -1, 0)){
            s->x -= 8;
        }
    } else if(joypad() & J_RIGHT) {
        if (can_pointer_move(s, 1, 0)){
            s->x += 8;
        }
    } else if(joypad() & J_A) {
        if(block_is_not_placed_below(s) 
        && (global_blocks_available[global_selected_block]>0)){
            place_object_at_pointer(s, global_selected_block + 6);
        }
    } else if(joypad() & J_B) {
        uint8_t block = block_is_placed_below(s);
        if(block>=6){
            remove_object_at_pointer(s, block - 6);
        }
    } else if(joypad() & J_SELECT) {
        move_foward_block_id();
        print_counter();
    }
}

//TODO:TEMPORAL
void print_counter(void){
    uint8_t tile_id = global_selected_block + 16;
    set_bkg_tiles(1, 1, 1, 1, &tile_id);
}

void update_pointer(Pointer* s) { 
    s->tileindexBR = tileindex_from_xy(s->x, s->y);
    control_pointer(s);
    move_pointer(s);
}

void hide_pointer(void){
    for(uint8_t i= 4; i<=7; i++){
        move_sprite(i, 0, 0);
    }
}

