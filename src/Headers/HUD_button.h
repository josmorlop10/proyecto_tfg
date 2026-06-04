#ifndef HUD_BUTTON_H
#define HUD_BUTTON_H

#include <stdint.h>

//BUTTON TYPES;
#define BOT_DELETE 0
#define BOT_GO 1

#define SELECTED 1
#define NOT_SELECTED 0

#define VISIBLE 1
#define NOT_VISIBLE 0

typedef struct {
    uint8_t x;
    uint8_t y;
    uint8_t type;
    void (*action)(void);
} HUD_button;

#endif