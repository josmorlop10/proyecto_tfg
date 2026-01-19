#ifndef COMMON_H
#define COMMON_H

#include <stdint.h>

//VALORES GLOBALES
#define SPRITESIZE 8

void performantdelay(uint8_t numloops);
uint16_t tileindex_from_xy(uint8_t x, uint8_t y);

#endif


