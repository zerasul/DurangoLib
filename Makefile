BUILD_DIR=bin
SOURCE_DIR=src
INCLUDE_DIRS=inc

all: makelib

compile: $(BUILD_DIR)
	cc65 $(SOURCE_DIR)/durango.c -I $(INCLUDE_DIRS) -o bin/durango.s

assemble: compile
	ca65 $(BUILD_DIR)/durango.s -o $(BUILD_DIR)/durango.o
	
makelib: assemble
	ar65 r $(BUILD_DIR)/durango.lib $(BUILD_DIR)/durango.o

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)
clean:
	rm -Rf bin/

