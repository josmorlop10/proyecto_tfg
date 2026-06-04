#ifndef HUD_BUTTON_H
#define HUD_BUTTON_H

#include <stdint.h>
#include "LevelLogic.h"

#define BOT_RESET 0
#define BOT_GO    1

#define HUD_ITEM_RESET NUMBER_OF_BLOCKS
#define HUD_ITEM_GO    (NUMBER_OF_BLOCKS + 1)
#define HUD_ITEM_COUNT (NUMBER_OF_BLOCKS + 2)

#define BOT_RESET_TILE_BR          31 
#define BOT_RESET_SELECTED_TILE_BR 35
#define BOT_GO_TILE_BR             39
#define BOT_GO_SELECTED_TILE_BR    43

typedef struct {
    uint8_t x;
    uint8_t y;
    uint8_t type;
    uint8_t normal_tile_BR;
    uint8_t selected_tile_BR;
} HUD_button;

extern const HUD_button global_game_hud_buttons[2];

void draw_hud_button(const HUD_button* button, uint8_t selected);
void draw_game_hud_buttons(void);
void update_game_hud_button_selection(uint8_t previous, uint8_t current);
void press_game_hud_button(uint8_t selected_item);

#endif