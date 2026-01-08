#include <gb/gb.h>
#include <stdint.h>
#include <stdio.h>
#include "../res/selector.h" 
#include "../res/duck.h"
#include "../res/map1.h" 
#include "../res/map_tiles.h" 
#include "Common.h"
#include "Character.h"
#include "LevelLogic.h"

Character p;

GameState last_state;

void init_gfx(void){
    //player
    set_sprite_data(0, 5, duck);
    set_sprite_tile(0,0);
    set_sprite_tile(1,1);
    set_sprite_tile(2,2);
    set_sprite_tile(3,3);
    set_sprite_tile(4,4);

    SHOW_SPRITES;

    //map
    set_bkg_data(0, 28, map_tiles);
    set_bkg_tiles(0,0,20,18,map1);
    get_colision_from_map(map1, global_colision_map);
    SHOW_BKG;
}

void main(void)
{   
    init_gfx();

    while(1) {
        switch ( global_game_state)
        {
        case STATE_GAME_SETTING:
            if(last_state != STATE_GAME_SETTING) {
                last_state = STATE_GAME_SETTING;
            }

            if(joypad() & J_START){
                update_game_state(STATE_GAME_RUNNING);
            }
            break;

        case STATE_GAME_RUNNING:
            if(last_state != STATE_GAME_RUNNING) {
                character_init(&p);
                last_state = STATE_GAME_RUNNING;
            }
            update_character(&p);
            break;
            
        default:
            break;
        }
        performantdelay(10);

        //DEBUG
        if(joypad() & J_A){
            for(uint16_t i = 0; i<360; i++){
                printf("%d",global_colision_map[i]);
            }
        }
    }
}