
#include "durango.h"

void initVideo(int mode){

    switch (mode)
    {
    case HIGH_RES:
        setHighRes();
        break;
    case COLOR:
        setColor();
        break;
   
    }
}