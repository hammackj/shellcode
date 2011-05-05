AC=/opt/local/bin/nasm
FILE=setuid_shell_x86_64


all: ${FILE}

setuid: ${FILE}.s
	${AC} -f macho64 ${FILE}.s -o ${FILE}.o
	ld -arch x86_64 ${FILE}.o -o setuid_shell

clean:
	rm -rf ${FILE}
	rm -rf *.dSYM/
	rm a.out

