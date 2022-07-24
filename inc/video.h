#ifndef _H_VIDEO
#define _H_VIDEO

#define HIRES 0X80
#define INVERT 0X40
#define SCREEN_0 0x00
#define SCREEN_1 0x10
#define SCREEN_2 0x20
#define SCREEN_3 0x30
#define RGB 0x08
#define LED 0x04

#define VIDEO_MEM (unsigned int*)0xdf80

void setVideoMode(int mode);

#endif