	.text
	.syntax unified
	.eabi_attribute	67, "2.09"	@ Tag_conformance
	.eabi_attribute	6, 10	@ Tag_CPU_arch
	.eabi_attribute	7, 65	@ Tag_CPU_arch_profile
	.eabi_attribute	8, 1	@ Tag_ARM_ISA_use
	.eabi_attribute	9, 2	@ Tag_THUMB_ISA_use
	.fpu	neon
	.eabi_attribute	34, 1	@ Tag_CPU_unaligned_access
	.eabi_attribute	15, 1	@ Tag_ABI_PCS_RW_data
	.eabi_attribute	16, 1	@ Tag_ABI_PCS_RO_data
	.eabi_attribute	17, 2	@ Tag_ABI_PCS_GOT_use
	.eabi_attribute	20, 2	@ Tag_ABI_FP_denormal
	.eabi_attribute	21, 0	@ Tag_ABI_FP_exceptions
	.eabi_attribute	23, 1	@ Tag_ABI_FP_number_model
	.eabi_attribute	24, 1	@ Tag_ABI_align_needed
	.eabi_attribute	25, 1	@ Tag_ABI_align_preserved
	.eabi_attribute	38, 1	@ Tag_ABI_FP_16bit_format
	.eabi_attribute	18, 4	@ Tag_ABI_PCS_wchar_t
	.eabi_attribute	26, 2	@ Tag_ABI_enum_size
	.eabi_attribute	14, 0	@ Tag_ABI_PCS_R9_use
	.file	"yuv444rgb8888.c"
	.globl	yuv444_2_rgb8888        @ -- Begin function yuv444_2_rgb8888
	.p2align	2
	.type	yuv444_2_rgb8888,%function
	.code	32                      @ @yuv444_2_rgb8888
yuv444_2_rgb8888:
	.fnstart
