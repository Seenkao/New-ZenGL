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
	.file	"yuv420rgb8888.c"
	.globl	yuv420_2_rgb8888        @ -- Begin function yuv420_2_rgb8888
	.p2align	2
	.type	yuv420_2_rgb8888,%function
	.code	32                      @ @yuv420_2_rgb8888
yuv420_2_rgb8888:
	.fnstart
@ %bb.0:
	.save	{r4, r5, r6, r7, r8, r9, r10, r11, lr}
	push	{r4, r5, r6, r7, r8, r9, r10, r11, lr}
	.setfp	r11, sp, #28
	add	r11, sp, #28
	.pad	#48
	sub	sp, sp, #48
	str	r2, [sp, #36]           @ 4-byte Spill
	movw	r9, #256
	ldr	r2, [r11, #12]
	movt	r9, #16392
	ldr	r12, [r11, #28]
	ldr	r7, [r11, #8]
	sub	r5, r2, #1
	cmp	r5, #1
	str	r3, [r11, #-36]         @ 4-byte Spill
	blt	.LBB0_9
@ %bb.1:
	ldr	r2, [r11, #24]
	ldr	r6, [r11, #16]
	ldr	lr, [r11, #20]
	asr	r3, r2, #2
	mov	r2, #4
	add	r2, r2, r3, lsl #2
	str	r2, [r11, #-32]         @ 4-byte Spill
	mvn	r2, #65536
	sub	r4, lr, r7, asr #1
	add	r2, r2, r7, lsl #16
	str	r2, [sp, #12]           @ 4-byte Spill
	mov	r2, #196608
	rsb	r10, r7, r6, lsl #1
	sub	r2, r2, r7, lsl #16
	str	r2, [sp, #8]            @ 4-byte Spill
	mov	r2, r3
	str	r3, [sp, #16]           @ 4-byte Spill
	rsb	r2, r7, r3, lsl #1
	str	r2, [sp, #32]           @ 4-byte Spill
	mov	r2, #65536
	str	r4, [sp, #4]            @ 4-byte Spill
	sub	r2, r2, r7, lsl #16
	str	r2, [sp, #28]           @ 4-byte Spill
	str	r10, [sp]               @ 4-byte Spill
	b	.LBB0_3
.LBB0_2:                                @   in Loop: Header=BB0_3 Depth=1
	ldr	r2, [r11, #-36]         @ 4-byte Reload
	add	r1, r1, r10
	add	r2, r2, r4
	str	r2, [r11, #-36]         @ 4-byte Spill
	ldr	r2, [sp, #36]           @ 4-byte Reload
	add	r2, r2, r4
	str	r2, [sp, #36]           @ 4-byte Spill
	ldr	r2, [sp, #32]           @ 4-byte Reload
	add	r0, r0, r2, lsl #2
	sxth	r2, r8
	sub	r5, r2, #2
	cmp	r5, #0
	ble	.LBB0_9
.LBB0_3:                                @ =>This Loop Header: Depth=1
                                        @     Child Loop BB0_5 Depth 2
	ldr	r2, [sp, #28]           @ 4-byte Reload
	add	r8, r2, r5
	cmn	r8, #1
	bgt	.LBB0_7
@ %bb.4:                                @   in Loop: Header=BB0_3 Depth=1
	ldr	r2, [sp, #12]           @ 4-byte Reload
	add	r1, r1, #1
	movw	r3, #0
	mov	r10, #0
	sub	r2, r2, r5
	movt	r3, #65534
	and	r2, r2, r3
	str	r5, [sp, #24]           @ 4-byte Spill
	str	r2, [sp, #20]           @ 4-byte Spill
.LBB0_5:                                @   Parent Loop BB0_3 Depth=1
                                        @ =>  This Inner Loop Header: Depth=2
	ldr	r2, [sp, #36]           @ 4-byte Reload
	movw	r4, #256
	ldr	r3, [r11, #-36]         @ 4-byte Reload
	movt	r4, #16392
	ldr	r7, [r11, #16]
	mov	r9, r8
	ldrb	r2, [r2, r10]
	movw	r8, #63488
	ldrb	r3, [r3, r10]
	add	r7, r1, r7
	orr	r2, r2, #256
	ldrb	r5, [r1, #-1]
	orr	r3, r3, #512
	ldrb	r7, [r7, #-1]
	ldr	r2, [r12, r2, lsl #2]
	movt	r8, #7
	ldr	r3, [r12, r3, lsl #2]
	ldr	r6, [r12, r7, lsl #2]
	ldr	r5, [r12, r5, lsl #2]
	add	lr, r3, r2
	movw	r2, #256
	add	r12, r6, lr
	movt	r2, #16392
	ands	r3, r12, r2
	add	r7, r5, lr
	mov	r5, #65280
	subne	r2, r3, r3, lsr #8
	movwne	r3, #2049
	orrne	r2, r2, r12
	movtne	r3, #64
	add	r10, r10, #1
	bicne	r3, r3, r2, lsr #9
	addne	r12, r3, r2
	ands	r3, r7, r4
	subne	r2, r3, r3, lsr #8
	movwne	r3, #2049
	orrne	r2, r2, r7
	movtne	r3, #64
	uxtb	r6, r12
	bicne	r3, r3, r2, lsr #9
	addne	r7, r3, r2
	and	r3, r5, r12, lsr #14
	and	r2, r12, r8
	orr	r3, r6, r3
	ldr	r12, [r11, #28]
	orr	r2, r3, r2, lsl #5
	ldr	r3, [r11, #-32]         @ 4-byte Reload
	orr	r2, r2, #-16777216
	add	r3, r0, r3
	str	r2, [r3, #-4]
	and	r2, r7, r8
	and	r3, r5, r7, lsr #14
	uxtb	r7, r7
	orr	r3, r7, r3
	mov	r8, r9
	orr	r2, r3, r2, lsl #5
	orr	r2, r2, #-16777216
	str	r2, [r0]
	ldr	r2, [r11, #16]
	ldrb	r3, [r1]
	ldrb	r2, [r1, r2]
	add	r1, r1, #2
	ldr	r3, [r12, r3, lsl #2]
	ldr	r2, [r12, r2, lsl #2]
	add	r7, r3, lr
	add	r3, r2, lr
	ands	r2, r3, r4
	subne	r2, r2, r2, lsr #8
	orrne	r2, r2, r3
	movwne	r3, #2049
	movtne	r3, #64
	bicne	r3, r3, r2, lsr #9
	addne	r3, r3, r2
	ands	r2, r7, r4
	mov	r4, #65280
	subne	r2, r2, r2, lsr #8
	and	r6, r4, r3, lsr #14
	orrne	r2, r2, r7
	movwne	r7, #2049
	movtne	r7, #64
	bicne	r7, r7, r2, lsr #9
	addne	r7, r7, r2
	movw	r2, #63488
	movt	r2, #7
	adds	r8, r8, #131072
	mov	r5, r2
	and	r2, r3, r2
	uxtb	r3, r3
	orr	r3, r3, r6
	orr	r2, r3, r2, lsl #5
	ldr	r3, [r11, #-32]         @ 4-byte Reload
	orr	r2, r2, #-16777216
	str	r2, [r0, r3]
	and	r2, r7, r5
	and	r3, r4, r7, lsr #14
	uxtb	r7, r7
	orr	r3, r7, r3
	orr	r2, r3, r2, lsl #5
	orr	r2, r2, #-16777216
	str	r2, [r0, #4]
	add	r0, r0, #8
	bmi	.LBB0_5
@ %bb.6:                                @   in Loop: Header=BB0_3 Depth=1
	ldr	r2, [r11, #-36]         @ 4-byte Reload
	movw	r9, #256
	ldr	r3, [sp, #24]           @ 4-byte Reload
	sub	r1, r1, #1
	add	r2, r2, r10
	str	r2, [r11, #-36]         @ 4-byte Spill
	ldr	r2, [sp, #36]           @ 4-byte Reload
	movt	r9, #16392
	ldr	r4, [sp, #4]            @ 4-byte Reload
	add	r2, r2, r10
	str	r2, [sp, #36]           @ 4-byte Spill
	ldr	r2, [sp, #8]            @ 4-byte Reload
	ldr	r10, [sp]               @ 4-byte Reload
	add	r2, r2, r3
	ldr	r3, [sp, #20]           @ 4-byte Reload
	add	r8, r2, r3
.LBB0_7:                                @   in Loop: Header=BB0_3 Depth=1
	mov	r2, #0
	cmp	r2, r8, lsr #16
	bne	.LBB0_2
@ %bb.8:                                @   in Loop: Header=BB0_3 Depth=1
	ldr	r2, [sp, #36]           @ 4-byte Reload
	ldr	r6, [r11, #-36]         @ 4-byte Reload
	ldr	r3, [r11, #16]
	ldrb	r2, [r2]
	ldrb	r6, [r6]
	ldrb	r3, [r1, r3]
	orr	r2, r2, #256
	orr	r6, r6, #512
	ldrb	r7, [r1]
	add	r1, r1, #1
	ldr	r2, [r12, r2, lsl #2]
	ldr	r6, [r12, r6, lsl #2]
	ldr	r3, [r12, r3, lsl #2]
	ldr	r7, [r12, r7, lsl #2]
	add	r2, r6, r2
	add	lr, r3, r2
	mov	r6, #65280
	add	r7, r7, r2
	ands	r2, lr, r9
	movwne	r3, #2049
	subne	r2, r2, r2, lsr #8
	movtne	r3, #64
	orrne	r2, r2, lr
	bicne	r3, r3, r2, lsr #9
	addne	lr, r3, r2
	ands	r2, r7, r9
	movwne	r3, #2049
	subne	r2, r2, r2, lsr #8
	movtne	r3, #64
	orrne	r2, r2, r7
	bicne	r3, r3, r2, lsr #9
	addne	r7, r3, r2
	movw	r2, #63488
	movt	r2, #7
	mov	r5, r2
	and	r2, r7, r2
	and	r3, r6, r7, lsr #14
	uxtb	r7, r7
	orr	r3, r7, r3
	uxtb	r7, lr
	orr	r2, r3, r2, lsl #5
	ldr	r3, [sp, #16]           @ 4-byte Reload
	orr	r2, r2, #-16777216
	str	r2, [r0, r3, lsl #2]
	and	r3, r6, lr, lsr #14
	and	r2, lr, r5
	orr	r3, r7, r3
	orr	r2, r3, r2, lsl #5
	orr	r2, r2, #-16777216
	str	r2, [r0], #4
	b	.LBB0_2
.LBB0_9:
	cmp	r5, #0
	bne	.LBB0_16
@ %bb.10:
	ldr	r3, [r11, #8]
	mov	r2, #65536
	sub	r6, r2, r3, lsl #16
	cmn	r6, #1
	bgt	.LBB0_14
@ %bb.11:
	mvn	r2, #65536
	lsl	r8, r3, #16
	add	r2, r8, r2
	movw	r9, #256
	mov	r5, r0
	mov	r10, #65280
	bfc	r2, #0, #17
	movt	r9, #16392
	add	r0, r2, #196608
	str	r0, [r11, #-32]         @ 4-byte Spill
.LBB0_12:                               @ =>This Inner Loop Header: Depth=1
	ldr	r4, [sp, #36]           @ 4-byte Reload
	mov	lr, r1
	ldrb	r1, [r1]
	ldrb	r2, [lr, #1]
	ldrb	r3, [r4], #1
	str	r4, [sp, #36]           @ 4-byte Spill
	ldr	r4, [r11, #-36]         @ 4-byte Reload
	orr	r3, r3, #256
	ldr	r1, [r12, r1, lsl #2]
	ldr	r3, [r12, r3, lsl #2]
	ldrb	r7, [r4], #1
	ldr	r2, [r12, r2, lsl #2]
	orr	r7, r7, #512
	str	r4, [r11, #-36]         @ 4-byte Spill
	ldr	r7, [r12, r7, lsl #2]
	add	r3, r7, r3
	add	r1, r1, r3
	add	r7, r2, r3
	ands	r2, r1, r9
	subne	r2, r2, r2, lsr #8
	orrne	r1, r2, r1
	movwne	r2, #2049
	movtne	r2, #64
	bicne	r2, r2, r1, lsr #9
	addne	r1, r2, r1
	ands	r2, r7, r9
	movwne	r3, #2049
	subne	r2, r2, r2, lsr #8
	movtne	r3, #64
	orrne	r2, r2, r7
	bicne	r3, r3, r2, lsr #9
	addne	r7, r3, r2
	movw	r2, #63488
	movt	r2, #7
	adds	r6, r6, #131072
	mov	r0, r2
	and	r2, r7, r2
	and	r3, r10, r7, lsr #14
	uxtb	r7, r7
	orr	r3, r7, r3
	and	r7, r10, r1, lsr #14
	orr	r2, r3, r2, lsl #5
	and	r3, r1, r0
	uxtb	r1, r1
	orr	r2, r2, #-16777216
	orr	r1, r1, r7
	orr	r1, r1, r3, lsl #5
	orr	r1, r1, #-16777216
	stm	r5!, {r1, r2}
	add	r1, lr, #2
	bmi	.LBB0_12
@ %bb.13:
	ldr	r0, [r11, #-32]         @ 4-byte Reload
	add	r1, lr, #2
	sub	r6, r0, r8
	mov	r0, r5
.LBB0_14:
	mov	r2, #0
	cmp	r2, r6, lsr #16
	bne	.LBB0_16
@ %bb.15:
	ldr	r2, [sp, #36]           @ 4-byte Reload
	ldr	r3, [r11, #-36]         @ 4-byte Reload
	ldrb	r1, [r1]
	ldrb	r2, [r2]
	ldrb	r3, [r3]
	orr	r2, r2, #256
	ldr	r1, [r12, r1, lsl #2]
	orr	r3, r3, #512
	ldr	r2, [r12, r2, lsl #2]
	ldr	r3, [r12, r3, lsl #2]
	add	r2, r3, r2
	mov	r3, #65280
	add	r1, r2, r1
	ands	r2, r1, r9
	subne	r2, r2, r2, lsr #8
	orrne	r1, r2, r1
	movwne	r2, #2049
	movtne	r2, #64
	bicne	r2, r2, r1, lsr #9
	addne	r1, r2, r1
	movw	r2, #63488
	movt	r2, #7
	and	r2, r1, r2
	and	r3, r3, r1, lsr #14
	uxtb	r1, r1
	orr	r1, r1, r3
	orr	r1, r1, r2, lsl #5
	orr	r1, r1, #-16777216
	str	r1, [r0]
.LBB0_16:
	sub	sp, r11, #28
	pop	{r4, r5, r6, r7, r8, r9, r10, r11, pc}
.Lfunc_end0:
	.size	yuv420_2_rgb8888, .Lfunc_end0-yuv420_2_rgb8888
	.cantunwind
	.fnend
                                        @ -- End function

	.ident	"Android (5900059 based on r365631c) clang version 9.0.8 (https://android.googlesource.com/toolchain/llvm-project 207d7abc1a2abf3ef8d4301736d6a7ebc224a290) (based on LLVM 9.0.8svn)"
	.section	".note.GNU-stack","",%progbits
