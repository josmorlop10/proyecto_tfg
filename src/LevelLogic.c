#include "LevelLogic.h"
#include <stdio.h>
#include <gb/gb.h>
#include <gbdk/console.h>

#define SOLID 1
#define OBJECT 2
#define SOURCE 3
#define DESTINATION 4
#define UMBRAL_COLISION 3

//variables globales
GameState global_game_state = STATE_GAME_SETTING;
uint8_t global_colision_map[360] = {0};
struct TileEvent global_events[10];


void update_game_state(GameState new_value){
     global_game_state = new_value;
}

//READ FROM MAP
void get_colision_from_map(const unsigned char in[], uint8_t out[]){
    uint8_t e = 0;
    for(uint16_t i = 0; i<360; i++){
        if(in[i] >= 24 && in[i] <= 27){
            out[i] = SOURCE;
        } else if(in[i] >= 20 && in[i] <= 23){
            out[i] = DESTINATION;
        } else if(in[i] >= UMBRAL_COLISION){
            out[i] = SOLID;
        }
    }
}

