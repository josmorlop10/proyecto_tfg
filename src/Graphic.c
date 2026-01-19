#include "Headers/Graphic.h"
#include "Headers/LevelLogic.h"
#include  "../res/hud_selector.h"
#include <stdio.h>
#include <gb/gb.h>
#include <gbdk/console.h>


//Changing graphics BKG
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

//Changing graphics HUD (WIN)

//TODO:TEMPORAL
void print_counter(void){
    uint8_t tile_id = global_selected_block + 16;
    set_win_tile_xy(0, 0, tile_id);
}

void update_values_in_hud(uint8_t position, uint8_t new_value){
    /** Cambia un valor en la HUD (window) en una posicion concreta.

    @param position la posicion en la que se quiere cambiar el valor
    @param new_value el nuevo valor a poner en esa posicion
    */

    uint8_t x = 0;
    uint8_t y = 0;

    switch (position)
    {
    case RIGHT:
        x = 3;
        y = 1;
        break;
    case LEFT:
        x = 3;
        y = 2;
        break;
    case UP:
        x = 7;
        y = 1;
        break;
    case DOWN:
        x = 7;
        y = 2;
        break;
    default:
        break;
    }

    set_win_tile_xy(x,y, new_value + hud_selectorTileOffset);
}