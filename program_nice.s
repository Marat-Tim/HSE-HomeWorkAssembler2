	.file	"program.c"
	.intel_syntax noprefix
	.text
	
	.globl	read
	.type	read, @function
read:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 48
	mov	QWORD PTR -24[rbp], rdi
	mov	QWORD PTR -32[rbp], rsi
	mov	QWORD PTR -40[rbp], rdx
	mov	rax, QWORD PTR -32[rbp]
	mov	DWORD PTR [rax], 0
.L2:
	mov	rax, QWORD PTR -40[rbp]
	mov	rdi, rax
	call	fgetc@PLT
	mov	DWORD PTR -4[rbp], eax
	mov	rax, QWORD PTR -32[rbp]
	mov	eax, DWORD PTR [rax]
	lea	ecx, 1[rax]
	mov	rdx, QWORD PTR -32[rbp]
	mov	DWORD PTR [rdx], ecx
	movsx	rdx, eax
	mov	rax, QWORD PTR -24[rbp]
	add	rax, rdx
	mov	edx, DWORD PTR -4[rbp]
	mov	BYTE PTR [rax], dl
	cmp	DWORD PTR -4[rbp], -1
	jne	.L2
	mov	rax, QWORD PTR -32[rbp]
	mov	eax, DWORD PTR [rax]
	lea	edx, -1[rax]
	mov	rax, QWORD PTR -32[rbp]
	mov	DWORD PTR [rax], edx
	mov	rax, QWORD PTR -32[rbp]
	mov	eax, DWORD PTR [rax]
	movsx	rdx, eax
	mov	rax, QWORD PTR -24[rbp]
	add	rax, rdx
	mov	BYTE PTR [rax], 0
	nop
	leave
	ret
	.size	read, .-read
	
	.globl	countNumbers
	.type	countNumbers, @function
countNumbers:
	endbr64
	push	rbp
	mov	rbp, rsp
	mov	QWORD PTR -24[rbp], rdi
	mov	DWORD PTR -28[rbp], esi
	mov	QWORD PTR -40[rbp], rdx
	mov	DWORD PTR -4[rbp], 0
	jmp	.L4
.L6:
	mov	eax, DWORD PTR -4[rbp]
	movsx	rdx, eax
	mov	rax, QWORD PTR -24[rbp]
	add	rax, rdx
	movzx	eax, BYTE PTR [rax]
	cmp	al, 47
	jle	.L5
	mov	eax, DWORD PTR -4[rbp]
	movsx	rdx, eax
	mov	rax, QWORD PTR -24[rbp]
	add	rax, rdx
	movzx	eax, BYTE PTR [rax]
	cmp	al, 57
	jg	.L5
	mov	eax, DWORD PTR -4[rbp]
	movsx	rdx, eax
	mov	rax, QWORD PTR -24[rbp]
	add	rax, rdx
	movzx	eax, BYTE PTR [rax]
	movsx	rax, al
	sal	rax, 2
	lea	rdx, -192[rax]
	mov	rax, QWORD PTR -40[rbp]
	add	rax, rdx
	mov	edx, DWORD PTR [rax]
	add	edx, 1
	mov	DWORD PTR [rax], edx
.L5:
	add	DWORD PTR -4[rbp], 1
.L4:
	mov	eax, DWORD PTR -4[rbp]
	cmp	eax, DWORD PTR -28[rbp]
	jl	.L6
	nop
	nop
	pop	rbp
	ret
	.size	countNumbers, .-countNumbers
	
	.section	.rodata
.LC0:
	.string	"Count of \"%d\": %d\n"
	.text
	
	.globl	main
	.type	main, @function
main:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 10064
	
	mov	rdx, QWORD PTR stdin[rip]
	lea	rsi, -10020[rbp]
	lea	rdi, -10016[rbp]
	call	read
	
	mov	esi, DWORD PTR -10020[rbp]
	lea	rdx, -10064[rbp]
	lea	rdi, -10016[rbp]
	call	countNumbers
	
	mov	DWORD PTR -4[rbp], 0
	jmp	.L8
.L9:
	mov	eax, DWORD PTR -4[rbp]
	cdqe
	mov	edx, DWORD PTR -10064[rbp+rax*4]
	mov	esi, DWORD PTR -4[rbp]
	lea	rdi, .LC0[rip]
	mov	eax, 0
	call	printf@PLT
	
	add	DWORD PTR -4[rbp], 1
.L8:
	cmp	DWORD PTR -4[rbp], 9
	jle	.L9
	mov	eax, 0
	leave
	ret
	
	.size	main, .-main
	.ident	"GCC: (Ubuntu 11.2.0-19ubuntu1) 11.2.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
