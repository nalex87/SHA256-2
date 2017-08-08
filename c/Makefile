CC = gcc
CFLAGS = -std=c99 -pedantic -Wall
OBJECTS = sha256.o

all: appname

sha256.o: sha256.c
	$(CC) $(CFLAGS) -c sha256.c

appname: $(OBJECTS)
	$(CC) $(OBJECTS) -o sha256

clean:
	rm -f *.o sha256