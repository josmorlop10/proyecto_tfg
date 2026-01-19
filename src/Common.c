#include "Headers/Common.h"
#include <stdio.h>
#include <gb/gb.h>

void performantdelay(uint8_t numloops){
    uint8_t i;
    for(i = 0; i < numloops; i++){
        wait_vbl_done();
    }     
}

uint16_t tileindex_from_xy(uint8_t x, uint8_t y){
    /** Calcula el tileindex BR (Bottom Right) a partir de
    unas coordenadas x,y en pixeles.

    @param x coordenada x en pixeles
    @param y coordenada y en pixeles
    @return el tileindex BR correspondiente a esas coordenadas
    */

    uint8_t indexBRx = (x - 8) / 8; //señala la columna
    uint8_t indexBRy = (y - 16) / 8; //señala la fila
    uint16_t tileindexBR = 20 * indexBRy + indexBRx;

    return tileindexBR;
}


