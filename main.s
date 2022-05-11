	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 10, 15	sdk_version 10, 15, 6
	.intel_syntax noprefix
	.globl	_main                   ## -- Begin function main
	.p2align	4, 0x90
_main:                                  ## @main
	.cfi_startproc
## %bb.0:
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset rbp, -16
	mov	rbp, rsp
	.cfi_def_cfa_register rbp
	xor	eax, eax
	mov	dword ptr [rbp - 4], 0
	mov	ecx, dword ptr [rip + _i]
	add	ecx, 1
	mov	dword ptr [rip + _i], ecx
	pop	rbp
	ret
	.cfi_endproc
                                        ## -- End function
	.globl	_i                      ## @i
.zerofill __DATA,__common,_i,4,2
	.comm	_tape,20000,4           ## @tape

.subsections_via_symbols
