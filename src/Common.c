#include "Common.h"
#include <stdio.h>
#include <gb/gb.h>

//variables globales
uint8_t global_colision_map[360] = {0};
struct TileEvent global_events[10];

void performantdelay(uint8_t numloops){
    uint8_t i;
    for(i = 0; i < numloops; i++){
        wait_vbl_done();
    }     
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

