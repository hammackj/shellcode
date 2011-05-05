CC=gcc
CFLAGS= -g -Wall
FILE= bind_tcp


all: ${FILE}

reverse: ${FILE}.c
	${CC} ${CFLAGS} ${FILE}.c -o ${FILE}

bind: bind_tcp.s
	/opt/local/bin/nasm -f macho64 bind_tcp.s -o bind_tcp.o
	ld -arch x86_64 bind_tcp.o -o bind_shell

tester: sc_tester.c
	${CC} sc_tester.c -o sc_tester

clean:
	rm -rf ${FILE}
	rm -rf *.dSYM/
	rm *.o bind_shell sc_tester bind_tcp

