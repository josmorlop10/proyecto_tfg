#ifndef LEVEL_LOGIC_H
#define LEVEL_LOGIC_H

#include <stdint.h>

#define SOLID 1
#define OBJECT 2
#define SOURCE 3
#define DESTINATION 4
#define UMBRAL_COLISION_UP 3
#define UMBRAL_COLISION_DOWN 15

typedef enum {
    STATE_MENU,
    STATE_SELECTION,
    STATE_GAME_SETTING,
    STATE_GAME_RUNNING,
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

#endif
