CC        = gcc
CFLAGS    = -O2 -Wall -I/usr/local/include
LDFLAGS   = -L/usr/local/lib
LIBS      = 
OBJS      = $(patsubst %.c, %.o, $(wildcard *.c))
PROGRAM   = hello

.PHONY: all clean

all: $(PROGRAM)

$(PROGRAM): $(OBJS)
	$(CC) $^ $(LDFLAGS) $(LIBS) -o $@

clean:
	rm -f *.o $(PROGRAM)
