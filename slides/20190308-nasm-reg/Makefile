all: asm_io.o test.o
	gcc -c driver.c -o driver.o
	gcc driver.o asm_io.o test.o -o test

asm_io.o: asm_io.asm asm_io.inc
	nasm -f elf -g -F stabs -d ELF_TYPE asm_io.asm -o asm_io.o

test.o: test.asm 
	nasm -f elf -g -F stabs test.asm -o test.o

clean:
	rm *~ *.o test