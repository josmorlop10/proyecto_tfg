#ifndef POINTER_SELECTOR_H
#define POINTER_SELECTOR_H

#include <stdint.h>

typedef struct {
    uint8_t x, y;
    uint8_t sprite_ids[4];
} Pointer;

void pointer_init(Pointer* s);
void move_pointer(Pointer* s);
void control_pointer(Pointer* s);
void update_pointer(Pointer* s);
void hide_pointer(void);
void place_object_at_pointer(uint8_t x, uint8_t y);
void remove_object_at_pointer(uint8_t x, uint8_t y);

#endif