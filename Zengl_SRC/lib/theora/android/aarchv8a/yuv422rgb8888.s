	.text
	.file	"yuv422rgb8888.c"
	.globl	yuv422_2_rgb8888        // -- Begin function yuv422_2_rgb8888
	.p2align	2
	.type	yuv422_2_rgb8888,@function
yuv422_2_rgb8888:                       // @yuv422_2_rgb8888
// %bb.0:
	stp	x26, x25, [sp, #-64]!   // 16-byte Folded Spill
	stp	x20, x19, [sp, #48]     // 16-byte Folded Spill
	sub	w20, w5, #1             // =1
	cmp	w20, #1                 // =1
	stp	x24, x23, [sp, #16]     // 16-byte Folded Spill
	stp	x22, x21, [sp, #32]     // 16-byte Folded Spill
                                        // kill: def $w7 killed $w7 def $x7
                                        // kill: def $w6 killed $w6 def $x6
                                        // kill: def $w4 killed $w4 def $x4
	b.lt	.LBB0_28
// %bb.1:
	ldr	w19, [sp, #64]
	ldr	x8, [sp, #72]
	mov	w9, #256
	mov	w10, #2049
	lsl	w5, w4, #16
	mov	w12, #65536
	sxtw	x13, w6
	sxtw	x11, w7
	sbfx	x6, x4, #1, #31
	mov	w15, #196608
	mov	w16, #-65537
	mov	w17, #196607
	sxtw	x7, w19
	movk	w9, #16392, lsl #16
	movk	w10, #64, lsl #16
	sub	w12, w12, w5
	sub	x13, x13, w4, sxtw
	sub	x14, x11, x6
	sub	w15, w15, w5
	add	w16, w5, w16
	sub	w17, w17, w5
	sub	w5, w5, #16, lsl #12    // =65536
	neg	x6, x6
	sub	x4, x7, w4, sxtw #2
	mov	w7, #255
	adds	w19, w12, w20
	b.pl	.LBB0_5
	b	.LBB0_6
.LBB0_2:
	strb	w2, [x0]
	lsr	w21, w2, #22
	lsr	w2, w2, #11
	strb	w2, [x0, #2]
	add	x2, x0, #4              // =4
	strb	w21, [x0, #1]
	strb	w7, [x0, #3]
	mov	x0, x2
.LBB0_3:
	sxth	w19, w19
	add	x2, x20, x14
	sub	w20, w19, #1            // =1
	add	x0, x0, x4
	add	x1, x1, x13
	cmp	w20, #0                 // =0
	add	x3, x3, x14
	b.le	.LBB0_28
// %bb.4:
	adds	w19, w12, w20
	b.mi	.LBB0_6
.LBB0_5:
	lsr	w20, w19, #16
	cbz	w20, .LBB0_13
	b	.LBB0_16
.LBB0_6:
	sub	w21, w16, w20
	and	w21, w21, #0xfffe0000
	b	.LBB0_8
.LBB0_7:                                //   in Loop: Header=BB0_8 Depth=1
	strb	w23, [x0]
	lsr	w24, w23, #22
	lsr	w23, w23, #11
	strb	w1, [x0, #4]
	strb	w24, [x0, #1]
	lsr	w24, w1, #22
	lsr	w1, w1, #11
	strb	w23, [x0, #2]
	add	x23, x0, #8             // =8
	strb	w7, [x0, #3]
	strb	w7, [x0, #7]
	adds	w19, w19, #32, lsl #12  // =131072
	strb	w24, [x0, #5]
	strb	w1, [x0, #6]
	add	x1, x22, #2             // =2
	mov	x0, x23
	b.pl	.LBB0_12
.LBB0_8:                                // =>This Inner Loop Header: Depth=1
	ldrb	w22, [x2], #1
	mov	w23, #1024
	bfi	x23, x22, #2, #8
	ldr	w23, [x8, x23]
	ldrb	w24, [x3], #1
	mov	x22, x1
	mov	w1, #2048
	ldrb	w25, [x22]
	bfi	x1, x24, #2, #8
	ldrb	w24, [x22, #1]
	ldr	w1, [x8, x1]
	ldr	w25, [x8, x25, lsl #2]
	ldr	w26, [x8, x24, lsl #2]
	add	w1, w1, w23
	add	w23, w25, w1
	ands	w24, w23, w9
	add	w1, w26, w1
	b.eq	.LBB0_10
// %bb.9:                               //   in Loop: Header=BB0_8 Depth=1
	sub	w24, w24, w24, lsr #8
	orr	w23, w24, w23
	bic	w24, w10, w23, lsr #9
	add	w23, w24, w23
.LBB0_10:                               //   in Loop: Header=BB0_8 Depth=1
	ands	w24, w1, w9
	b.eq	.LBB0_7
// %bb.11:                              //   in Loop: Header=BB0_8 Depth=1
	sub	w24, w24, w24, lsr #8
	orr	w1, w24, w1
	bic	w24, w10, w1, lsr #9
	add	w1, w24, w1
	b	.LBB0_7
.LBB0_12:
	add	w0, w15, w20
	add	x1, x22, #2             // =2
	add	w19, w0, w21
	mov	x0, x23
	lsr	w20, w19, #16
	cbnz	w20, .LBB0_16
.LBB0_13:
	ldrb	w20, [x2]
	ldrb	w21, [x3]
	mov	w22, #1024
	mov	w23, #2048
	bfi	x22, x20, #2, #8
	bfi	x23, x21, #2, #8
	ldr	w20, [x8, x22]
	ldr	w21, [x8, x23]
	ldrb	w22, [x1], #1
	add	w20, w21, w20
	ldr	w22, [x8, x22, lsl #2]
	add	w20, w20, w22
	ands	w21, w20, w9
	b.eq	.LBB0_15
// %bb.14:
	sub	w21, w21, w21, lsr #8
	orr	w20, w21, w20
	bic	w21, w10, w20, lsr #9
	add	w20, w21, w20
.LBB0_15:
	strb	w20, [x0]
	lsr	w21, w20, #22
	lsr	w20, w20, #11
	strb	w20, [x0, #2]
	add	x20, x0, #4             // =4
	strb	w21, [x0, #1]
	strb	w7, [x0, #3]
	mov	x0, x20
.LBB0_16:
	sxth	w20, w19
	subs	w19, w20, #1            // =1
	b.eq	.LBB0_28
// %bb.17:
	add	x1, x1, x13
	adds	w19, w12, w19
	add	x0, x0, x4
	b.mi	.LBB0_19
// %bb.18:
	add	x3, x3, x14
	add	x20, x2, x14
	lsr	w2, w19, #16
	cbnz	w2, .LBB0_3
	b	.LBB0_26
.LBB0_19:
	sub	w22, w5, w20
	add	x21, x2, x6
	and	w2, w22, #0xfffe0000
	add	w22, w17, w2
	add	x2, x3, x6
	b	.LBB0_21
.LBB0_20:                               //   in Loop: Header=BB0_21 Depth=1
	strb	w23, [x0]
	lsr	w24, w23, #22
	lsr	w23, w23, #11
	strb	w1, [x0, #4]
	strb	w24, [x0, #1]
	lsr	w24, w1, #22
	lsr	w1, w1, #11
	strb	w23, [x0, #2]
	add	x23, x0, #8             // =8
	strb	w7, [x0, #3]
	strb	w7, [x0, #7]
	adds	w19, w19, #32, lsl #12  // =131072
	add	x21, x21, #1            // =1
	add	x2, x2, #1              // =1
	strb	w24, [x0, #5]
	strb	w1, [x0, #6]
	add	x1, x3, #2              // =2
	mov	x0, x23
	b.pl	.LBB0_25
.LBB0_21:                               // =>This Inner Loop Header: Depth=1
	mov	x3, x1
	ldrb	w1, [x21, x11]
	ldrb	w24, [x2, x11]
	mov	w23, #1024
	mov	w25, #2048
	bfi	x23, x1, #2, #8
	ldrb	w1, [x3]
	bfi	x25, x24, #2, #8
	ldrb	w24, [x3, #1]
	ldr	w23, [x8, x23]
	ldr	w25, [x8, x25]
	ldr	w1, [x8, x1, lsl #2]
	ldr	w26, [x8, x24, lsl #2]
	add	w25, w25, w23
	add	w23, w1, w25
	ands	w24, w23, w9
	add	w1, w26, w25
	b.eq	.LBB0_23
// %bb.22:                              //   in Loop: Header=BB0_21 Depth=1
	sub	w24, w24, w24, lsr #8
	orr	w23, w24, w23
	bic	w24, w10, w23, lsr #9
	add	w23, w24, w23
.LBB0_23:                               //   in Loop: Header=BB0_21 Depth=1
	ands	w24, w1, w9
	b.eq	.LBB0_20
// %bb.24:                              //   in Loop: Header=BB0_21 Depth=1
	sub	w24, w24, w24, lsr #8
	orr	w1, w24, w1
	bic	w24, w10, w1, lsr #9
	add	w1, w24, w1
	b	.LBB0_20
.LBB0_25:
	add	x1, x3, #2              // =2
	add	w19, w22, w20
	add	x20, x21, x11
	add	x3, x2, x11
	mov	x0, x23
	lsr	w2, w19, #16
	cbnz	w2, .LBB0_3
.LBB0_26:
	ldrb	w2, [x20]
	ldrb	w21, [x3]
	mov	w22, #1024
	mov	w23, #2048
	bfi	x22, x2, #2, #8
	bfi	x23, x21, #2, #8
	ldr	w2, [x8, x22]
	ldr	w21, [x8, x23]
	ldrb	w22, [x1], #1
	add	w2, w21, w2
	ldr	w22, [x8, x22, lsl #2]
	add	w2, w2, w22
	ands	w21, w2, w9
	b.eq	.LBB0_2
// %bb.27:
	sub	w21, w21, w21, lsr #8
	orr	w2, w21, w2
	bic	w21, w10, w2, lsr #9
	add	w2, w21, w2
	b	.LBB0_2
.LBB0_28:
	ldp	x20, x19, [sp, #48]     // 16-byte Folded Reload
	ldp	x22, x21, [sp, #32]     // 16-byte Folded Reload
	ldp	x24, x23, [sp, #16]     // 16-byte Folded Reload
	ldp	x26, x25, [sp], #64     // 16-byte Folded Reload
	ret
.Lfunc_end0:
	.size	yuv422_2_rgb8888, .Lfunc_end0-yuv422_2_rgb8888
                                        // -- End function

	.ident	"Android (5900059 based on r365631c) clang version 9.0.8 (https://android.googlesource.com/toolchain/llvm-project 207d7abc1a2abf3ef8d4301736d6a7ebc224a290) (based on LLVM 9.0.8svn)"
	.section	".note.GNU-stack","",@progbits
