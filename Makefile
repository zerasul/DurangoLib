BUILD_DIR=bin
SOURCE_DIR=src
INCLUDE_DIRS=inc
CFG_DIR=cfg
ASM_DIR=asm

COMPILE_OPTS = -c -I $(INCLUDE_DIRS) -Oir

all: $(BUILD_DIR)/durango.lib



$(BUILD_DIR)/video.o: $(BUILD_DIR)/ $(SOURCE_DIR)/video.c
	cl65 $(COMPILE_OPTS) -o $(BUILD_DIR)/video.o $(SOURCE_DIR)/video.c

$(BUILD_DIR)/dlib.o: $(ASM_DIR)/dlib.s
	ca65 -t none $(ASM_DIR)/dlib.s -o $(BUILD_DIR)/dlib.o

$(BUILD_DIR)/vectors.o: $(ASM_DIR)/vectors.s
	ca65 -t none $(ASM_DIR)/vectors.s -o $(BUILD_DIR)/vectors.o

$(BUILD_DIR)/crt0.o: $(ASM_DIR)/crt0.s
	ca65 -t none $(ASM_DIR)/crt0.s -o $(BUILD_DIR)/crt0.o

$(BUILD_DIR)/interrupt.o: $(ASM_DIR)/interrupt.s
	ca65 -t none $(ASM_DIR)/interrupt.s -o $(BUILD_DIR)/interrupt.o

$(BUILD_DIR)/wait.o: $(ASM_DIR)/wait.s
	ca65 -t none $(ASM_DIR)/wait.s -o $(BUILD_DIR)/wait.o

$(BUILD_DIR)/durango.lib: $(BUILD_DIR)/ $(BUILD_DIR)/dlib.o $(BUILD_DIR)/sbc.lib $(BUILD_DIR)/interrupt.o $(BUILD_DIR)/vectors.o $(BUILD_DIR)/wait.o
	ar65 r $(BUILD_DIR)/durango.lib $(BUILD_DIR)/dlib.o $(BUILD_DIR)/interrupt.o $(BUILD_DIR)/wait.o

$(BUILD_DIR)/sbc.lib: $(BUILD_DIR)/crt0.o
	cp /usr/share/cc65/lib/supervision.lib $(BUILD_DIR)/sbc.lib && ar65 a $(BUILD_DIR)/sbc.lib $(BUILD_DIR)/crt0.o

$(BUILD_DIR)/:
	mkdir -p $(BUILD_DIR)

makeziplib: $(BUILD_DIR)/durango.lib
	zip durangoLib.zip $(BUILD_DIR)/durango.lib $(BUILD_DIR)/sbc.lib $(INCLUDE_DIRS)/durango.h $(CFG_DIR)/durango.cfg $(CFG_DIR)/durango16k.cfg $(BUILD_DIR)/vectors.o $(INCLUDE_DIRS)/video.h

clean:
	rm -Rf bin/ durangoLib.zip

