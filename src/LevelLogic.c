#include "Headers/LevelLogic.h"
#include "Headers/Character.h"
#include "Headers/PointerSelector.h"
#include "Headers/Object.h"
#include "Headers/Graphic.h"
#include "Headers/Common.h"

#include <stdio.h>
#include <gb/gb.h>
#include <gbdk/console.h>
#include "../res/map1_alt.h"
#include "../res/map2.h"
#include "../res/map_test.h"
#include "../res/png_prueba.h"
#include "../res/selection_menu.h"
#include "../res/map_tiles_alt.h"
#include "../res/hud_tiles.h"
#include "../res/game_over_screen.h"
#include "../res/victory_screen.h"

#include "Headers/PointerSelector.h"
#include "Headers/HUD_button.h"


//variables globales
GameState global_game_state;
uint8_t global_colision_map[NUMBER_OF_TILES_IN_GRID] = {EMPTY};
struct TileEvent global_events[10];
uint16_t global_init_point;
uint8_t global_keyset;

uint8_t global_blocks_available[NUMBER_OF_BLOCKS] = {0}; 
int8_t global_selected_block = 0;

int8_t global_first_x = 0;
int8_t global_first_y = 0;

const unsigned char* global_levels_array[] = {map_test, map1_alt, map2};
const unsigned char* global_level_objects_array[] = {objects_map_test, objects_map1_alt, objects_map2};
const unsigned char* global_level_blocks_array[] = { blocks_map_test, blocks_map1_alt, blocks_map2 };

#define LEVEL_COUNT (sizeof(global_levels_array) / sizeof(global_levels_array[0]))

uint8_t global_actual_level = 0;
uint8_t global_option_selection_from_menu = 0;
uint8_t global_steps_counter = MAX_STEPS_COUNTER;

void reset_steps_counter(void){
    global_steps_counter = MAX_STEPS_COUNTER;
}

void decrease_steps_counter(void){
    if(global_steps_counter > 0){
        global_steps_counter--;
        print_counter();
    }
}

uint8_t normalize_level_number(uint8_t level_number){
    if(level_number >= NUMBER_OF_LEVELS){
        level_number = level_number % NUMBER_OF_LEVELS;
    }

    return level_number;
}

void init_game_title(void){
    
    HIDE_WIN;
    HIDE_SPRITES;
    set_bkg_data(0,232,png_prueba_tiles);
    set_bkg_tiles(0,0,20,18,png_prueba_map);
    SHOW_BKG;
}

void init_level(uint8_t level_number){

    global_keyset = 0;
    global_hud_selected = 0;
    reset_steps_counter();
    level_number = normalize_level_number(level_number);
    global_actual_level = level_number;

    //map
    for(uint16_t i = 0; i<NUMBER_OF_TILES_IN_GRID; i++){
        global_colision_map[i] = EMPTY;
    }

    get_colision_from_map(global_levels_array[level_number], global_colision_map);
    read_global_object_info_from_map(global_level_objects_array[level_number]);
    read_global_block_info_from_map(global_level_blocks_array[level_number]);

    for(uint8_t e = 0; e < NUMBER_OF_BLOCKS; e++){
        update_values_in_hud(RIGHT+e, global_blocks_available[e]);
    }

    get_init_point_from_map(global_colision_map);

}

void update_game_state(GameState new_value){
     global_game_state = new_value;
}

//READ FROM MAP
void get_colision_from_map(const unsigned char in[], uint8_t out[]){
    uint8_t e = 0;
    for(uint16_t i = 0; i<NUMBER_OF_TILES_IN_GRID; i++){
        if(in[i] >= 48 && in[i] <= 63){
            out[i] = NULO;
            if(in[i] == 51){
                out[i] = SOURCE_R;
            } else if(in[i] == 55){
                out[i] = SOURCE_L;
            } else if(in[i] == 59){
                out[i] = SOURCE_U;
            } else if(in[i] == 63){
                out[i] = SOURCE_D;
            } 
        }else if(in[i] >= 64 && in[i] <= 67){
            out[i] = DESTINATION;
        } else if(in[i] >= 21 && in[i] <= 29){
            out[i] = FALL;
        } else if(in[i] >= UMBRAL_COLISION_UP && in[i] <= UMBRAL_COLISION_DOWN){
            out[i] = SOLID;
        } else if(in[i] >= 32 && in[i] <= 39){
            out[i] = DOOR;
        }
    }
}

