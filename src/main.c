#include <gb/gb.h>
#include <stdint.h>
#include <stdio.h>
#include "../res/selector.h" 
#include "../res/duck.h"
#include "../res/block_pointer.h"

#include "../res/map_tiles_alt.h"
#include "../res/map1_alt.h"
#include "../res/map2.h"
#include"../res/map_test.h"

#include "../res/object_sprites.h"
#include "../res/hud_tiles.h"
#include "../res/hud_selector.h"

#include "Headers/Common.h"
#include "Headers/Character.h"
#include "Headers/LevelLogic.h"
#include "Headers/PointerSelector.h"
#include "Headers/Object.h"
#include "Headers/Graphic.h"
#include "Headers/HUD_button.h"

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

    //block hud pointer
    set_sprite_data(16,1,block_pointer);
    set_sprite_tile(16,16);

    //map
    set_bkg_data(0, 96, map_tiles_alt);
    set_bkg_tiles(0,0,20,15,global_levels_array[global_actual_level]);
    SHOW_BKG;

    //HUD
    // Activa la window
    set_win_data(96,68, hud_tiles);
    set_win_tiles(0,0,20,4, hud_selector);
    draw_game_hud_buttons();

    WX_REG = 7;      // SIEMPRE 7
    WY_REG = 120;    // 144 - 24
    SHOW_WIN;
    SHOW_SPRITES;

}

void main(void)
{   
    init_game_title();
    global_game_state = STATE_MENU;
    
    while(1) {
        switch (global_game_state)
        {

        case STATE_MENU:
            if(last_state != STATE_MENU) {
                init_game_title();
                last_state = STATE_MENU;
            }

            if(joypad() & J_START){
                update_game_state(STATE_SELECTION);
            }

            performantdelay(5);
            break;
        
        case STATE_SELECTION:
            if(last_state != STATE_SELECTION) {
                    init_start_selection_menu();
                    last_state = STATE_SELECTION;
            }

            update_start_selection_menu();
            break;
        
        case STATE_GAME_SETTING:
            if(last_state != STATE_GAME_SETTING) {
                init_gfx();
                pointer_init(&s);
                init_level(global_actual_level);
                get_colision_from_map(global_levels_array[global_actual_level], global_colision_map);

                print_objects_in_screen();
                last_state = STATE_GAME_SETTING;
            }
            update_pointer(&s);
            break;

        case STATE_GAME_RUNNING:
            if(last_state != STATE_GAME_RUNNING) {
                character_init(&p);
                last_state = STATE_GAME_RUNNING;
            }
            update_character(&p);
            break;
            
        case STATE_GAME_OVER:
            if(last_state != STATE_GAME_OVER) {
                last_state = STATE_GAME_OVER;
                init_game_over_screen();
            }
            update_game_over_screen();
            break;

        case STATE_VICTORY:
            if(last_state != STATE_VICTORY) {
                last_state = STATE_VICTORY;
                init_victory_screen();
            }
            update_victory_screen();
            break;

        default:
            break;
        }
        performantdelay(10);
    }
}
