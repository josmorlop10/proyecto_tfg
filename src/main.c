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
#include "../res/HUD_running.h"
#include "../res/final_message.h"
#include "../res/pausa.h"
#include "../res/game_over_screen.h"
#include "../res/victory_screen.h"
#include "../res/selection_menu.h"

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

void draw_running_hud(void){
    set_win_tiles(0, 0, HUD_runningWidth, HUD_runningHeight, HUD_running);
    print_counter();
}

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
    global_actual_level = normalize_level_number(global_actual_level);
    set_bkg_data(0, 96, map_tiles_alt);
    set_bkg_tiles(0,0,20,15,global_levels_array[global_actual_level]);
    SHOW_BKG;

    //HUD
    // Activa la window
    set_win_data(96,68, hud_tiles);
    set_win_tiles(0,0,20,4, hud_selector);
    draw_game_hud_buttons();

    WX_REG = 7;      // SIEMPRE 7
    //WY_REG = 120;    // 144 - 24
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
            break;
        
        case STATE_SELECTION:
            if(last_state != STATE_SELECTION) {
                set_win_data(96,68, hud_tiles);
                init_win_screen(selection_menu, 7, 0, 20, 18, 0);
                last_state = STATE_SELECTION;
                performantdelay(30);
            }
            update_start_selection_menu();
            break;
        
        case STATE_GAME_SETTING:
            if(last_state != STATE_GAME_SETTING) {
                init_gfx();
                WY_REG = 120;
                pointer_init(&s);
                init_level(global_actual_level);
                print_objects_in_screen();
                last_state = STATE_GAME_SETTING;
            }
            update_pointer(&s);
            update_HUD();
            update_objects_vaiven();
            break;

        case STATE_GAME_RUNNING:
            if(last_state == STATE_GAME_SETTING) {
                draw_running_hud();
                character_init(&p);
            } else if(last_state == STATE_GAME_PAUSED) {
                WX_REG = 7;
                WY_REG = 120;
                draw_running_hud();
                move_character(&p);
                SHOW_SPRITES;
                waitpadup();
            }
            
            last_state = STATE_GAME_RUNNING;
            update_character(&p);
            update_objects_vaiven();
            if(joypad() & J_START){
                update_game_state(STATE_GAME_PAUSED);
            }
            
            break;
            
        case STATE_GAME_OVER:
            if(last_state != STATE_GAME_OVER) {
                last_state = STATE_GAME_OVER;
                global_option_selection_from_menu = 0;
                init_win_screen(game_over_screen, 7, 120, 20, 12, -72);
            }
            update_game_over_screen();
            break;

        case STATE_VICTORY:
            if(last_state != STATE_VICTORY) {
                last_state = STATE_VICTORY;
                global_option_selection_from_menu = 0;
                init_win_screen(victory_screen, 7, 120, 20, 12, -72);
            }
            update_victory_screen();
            break;
        
        case STATE_FINAL_MESSAGE:
            if(last_state != STATE_FINAL_MESSAGE) {
                last_state = STATE_FINAL_MESSAGE;
                init_win_screen(final_message, 0, 0, 20, 18, 0);
            }
            if(joypad() & (J_START | J_A)){
                global_actual_level = 0;
                update_game_state(STATE_MENU);
           }
           break;

        case STATE_GAME_PAUSED:
            if(last_state != STATE_GAME_PAUSED) {
                    last_state = STATE_GAME_PAUSED;
                    global_option_selection_from_menu = 0;
                    init_win_screen(pausa, 7, 120, 20, 12, -72);
                }
            update_pausa_screen();
            break;
        
        default:
            break;
        }
        performantdelay(10);
    }
}
