#ifndef OBJECT_H
#define OBJECT_H

#include <stdint.h>

#define OBJECT_SIZE 8
#define NUMBER_OF_OBJECTS 8

//OBJECT TYPES;
//Esto debe estar en orden. Empieza en 8, y no en 0 debido a los tiles están cargados
//de esa forma en la OAM.
#define GO_RIGHT 8
#define GO_LEFT 9
#define GO_UP 10
#define GO_DOWN 11
#define TURN_AROUND 12
#define NO_ACTION 13
#define KEY 14
#define JUMP 15

extern uint8_t global_object_information[3*NUMBER_OF_OBJECTS];

void print_objects_in_screen(void);
void hide_object(uint8_t i);
uint8_t check_colision_with_object(uint8_t x, uint8_t y, uint8_t w, uint8_t h);


#endif