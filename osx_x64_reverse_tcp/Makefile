CC=gcc
CFLAGS= -g -Wall
FILE=reverse_tcp


all: ${FILE}

reverse: ${FILE}.c
	${CC} ${CFLAGS} ${FILE}.c -o ${FILE}

asm: reverse_tcp1.s
	/opt/local/bin/nasm -f macho64 reverse_tcp1.s -o reverse_tcp1.o
	ld -arch x86_64 reverse_tcp1.o -o reverse_shell

rev: reverse_tcp2.s
	/opt/local/bin/nasm -f macho64 reverse_tcp2.s -o reverse_tcp2.o
	ld -arch x86_64 reverse_tcp2.o -o reverse_shell2

rev3: reverse_tcp3.s
	/opt/local/bin/nasm -f macho64 reverse_tcp3.s -o reverse_tcp3.o
	ld -arch x86_64 reverse_tcp3.o -o reverse_shell3

shell: spawn_shell.s
	/opt/local/bin/nasm -f macho64 spawn_shell.s -o spawn_shell.o
	ld -arch x86_64 -macosx_version_min 10.6 spawn_shell.o -o spawn_shell

tester: sc_tester.c
	${CC} sc_tester.c -o sc_tester

clean:
	rm -rf ${FILE}
	rm -rf *.dSYM/
	rm *.o reverse_shell reverse_shell2 sc_tester reverse_shell3

