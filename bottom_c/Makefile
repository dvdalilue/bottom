CC = gcc
OBJS = bottom.o list.o
DEPS = list.h
CFLAGS = -O3

%.o: %.c $(DEPS)
	$(CC) $(CFLAGS) -c $< -o $@

bottom: $(OBJS)
	$(CC) $(CFLAGS) $(OBJS) -o $@