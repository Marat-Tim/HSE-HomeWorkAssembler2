	.file	"program.c"
	.intel_syntax noprefix
	.text
	
	.globl	read
	.type	read, @function
read:
.LFB0:
	.cfi_startproc
	endbr64
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 48				# int ch;
	mov	QWORD PTR -24[rbp], rdi		# char str[]
	mov	QWORD PTR -32[rbp], rsi		# int *size
	mov	QWORD PTR -40[rbp], rdx		# FILE *stream
	mov	rax, QWORD PTR -32[rbp]
	mov	DWORD PTR [rax], 0		# *size = 0;
.L2:						# do {
	mov	rax, QWORD PTR -40[rbp]		# 	ch = fgetc(stream);
	mov	rdi, rax
	call	fgetc@PLT
	mov	DWORD PTR -4[rbp], eax
	
	mov	rax, QWORD PTR -32[rbp]		# 	str[(*size)++] = ch;
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
	jne	.L2				# } while(ch != -1);
	
	mov	rax, QWORD PTR -32[rbp]		# str[--(*size)] = '\0';
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
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	read, .-read
	
	.globl	countNumbers
	.type	countNumbers, @function
countNumbers:
.LFB1:
	.cfi_startproc
	endbr64
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6			# Я не знаю, почему здесь не выделяется место на стеке
	mov	QWORD PTR -24[rbp], rdi		# char str[]
	mov	DWORD PTR -28[rbp], esi		# int size
	mov	QWORD PTR -40[rbp], rdx		# int numbers_count[]
	mov	DWORD PTR -4[rbp], 0		# int i;
	
	jmp	.L4				# for (i = 0; i < size; ++i) {
.L6:
	mov	eax, DWORD PTR -4[rbp]		# 	if (str[i] >= '0' && str[i] <= '9') {
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
	
	mov	eax, DWORD PTR -4[rbp]		# 		++numbers_count[str[i] - '0'];
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
	mov	DWORD PTR [rax], edx		# 	}
.L5:
	add	DWORD PTR -4[rbp], 1
.L4:
	mov	eax, DWORD PTR -4[rbp]
	cmp	eax, DWORD PTR -28[rbp]
	jl	.L6				# }
	
	nop
	nop
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1:
	.size	countNumbers, .-countNumbers
	.section	.rodata
.LC0:
	.string	"Count of \"%d\": %d\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB2:
	.cfi_startproc
	endbr64
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	
	sub	rsp, 4096			# char str[10000];
	or	QWORD PTR [rsp], 0		# int size, i;
	sub	rsp, 4096			# int numbers_count[10];
	or	QWORD PTR [rsp], 0
	sub	rsp, 1888
	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR -8[rbp], rax
	xor	eax, eax
	
	mov	rdx, QWORD PTR stdin[rip]	# read(str, &size, stdin);
	lea	rcx, -10072[rbp]
	lea	rax, -10016[rbp]
	mov	rsi, rcx
	mov	rdi, rax
	call	read
	
	mov	ecx, DWORD PTR -10072[rbp]	# countNumbers(str, size, numbers_count);
	lea	rdx, -10064[rbp]
	lea	rax, -10016[rbp]
	mov	esi, ecx
	mov	rdi, rax
	call	countNumbers
	
	mov	DWORD PTR -10068[rbp], 0	# for (i = 0; i < 10; ++i) {
	jmp	.L8
.L9:
	mov	eax, DWORD PTR -10068[rbp]	# 	printf("Count of \"%d\": %d\n", i, numbers_count[i]);
	cdqe
	mov	edx, DWORD PTR -10064[rbp+rax*4]
	mov	eax, DWORD PTR -10068[rbp]
	mov	esi, eax
	lea	rax, .LC0[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	
	add	DWORD PTR -10068[rbp], 1
.L8:
	cmp	DWORD PTR -10068[rbp], 9
	jle	.L9				# }
	mov	eax, 0
	mov	rdx, QWORD PTR -8[rbp]
	sub	rdx, QWORD PTR fs:40
	je	.L11
	call	__stack_chk_fail@PLT
.L11:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2:
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
