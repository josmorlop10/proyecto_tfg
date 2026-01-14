#ifndef OBJECT_H
#define OBJECT_H

#include <stdint.h>

#define OBJECT_SIZE 8
#define NUMBER_OF_OBJECTS 2

//OBJECT TYPES;
#define NO_ACTION 8

extern uint8_t global_object_information[3*NUMBER_OF_OBJECTS];

void print_objects_in_screen(void);
void hide_object(uint8_t i);
uint8_t check_colision_with_object(uint8_t x, uint8_t y, uint8_t w, uint8_t h);


#endif