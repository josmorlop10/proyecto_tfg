#include <stdio.h>
#include <gb/gb.h>
#include "Headers/Object.h"
#include "Headers/LevelLogic.h"

uint8_t global_object_information[3*NUMBER_OF_OBJECTS] = {0};

void print_objects_in_screen(void){

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
    global_object_information[i*3] = 255;
    global_object_information[(i*3)+1] = 255;
    move_sprite(8+i, 0, 0);
}

uint8_t check_colision_with_object(uint8_t x, uint8_t y, uint8_t w, uint8_t h){
    uint8_t obj_x;
    uint8_t obj_y;
    uint8_t obj_type;
    uint8_t res = 255;

    for(uint8_t e = 0; e<NUMBER_OF_OBJECTS; e++){

        obj_x = global_object_information[3*e];
        obj_y = global_object_information[3*e + 1];
        obj_type = global_object_information[3*e + 2];

        if(obj_x==255 && obj_y==255){
            if(obj_type ==255){
                break;
            }
        }
        //Axis Aligned Bounding box (AABB)
        else if(check_colision_of_sprites(obj_x,obj_y,OBJECT_SIZE, OBJECT_SIZE,
        x, y, w, h)){
            res = e;
            break;
        }
    }

    return res;
}