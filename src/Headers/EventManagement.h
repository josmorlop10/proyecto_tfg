#ifndef EVENT_MANAGEMENT_H
#define EVENT_MANAGEMENT_H

#include <stdint.h>

uint8_t player_tileBR_over_a_block(uint16_t tileindexBR);
uint8_t player_tileBR_over_destination(uint16_t tileindexBR);
uint8_t player_over_fall(uint16_t tileindexBR);

#endif