@ %bb.0:
	.save	{r4, r5, r6, r7, r8, r9, r10, r11, lr}
	push	{r4, r5, r6, r7, r8, r9, r10, r11, lr}
	.setfp	r11, sp, #28
	add	r11, sp, #28
	.pad	#52
	sub	sp, sp, #52
	mov	r5, r1
	ldr	r1, [r11, #12]
	sub	r10, r1, #1
	cmp	r10, #1
	blt	.LBB0_19
@ %bb.1:
	ldr	r4, [r11, #8]
	movw	r1, #0
	movt	r1, #65535
	mov	r7, r3
	ldr	r3, [r11, #20]
	movw	r8, #2049
	add	r1, r1, r4, lsl #16
	str	r1, [sp, #4]            @ 4-byte Spill
	movw	r1, #65535
	ldr	lr, [r11, #24]
	movt	r1, #2
	ldr	r6, [r11, #16]
	sub	r1, r1, r4, lsl #16
	str	r1, [sp]                @ 4-byte Spill
	mvn	r1, #65536
	ldr	r12, [r11, #28]
	add	r1, r1, r4, lsl #16
	str	r1, [sp, #12]           @ 4-byte Spill
	mov	r1, #196608
	movw	r9, #256
	sub	r1, r1, r4, lsl #16
	str	r1, [sp, #8]            @ 4-byte Spill
	sub	r1, r3, r4
	str	r1, [sp, #32]           @ 4-byte Spill
	sub	r1, r6, r4
	sub	lr, lr, r4, lsl #2
	str	r1, [sp, #28]           @ 4-byte Spill
	mov	r1, #65536
	movt	r8, #64
	movt	r9, #16392
	sub	r1, r1, r4, lsl #16
	str	r1, [sp, #36]           @ 4-byte Spill
	str	lr, [sp, #20]           @ 4-byte Spill
	b	.LBB0_3
.LBB0_2:                                @   in Loop: Header=BB0_3 Depth=1
	ldr	r0, [sp, #32]           @ 4-byte Reload
	ldr	r1, [sp, #40]           @ 4-byte Reload
	add	r7, r1, r0
	ldr	r1, [r11, #-36]         @ 4-byte Reload
	add	r2, r1, r0
	ldr	r0, [sp, #28]           @ 4-byte Reload
	ldr	r1, [r11, #-32]         @ 4-byte Reload
	add	r5, r1, r0
	ldr	r1, [sp, #20]           @ 4-byte Reload
	add	r0, r6, r1
	mov	lr, r1
	sxth	r1, r10
	sub	r10, r1, #1
	cmp	r10, #0
	ble	.LBB0_19
.LBB0_3:                                @ =>This Loop Header: Depth=1
                                        @     Child Loop BB0_5 Depth 2
                                        @     Child Loop BB0_14 Depth 2
	ldr	r1, [sp, #36]           @ 4-byte Reload
	add	r4, r1, r10
	cmn	r4, #1
	bgt	.LBB0_7
@ %bb.4:                                @   in Loop: Header=BB0_3 Depth=1
	ldr	r1, [sp, #12]           @ 4-byte Reload
	movw	r3, #0
	movt	r3, #65534
	sub	r1, r1, r10
	and	r1, r1, r3
	str	r1, [r11, #-32]         @ 4-byte Spill
.LBB0_5:                                @   Parent Loop BB0_3 Depth=1
                                        @ =>  This Inner Loop Header: Depth=2
	mov	r3, r7
	ldrb	r7, [r5]
	mov	r6, r2
	ldrb	r2, [r2]
	mov	r1, r5
	ldrb	r5, [r3]
	orr	r2, r2, #256
	ldr	r7, [r12, r7, lsl #2]
	orr	r5, r5, #512
	ldr	r2, [r12, r2, lsl #2]
	ldr	r5, [r12, r5, lsl #2]
	add	r2, r5, r2
	mov	r5, #255
	add	r2, r2, r7
	strb	r5, [r0, #3]
	ands	r7, r2, r9
	subne	r7, r7, r7, lsr #8
	orrne	r2, r7, r2
	bicne	r7, r8, r2, lsr #9
	addne	r2, r7, r2
	strb	r2, [r0]
	lsr	r7, r2, #11
	lsr	r2, r2, #22
	strb	r7, [r0, #2]
	strb	r2, [r0, #1]
	ldrb	r2, [r6, #1]
	ldrb	r5, [r3, #1]
	ldrb	r7, [r1, #1]
	orr	r2, r2, #256
	orr	r5, r5, #512
	ldr	r2, [r12, r2, lsl #2]
	ldr	r5, [r12, r5, lsl #2]
	ldr	r7, [r12, r7, lsl #2]
	add	r2, r5, r2
	mov	r5, #255
	add	r2, r2, r7
	strb	r5, [r0, #7]
	ands	r7, r2, r9
	add	r5, r1, #2
	subne	r7, r7, r7, lsr #8
	orrne	r2, r7, r2
	bicne	r7, r8, r2, lsr #9
	addne	r2, r7, r2
	strb	r2, [r0, #4]
	adds	r4, r4, #131072
	lsr	r7, r2, #11
	lsr	r2, r2, #22
	strb	r7, [r0, #6]
	add	r7, r3, #2
	strb	r2, [r0, #5]
	add	r0, r0, #8
	add	r2, r6, #2
	bmi	.LBB0_5
@ %bb.6:                                @   in Loop: Header=BB0_3 Depth=1
	add	r5, r1, #2
	ldr	r1, [sp, #8]            @ 4-byte Reload
	add	r7, r3, #2
	ldr	r3, [r11, #-32]         @ 4-byte Reload
	add	r1, r1, r10
	add	r2, r6, #2
	add	r4, r1, r3
.LBB0_7:                                @   in Loop: Header=BB0_3 Depth=1
	mov	r1, #0
	cmp	r1, r4, lsr #16
	bne	.LBB0_9
@ %bb.8:                                @   in Loop: Header=BB0_3 Depth=1
	ldrb	r1, [r2], #1
	ldrb	r6, [r7], #1
	ldrb	r3, [r5], #1
	orr	r1, r1, #256
	orr	r6, r6, #512
	ldr	r1, [r12, r1, lsl #2]
	ldr	r6, [r12, r6, lsl #2]
	ldr	r3, [r12, r3, lsl #2]
	add	r1, r6, r1
	add	r1, r1, r3
	ands	r3, r1, r9
	subne	r3, r3, r3, lsr #8
	orrne	r1, r3, r1
	bicne	r3, r8, r1, lsr #9
	addne	r1, r3, r1
	mov	r3, #255
	strb	r3, [r0, #3]
	strb	r1, [r0]
	lsr	r3, r1, #11
	lsr	r1, r1, #22
	strb	r3, [r0, #2]
	strb	r1, [r0, #1]
	add	r0, r0, #4
.LBB0_9:                                @   in Loop: Header=BB0_3 Depth=1
	sxth	r1, r4
	str	r1, [sp, #24]           @ 4-byte Spill
	subs	r1, r1, #1
	beq	.LBB0_19
@ %bb.10:                               @   in Loop: Header=BB0_3 Depth=1
	add	r6, r0, lr
	ldr	r0, [sp, #28]           @ 4-byte Reload
	ldr	r3, [sp, #36]           @ 4-byte Reload
	add	r0, r5, r0
	str	r0, [r11, #-32]         @ 4-byte Spill
	add	r10, r3, r1
	ldr	r0, [sp, #32]           @ 4-byte Reload
	cmn	r10, #1
	add	r1, r2, r0
	add	r0, r7, r0
	str	r1, [r11, #-36]         @ 4-byte Spill
	str	r0, [sp, #40]           @ 4-byte Spill
	bgt	.LBB0_17
@ %bb.11:                               @   in Loop: Header=BB0_3 Depth=1
	ldr	r0, [sp, #4]            @ 4-byte Reload
	mov	r12, #0
	ldr	r1, [sp, #24]           @ 4-byte Reload
	mov	r5, #0
	sub	r1, r0, r1
	movw	r0, #0
	movt	r0, #65534
	and	r1, r1, r0
	ldr	r0, [sp]                @ 4-byte Reload
	add	r0, r0, r1
	str	r0, [sp, #16]           @ 4-byte Spill
	b	.LBB0_14
.LBB0_12:                               @   in Loop: Header=BB0_14 Depth=2
	sub	r0, r8, r8, lsr #8
	mov	r8, lr
	orr	r0, r0, r9
	bic	r4, lr, r0, lsr #9
	add	r9, r4, r0
.LBB0_13:                               @   in Loop: Header=BB0_14 Depth=2
	mov	r0, #255
	add	r12, r12, #8
	strb	r0, [r7, #3]
	lsr	r0, r9, #11
	strb	r9, [r7]
	add	r5, r5, #2
	strb	r0, [r7, #2]
	lsr	r0, r9, #22
	strb	r0, [r7, #1]
	ldrb	r0, [r2, #1]
	ldrb	r2, [r3, #1]
	ldr	r3, [r11, #28]
	orr	r0, r0, #256
	ldrb	r1, [r1, #1]
	orr	r2, r2, #512
	ldr	r0, [r3, r0, lsl #2]
	ldr	r2, [r3, r2, lsl #2]
	ldr	r1, [r3, r1, lsl #2]
	add	r0, r2, r0
	add	r1, r0, r1
	movw	r0, #256
	movt	r0, #16392
	ands	r2, r1, r0
	subne	r0, r2, r2, lsr #8
	orrne	r0, r0, r1
	bicne	r1, r8, r0, lsr #9
	addne	r1, r1, r0
	mov	r0, #255
	strb	r0, [r7, #7]
	adds	r10, r10, #131072
	lsr	r0, r1, #11
	strb	r1, [r7, #4]
	strb	r0, [r7, #6]
	lsr	r0, r1, #22
	strb	r0, [r7, #5]
	bpl	.LBB0_16
.LBB0_14:                               @   Parent Loop BB0_3 Depth=1
                                        @ =>  This Inner Loop Header: Depth=2
	ldr	r2, [r11, #-36]         @ 4-byte Reload
	mov	lr, r8
	ldr	r3, [sp, #40]           @ 4-byte Reload
	mov	r4, r6
	ldr	r0, [r11, #28]
	ldrb	r1, [r2, r5]!
	ldrb	r7, [r3, r5]!
	orr	r1, r1, #256
	mov	r6, r0
	ldr	r8, [r0, r1, lsl #2]
	orr	r1, r7, #512
	ldr	r7, [r0, r1, lsl #2]
	ldr	r1, [r11, #-32]         @ 4-byte Reload
	ldrb	r0, [r1, r5]!
	ldr	r0, [r6, r0, lsl #2]
	mov	r6, r4
	add	r4, r7, r8
	add	r7, r6, r5, lsl #2
	add	r9, r4, r0
	movw	r0, #256
	movt	r0, #16392
	ands	r8, r9, r0
	bne	.LBB0_12
@ %bb.15:                               @   in Loop: Header=BB0_14 Depth=2
	mov	r8, lr
	b	.LBB0_13
.LBB0_16:                               @   in Loop: Header=BB0_3 Depth=1
	ldr	r0, [sp, #40]           @ 4-byte Reload
	add	r6, r6, r12
	ldr	r1, [sp, #16]           @ 4-byte Reload
	movw	r9, #256
	add	r0, r0, r5
	str	r0, [sp, #40]           @ 4-byte Spill
	ldr	r0, [r11, #-36]         @ 4-byte Reload
	movt	r9, #16392
	ldr	r12, [r11, #28]
	add	r0, r0, r5
	str	r0, [r11, #-36]         @ 4-byte Spill
	ldr	r0, [r11, #-32]         @ 4-byte Reload
	add	r0, r0, r5
	str	r0, [r11, #-32]         @ 4-byte Spill
	ldr	r0, [sp, #24]           @ 4-byte Reload
	add	r10, r1, r0
.LBB0_17:                               @   in Loop: Header=BB0_3 Depth=1
	mov	r0, #0
	cmp	r0, r10, lsr #16
	bne	.LBB0_2
@ %bb.18:                               @   in Loop: Header=BB0_3 Depth=1
	ldr	r1, [r11, #-36]         @ 4-byte Reload
	ldr	r2, [r11, #-32]         @ 4-byte Reload
	ldr	r3, [sp, #40]           @ 4-byte Reload
	ldrb	r0, [r1], #1
	str	r1, [r11, #-36]         @ 4-byte Spill
	ldrb	r1, [r2], #1
	orr	r0, r0, #256
	str	r2, [r11, #-32]         @ 4-byte Spill
	ldrb	r2, [r3], #1
	ldr	r0, [r12, r0, lsl #2]
	orr	r2, r2, #512
	ldr	r1, [r12, r1, lsl #2]
	ldr	r2, [r12, r2, lsl #2]
	str	r3, [sp, #40]           @ 4-byte Spill
	add	r0, r2, r0
	add	r1, r0, r1
	ands	r2, r1, r9
	subne	r0, r2, r2, lsr #8
	orrne	r0, r0, r1
	bicne	r1, r8, r0, lsr #9
	addne	r1, r1, r0
	mov	r0, #255
	strb	r0, [r6, #3]
	lsr	r0, r1, #11
	strb	r1, [r6]
	strb	r0, [r6, #2]
	lsr	r0, r1, #22
	strb	r0, [r6, #1]
	add	r6, r6, #4
	b	.LBB0_2
.LBB0_19:
	sub	sp, r11, #28
	pop	{r4, r5, r6, r7, r8, r9, r10, r11, pc}
.Lfunc_end0:
	.size	yuv444_2_rgb8888, .Lfunc_end0-yuv444_2_rgb8888
	.cantunwind
	.fnend
                                        @ -- End function

	.ident	"Android (5900059 based on r365631c) clang version 9.0.8 (https://android.googlesource.com/toolchain/llvm-project 207d7abc1a2abf3ef8d4301736d6a7ebc224a290) (based on LLVM 9.0.8svn)"
	.section	".note.GNU-stack","",%progbits
