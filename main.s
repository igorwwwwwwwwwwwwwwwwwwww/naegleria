	.arch armv8-a
	.file	"main.c"
	.text
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align	3
.LC0:
	.string	"stty -icanon"
	.text
	.align	2
	.global	main
	.type	main, %function
main:
.LFB11:
	.cfi_startproc
	stp	x29, x30, [sp, -16]!
	.cfi_def_cfa_offset 16
	.cfi_offset 29, -16
	.cfi_offset 30, -8
	mov	x29, sp
	adrp	x0, .LC0
	add	x0, x0, :lo12:.LC0
	bl	system
	adrp	x1, .LANCHOR0
	adrp	x0, tape+4
	add	x0, x0, :lo12:tape+4
	str	x0, [x1, #:lo12:.LANCHOR0]
	adrp	x0, tape+4
	ldr	w0, [x0, #:lo12:tape+4]
	bl	putchar
	mov	w0, 0
	ldp	x29, x30, [sp], 16
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE11:
	.size	main, .-main
	.global	i
	.global	tape
	.bss
	.align	3
	.set	.LANCHOR0,. + 0
	.type	i, %object
	.size	i, 8
i:
	.zero	8
	.type	tape, %object
	.size	tape, 20000
tape:
	.zero	20000
	.ident	"GCC: (GNU) 10.3.0"
	.section	.note.GNU-stack,"",@progbits
