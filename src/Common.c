#include "Headers/Common.h"
#include <stdio.h>
#include <gb/gb.h>

void performantdelay(uint8_t numloops){
    uint8_t i;
    for(i = 0; i < numloops; i++){
        wait_vbl_done();
    }     
}

//Changing graphics
void change_bkg_tile_xy(uint16_t tile_index, uint8_t tile_id){

    /** Cambia un conjunto de 2x2 tiles (16x16 px) todos por un 
    solo tile especificado.

    @param tile_index la posicion del tileindex que quieres cambiar
    @param tile_id el nuevo tile que quieres que sustituya al resto
    */

    uint8_t y = (tile_index / 20);
    uint8_t x = (tile_index % 20);
    set_bkg_tiles(x-1, y-1, 1, 1, &tile_id);
    set_bkg_tiles(x, y-1, 1, 1, &tile_id);
    set_bkg_tiles(x-1, y, 1, 1, &tile_id);
    set_bkg_tiles(x, y, 1, 1, &tile_id);
}

