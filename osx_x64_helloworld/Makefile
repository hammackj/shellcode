AC=/opt/local/bin/nasm
AFLAGS= -f macho64
FILE=helloworld


helloworld: ${FILE}.s
	${AC} ${AFLAGS} ${FILE}.s -o ${FILE}.o
	ld -arch x86_64 ${FILE}.o -o ${FILE}

clean:
	rm -rf ${FILE}
	rm -rf *.dSYM/
	rm a.out

