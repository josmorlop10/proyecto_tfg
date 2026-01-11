#ifndef POINTER_SELECTOR_H
#define POINTER_SELECTOR_H

#include <stdint.h>

typedef struct {
    uint8_t x, y;
    uint8_t sprite_ids[4];
    uint16_t tileindexBR;
} Pointer;

void pointer_init(Pointer* s);
void move_pointer(Pointer* s);
void control_pointer(Pointer* s);
void update_pointer(Pointer* s);
void hide_pointer(void);
void place_object_at_pointer(Pointer* s, uint8_t block_type);
void remove_object_at_pointer(Pointer* s, uint8_t block_type);
uint8_t block_is_placed_below(Pointer* s);
uint8_t block_is_not_placed_below(Pointer* s);
void print_counter(void);

#endif