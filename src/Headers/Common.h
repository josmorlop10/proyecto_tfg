#ifndef COMMON_H
#define COMMON_H

#include <stdint.h>

//VALORES GLOBALES
#define SPRITESIZE 8

void performantdelay(uint8_t numloops);
void change_bkg_tile_xy(uint16_t tile_index, uint8_t tile_id);
void change_bkg_tile_16x16(uint16_t tile_index, uint8_t tile_id_BR);
uint16_t tileindex_from_xy(uint8_t x, uint8_t y);

#endif


