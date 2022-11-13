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

	mov	rax, QWORD PTR -40[rbp]
	mov	rdi, rax			# 	rdi - первый аргумент = stream
	call	fgetc@PLT			# 	ch = fgetc(stream);
	mov	DWORD PTR -4[rbp], eax		# 	функция отработала и вернула результат в eax и мы кладем его в ch
	
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
