#ifndef CHARACTER_H
#define CHARACTER_H

#include <stdint.h>

typedef struct {
    int8_t sprite_ids[4];
    uint8_t x, y;
    int8_t dir_x, dir_y; 
    int8_t speed;
    //atributos derivados
    uint16_t tileindexBR;
    uint16_t next_tileindexBR;
} Character;

void character_init(Character* p);
void update_character(Character* p);
void move_character(Character* p);
void set_direction(Character* p,  int8_t x, int8_t y);
uint8_t canplayermove(Character* p);

#endif