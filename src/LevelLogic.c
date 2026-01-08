#include "LevelLogic.h"
#include <stdio.h>
#include <gb/gb.h>
#include <gbdk/console.h>

void update_game_state(GameState new_value){
     global_game_state = new_value;
}
