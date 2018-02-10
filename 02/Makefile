CC=gcc -g -Wall
program_NAME := Practical2

all: $(program_NAME)

$(program_NAME): Practical2.c
	$(CC) --std=c99 -o $(program_NAME) $(program_NAME).c -pthread 
clean:
	rm $(program_NAME)
check:
	valgrind --trace-children=yes --track-origins=yes --dsymutil=yes ./$(program_NAME)
