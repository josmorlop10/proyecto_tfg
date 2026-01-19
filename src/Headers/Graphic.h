#ifndef GRAPHIC_H
#define GRAPHIC_H

#include <stdint.h>

void change_bkg_tile_xy(uint16_t tile_index, uint8_t tile_id);
void change_bkg_tile_16x16(uint16_t tile_index, uint8_t tile_id_BR);
void update_values_in_hud(uint8_t position, uint8_t new_value);

#endif