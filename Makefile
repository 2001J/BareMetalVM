flags=-O2 -std=c2x 
ldflags=-lbu
#ldflags=

.PHONY: all clean

all: baremetalvm

baremetalvm: baremetalvm.o
	cc $(flags) $< -o $@ $(ldflags)  

baremetalvm.o: baremetalvm.c baremetalvm.h
	cc $(flags) -c $<

clean:
	rm -f *.o baremetalvm