void read_global_object_info_from_map(const unsigned char* objects_map){
    for(uint8_t e=0; e<NUMBER_OF_OBJECTS; e++){
        global_object_information[e*3] = objects_map[e*3];
        global_object_information[e*3+1] = objects_map[e*3+1];
        global_object_information[e*3+2] = objects_map[e*3+2];
    }
}

void read_global_block_info_from_map(const unsigned char* blocks_map){
    for(uint8_t e=0; e<NUMBER_OF_BLOCKS; e++){
        global_blocks_available[e] = blocks_map[e];
    }
}

void change_colision_map_at(uint16_t tileindexBR, uint8_t new_value){
    if(tileindexBR < NUMBER_OF_TILES_IN_GRID){
        global_colision_map[tileindexBR] = new_value;
        global_colision_map[tileindexBR-1] = new_value;
        global_colision_map[tileindexBR-20] = new_value;
        global_colision_map[tileindexBR-21] = new_value;
    }
}

void change_colision_map_BR(uint16_t tileindexBR, uint8_t new_value){
    if(tileindexBR < NUMBER_OF_TILES_IN_GRID){
        global_colision_map[tileindexBR] = new_value;
    }
}

uint8_t check_colision_of_sprites(uint8_t ax, uint8_t ay, uint8_t aw, uint8_t ah, uint8_t bx, uint8_t by, uint8_t bw, uint8_t bh){
        uint8_t res = 0; //no colision of sprites
            //Axis Aligned Bounding box (AABB)
            if(ax < bx + bw &&
            ax + aw > bx &&
            ay < by + bh &&
            ay + ah > by){
                res = 1;
            }
        return res;
}

//get init point from colision map
void get_init_point_from_map(uint8_t colision_map[NUMBER_OF_TILES_IN_GRID]){
    global_first_x = 0;
    global_first_y = 0;

    for(uint16_t i = 0; i<NUMBER_OF_TILES_IN_GRID; i++){
            if(colision_map[i] == SOURCE_L || colision_map[i] == SOURCE_R || colision_map[i] == SOURCE_U || colision_map[i] == SOURCE_D){
                global_init_point = i;
                if(colision_map[i]==SOURCE_L){
                    global_first_x = -1;
                } else if(colision_map[i]==SOURCE_R){
                    global_first_x = 1;
                }else if(colision_map[i]==SOURCE_U){
                    global_first_y = -1;
                }else if(colision_map[i]==SOURCE_D){
                    global_first_y = 1;
                }
          }
     }
}

void move_foward_block_id(uint8_t button_pressed){
    //0 der
    //1 izq

    switch (button_pressed)
    {
    case 0:
        global_selected_block ++;
        break;

    case 1:
        global_selected_block --;
        break;
    
    default:
        break;
    }

    if(global_selected_block >= HUD_ITEM_COUNT) {
        global_selected_block -= HUD_ITEM_COUNT;
    } else if(global_selected_block < 0) {
        global_selected_block += HUD_ITEM_COUNT;
    }
}

void update_start_selection_menu(void){
    if(joypad() & J_START){
        uint8_t blank_map[20 * 18];
        for(uint16_t i = 0; i < 20 * 18; i++) {
            blank_map[i] = 96;
        }
        set_bkg_tiles(0, 0, 20, 18, blank_map);
        move_win_screen(120);
        update_game_state(STATE_GAME_SETTING);
    }
}

void init_win_screen(const unsigned char* screen, uint8_t wx, uint8_t wy, uint8_t width, uint8_t height, int8_t movement){
    HIDE_SPRITES;
    hide_character();
    WX_REG = wx;
    WY_REG = wy;
    set_win_tiles(0,0,width,height,screen);
    if(movement != 0){
        move_win_screen(movement);
    }
    SHOW_WIN;
}

void update_victory_screen(void){
    update_menu_pointer();
    if(joypad() & (J_START | J_A)){
        if(global_option_selection_from_menu == 0){
            update_game_state(STATE_GAME_SETTING);
        } else {
            update_game_state(STATE_SELECTION);
        }
    }
}

void update_game_over_screen(void){
    update_menu_pointer();
    if(joypad() & (J_START | J_A)){
        if(global_option_selection_from_menu == 0){
            update_game_state(STATE_GAME_SETTING);
        } else {
            update_game_state(STATE_SELECTION);
        }
    }
}

void update_pausa_screen(void) {
    update_menu_pointer();
    if(joypad() & (J_START | J_A)){
        if(global_option_selection_from_menu == 0){
            waitpadup();
            update_game_state(STATE_GAME_RUNNING);
        } else {
            update_game_state(STATE_GAME_SETTING);
        }
    }
} 
