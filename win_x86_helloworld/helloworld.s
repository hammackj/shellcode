section .data
hello_world     db      "Hello World!", 0x0a
 
section .text
global start
 
start:

mov r8b, 0x02          ; Unix class system calls = 2
shl r8, 24             ; shift left 24 to the upper order bits
or r8, 0x04            ; setuid = 23, or with class = 0x2000017
mov rax, r8


;Write
;mov rax, 0x2000004      ; System call write = 4
mov rdi, 1              ; Write to standard out = 1
mov rsi, hello_world    ; The address of hello_world string
mov rdx, 14             ; The size to write
syscall                 ; Invoke the kernel

sub r8, 0x03

mov rax, r8

;Exit
;mov rax, 0x2000001      ; System call number for exit = 1
mov rdi, 1              ; Exit success = 0
syscall                 ; Invoke the kernel
