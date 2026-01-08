#include "LevelLogic.h"
#include "Character.h"
#include "Common.h"
#include <stdio.h>
#include <gb/gb.h>

uint8_t debug = 0;

//atributos derivados.
uint16_t tile_index_BR(Character* p){
    uint8_t indexBRx = (p->x - 8) / 8; //señala la columna
    uint8_t indexBRy = (p->y - 16) / 8; //señala la fila
    uint16_t tileindexBR = 20 * (indexBRy) + (indexBRx);

    return tileindexBR;
}

uint16_t next_tile_index_BR(Character* p){
    uint8_t next_indexBRx = (p->x - 8 + SPRITESIZE * p->dir_x) / 8; //señala la columna
    uint8_t next_indexBRy = (p->y - 16 + SPRITESIZE * p->dir_y) / 8; //señala la fila
    uint16_t next_tileindexBR = 20 * (next_indexBRy) + (next_indexBRx);

    return next_tileindexBR;
}

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
    p->dir_x = 1;  
    p->dir_y = 0; 
    p->speed = 8;
    for(uint8_t i = 0;i<=3;i++){
        p->sprite_ids[i] = i;
    }
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
    uint16_t tileindexBR = next_tile_index_BR(p);
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
    /* 
    if (global_colision_map[tileindexTL] == OBJECT){
        return event_management(tileindexTL);
    } else if ((global_colision_map[tileindexTR] == OBJECT)){
        return event_management(tileindexTR);
    } else if ((global_colision_map[tileindexBR] == OBJECT)){
        return event_management(tileindexBR);
    } else if ((global_colision_map[tileindexBL] == OBJECT)){
        return event_management(tileindexBL); 

    }  */

    return 1;
}

void flip_direction(Character* p){
    p->dir_x = - p->dir_x;
    p->dir_y = - p->dir_y;
}

//DEBUG 
void control_player(Character* p){

    if(joypad() & J_UP) {
        set_direction(p, 0, -1);
        if(canplayermove(p)) {
            movement_step_by_step(p);
        }
    } else if(joypad() & J_DOWN) {
        set_direction(p, 0, 1);
        if(canplayermove(p)) {
            movement_step_by_step(p);
        }
    } else if(joypad() & J_LEFT) {
        set_direction(p, -1, 0);
        if(canplayermove(p)) {
            movement_step_by_step(p);
        }
    } else if(joypad() & J_RIGHT) {
        set_direction(p, 1, 0);
        if(canplayermove(p)) {
            movement_step_by_step(p);
        }
    }
}

void update_character(Character* p) { //devuelve las teclas actuales

     if(canplayermove(p)) {
        p->x += p->speed * p->dir_x;
        p->y += p->speed * p->dir_y;
    } else {
        flip_direction(p);
    } 
    control_player(p); //DEBUG
    move_character(p);
}

