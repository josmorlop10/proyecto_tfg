#include <gb/gb.h>
#include <stdint.h>
#include <stdio.h>
#include "../res/selector.h" 
#include "../res/duck.h"
#include "../res/map1.h" 
#include "../res/map_tiles.h" 

#include "../res/map_tiles_alt.h"
#include "../res/map1_alt.h"

#include "../res/object_sprites.h"
#include "../res/hud_tiles.h"
#include "../res/hud_selector.h"
#include "Headers/Common.h"
#include "Headers/Character.h"
#include "Headers/LevelLogic.h"
#include "Headers/PointerSelector.h"
#include "Headers/Object.h"

Character p;
Pointer s;
GameState last_state;

void init_gfx(void){
    //player
    set_sprite_data(0, 4, duck);
    set_sprite_tile(0,0);
    set_sprite_tile(1,1);
    set_sprite_tile(2,2);
    set_sprite_tile(3,3);

    //pointer
    set_sprite_data(4, 4, selector);
    set_sprite_tile(4,4);
    set_sprite_tile(5,5);
    set_sprite_tile(6,6);
    set_sprite_tile(7,7);

    //objects
    set_sprite_data(8,8,object_sprites);
    set_sprite_tile(8,8);
    set_sprite_tile(9,9);
    set_sprite_tile(10,10);
    set_sprite_tile(11,11);
    set_sprite_tile(12,12);
    set_sprite_tile(13,13);
    set_sprite_tile(14,14);
    set_sprite_tile(15,15);
    SHOW_SPRITES;

    //map
    set_bkg_data(0, 104, map_tiles_alt);
    set_bkg_tiles(0,0,20,16,map1_alt);
    SHOW_BKG;

    //HUD
    // Activa la window
    set_win_data(104,22, hud_tiles);
    set_win_tiles(0,0,20,3, hud_selector);
    SHOW_WIN;
    WX_REG = 7;      // SIEMPRE 7
    WY_REG = 120;    // 144 - 24
}

void main(void)
{   
    init_gfx();
    pointer_init(&s);

    global_game_state = STATE_GAME_SETTING;
    
    while(1) {
        switch (global_game_state)
        {
        case STATE_GAME_SETTING:
            if(last_state != STATE_GAME_SETTING) {
                init_gfx();
                init_level(0);
                get_colision_from_map(map1, global_colision_map);

                print_objects_in_screen();
                last_state = STATE_GAME_SETTING;
            }
            update_pointer(&s);
            if(joypad() & J_START){
                hide_pointer();
                update_game_state(STATE_GAME_RUNNING);
            }
            break;

        case STATE_GAME_RUNNING:
            if(last_state != STATE_GAME_RUNNING) {
                character_init(&p);
                last_state = STATE_GAME_RUNNING;
            }
            update_character(&p);
            
            //DEBUG
            if(joypad() & J_A){
                for(uint16_t i = 0; i<360; i++){
                    printf("%d",global_colision_map[i]);
                }
            }

           
            break;
        
        case STATE_GAME_OVER:
            if(last_state != STATE_GAME_OVER) {
                last_state = STATE_GAME_OVER;
                printf("You WIN!\nPress start to try again");
            }
            if(joypad() & J_START){
                update_game_state(STATE_GAME_SETTING);
            }
            break;

        default:
            break;
        }
        performantdelay(10);
    }
}