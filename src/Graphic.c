#include "Headers/Graphic.h"
#include "Headers/LevelLogic.h"
#include "Headers/PointerSelector.h"
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

void change_all_block_tiles(uint8_t tile_id_BR){
    uint8_t block_type;

    for(uint16_t i = 0; i < NUMBER_OF_TILES_IN_GRID; i++){
        block_type = global_colision_map[i];

        if(i >= 21 && block_type >= RIGHT && block_type < RIGHT + NUMBER_OF_BLOCKS){
            if(global_colision_map[i-1] == BLOCK &&
               global_colision_map[i-20] == BLOCK &&
               global_colision_map[i-21] == BLOCK){
                change_bkg_tile_16x16(i, tile_id_BR);
            }
        }
    }
}

void restore_all_block_tiles(void){
    uint8_t block_type;
    uint8_t tile_id_BR;

    for(uint16_t i = 0; i < NUMBER_OF_TILES_IN_GRID; i++){
        block_type = global_colision_map[i];

        if(i >= 21 && block_type >= RIGHT && block_type < RIGHT + NUMBER_OF_BLOCKS){
            if(global_colision_map[i-1] == BLOCK &&
               global_colision_map[i-20] == BLOCK &&
               global_colision_map[i-21] == BLOCK){
                tile_id_BR = (block_type - RIGHT) * 4 + UMBRAL_BLOCKS;
                change_bkg_tile_16x16(i, tile_id_BR);
            }
        }
    }
}

//Changing graphics HUD (WIN)

void change_win_tile_16x16(uint16_t tile_index, uint8_t tile_id_BR){

    /** Cambia un conjunto de 2x2 tiles (16x16 px) todos por un conjunto
     * de tiles que esten de seguido en la VRAM. Hay que especificar el
     * tile que esté abajo a la derecha. (Botton Right BR).

    @param tile_index la posicion del tileindex que quieres cambiar
    @param tile_id_BR el nuevo tile index
    */

    tile_id_BR = tile_id_BR + hud_selectorTileOffset;

    uint8_t y = (tile_index / 20);
    uint8_t x = (tile_index % 20);

    uint8_t tile_id_TR = tile_id_BR - 0x01;
    uint8_t tile_id_BL = tile_id_BR - 0x02;
    uint8_t tile_id_TL = tile_id_BR - 0x03;

    set_win_tiles(x,y,1,1,&tile_id_BR);
    set_win_tiles(x-1,y,1,1,&tile_id_BL);
    set_win_tiles(x,y-1,1,1,&tile_id_TR);
    set_win_tiles(x-1,y-1,1,1,&tile_id_TL);
}

void move_sprite_block_pointer(uint8_t direction){
    //0 der
    //1 izq
    //2 arriba 
    //3 abajo
    //4 clockwise
    //5 counter-clockwise
    //6-7 OPTIONS
    if(direction<6){
        move_sprite(16, 24 + direction * 16 , 144 - global_hud_selected * 4);
    } else {
        move_sprite(16, 0 , 160);
        //change_win_tile_16x16(58,35);
    }
}

//TODO:TEMPORAL
void print_counter(void){
    uint8_t tile_id = global_selected_block + 115;
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
        x = 2;
        y = 2;
        break;
    case LEFT:
        x = 4;
        y = 2;
        break;
    case UP:
        x = 6;
        y = 2;
        break;
    case DOWN:
        x = 8;
        y = 2;
        break;
    case CLOCKWISE:
        x = 10;
        y = 2;
        break;
    case COUNTER_CLOCKWISE:
        x = 12;
        y = 2;
        break;

    default:
        break;
    }

    set_win_tile_xy(x,y, new_value + hud_selectorTileOffset + 1);
}

void move_win_screen(int8_t pixeles){
    //(si pixeles negativo, ira hacia arriba. Si pixeles positivos, hacia abajo)
    if(pixeles < 0){
        pixeles = -pixeles;
        for(uint8_t i = 1;i<=pixeles;i++){
            WY_REG = WY_REG - 1;
            delay(10);
        }
    } else {
        for(uint8_t i = 1;i<=pixeles;i++){
            WY_REG = WY_REG + 1;
            delay(10);
        }   
    }
} 
