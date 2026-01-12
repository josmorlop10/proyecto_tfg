#ifndef OBJECT_H
#define OBJECT_H

#include <stdint.h>

typedef struct {
    int8_t sprite_id;
    //las posiciones x e y de los objetos no pueden ser aleatorias. Deben ser
    //de la forma 4 + k*8, para que esté dento del grid. 
    uint8_t x, y;
    uint8_t weight,height;

} Object;

void init_object(void);
void update_object(void);
void check_colision(Object o, uint8_t px, uint8_t py);


#endif