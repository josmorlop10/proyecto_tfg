#include "LevelLogic.h"
#include <stdio.h>
#include <gb/gb.h>
#include <gbdk/console.h>

//variables globales
GameState global_game_state = STATE_GAME_SETTING;

void update_game_state(GameState new_value){
     global_game_state = new_value;
}
