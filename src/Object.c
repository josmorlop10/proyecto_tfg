#include <stdio.h>
#include <gb/gb.h>
#include "Headers/Object.h"

uint8_t global_object_information[3*NUMBER_OF_OBJECTS] = {84, 28, 8, 92, 28, 8};

void print_objects_in_screen(void){
    //Todo: Se está imprimiendo solo el ultimo de los sprites, pues 
    //usan el mismo tile creo

    uint8_t obj_x;
    uint8_t obj_y;
    uint8_t obj_type;
    for(uint8_t e = 0; e<NUMBER_OF_OBJECTS; e++){
        obj_x = global_object_information[3*e];
        obj_y = global_object_information[3*e + 1];
        obj_type = global_object_information[3*e + 2];
        
        set_sprite_tile(8+e,obj_type);
        move_sprite(8+e, obj_x, obj_y);
    }
}

void hide_object(uint8_t i){
    global_object_information[i*NUMBER_OF_OBJECTS] = 0;
    global_object_information[i*NUMBER_OF_OBJECTS+1] = 0;
}