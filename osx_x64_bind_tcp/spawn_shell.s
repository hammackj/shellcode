;nasm -f macho reverse_tcp.s -o reverse_tcp.o
;ld -o reverse_shell -e start reverse_tcp.o

BITS 64
    
section .text
global start

start:
	mov r8, '/bin/sh'
	push r8
	mov rdi, rsp

 	mov rax, 0x200003B ;59 AUE_EXECVE  ALL { int execve(char *fname, char **argp, char **envp); }
	xor rsi, rsi
	xor rdx, rdx
 	syscall

	mov r12, rax

	;Exit
	mov rax, 0x2000001
	mov rdi, r12
	syscall

