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
	.file	"yuv422rgb8888.c"
	.globl	yuv422_2_rgb8888        @ -- Begin function yuv422_2_rgb8888
	.p2align	2
	.type	yuv422_2_rgb8888,%function
	.code	32                      @ @yuv422_2_rgb8888
yuv422_2_rgb8888:
	.fnstart
@ %bb.0:
	.save	{r4, r5, r6, r7, r8, r9, r10, r11, lr}
	push	{r4, r5, r6, r7, r8, r9, r10, r11, lr}
	.setfp	r11, sp, #28
	add	r11, sp, #28
	.pad	#52
	sub	sp, sp, #52
	ldr	r7, [r11, #12]
	sub	r8, r7, #1
	cmp	r8, #1
	blt	.LBB0_16
@ %bb.1:
	ldr	r5, [r11, #8]
	movw	r7, #0
	movt	r7, #65535
	add	lr, r11, #16
	mov	r12, #255
	add	r7, r7, r5, lsl #16
	str	r7, [sp, #4]            @ 4-byte Spill
	movw	r7, #65535
	ldm	lr, {r4, r6, lr}
	movt	r7, #2
	sub	r7, r7, r5, lsl #16
	str	r7, [sp]                @ 4-byte Spill
	mvn	r7, #65536
	sub	r4, r4, r5
	add	r7, r7, r5, lsl #16
	str	r7, [sp, #12]           @ 4-byte Spill
	mov	r7, #196608
	sub	r6, r6, r5, asr #1
	sub	r7, r7, r5, lsl #16
	str	r7, [sp, #8]            @ 4-byte Spill
	sub	r7, lr, r5, lsl #2
	str	r7, [sp, #36]           @ 4-byte Spill
	mov	r7, #65536
	sub	r10, r7, r5, lsl #16
	mov	lr, r6
	mov	r6, r4
	str	lr, [sp, #28]           @ 4-byte Spill
	str	r4, [sp, #24]           @ 4-byte Spill
	str	r10, [sp, #32]          @ 4-byte Spill
	b	.LBB0_3
.LBB0_2:                                @   in Loop: Header=BB0_3 Depth=1
	ldr	r0, [sp, #40]           @ 4-byte Reload
	sxth	r7, r10
	ldr	r5, [sp, #36]           @ 4-byte Reload
	sub	r8, r7, #1
	add	r3, r0, lr
	ldr	r0, [r11, #-36]         @ 4-byte Reload
	ldr	r10, [sp, #32]          @ 4-byte Reload
	cmp	r8, #0
	add	r2, r0, lr
	ldr	r0, [r11, #-32]         @ 4-byte Reload
	add	r1, r0, r6
	add	r0, r9, r5
	ble	.LBB0_16
.LBB0_3:                                @ =>This Loop Header: Depth=1
                                        @     Child Loop BB0_5 Depth 2
                                        @     Child Loop BB0_12 Depth 2
	add	r9, r10, r8
	cmn	r9, #1
	bgt	.LBB0_7
@ %bb.4:                                @   in Loop: Header=BB0_3 Depth=1
	ldr	r7, [sp, #12]           @ 4-byte Reload
	movw	r6, #0
	movt	r6, #65534
	sub	r7, r7, r8
	and	r7, r7, r6
	str	r7, [r11, #-32]         @ 4-byte Spill
.LBB0_5:                                @   Parent Loop BB0_3 Depth=1
                                        @ =>  This Inner Loop Header: Depth=2
	mov	lr, r1
	ldrb	r6, [r2], #1
	ldr	r4, [r11, #28]
	mov	r12, #255
	ldrb	r5, [lr, #1]
	orr	r6, r6, #256
	ldrb	r1, [r1]
	mov	r7, r4
	ldr	r6, [r4, r6, lsl #2]
	ldr	r5, [r4, r5, lsl #2]
	ldrb	r4, [r3], #1
	ldr	r1, [r7, r1, lsl #2]
	orr	r4, r4, #512
	ldr	r4, [r7, r4, lsl #2]
	add	r4, r4, r6
	add	r6, r5, r4
	add	r1, r1, r4
	movw	r4, #256
	movt	r4, #16392
	ands	r5, r1, r4
	subne	r4, r5, r5, lsr #8
	orrne	r1, r4, r1
	movwne	r4, #2049
	movtne	r4, #64
	bicne	r4, r4, r1, lsr #9
	addne	r1, r4, r1
	movw	r4, #256
	movt	r4, #16392
	ands	r5, r6, r4
	subne	r4, r5, r5, lsr #8
	movwne	r5, #2049
	orrne	r4, r4, r6
	movtne	r5, #64
	bicne	r5, r5, r4, lsr #9
	addne	r6, r5, r4
	mov	r4, #255
	strb	r4, [r0, #7]
	adds	r9, r9, #131072
	strb	r6, [r0, #4]
	strb	r4, [r0, #3]
	lsr	r4, r6, #11
	strb	r1, [r0]
	strb	r4, [r0, #6]
	lsr	r4, r6, #22
	strb	r4, [r0, #5]
	lsr	r4, r1, #11
	lsr	r1, r1, #22
	strb	r4, [r0, #2]
	strb	r1, [r0, #1]
	add	r0, r0, #8
	add	r1, lr, #2
	bmi	.LBB0_5
@ %bb.6:                                @   in Loop: Header=BB0_3 Depth=1
	ldr	r4, [sp, #8]            @ 4-byte Reload
	add	r1, lr, #2
	ldr	r7, [r11, #-32]         @ 4-byte Reload
	add	r4, r4, r8
	ldr	lr, [sp, #28]           @ 4-byte Reload
	ldr	r6, [sp, #24]           @ 4-byte Reload
	add	r9, r4, r7
.LBB0_7:                                @   in Loop: Header=BB0_3 Depth=1
	mov	r4, #0
	cmp	r4, r9, lsr #16
	bne	.LBB0_9
@ %bb.8:                                @   in Loop: Header=BB0_3 Depth=1
	ldrb	r7, [r2]
	mov	r8, r6
	ldrb	r5, [r3]
	ldr	r4, [r11, #28]
	orr	r7, r7, #256
	ldrb	r6, [r1], #1
	orr	r5, r5, #512
	ldr	r7, [r4, r7, lsl #2]
	ldr	r5, [r4, r5, lsl #2]
	ldr	r6, [r4, r6, lsl #2]
	strb	r12, [r0, #3]
	add	r7, r5, r7
	movw	r5, #256
	add	r7, r7, r6
	movt	r5, #16392
	ands	r6, r7, r5
	movwne	r5, #2049
	subne	r6, r6, r6, lsr #8
	movtne	r5, #64
	orrne	r7, r6, r7
	bicne	r6, r5, r7, lsr #9
	addne	r7, r6, r7
	strb	r7, [r0]
	lsr	r6, r7, #11
	lsr	r7, r7, #22
	strb	r6, [r0, #2]
	mov	r6, r8
	strb	r7, [r0, #1]
	add	r0, r0, #4
.LBB0_9:                                @   in Loop: Header=BB0_3 Depth=1
	sxth	r4, r9
	subs	r7, r4, #1
	beq	.LBB0_16
@ %bb.10:                               @   in Loop: Header=BB0_3 Depth=1
	ldr	r5, [sp, #36]           @ 4-byte Reload
	add	r10, r10, r7
	cmn	r10, #1
	add	r9, r0, r5
	add	r0, r1, r6
	str	r0, [r11, #-32]         @ 4-byte Spill
	add	r0, r2, lr
	str	r0, [r11, #-36]         @ 4-byte Spill
	add	r0, r3, lr
	str	r0, [sp, #40]           @ 4-byte Spill
	bgt	.LBB0_14
@ %bb.11:                               @   in Loop: Header=BB0_3 Depth=1
	ldr	r1, [sp, #4]            @ 4-byte Reload
	mov	r6, #0
	mov	r5, #0
	mov	r7, #0
	sub	r2, r1, r4
	movw	r1, #0
	movt	r1, #65534
	and	r2, r2, r1
	ldr	r1, [sp]                @ 4-byte Reload
	str	r4, [sp, #20]           @ 4-byte Spill
	add	r0, r1, r2
	str	r0, [sp, #16]           @ 4-byte Spill
.LBB0_12:                               @   Parent Loop BB0_3 Depth=1
                                        @ =>  This Inner Loop Header: Depth=2
	ldr	r0, [r11, #-36]         @ 4-byte Reload
	add	r8, r9, r7, lsl #3
	ldr	r1, [r11, #-32]         @ 4-byte Reload
	add	r6, r6, #2
	add	r5, r5, #8
	mov	r12, #255
	ldrb	r2, [r0, r7]
	ldr	r0, [sp, #40]           @ 4-byte Reload
	ldrb	r4, [r1, r7, lsl #1]!
	orr	r2, r2, #256
	ldrb	r3, [r0, r7]
	add	r7, r7, #1
	ldr	r0, [r11, #28]
	ldrb	r1, [r1, #1]
	orr	r3, r3, #512
	ldr	r2, [r0, r2, lsl #2]
	ldr	r3, [r0, r3, lsl #2]
	ldr	r4, [r0, r4, lsl #2]
	ldr	r1, [r0, r1, lsl #2]
	add	r2, r3, r2
	add	r4, r4, r2
	add	lr, r1, r2
	movw	r1, #256
	movt	r1, #16392
	ands	r2, r4, r1
	subne	r1, r2, r2, lsr #8
	movwne	r2, #2049
	orrne	r1, r1, r4
	movtne	r2, #64
	bicne	r2, r2, r1, lsr #9
	addne	r4, r2, r1
	movw	r1, #256
	movt	r1, #16392
	ands	r2, lr, r1
	subne	r1, r2, r2, lsr #8
	movwne	r2, #2049
	orrne	r1, r1, lr
	movtne	r2, #64
	bicne	r2, r2, r1, lsr #9
	addne	lr, r2, r1
	mov	r1, #255
	strb	r1, [r8, #7]
	adds	r10, r10, #131072
	strb	lr, [r8, #4]
	strb	r1, [r8, #3]
	lsr	r1, lr, #11
	strb	r4, [r8]
	strb	r1, [r8, #6]
	lsr	r1, lr, #22
	strb	r1, [r8, #5]
	lsr	r1, r4, #11
	strb	r1, [r8, #2]
	lsr	r1, r4, #22
	strb	r1, [r8, #1]
	bmi	.LBB0_12
@ %bb.13:                               @   in Loop: Header=BB0_3 Depth=1
	ldr	r0, [sp, #40]           @ 4-byte Reload
	add	r9, r9, r5
	ldr	r1, [sp, #16]           @ 4-byte Reload
	add	r0, r0, r7
	str	r0, [sp, #40]           @ 4-byte Spill
	ldr	r0, [r11, #-36]         @ 4-byte Reload
	ldr	lr, [sp, #28]           @ 4-byte Reload
	add	r0, r0, r7
	str	r0, [r11, #-36]         @ 4-byte Spill
	ldr	r0, [r11, #-32]         @ 4-byte Reload
	add	r0, r0, r6
	str	r0, [r11, #-32]         @ 4-byte Spill
	ldr	r0, [sp, #20]           @ 4-byte Reload
	ldr	r6, [sp, #24]           @ 4-byte Reload
	add	r10, r1, r0
.LBB0_14:                               @   in Loop: Header=BB0_3 Depth=1
	mov	r0, #0
	cmp	r0, r10, lsr #16
	bne	.LBB0_2
@ %bb.15:                               @   in Loop: Header=BB0_3 Depth=1
	ldr	r0, [r11, #-36]         @ 4-byte Reload
	ldrb	r1, [r0]
	ldr	r0, [r11, #-32]         @ 4-byte Reload
	orr	r1, r1, #256
	ldrb	r2, [r0], #1
	str	r0, [r11, #-32]         @ 4-byte Spill
	ldr	r0, [sp, #40]           @ 4-byte Reload
	ldrb	r3, [r0]
	ldr	r0, [r11, #28]
	orr	r3, r3, #512
	ldr	r1, [r0, r1, lsl #2]
	ldr	r3, [r0, r3, lsl #2]
	ldr	r2, [r0, r2, lsl #2]
	strb	r12, [r9, #3]
	add	r1, r3, r1
	add	r7, r1, r2
	movw	r1, #256
	movt	r1, #16392
	ands	r2, r7, r1
	subne	r1, r2, r2, lsr #8
	movwne	r2, #2049
	orrne	r1, r1, r7
	movtne	r2, #64
	bicne	r2, r2, r1, lsr #9
	addne	r7, r2, r1
	strb	r7, [r9]
	lsr	r1, r7, #11
	strb	r1, [r9, #2]
	lsr	r1, r7, #22
	strb	r1, [r9, #1]
	add	r9, r9, #4
	b	.LBB0_2
.LBB0_16:
	sub	sp, r11, #28
	pop	{r4, r5, r6, r7, r8, r9, r10, r11, pc}
.Lfunc_end0:
	.size	yuv422_2_rgb8888, .Lfunc_end0-yuv422_2_rgb8888
	.cantunwind
	.fnend
                                        @ -- End function

	.ident	"Android (5900059 based on r365631c) clang version 9.0.8 (https://android.googlesource.com/toolchain/llvm-project 207d7abc1a2abf3ef8d4301736d6a7ebc224a290) (based on LLVM 9.0.8svn)"
	.section	".note.GNU-stack","",%progbits
