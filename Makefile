all: compile

compile: bin
	cc65 src/durango.c -I inc -o bin/durango.o
bin:
	mkdir -p bin
clean:
	rm -Rf bin/

