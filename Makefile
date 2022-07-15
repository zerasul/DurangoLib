BUILD_DIR=bin
SOURCE_DIR=src
INCLUDE_DIRS=inc

all: $(BUILD_DIR)/durango.lib

compile: $(BUILD_DIR)
	cc65 $(SOURCE_DIR)/durango.c -I $(INCLUDE_DIRS) -Oir -o $(BUILD_DIR)/durango.s

$(BUILD_DIR)/durango.o: compile
	ca65 $(BUILD_DIR)/durango.s -o $(BUILD_DIR)/durango.o
	
$(BUILD_DIR)/durango.lib: $(BUILD_DIR)/durango.o
	ar65 r $(BUILD_DIR)/durango.lib $(BUILD_DIR)/durango.o

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

makeziplib: $(BUILD_DIR)/durango.lib
	zip durangoLib.zip $(BUILD_DIR)/durango.lib $(INCLUDE_DIRS)/durango.h

clean:
	rm -Rf bin/

