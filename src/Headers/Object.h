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

#endif