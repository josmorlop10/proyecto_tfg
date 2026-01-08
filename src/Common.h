#ifndef COMMON_H
#define COMMON_H

#include <stdint.h>


//VALORES GLOBALES
#define SPRITESIZE 8
#define SOLID 1
#define OBJECT 2
#define SOURCE 3
#define DESTINATION 4
#define UMBRAL_COLISION 3

//global colision map : 20x18 = 360 tiles, cada posicion es un tile del mapa de fondo.
//cada incice indicara que tipo de bloque hay en ese tile y como gestionar la colision
extern uint8_t global_colision_map[360];

//global events: cada mapa puede tener hasta 10 tiles con eventos especiales
extern struct TileEvent global_events[10];

struct TileEvent {
    uint16_t tile_index;
    uint8_t (*on_trigger)(void);
};

void performantdelay(uint8_t numloops);
void get_colision_from_map(const unsigned char in[], uint8_t out[]);

#endif


