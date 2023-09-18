	.text
	.file	"yuv444rgb8888.c"
	.globl	yuv444_2_rgb8888        // -- Begin function yuv444_2_rgb8888
	.p2align	2
	.type	yuv444_2_rgb8888,@function
yuv444_2_rgb8888:                       // @yuv444_2_rgb8888
// %bb.0:
	str	x28, [sp, #-96]!        // 8-byte Folded Spill
	stp	x21, x20, [sp, #64]     // 16-byte Folded Spill
	sub	w21, w5, #1             // =1
	cmp	w21, #1                 // =1
	stp	x27, x26, [sp, #16]     // 16-byte Folded Spill
	stp	x25, x24, [sp, #32]     // 16-byte Folded Spill
	stp	x23, x22, [sp, #48]     // 16-byte Folded Spill
	stp	x19, x29, [sp, #80]     // 16-byte Folded Spill
                                        // kill: def $w7 killed $w7 def $x7
                                        // kill: def $w6 killed $w6 def $x6
                                        // kill: def $w4 killed $w4 def $x4
	b.lt	.LBB0_28
// %bb.1:
	ldr	w19, [sp, #96]
	ldr	x8, [sp, #104]
	mov	w9, #256
	mov	w10, #2049
	lsl	w20, w4, #16
	mov	w13, #65536
	sxtw	x22, w4
	sxtw	x11, w6
	sxtw	x12, w7
	mov	w16, #196608
	mov	w17, #-65537
	mov	w5, #196607
	sxtw	x19, w19
	movk	w9, #16392, lsl #16
	movk	w10, #64, lsl #16
	sub	w13, w13, w20
	sub	x14, x11, x22
	sub	x15, x12, x22
	sub	w16, w16, w20
	add	w17, w20, w17
	sub	w5, w5, w20
	sub	w6, w20, #16, lsl #12   // =65536
	neg	x7, x22
	sub	x4, x19, w4, sxtw #2
	mov	w19, #255
	adds	w20, w13, w21
	b.pl	.LBB0_5
	b	.LBB0_6
.LBB0_2:
	strb	w1, [x0]
	lsr	w22, w1, #22
	lsr	w1, w1, #11
	strb	w1, [x0, #2]
	add	x1, x0, #4              // =4
	strb	w22, [x0, #1]
	strb	w19, [x0, #3]
	mov	x0, x1
.LBB0_3:
	sxth	w20, w20
	add	x1, x21, x14
	sub	w21, w20, #1            // =1
	add	x0, x0, x4
	add	x2, x2, x15
	cmp	w21, #0                 // =0
	add	x3, x3, x15
	b.le	.LBB0_28
// %bb.4:
	adds	w20, w13, w21
	b.mi	.LBB0_6
.LBB0_5:
	lsr	w21, w20, #16
	cbz	w21, .LBB0_13
	b	.LBB0_16
.LBB0_6:
	sub	w22, w17, w21
	and	w22, w22, #0xfffe0000
	b	.LBB0_8
.LBB0_7:                                //   in Loop: Header=BB0_8 Depth=1
	strb	w2, [x0, #4]
	lsr	w1, w2, #22
	lsr	w2, w2, #11
	add	x26, x0, #8             // =8
	adds	w20, w20, #32, lsl #12  // =131072
	strb	w1, [x0, #5]
	strb	w2, [x0, #6]
	strb	w19, [x0, #7]
	mov	x0, x26
	mov	x1, x25
	mov	x2, x23
	mov	x3, x24
	b.pl	.LBB0_12
.LBB0_8:                                // =>This Inner Loop Header: Depth=1
	ldrb	w23, [x2]
	ldrb	w25, [x3]
	ldrb	w27, [x1]
	mov	w24, #1024
	mov	w26, #2048
	bfi	x24, x23, #2, #8
	bfi	x26, x25, #2, #8
	ldr	w23, [x8, x24]
	ldr	w24, [x8, x26]
	ldr	w25, [x8, x27, lsl #2]
	add	w23, w24, w23
	add	w23, w23, w25
	ands	w24, w23, w9
	b.eq	.LBB0_10
// %bb.9:                               //   in Loop: Header=BB0_8 Depth=1
	sub	w24, w24, w24, lsr #8
	orr	w23, w24, w23
	bic	w24, w10, w23, lsr #9
	add	w23, w24, w23
.LBB0_10:                               //   in Loop: Header=BB0_8 Depth=1
	strb	w23, [x0]
	lsr	w24, w23, #22
	lsr	w23, w23, #11
	strb	w19, [x0, #3]
	strb	w24, [x0, #1]
	strb	w23, [x0, #2]
	ldrb	w23, [x2, #1]
	ldrb	w25, [x3, #1]
	mov	w24, #1024
	mov	w26, #2048
	bfi	x24, x23, #2, #8
	ldrb	w23, [x1, #1]
	bfi	x26, x25, #2, #8
	ldr	w25, [x8, x24]
	ldr	w26, [x8, x26]
	ldr	w27, [x8, x23, lsl #2]
	add	x23, x2, #2             // =2
	add	x24, x3, #2             // =2
	add	w2, w26, w25
	add	w2, w2, w27
	ands	w3, w2, w9
	add	x25, x1, #2             // =2
	b.eq	.LBB0_7
// %bb.11:                              //   in Loop: Header=BB0_8 Depth=1
	sub	w1, w3, w3, lsr #8
	orr	w1, w1, w2
	bic	w2, w10, w1, lsr #9
	add	w2, w2, w1
	b	.LBB0_7
.LBB0_12:
	add	w0, w16, w21
	add	w20, w0, w22
	mov	x3, x24
	mov	x2, x23
	mov	x1, x25
	mov	x0, x26
	lsr	w21, w20, #16
	cbnz	w21, .LBB0_16
.LBB0_13:
	ldrb	w21, [x2], #1
	mov	w22, #1024
	mov	w23, #2048
	bfi	x22, x21, #2, #8
	ldr	w21, [x8, x22]
	ldrb	w22, [x3], #1
	bfi	x23, x22, #2, #8
	ldr	w22, [x8, x23]
	ldrb	w23, [x1], #1
	add	w21, w22, w21
	ldr	w23, [x8, x23, lsl #2]
	add	w21, w21, w23
	ands	w22, w21, w9
	b.eq	.LBB0_15
// %bb.14:
	sub	w22, w22, w22, lsr #8
	orr	w21, w22, w21
	bic	w22, w10, w21, lsr #9
	add	w21, w22, w21
.LBB0_15:
	strb	w21, [x0]
	lsr	w22, w21, #22
	lsr	w21, w21, #11
	strb	w21, [x0, #2]
	add	x21, x0, #4             // =4
	strb	w22, [x0, #1]
	strb	w19, [x0, #3]
	mov	x0, x21
.LBB0_16:
	sxth	w21, w20
	subs	w20, w21, #1            // =1
	b.eq	.LBB0_28
// %bb.17:
	adds	w20, w13, w20
	add	x0, x0, x4
	b.mi	.LBB0_19
// %bb.18:
	add	x3, x3, x15
	add	x2, x2, x15
	add	x21, x1, x14
	lsr	w1, w20, #16
	cbnz	w1, .LBB0_3
	b	.LBB0_26
.LBB0_19:
	sub	w23, w6, w21
	add	x22, x1, x11
	and	w1, w23, #0xfffe0000
	add	x2, x2, x12
	add	w23, w5, w1
	add	x1, x3, x12
	b	.LBB0_21
.LBB0_20:                               //   in Loop: Header=BB0_21 Depth=1
	strb	w3, [x0, #4]
	lsr	w25, w3, #22
	lsr	w3, w3, #11
	add	x24, x0, #8             // =8
	strb	w19, [x0, #7]
	adds	w20, w20, #32, lsl #12  // =131072
	add	x22, x22, #2            // =2
	add	x2, x2, #2              // =2
	strb	w25, [x0, #5]
	strb	w3, [x0, #6]
	add	x1, x1, #2              // =2
	mov	x0, x24
	b.pl	.LBB0_25
.LBB0_21:                               // =>This Inner Loop Header: Depth=1
	add	x25, x2, x7
	ldrb	w26, [x25]
	add	x24, x1, x7
	ldrb	w28, [x24]
	add	x3, x22, x7
	mov	w27, #1024
	bfi	x27, x26, #2, #8
	ldrb	w26, [x3]
	mov	w29, #2048
	bfi	x29, x28, #2, #8
	ldr	w27, [x8, x27]
	ldr	w28, [x8, x29]
	ldr	w26, [x8, x26, lsl #2]
	add	w27, w28, w27
	add	w26, w27, w26
	ands	w27, w26, w9
	b.eq	.LBB0_23
// %bb.22:                              //   in Loop: Header=BB0_21 Depth=1
	sub	w27, w27, w27, lsr #8
	orr	w26, w27, w26
	bic	w27, w10, w26, lsr #9
	add	w26, w27, w26
.LBB0_23:                               //   in Loop: Header=BB0_21 Depth=1
	strb	w26, [x0]
	lsr	w27, w26, #22
	lsr	w26, w26, #11
	strb	w19, [x0, #3]
	strb	w27, [x0, #1]
	strb	w26, [x0, #2]
	ldrb	w25, [x25, #1]
	ldrb	w24, [x24, #1]
	ldrb	w3, [x3, #1]
	mov	w27, #1024
	mov	w26, #2048
	bfi	x27, x25, #2, #8
	bfi	x26, x24, #2, #8
	ldr	w24, [x8, x27]
	ldr	w25, [x8, x26]
	ldr	w3, [x8, x3, lsl #2]
	add	w24, w25, w24
	add	w3, w24, w3
	ands	w24, w3, w9
	b.eq	.LBB0_20
// %bb.24:                              //   in Loop: Header=BB0_21 Depth=1
	sub	w24, w24, w24, lsr #8
	orr	w3, w24, w3
	bic	w24, w10, w3, lsr #9
	add	w3, w24, w3
	b	.LBB0_20
.LBB0_25:
	add	w20, w23, w21
	add	x21, x22, x7
	add	x2, x2, x7
	add	x3, x1, x7
	mov	x0, x24
	lsr	w1, w20, #16
	cbnz	w1, .LBB0_3
.LBB0_26:
	ldrb	w1, [x2], #1
	mov	w22, #1024
	mov	w23, #2048
	bfi	x22, x1, #2, #8
	ldr	w1, [x8, x22]
	ldrb	w22, [x3], #1
	bfi	x23, x22, #2, #8
	ldr	w22, [x8, x23]
	ldrb	w23, [x21], #1
	add	w1, w22, w1
	ldr	w23, [x8, x23, lsl #2]
	add	w1, w1, w23
	ands	w22, w1, w9
	b.eq	.LBB0_2
// %bb.27:
	sub	w22, w22, w22, lsr #8
	orr	w1, w22, w1
	bic	w22, w10, w1, lsr #9
	add	w1, w22, w1
	b	.LBB0_2
.LBB0_28:
	ldp	x19, x29, [sp, #80]     // 16-byte Folded Reload
	ldp	x21, x20, [sp, #64]     // 16-byte Folded Reload
	ldp	x23, x22, [sp, #48]     // 16-byte Folded Reload
	ldp	x25, x24, [sp, #32]     // 16-byte Folded Reload
	ldp	x27, x26, [sp, #16]     // 16-byte Folded Reload
	ldr	x28, [sp], #96          // 8-byte Folded Reload
	ret
.Lfunc_end0:
	.size	yuv444_2_rgb8888, .Lfunc_end0-yuv444_2_rgb8888
                                        // -- End function

	.ident	"Android (5900059 based on r365631c) clang version 9.0.8 (https://android.googlesource.com/toolchain/llvm-project 207d7abc1a2abf3ef8d4301736d6a7ebc224a290) (based on LLVM 9.0.8svn)"
	.section	".note.GNU-stack","",@progbits
