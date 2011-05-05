section .data
hello_world     db      "Hello World!", 0x0a
 
section .text
global start
 
start:

mov r13, 3

dup:

	;Write
	mov rax, 0x2000004      ; System call write = 4
	mov rdi, 1              ; Write to standard out = 1
	mov rsi, hello_world    ; The address of hello_world string
	mov rdx, 14             ; The size to write
	syscall

	cmp r13, 0
	dec r13

	jne dup

;Exit
mov rax, 0x2000001      ; System call number for exit = 1
mov rdi, 0              ; Exit success = 0
syscall                 ; Invoke the kernel
