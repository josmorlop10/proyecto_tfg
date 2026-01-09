#ifndef LEVEL_LOGIC_H
#define LEVEL_LOGIC_H

#include <stdint.h>

//COLISION VALUES
#define EMPTY 0 //no colision
#define SOLID 1 //colision
#define OBJECT 2 //valor nulo para objetos (objetos te encuentras, bloques los pones)
#define SOURCE 3 //punto de inicio
#define DESTINATION 4 //punto de llegada
#define BLOCK  5 //valor nulo para bloques (objetos te encuentras, bloques los pones)
#define RIGHT 6
#define LEFT 7
#define UP 8
#define DOWN 9

#define UMBRAL_COLISION_UP 3
#define UMBRAL_COLISION_DOWN 15

//Global variable for block selected.Indicará la cantidad de bloques disponibles.
//Siendo index 1 = DER, 2= IZQ, 3=ARRIBA, 4=ABAJO (+6 por los "define" de arriba)
extern uint8_t global_blocks_available[4];
//indica el indice del array
extern uint8_t global_selected_block;

typedef enum {
    STATE_MENU,
    STATE_SELECTION,
    STATE_GAME_SETTING,
    STATE_GAME_RUNNING,
    STATE_GAME_PAUSED,
    STATE_GAME_OVER
} GameState;

struct TileEvent {
    uint16_t tile_index;
    uint8_t (*on_trigger)(void);
};

//global colision map : 20x18 = 360 tiles, cada posicion es un tile del mapa de fondo.
//cada incice indicara que tipo de bloque hay en ese tile y como gestionar la colision
extern struct TileEvent global_events[10];
extern uint8_t global_colision_map[360];
extern GameState global_game_state;
extern uint16_t global_init_point;

void update_game_state(GameState new_value);
void get_colision_from_map(const unsigned char in[], uint8_t out[]);
void get_init_point_from_map(uint8_t colision_map[360]);
void change_colision_map_at(uint16_t tileindexBR, uint8_t new_value);
void change_colision_map_BR(uint16_t tileindexBR, uint8_t new_value);
void move_foward_block_id(void);


#endif
