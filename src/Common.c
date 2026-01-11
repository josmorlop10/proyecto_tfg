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

void change_bkg_tile_16x16(uint16_t tile_index, uint8_t tile_id_BR){

    /** Cambia un conjunto de 2x2 tiles (16x16 px) todos por un conjunto
     * de tiles que esten de seguido en la VRAM. Hay que especificar el
     * tile que esté abajo a la derecha. (Botton Right BR)

    @param tile_index la posicion del tileindex que quieres cambiar
    @param tile_id_BR el nuevo tile index

    */

    uint8_t y = (tile_index / 20);
    uint8_t x = (tile_index % 20);

    uint8_t tile_id_TR = tile_id_BR - 0x01;
    uint8_t tile_id_BL = tile_id_BR - 0x02;
    uint8_t tile_id_TL = tile_id_BR - 0x03;

    set_bkg_tiles(x,y,1,1,&tile_id_BR);
    set_bkg_tiles(x-1,y,1,1,&tile_id_BL);
    set_bkg_tiles(x,y-1,1,1,&tile_id_TR);
    set_bkg_tiles(x-1,y-1,1,1,&tile_id_TL);

}
