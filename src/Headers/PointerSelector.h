#ifndef POINTER_SELECTOR_H
#define POINTER_SELECTOR_H

#include <stdint.h>

typedef struct {
    uint8_t x, y;
    uint8_t sprite_ids[4];
    uint16_t tileindexBR;
} Pointer;

uint16_t calculate_pointer_tileindexBR(Pointer* s);
void pointer_init(Pointer* s);
void move_pointer(Pointer* s);
void control_pointer(Pointer* s);
void update_pointer(Pointer* s);
void hide_pointer(void);
void place_object_at_pointer(Pointer* s);
void remove_object_at_pointer(Pointer* s);

#endif