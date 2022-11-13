	.intel_syntax noprefix
	.text
	
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
