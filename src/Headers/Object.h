#ifndef OBJECT_H
#define OBJECT_H

#include <stdint.h>

#define OBJECT_SIZE 8
#define NUMBER_OF_OBJECTS 2

//OBJECT TYPES;

#define GO_RIGHT 0
#define GO_LEFT 1
#define GO_UP 2
#define GO_DOWN 3
#define TURN_AROUND 4
#define NO_ACTION 5
#define KEY 6
#define JUMP 7

extern uint8_t global_object_information[3*NUMBER_OF_OBJECTS];

void print_objects_in_screen(void);
void hide_object(uint8_t i);
uint8_t check_colision_with_object(uint8_t x, uint8_t y, uint8_t w, uint8_t h);


#endif