#include "video.h"

void setHighRes(){
    asm("LDA #$3F\
         STA $df80");
}

void setColor(){
    asm("LDA #$3F\
         STA $df80");
}