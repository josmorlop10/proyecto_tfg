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

