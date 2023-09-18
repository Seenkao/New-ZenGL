	.text
	.file	"yuv420rgb8888.c"
	.globl	yuv420_2_rgb8888        // -- Begin function yuv420_2_rgb8888
	.p2align	2
	.type	yuv420_2_rgb8888,@function
yuv420_2_rgb8888:                       // @yuv420_2_rgb8888
// %bb.0:
	stp	x26, x25, [sp, #-64]!   // 16-byte Folded Spill
	ldr	x8, [sp, #72]
	stp	x20, x19, [sp, #48]     // 16-byte Folded Spill
	sub	w20, w5, #1             // =1
	cmp	w20, #1                 // =1
	lsl	w9, w4, #16
	stp	x24, x23, [sp, #16]     // 16-byte Folded Spill
	stp	x22, x21, [sp, #32]     // 16-byte Folded Spill
                                        // kill: def $w6 killed $w6 def $x6
	b.lt	.LBB0_21
// %bb.1:
	ldr	w19, [sp, #64]
	sub	w15, w7, w4, asr #1
	sxtw	x12, w6
	sbfiz	x14, x6, #1, #32
	asr	w7, w19, #2
	lsl	w6, w7, #1
	mov	w10, #256
	mov	w11, #2049
	mov	w13, #65536
	mov	w16, #196608
	mov	w17, #-65537
	sub	w6, w6, w4
	movk	w10, #16392, lsl #16
	movk	w11, #64, lsl #16
	sub	w13, w13, w9
	sub	x14, x14, w4, sxtw
	sxtw	x15, w15
	sub	w16, w16, w9
	add	w17, w9, w17
	add	x5, x12, #1             // =1
	sxtw	x4, w7
	sxtw	x6, w6
	sbfiz	x7, x7, #2, #32
	adds	w19, w13, w20
	b.pl	.LBB0_5
	b	.LBB0_6
.LBB0_2:
	lsr	w23, w20, #14
	and	w23, w23, #0xff00
	lsr	w21, w20, #11
	bfxil	w23, w20, #0, #8
	lsr	w20, w0, #14
	and	w20, w20, #0xff00
	bfxil	w20, w0, #0, #8
	lsr	w0, w0, #11
	bfi	w23, w21, #16, #8
	bfi	w20, w0, #16, #8
	orr	w0, w23, #0xff000000
	orr	w20, w20, #0xff000000
	str	w0, [x22, x4, lsl #2]
	add	x0, x22, #4             // =4
	str	w20, [x22]
	mov	x22, x0
.LBB0_3:
	sxth	w19, w19
	sub	w20, w19, #2            // =2
	add	x0, x22, x6, lsl #2
	add	x1, x1, x14
	add	x2, x2, x15
	cmp	w20, #0                 // =0
	add	x3, x3, x15
	b.le	.LBB0_21
// %bb.4:
	adds	w19, w13, w20
	b.mi	.LBB0_6
.LBB0_5:
	mov	x22, x0
	lsr	w0, w19, #16
	cbnz	w0, .LBB0_3
	b	.LBB0_17
.LBB0_6:
	sub	w21, w17, w20
	and	w21, w21, #0xfffe0000
	b	.LBB0_8
.LBB0_7:                                //   in Loop: Header=BB0_8 Depth=1
	lsr	w25, w23, #14
	and	w25, w25, #0xff00
	lsr	w24, w23, #11
	bfxil	w25, w23, #0, #8
	bfi	w25, w24, #16, #8
	lsr	w24, w22, #14
	and	w24, w24, #0xff00
	bfxil	w24, w22, #0, #8
	lsr	w22, w22, #11
	bfi	w24, w22, #16, #8
	add	x23, x0, x7
	add	x22, x0, #8             // =8
	orr	w25, w25, #0xff000000
	orr	w24, w24, #0xff000000
	adds	w19, w19, #32, lsl #12  // =131072
	str	w25, [x23, #4]
	str	w24, [x0, #4]
	mov	x0, x22
	b.pl	.LBB0_16
.LBB0_8:                                // =>This Inner Loop Header: Depth=1
	ldrb	w22, [x2], #1
	mov	w23, #1024
	add	x25, x1, x5
	mov	w24, #2048
	bfi	x23, x22, #2, #8
	ldr	w22, [x8, x23]
	ldrb	w23, [x3], #1
	ldurb	w25, [x25, #-1]
	bfi	x24, x23, #2, #8
	ldrb	w23, [x1]
	ldr	w24, [x8, x24]
	ldr	w25, [x8, x25, lsl #2]
	ldr	w23, [x8, x23, lsl #2]
	add	w22, w24, w22
	add	w24, w25, w22
	ands	w25, w24, w10
	add	w23, w23, w22
	b.eq	.LBB0_10
// %bb.9:                               //   in Loop: Header=BB0_8 Depth=1
	sub	w25, w25, w25, lsr #8
	orr	w24, w25, w24
	bic	w25, w11, w24, lsr #9
	add	w24, w25, w24
.LBB0_10:                               //   in Loop: Header=BB0_8 Depth=1
	ands	w25, w23, w10
	b.eq	.LBB0_12
// %bb.11:                              //   in Loop: Header=BB0_8 Depth=1
	sub	w25, w25, w25, lsr #8
	orr	w23, w25, w23
	bic	w25, w11, w23, lsr #9
	add	w23, w25, w23
.LBB0_12:                               //   in Loop: Header=BB0_8 Depth=1
	lsr	w26, w24, #14
	and	w26, w26, #0xff00
	lsr	w25, w24, #11
	bfxil	w26, w24, #0, #8
	lsr	w24, w23, #14
	and	w24, w24, #0xff00
	bfxil	w24, w23, #0, #8
	lsr	w23, w23, #11
	bfi	w26, w25, #16, #8
	bfi	w24, w23, #16, #8
	orr	w23, w26, #0xff000000
	orr	w24, w24, #0xff000000
	str	w23, [x0, x7]
	str	w24, [x0]
	ldrb	w23, [x1, x5]
	ldrb	w24, [x1, #1]
	ldr	w23, [x8, x23, lsl #2]
	ldr	w25, [x8, x24, lsl #2]
	add	w23, w23, w22
	ands	w24, w23, w10
	add	w22, w25, w22
	b.eq	.LBB0_14
// %bb.13:                              //   in Loop: Header=BB0_8 Depth=1
	sub	w24, w24, w24, lsr #8
	orr	w23, w24, w23
	bic	w24, w11, w23, lsr #9
	add	w23, w24, w23
.LBB0_14:                               //   in Loop: Header=BB0_8 Depth=1
	ands	w24, w22, w10
	add	x1, x1, #2              // =2
	b.eq	.LBB0_7
// %bb.15:                              //   in Loop: Header=BB0_8 Depth=1
	sub	w24, w24, w24, lsr #8
	orr	w22, w24, w22
	bic	w24, w11, w22, lsr #9
	add	w22, w24, w22
	b	.LBB0_7
.LBB0_16:
	add	w0, w16, w20
	add	w19, w0, w21
	lsr	w0, w19, #16
	cbnz	w0, .LBB0_3
.LBB0_17:
	ldrb	w0, [x2]
	ldrb	w21, [x3]
	mov	w20, #1024
	mov	w23, #2048
	bfi	x20, x0, #2, #8
	ldrb	w0, [x1, x12]
	bfi	x23, x21, #2, #8
	ldrb	w21, [x1]
	ldr	w20, [x8, x20]
	ldr	w23, [x8, x23]
	ldr	w0, [x8, x0, lsl #2]
	ldr	w24, [x8, x21, lsl #2]
	add	w20, w23, w20
	add	w0, w0, w20
	ands	w21, w0, w10
	add	w20, w24, w20
	b.eq	.LBB0_19
// %bb.18:
	sub	w21, w21, w21, lsr #8
	orr	w0, w21, w0
	bic	w21, w11, w0, lsr #9
	add	w0, w21, w0
.LBB0_19:
	ands	w21, w20, w10
	add	x1, x1, #1              // =1
	b.eq	.LBB0_2
// %bb.20:
	sub	w21, w21, w21, lsr #8
	orr	w20, w21, w20
	bic	w21, w11, w20, lsr #9
	add	w20, w21, w20
	b	.LBB0_2
.LBB0_21:
	cbnz	w20, .LBB0_34
// %bb.22:
	mov	w10, #65536
	subs	w10, w10, w9
	b.pl	.LBB0_30
// %bb.23:
	mov	w13, #-65537
	add	w13, w9, w13
	mov	w11, #256
	mov	w12, #2049
	and	w13, w13, #0xfffe0000
	movk	w11, #16392, lsl #16
	movk	w12, #64, lsl #16
	movi	d0, #0x0000ff000000ff
	movi	d1, #0x00ff000000ff00
	add	w13, w13, #48, lsl #12  // =196608
	movi	d2, #0xff000000ff0000
	b	.LBB0_25
.LBB0_24:                               //   in Loop: Header=BB0_25 Depth=1
	fmov	s3, w16
	mov	v3.s[1], w15
	ushr	v5.2s, v3.2s, #14
	and	v4.8b, v3.8b, v0.8b
	shl	v3.2s, v3.2s, #5
	and	v5.8b, v5.8b, v1.8b
	and	v3.8b, v3.8b, v2.8b
	orr	v4.8b, v4.8b, v5.8b
	orr	v3.8b, v4.8b, v3.8b
	orr	v3.2s, #255, lsl #24
	adds	w10, w10, #32, lsl #12  // =131072
	str	d3, [x0], #8
	add	x1, x14, #2             // =2
	b.pl	.LBB0_29
.LBB0_25:                               // =>This Inner Loop Header: Depth=1
	ldrb	w14, [x2], #1
	mov	w15, #1024
	mov	w17, #2048
	bfi	x15, x14, #2, #8
	ldr	w15, [x8, x15]
	ldrb	w16, [x3], #1
	mov	x14, x1
	ldrb	w1, [x1]
	bfi	x17, x16, #2, #8
	ldrb	w16, [x14, #1]
	ldr	w17, [x8, x17]
	ldr	w1, [x8, x1, lsl #2]
	ldr	w4, [x8, x16, lsl #2]
	add	w15, w17, w15
	add	w16, w1, w15
	ands	w17, w16, w11
	add	w15, w4, w15
	b.eq	.LBB0_27
// %bb.26:                              //   in Loop: Header=BB0_25 Depth=1
	sub	w17, w17, w17, lsr #8
	orr	w16, w17, w16
	bic	w17, w12, w16, lsr #9
	add	w16, w17, w16
.LBB0_27:                               //   in Loop: Header=BB0_25 Depth=1
	ands	w17, w15, w11
	b.eq	.LBB0_24
// %bb.28:                              //   in Loop: Header=BB0_25 Depth=1
	sub	w17, w17, w17, lsr #8
	orr	w15, w17, w15
	bic	w17, w12, w15, lsr #9
	add	w15, w17, w15
	b	.LBB0_24
.LBB0_29:
	add	x1, x14, #2             // =2
	sub	w10, w13, w9
.LBB0_30:
	lsr	w9, w10, #16
	cbnz	w9, .LBB0_34
// %bb.31:
	ldrb	w9, [x2]
	ldrb	w11, [x3]
	ldrb	w13, [x1]
	mov	w10, #1024
	mov	w12, #2048
	bfi	x10, x9, #2, #8
	bfi	x12, x11, #2, #8
	ldr	w9, [x8, x10]
	ldr	w10, [x8, x12]
	ldr	w8, [x8, x13, lsl #2]
	add	w9, w10, w9
	add	w8, w9, w8
	mov	w9, #256
	movk	w9, #16392, lsl #16
	ands	w9, w8, w9
	b.eq	.LBB0_33
// %bb.32:
	sub	w9, w9, w9, lsr #8
	orr	w8, w9, w8
	mov	w9, #2049
	movk	w9, #64, lsl #16
	bic	w9, w9, w8, lsr #9
	add	w8, w9, w8
.LBB0_33:
	lsr	w10, w8, #14
	and	w10, w10, #0xff00
	lsr	w9, w8, #11
	bfxil	w10, w8, #0, #8
	bfi	w10, w9, #16, #8
	orr	w8, w10, #0xff000000
	str	w8, [x0]
.LBB0_34:
	ldp	x20, x19, [sp, #48]     // 16-byte Folded Reload
	ldp	x22, x21, [sp, #32]     // 16-byte Folded Reload
	ldp	x24, x23, [sp, #16]     // 16-byte Folded Reload
	ldp	x26, x25, [sp], #64     // 16-byte Folded Reload
	ret
.Lfunc_end0:
	.size	yuv420_2_rgb8888, .Lfunc_end0-yuv420_2_rgb8888
                                        // -- End function

	.ident	"Android (5900059 based on r365631c) clang version 9.0.8 (https://android.googlesource.com/toolchain/llvm-project 207d7abc1a2abf3ef8d4301736d6a7ebc224a290) (based on LLVM 9.0.8svn)"
	.section	".note.GNU-stack","",@progbits
