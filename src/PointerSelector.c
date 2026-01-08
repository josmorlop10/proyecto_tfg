#include "Headers/PointerSelector.h"
#include "Headers/Common.h"
#include "Headers/LevelLogic.h"
#include <gb/gb.h>
#include <stdio.h>


void pointer_init(Pointer* s) {
    s->x = 80;
    s->y = 72;
    for(uint8_t i = 4;i<=7;i++){
        s->sprite_ids[i] = i;
    }
}

void move_pointer(Pointer* s) {
    move_sprite(4, s->x- SPRITESIZE, s->y-SPRITESIZE);
    move_sprite(5, s->x- SPRITESIZE, s->y);
    move_sprite(6, s->x, s->y-SPRITESIZE);
    move_sprite(7, s->x, s->y);

}

void place_object_at_pointer(uint8_t x, uint8_t y){
    uint8_t indexBRx = (x - 8) / 8; //señala la columna
    uint8_t indexBRy = (y - 16) / 8; //señala la fila
    uint16_t tileindexBR = 20 * indexBRy + indexBRx;
    change_colision_map_at(tileindexBR, SOLID);
    change_bkg_tile_xy(tileindexBR, 3);
}

void control_pointer(Pointer* s){

    if(joypad() & J_UP) {
        s->y -= 8;
    } else if(joypad() & J_DOWN) {
        s->y += 8;
    } else if(joypad() & J_LEFT) {
        s->x -= 8;
    } else if(joypad() & J_RIGHT) {
        s->x += 8;
    } else if(joypad() & J_A) {
        place_object_at_pointer(s->x, s->y);
    }
}

void update_pointer(Pointer* s) { 
    control_pointer(s);
    move_pointer(s);
}

void hide_pointer(void){
    for(uint8_t i= 4; i<=7; i++){
        move_sprite(i, 0, 0);
    }
}

