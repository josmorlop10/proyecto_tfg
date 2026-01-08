#include "Common.h"
#include <stdio.h>
#include <gb/gb.h>

void performantdelay(uint8_t numloops){
    uint8_t i;
    for(i = 0; i < numloops; i++){
        wait_vbl_done();
    }     
}
