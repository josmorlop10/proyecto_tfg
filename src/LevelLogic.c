#include "Headers/LevelLogic.h"
#include <stdio.h>
#include <gb/gb.h>
#include <gbdk/console.h>

//variables globales
GameState global_game_state;
uint8_t global_colision_map[360] = {EMPTY};
struct TileEvent global_events[10];
uint16_t global_init_point;

uint8_t global_blocks_available[4] = {2,2,2,2}; //MOCKUP. Change later
uint8_t global_selected_block = 0;

void update_game_state(GameState new_value){
     global_game_state = new_value;
}

//READ FROM MAP
void get_colision_from_map(const unsigned char in[], uint8_t out[]){
    uint8_t e = 0;
    for(uint16_t i = 0; i<360; i++){
        if(in[i] == 27){
            out[i] = SOURCE;
        } else if(in[i] >= 20 && in[i] <= 23){
            out[i] = DESTINATION;
        } else if(in[i] >= UMBRAL_COLISION_UP && in[i] <= UMBRAL_COLISION_DOWN){
            out[i] = SOLID;
        }
    }
}

void change_colision_map_at(uint16_t tileindexBR, uint8_t new_value){
    if(tileindexBR < 360){
        global_colision_map[tileindexBR] = new_value;
        global_colision_map[tileindexBR-1] = new_value;
        global_colision_map[tileindexBR-20] = new_value;
        global_colision_map[tileindexBR-21] = new_value;
    }
}

void change_colision_map_BR(uint16_t tileindexBR, uint8_t new_value){
    if(tileindexBR < 360){
        global_colision_map[tileindexBR] = new_value;
    }
}

//get init point from colision map
void get_init_point_from_map(uint8_t colision_map[360]){
     for(uint16_t i = 0; i<360; i++){
          if(colision_map[i] == SOURCE){
               global_init_point = i;
               break;
          }
     }
}
