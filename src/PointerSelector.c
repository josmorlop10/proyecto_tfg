#include "Headers/PointerSelector.h"
#include "Headers/Common.h"
#include "Headers/LevelLogic.h"
#include "Headers/Object.h"
#include "Headers/Graphic.h"
#include "../res/hud_selector.h"
#include "Headers/HUD_button.h"
#include <gb/gb.h>
#include <stdio.h>

uint8_t global_hud_selected = 0;

void pointer_init(Pointer* s) {
    s->x = 80;
    s->y = 72;
    for(uint8_t i = 4;i<=7;i++){
        s->sprite_ids[i] = i;
    }
    s->tileindexBR = 0;
    move_sprite_block_pointer(global_selected_block);
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

    if(new_x < 20 || new_x > 156 || new_y < 32 || new_y > 120){
        return 0;
    }
    return 1;

}

void place_object_at_pointer(Pointer* s, uint8_t block_type){
    change_colision_map_at(s->tileindexBR, BLOCK);
    change_colision_map_BR(s->tileindexBR, block_type);
    change_bkg_tile_16x16(s->tileindexBR, global_selected_block * 4 + UMBRAL_BLOCKS);
    global_blocks_available[global_selected_block]--;
    update_values_in_hud(block_type, global_blocks_available[global_selected_block]);
}

void remove_object_at_pointer(Pointer* s, uint8_t block_type){
    uint8_t block_index = block_type - RIGHT;
    change_colision_map_at(s->tileindexBR, EMPTY);
    change_bkg_tile_xy(s->tileindexBR, 0);
    global_blocks_available[block_index]++;
    update_values_in_hud(block_type, global_blocks_available[block_index]);
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
    if ((global_colision_map[s->tileindexBR]>= RIGHT && global_colision_map[s->tileindexBR]<=RIGHT+NUMBER_OF_BLOCKS) 
           && (global_colision_map[s->tileindexBR-1] == BLOCK)
           && (global_colision_map[s->tileindexBR-20] == BLOCK)
           && (global_colision_map[s->tileindexBR-21] == BLOCK)){
                res = global_colision_map[s->tileindexBR];
           }
    return res;
}

void update_HUD(void){
    if(global_hud_selected==0 && (joypad() & J_SELECT)) {
        global_hud_selected = !global_hud_selected;
        move_sprite_block_pointer(global_selected_block);
        move_win_screen(-4);
        set_win_tile_xy(0,1,hud_selectorTileOffset+26);
    } else if(global_hud_selected==1 && (joypad() & (J_SELECT | J_A))) {
        if(global_selected_block >= NUMBER_OF_BLOCKS) {
            press_game_hud_button(global_selected_block);
        } else {
            global_hud_selected = !global_hud_selected;
            move_sprite_block_pointer(global_selected_block);
            move_win_screen(4);
            set_win_tile_xy(0,1,hud_selectorTileOffset+27);
        }
    }
}

void control_pointer(Pointer* s){

    if(global_hud_selected==0){

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
            if(global_selected_block < NUMBER_OF_BLOCKS
            && block_is_not_placed_below(s)
            && (global_blocks_available[global_selected_block] > 0)
            && check_colision_with_object(s->x - (16 >> 1), s->y - (16 >> 1), 16, 16) == 255) {
                place_object_at_pointer(s, global_selected_block + RIGHT);
            }
        } else if(joypad() & J_B) {
            uint8_t block = block_is_placed_below(s);
            if(block>=6){
                remove_object_at_pointer(s, block);
            }
        }
    } else { //esta seleccionado el HUD
        if(joypad() & J_LEFT) {
            uint8_t previous = global_selected_block;

            move_foward_block_id(1);
            move_sprite_block_pointer(global_selected_block);
            update_game_hud_button_selection(previous, global_selected_block);

        } else if(joypad() & J_RIGHT) {
            uint8_t previous = global_selected_block;

            move_foward_block_id(0);
            move_sprite_block_pointer(global_selected_block);
            update_game_hud_button_selection(previous, global_selected_block);

        } 
    }
}

void update_pointer(Pointer* s) { 
    s->tileindexBR = tileindex_from_xy(s->x, s->y);
    control_pointer(s);
    if(global_game_state == STATE_GAME_SETTING) {
        move_pointer(s);
    }
}

void hide_pointer(void){
    for(uint8_t i= 4; i<=7; i++){
        move_sprite(i, 0, 160);
    }
    move_sprite(16, 0, 160);
}

static void update_menu_selector_tiles(uint8_t selected_option){
    const uint8_t cursor_row = selected_option == 0 ? 7 : 9;
    const uint8_t blank_row = selected_option == 0 ? 9 : 7;

    set_win_tile_xy(6, blank_row, 0);
    set_win_tile_xy(6, cursor_row, hud_selectorTileOffset + 11);
}

void update_menu_pointer(void){
    const uint8_t currentJoy = joypad();

    if(currentJoy & (J_UP | J_DOWN)){
        global_option_selection_from_menu ^= 1;
        update_menu_selector_tiles(global_option_selection_from_menu);
    }
}
