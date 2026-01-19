#include "Headers/EventManagement.h"
#include "Headers/LevelLogic.h"
#include <stdio.h>
#include <gb/gb.h>
#include <gbdk/console.h>

uint8_t player_tileBR_over_a_block(uint16_t tileindexBR){
    //devuelve el bloque sobre el que está el personaje
    if(global_colision_map[tileindexBR]>= RIGHT && global_colision_map[tileindexBR]<=DOWN){
        return global_colision_map[tileindexBR];
    } else {
        return 0;
    }
}

uint8_t player_tileBR_over_destination(uint16_t tileindexBR){
    if(global_colision_map[tileindexBR] == DESTINATION &&
       global_colision_map[tileindexBR-1] == DESTINATION &&
       global_colision_map[tileindexBR-20] == DESTINATION &&
       global_colision_map[tileindexBR-21] == DESTINATION){
        return 1;
    } else {
        return 0;
    }
}

uint8_t player_over_fall(uint16_t tileindexBR){
    if(global_colision_map[tileindexBR] == FALL &&
        global_colision_map[tileindexBR-1] == FALL &&
        global_colision_map[tileindexBR-20] == FALL &&
        global_colision_map[tileindexBR-21] == FALL){
            return 1;
    } else {
        return 0;
    }
}

