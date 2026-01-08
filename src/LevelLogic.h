#ifndef LEVEL_LOGIC_H
#define LEVEL_LOGIC_H

#include <stdint.h>

typedef enum {
    STATE_MENU,
    STATE_SELECTION,
    STATE_GAME_SETTING,
    STATE_GAME_RUNNING,
} GameState;

extern GameState global_game_state;

void update_game_state(GameState new_value);

#endif
