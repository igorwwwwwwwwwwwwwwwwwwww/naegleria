	.arch armv8-a
	.file	"main.c"
	.text
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align	3
.LC0:
	.string	"stty -icanon"
	.section	.text.startup,"ax",@progbits
	.align	2
	.p2align 4,,11
	.global	main
	.type	main, %function
main:
.LFB11:
	.cfi_startproc
	stp	x29, x30, [sp, -16]!
	.cfi_def_cfa_offset 16
	.cfi_offset 29, -16
	.cfi_offset 30, -8
	adrp	x0, .LC0
	add	x0, x0, :lo12:.LC0
	mov	x29, sp
	bl	system
	adrp	x2, .LANCHOR0
	mov	w0, 0
	ldp	x29, x30, [sp], 16
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa_offset 0
	ldr	w1, [x2, #:lo12:.LANCHOR0]
	add	w1, w1, 1
	str	w1, [x2, #:lo12:.LANCHOR0]
	ret
	.cfi_endproc
.LFE11:
	.size	main, .-main
	.global	i
	.global	tape
	.bss
	.align	4
	.set	.LANCHOR0,. + 0
	.type	i, %object
	.size	i, 4
i:
	.zero	4
	.zero	12
	.type	tape, %object
	.size	tape, 20000
tape:
	.zero	20000
	.ident	"GCC: (GNU) 10.3.0"
	.section	.note.GNU-stack,"",@progbits
