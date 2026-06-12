#include <stdio.h>
#include <gb/gb.h>
#include "Headers/Object.h"
#include "Headers/LevelLogic.h"

uint8_t global_object_information[3*NUMBER_OF_OBJECTS] = {0};
static uint8_t global_object_vaiven_frame = 0;

void print_objects_in_screen(void){

    uint8_t obj_x;
    uint8_t obj_y;
    uint8_t obj_type;
    for(uint8_t e = 0; e<NUMBER_OF_OBJECTS; e++){
        obj_x = global_object_information[3*e];
        obj_y = global_object_information[3*e + 1];
        obj_type = global_object_information[3*e + 2];

        if(obj_x == OBJECT_NONE && obj_y == OBJECT_NONE && obj_type == OBJECT_NONE){
            move_sprite(8+e, 0, 160);
        } else {
            set_sprite_tile(8+e,obj_type);
            move_sprite(8+e, obj_x, obj_y);
        }
    }
}

void hide_object(uint8_t i){
    global_object_information[i*3] = OBJECT_NONE;
    global_object_information[(i*3)+1] = OBJECT_NONE;
    global_object_information[(i*3)+2] = OBJECT_NONE;
    move_sprite(8+i, 0, 160);
}

void update_objects_vaiven(void){
    const int8_t offsets[8] = {0, 0, 0, -1, 0, 0, 0, 0};
    int8_t offset;
    uint8_t obj_x;
    uint8_t obj_y;

    global_object_vaiven_frame++;
    offset = offsets[(global_object_vaiven_frame) & 7];

    for(uint8_t e = 0; e<NUMBER_OF_OBJECTS; e++){
        obj_x = global_object_information[3*e];
        obj_y = global_object_information[3*e + 1];

        if(obj_x == OBJECT_NONE && obj_y == OBJECT_NONE){
            continue;
        }

        move_sprite(8+e, obj_x, obj_y + offset);
    }
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

        if(obj_x==OBJECT_NONE && obj_y==OBJECT_NONE){
            if(obj_type == OBJECT_NONE){
                continue;
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
