#include <gb/gb.h>
#include "Headers/HUD_button.h"
#include "Headers/LevelLogic.h"
#include "Headers/Graphic.h"
#include "Headers/PointerSelector.h"

const HUD_button global_game_hud_buttons[2] = {
    {16, 2, BOT_RESET, BOT_RESET_TILE_BR, BOT_RESET_SELECTED_TILE_BR},
    {18, 2, BOT_GO,    BOT_GO_TILE_BR,    BOT_GO_SELECTED_TILE_BR}
};

void draw_hud_button(const HUD_button* button, uint8_t selected) {
    uint16_t tileindexBR = (button->y * 20) + button->x;
    uint8_t tile_id_BR = selected ? button->selected_tile_BR : button->normal_tile_BR;

    change_win_tile_16x16(tileindexBR, tile_id_BR);
}

void draw_game_hud_buttons(void) {
    draw_hud_button(&global_game_hud_buttons[0], 0);
    draw_hud_button(&global_game_hud_buttons[1], 0);
}

void update_game_hud_button_selection(uint8_t previous, uint8_t current) {
    if(previous == HUD_ITEM_RESET) {
        draw_hud_button(&global_game_hud_buttons[0], 0);
    } else if(previous == HUD_ITEM_GO) {
        draw_hud_button(&global_game_hud_buttons[1], 0);
    }

    if(current == HUD_ITEM_RESET) {
        draw_hud_button(&global_game_hud_buttons[0], 1);
    } else if(current == HUD_ITEM_GO) {
        draw_hud_button(&global_game_hud_buttons[1], 1);
    }
}

void press_game_hud_button(uint8_t selected_item) {
    switch(selected_item) {
        case HUD_ITEM_RESET:
            init_gfx();
            WY_REG = 120;
            global_hud_selected = 0;
            global_selected_block = 0;
            init_level(global_actual_level);
            get_colision_from_map(global_levels_array[global_actual_level], global_colision_map);

            print_objects_in_screen();
            break;

        case HUD_ITEM_GO:
            hide_pointer();
            update_game_state(STATE_GAME_RUNNING);
            break;

        default:
            break;
    }
}