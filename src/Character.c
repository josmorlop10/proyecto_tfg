#include "Headers/LevelLogic.h"
#include "Headers/Character.h"
#include "Headers/Common.h"
#include "Headers/EventManagement.h"
#include "Headers/Object.h"
#include <stdio.h>
#include <gb/gb.h>

uint8_t debug = 0;

void set_direction(Character* p,  int8_t x, int8_t y){
    p->dir_x = x;
    p->dir_y = y;
}

//Character
void character_init(Character* p) {

    get_init_point_from_map(global_colision_map);
    uint8_t player_x = (global_init_point % 20) * 8 + 8; //columna
    uint8_t player_y = (global_init_point / 20) * 8 + 16; //fila

    p->x = player_x;
    p->y = player_y;
    p->w = 16;
    p->h = 16;
    p->dir_x = 1;  
    p->dir_y = 0; 
    p->speed = 8;
    for(uint8_t i = 0;i<=3;i++){
        p->sprite_ids[i] = i;
    }
    p->tileindexBR = 0;
    p->next_tileindexBR = 0;
}

void move_character(Character* p) {
    //las cordenadas x,y del personaje estan centradas en lo que se ve.
    move_sprite(0, p->x-SPRITESIZE, p->y-SPRITESIZE);
    move_sprite(1, p->x-SPRITESIZE, p->y);
    move_sprite(2, p->x, p->y-SPRITESIZE);
    move_sprite(3, p->x, p->y);

}

void movement_step_by_step(Character* p){
    //TODO no funciona
    for(uint8_t i = 0; i < SPRITESIZE; i++) {
        p->y += 1 * p->dir_y;
        p->x += 1 * p->dir_x;
    }
}

uint8_t canplayermove(Character* p){
    //devuelve 1 si el personaje puede andar, y 0 si no puede
    uint16_t tileindexBR = p->next_tileindexBR;
    uint16_t tileindexTL = tileindexBR -21;
    uint16_t tileindexTR = tileindexBR -20;
    uint16_t tileindexBL = tileindexBR -1;

    //comprobar solidos
    if ((global_colision_map[tileindexTL] == SOLID) || 
    (global_colision_map[tileindexTR] == SOLID) || 
    (global_colision_map[tileindexBL] == SOLID) ||
    (global_colision_map[tileindexBR] == SOLID))
    {
        return 0;
    }
    //comprobar eventos 
    uint8_t event = player_tileBR_over_a_block(p->tileindexBR);
    switch(event){
        case RIGHT:
            set_direction(p, 1, 0);
            break;
        case LEFT:
            set_direction(p, -1, 0);
            break;
        case UP:
            set_direction(p, 0, -1);
            break;
        case DOWN:
            set_direction(p, 0, 1);
            break;
        default:
            break;
    }

    return 1;
}

void flip_direction(Character* p){
    p->dir_x = - p->dir_x;
    p->dir_y = - p->dir_y;
}

void update_character(Character* p) { //devuelve las teclas actuales

    if(player_tileBR_over_destination(p->tileindexBR)){
        update_game_state(STATE_GAME_OVER);
        return;
    }

    p->tileindexBR = tileindex_from_xy(p->x, p->y);
    p->next_tileindexBR = tileindex_from_xy(p->x + SPRITESIZE * p->dir_x, p->y + SPRITESIZE * p->dir_y);

    if(canplayermove(p)) {
        p->x += p->speed * p->dir_x;
        p->y += p->speed * p->dir_y;
    } else {
        flip_direction(p);
    } 
    move_character(p);
}

