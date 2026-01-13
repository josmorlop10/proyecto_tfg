#include <stdio.h>
#include <gb/gb.h>
#include "Headers/Object.h"

uint8_t global_object_information[3*NUMBER_OF_OBJECTS] = {84, 26, 8, 92, 26, 8};

void print_objects_in_screen(void){
    for(uint8_t e = 0; e<NUMBER_OF_OBJECTS; e++){
        uint8_t obj_x = global_object_information[3*e];
        uint8_t obj_y = global_object_information[3*e + 1];
        uint8_t obj_type = global_object_information[3*e + 2];
        move_sprite(obj_type, obj_x, obj_y);
    }
}

void hide_object(uint8_t i){
    global_object_information[i*NUMBER_OF_OBJECTS] = 0;
    global_object_information[i*NUMBER_OF_OBJECTS+1] = 0;
}