BUILD_DIR=bin
SOURCE_DIR=src
INCLUDE_DIRS=inc
CFG_DIR=cfg
ASM_DIR=asm

COMPILE_OPTS = -c -I $(INCLUDE_DIRS) -Oir

all: $(BUILD_DIR)/durango.lib

$(BUILD_DIR)/durango.o: $(BUILD_DIR)/ $(SOURCE_DIR)/durango.c
	cl65 $(COMPILE_OPTS) -o $(BUILD_DIR)/durango.o $(SOURCE_DIR)/durango.c

$(BUILD_DIR)/video.o: $(BUILD_DIR)/ $(SOURCE_DIR)/video.c
	cl65 $(COMPILE_OPTS) -o $(BUILD_DIR)/video.o $(SOURCE_DIR)/video.c

$(BUILD_DIR)/vectors.o: $(ASM_DIR)/vectors.s
	ca65 $(ASM_DIR)/vectors.s -o $(BUILD_DIR)/vectors.o

$(BUILD_DIR)/durango.lib: $(BUILD_DIR)/durango.o $(BUILD_DIR)/video.o $(BUILD_DIR)/vectors.o
	ar65 r $(BUILD_DIR)/durango.lib $(BUILD_DIR)/durango.o $(BUILD_DIR)/video.o

$(BUILD_DIR)/:
	mkdir -p $(BUILD_DIR)

makeziplib: $(BUILD_DIR)/durango.lib
	zip durangoLib.zip $(BUILD_DIR)/durango.lib $(INCLUDE_DIRS)/durango.h $(CFG_DIR)/durango.cfg $() $(BUILD_DIR)/vectors.o $(INCLUDE_DIRS)/video.h

clean:
	rm -Rf bin/

