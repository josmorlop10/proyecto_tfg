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
void hide_pointer(Pointer* s);

#endif