#include "Headers/LevelLogic.h"
#include "Headers/Object.h"
#include "Headers/Graphic.h"
#include <stdio.h>
#include <gb/gb.h>
#include <gbdk/console.h>
#include "../res/map1_alt.h"
#include "../res/map_tiles.h"

//variables globales
GameState global_game_state;
uint8_t global_colision_map[NUMBER_OF_TILES_IN_GRID] = {EMPTY};
struct TileEvent global_events[10];
uint16_t global_init_point;

uint8_t global_blocks_available[NUMBER_OF_BLOCKS] = {0}; 
uint8_t global_selected_block = 0;

const unsigned char* global_levels_array[] = {map1_alt};

void init_level(uint8_t level_number){

    if(level_number >= sizeof(global_levels_array)){
        level_number = level_number % sizeof(global_levels_array);
    }
    //map
    for(uint16_t i = 0; i<NUMBER_OF_TILES_IN_GRID; i++){
        global_colision_map[i] = EMPTY;
    }

    get_colision_from_map(global_levels_array[level_number], global_colision_map);
    
    //TODO: Those values in params (objects_map1, blocks_map should be decided by the level. Not alway map1)
    read_global_object_info_from_map(objects_map1_alt);
    read_global_block_info_from_map(blocks_map1_alt);

    for(uint8_t e = 0; e < NUMBER_OF_BLOCKS; e++){
        update_values_in_hud(RIGHT+e, global_blocks_available[e]+1);
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
        if(in[i] == 51){
            out[i] = SOURCE;
        } else if(in[i] >= 64 && in[i] <= 67){
            out[i] = DESTINATION;
        } else if(in[i] >= 21 && in[i] <= 29){
            out[i] = FALL;
        } else if(in[i] >= UMBRAL_COLISION_UP && in[i] <= UMBRAL_COLISION_DOWN){
            out[i] = SOLID;
        }
    }
}

void read_global_object_info_from_map(unsigned char* objects_map){
    for(uint8_t e=0; e<NUMBER_OF_OBJECTS; e++){
        global_object_information[e*3] = objects_map[e*3];
        global_object_information[e*3+1] = objects_map[e*3+1];
        global_object_information[e*3+2] = objects_map[e*3+2];
    }
}

void read_global_block_info_from_map(unsigned char* blocks_map){
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
     for(uint16_t i = 0; i<NUMBER_OF_TILES_IN_GRID; i++){
          if(colision_map[i] == SOURCE){
               global_init_point = i;
               break;
          }
     }
}

void move_foward_block_id(void){
    global_selected_block++;
    if(global_selected_block >= NUMBER_OF_BLOCKS){
        global_selected_block = 0;
    }
}

