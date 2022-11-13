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
	.cfi_def_cfa_register 6			# int ch;
	mov	r12, rdi			# char str[]
	mov	r14, rsi			# int *size
	mov	r13, rdx			# FILE *stream
	mov	rax, r14
	mov	DWORD PTR [rax], 0		# *size = 0;
.L2:						# do {

	mov	rax, r13
	mov	rdi, rax			# 	rdi - первый аргумент = stream
	call	fgetc@PLT			# 	ch = fgetc(stream);
	mov	r15d, eax			# 	функция отработала и вернула результат в eax и мы кладем его в ch
	
	mov	rax, r14			# 	str[(*size)++] = ch;
	mov	eax, DWORD PTR [rax]
	lea	ecx, 1[rax]
	mov	rdx, r14
	mov	DWORD PTR [rdx], ecx
	movsx	rdx, eax
	mov	rax, r12
	add	rax, rdx
	mov	edx, r15d
	mov	BYTE PTR [rax], dl
	
	cmp	r15d, -1
	jne	.L2				# } while(ch != -1);
	
	mov	rax, r14			# str[--(*size)] = '\0';
	mov	eax, DWORD PTR [rax]
	lea	edx, -1[rax]
	mov	rax, r14
	mov	DWORD PTR [rax], edx
	mov	rax, r14
	mov	eax, DWORD PTR [rax]
	movsx	rdx, eax
	mov	rax, r12
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
	mov	r12, rdi			# char str[]
	mov	r14d, esi			# int size
	mov	r13, rdx			# int numbers_count[]
	mov	r15d, 0				# int i;
	
	jmp	.L4				# for (i = 0; i < size; ++i) {
.L6:
	mov	eax, r15d			# 	if (str[i] >= '0' && str[i] <= '9') {
	movsx	rdx, eax
	mov	rax, r12
	add	rax, rdx
	movzx	eax, BYTE PTR [rax]
	cmp	al, 47
	jle	.L5
	mov	eax, r15d
	movsx	rdx, eax
	mov	rax, r12
	add	rax, rdx
	movzx	eax, BYTE PTR [rax]
	cmp	al, 57
	jg	.L5
	
	mov	eax, r15d			# 		++numbers_count[str[i] - '0'];
	movsx	rdx, eax
	mov	rax, r12
	add	rax, rdx
	movzx	eax, BYTE PTR [rax]
	movsx	rax, al
	sal	rax, 2
	lea	rdx, -192[rax]
	mov	rax, r13
	add	rax, rdx
	mov	edx, DWORD PTR [rax]
	add	edx, 1
	mov	DWORD PTR [rax], edx		# 	}
.L5:
	add	r15d, 1
.L4:
	mov	eax, r15d
	cmp	eax, r14d
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
	
	mov	rdx, QWORD PTR stdin[rip]	# rdx - третий аргумент = stdin
	lea	rcx, -10072[rbp]
	lea	rax, -10016[rbp]
	mov	rsi, rcx			# rsi - второй аргумент = &size
	mov	rdi, rax			# rdi - первый аргумент = str
	call	read				# read(str, &size, stdin);
	
	mov	ecx, DWORD PTR -10072[rbp]
	lea	rdx, -10064[rbp]		# rdx - третий аргумент = numbers_count
	lea	rax, -10016[rbp]
	mov	esi, ecx			# esi - второй аргумент = size
	mov	rdi, rax			# rdi - первый аргумент = str
	call	countNumbers			# countNumbers(str, size, numbers_count);
	
	mov	r15d, 0				# for (i = 0; i < 10; ++i) {
	jmp	.L8
.L9:
	mov	eax, r15d
	cdqe
	mov	edx, DWORD PTR -10064[rbp+rax*4]#	edx - третий аргумент = numbers_count[i]
	mov	eax, r15d
	mov	esi, eax			# 	esi - второй аргумент = i
	lea	rax, .LC0[rip]
	mov	rdi, rax			# 	rdi - первый аргумент = "Count of \"%d\": %d\n"
	mov	eax, 0
	call	printf@PLT			# 	printf("Count of \"%d\": %d\n", i, numbers_count[i]);
	
	add	r15d, 1
.L8:
	cmp	r15d, 9
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
