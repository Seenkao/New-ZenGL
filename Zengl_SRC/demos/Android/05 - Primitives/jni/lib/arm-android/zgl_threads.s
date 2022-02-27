	.file "zgl_threads.pas"
# Begin asmlist al_procedures

.section .text.n_zgl_threads_$$_thread_create$zgltthread$tthreadfunc$pointer
	.balign 4
.globl	ZGL_THREADS_$$_THREAD_CREATE$ZGLTTHREAD$TTHREADFUNC$POINTER
	.type	ZGL_THREADS_$$_THREAD_CREATE$ZGLTTHREAD$TTHREADFUNC$POINTER,#function
ZGL_THREADS_$$_THREAD_CREATE$ZGLTTHREAD$TTHREADFUNC$POINTER:
# [zgl_threads.pas]
# [62] begin
	mov	r12,r13
	stmfd	r13!,{r11,r12,r14,r15}
	sub	r11,r12,#4
	sub	r13,r13,#56
# Var Thread located at r11-48, size=OS_32
# Var Callback located at r11-52, size=OS_32
# Var Data located at r11-56, size=OS_32
	str	r0,[r11, #-48]
	str	r1,[r11, #-52]
	str	r2,[r11, #-56]
# [64] Thread.Handle := BeginThread(Callback, Data, Thread.ID);
	ldr	r2,[r11, #-48]
	ldr	r1,[r11, #-56]
	ldr	r0,[r11, #-52]
	bl	SYSTEM_$$_BEGINTHREAD$TTHREADFUNC$POINTER$LONGWORD$$LONGWORD(PLT)
	ldr	r1,[r11, #-48]
	str	r0,[r1, #4]
# [68] end;
	ldmea	r11,{r11,r13,r15}
.Le0:
	.size	ZGL_THREADS_$$_THREAD_CREATE$ZGLTTHREAD$TTHREADFUNC$POINTER, .Le0 - ZGL_THREADS_$$_THREAD_CREATE$ZGLTTHREAD$TTHREADFUNC$POINTER

.section .text.n_zgl_threads_$$_thread_close$zgltthread
	.balign 4
.globl	ZGL_THREADS_$$_THREAD_CLOSE$ZGLTTHREAD
	.type	ZGL_THREADS_$$_THREAD_CLOSE$ZGLTTHREAD,#function
ZGL_THREADS_$$_THREAD_CLOSE$ZGLTTHREAD:
# [71] begin
	mov	r12,r13
	stmfd	r13!,{r11,r12,r14,r15}
	sub	r11,r12,#4
	sub	r13,r13,#48
# Var Thread located at r11-48, size=OS_32
	str	r0,[r11, #-48]
# [73] CloseThread(Thread.Handle);
	ldr	r0,[r0, #4]
	bl	SYSTEM_$$_CLOSETHREAD$LONGWORD$$LONGWORD(PLT)
# [77] end;
	ldmea	r11,{r11,r13,r15}
.Le1:
	.size	ZGL_THREADS_$$_THREAD_CLOSE$ZGLTTHREAD, .Le1 - ZGL_THREADS_$$_THREAD_CLOSE$ZGLTTHREAD

.section .text.n_zgl_threads_$$_thread_csinit$trtlcriticalsection
	.balign 4
.globl	ZGL_THREADS_$$_THREAD_CSINIT$TRTLCRITICALSECTION
	.type	ZGL_THREADS_$$_THREAD_CSINIT$TRTLCRITICALSECTION,#function
ZGL_THREADS_$$_THREAD_CSINIT$TRTLCRITICALSECTION:
# [80] begin
	mov	r12,r13
	stmfd	r13!,{r11,r12,r14,r15}
	sub	r11,r12,#4
	sub	r13,r13,#48
# Var CS located at r11-48, size=OS_32
	str	r0,[r11, #-48]
# [82] InitCriticalSection(CS);
	bl	SYSTEM_$$_INITCRITICALSECTION$TRTLCRITICALSECTION(PLT)
# [86] end;
	ldmea	r11,{r11,r13,r15}
.Le2:
	.size	ZGL_THREADS_$$_THREAD_CSINIT$TRTLCRITICALSECTION, .Le2 - ZGL_THREADS_$$_THREAD_CSINIT$TRTLCRITICALSECTION

.section .text.n_zgl_threads_$$_thread_csdone$trtlcriticalsection
	.balign 4
.globl	ZGL_THREADS_$$_THREAD_CSDONE$TRTLCRITICALSECTION
	.type	ZGL_THREADS_$$_THREAD_CSDONE$TRTLCRITICALSECTION,#function
ZGL_THREADS_$$_THREAD_CSDONE$TRTLCRITICALSECTION:
# [89] begin
	mov	r12,r13
	stmfd	r13!,{r11,r12,r14,r15}
	sub	r11,r12,#4
	sub	r13,r13,#48
# Var CS located at r11-48, size=OS_32
	str	r0,[r11, #-48]
# [91] DoneCriticalSection(CS);
	bl	SYSTEM_$$_DONECRITICALSECTION$TRTLCRITICALSECTION(PLT)
# [95] end;
	ldmea	r11,{r11,r13,r15}
.Le3:
	.size	ZGL_THREADS_$$_THREAD_CSDONE$TRTLCRITICALSECTION, .Le3 - ZGL_THREADS_$$_THREAD_CSDONE$TRTLCRITICALSECTION

.section .text.n_zgl_threads_$$_thread_csenter$trtlcriticalsection
	.balign 4
.globl	ZGL_THREADS_$$_THREAD_CSENTER$TRTLCRITICALSECTION
	.type	ZGL_THREADS_$$_THREAD_CSENTER$TRTLCRITICALSECTION,#function
ZGL_THREADS_$$_THREAD_CSENTER$TRTLCRITICALSECTION:
# [98] begin
	mov	r12,r13
	stmfd	r13!,{r11,r12,r14,r15}
	sub	r11,r12,#4
	sub	r13,r13,#48
# Var CS located at r11-48, size=OS_32
	str	r0,[r11, #-48]
# [99] EnterCriticalSection(CS);
	bl	SYSTEM_$$_ENTERCRITICALSECTION$TRTLCRITICALSECTION(PLT)
# [100] end;
	ldmea	r11,{r11,r13,r15}
.Le4:
	.size	ZGL_THREADS_$$_THREAD_CSENTER$TRTLCRITICALSECTION, .Le4 - ZGL_THREADS_$$_THREAD_CSENTER$TRTLCRITICALSECTION

.section .text.n_zgl_threads_$$_thread_csleave$trtlcriticalsection
	.balign 4
.globl	ZGL_THREADS_$$_THREAD_CSLEAVE$TRTLCRITICALSECTION
	.type	ZGL_THREADS_$$_THREAD_CSLEAVE$TRTLCRITICALSECTION,#function
ZGL_THREADS_$$_THREAD_CSLEAVE$TRTLCRITICALSECTION:
# [103] begin
	mov	r12,r13
	stmfd	r13!,{r11,r12,r14,r15}
	sub	r11,r12,#4
	sub	r13,r13,#48
# Var CS located at r11-48, size=OS_32
	str	r0,[r11, #-48]
# [104] LeaveCriticalSection(CS);
	bl	SYSTEM_$$_LEAVECRITICALSECTION$TRTLCRITICALSECTION(PLT)
# [105] end;
	ldmea	r11,{r11,r13,r15}
.Le5:
	.size	ZGL_THREADS_$$_THREAD_CSLEAVE$TRTLCRITICALSECTION, .Le5 - ZGL_THREADS_$$_THREAD_CSLEAVE$TRTLCRITICALSECTION

.section .text.n_zgl_threads_$$_thread_eventcreate$pointer
	.balign 4
.globl	ZGL_THREADS_$$_THREAD_EVENTCREATE$POINTER
	.type	ZGL_THREADS_$$_THREAD_EVENTCREATE$POINTER,#function
ZGL_THREADS_$$_THREAD_EVENTCREATE$POINTER:
# [108] begin
	mov	r12,r13
	stmfd	r13!,{r11,r12,r14,r15}
	sub	r11,r12,#4
	sub	r13,r13,#48
# Var Event located at r11-48, size=OS_32
	str	r0,[r11, #-48]
# [110] Event := Pointer(RTLEventCreate());
	bl	SYSTEM_$$_RTLEVENTCREATE$$PRTLEVENT(PLT)
	ldr	r1,[r11, #-48]
	str	r0,[r1]
# [114] end;
	ldmea	r11,{r11,r13,r15}
.Le6:
	.size	ZGL_THREADS_$$_THREAD_EVENTCREATE$POINTER, .Le6 - ZGL_THREADS_$$_THREAD_EVENTCREATE$POINTER

.section .text.n_zgl_threads_$$_thread_eventdestroy$pointer
	.balign 4
.globl	ZGL_THREADS_$$_THREAD_EVENTDESTROY$POINTER
	.type	ZGL_THREADS_$$_THREAD_EVENTDESTROY$POINTER,#function
ZGL_THREADS_$$_THREAD_EVENTDESTROY$POINTER:
# [117] begin
	mov	r12,r13
	stmfd	r13!,{r11,r12,r14,r15}
	sub	r11,r12,#4
	sub	r13,r13,#48
# Var Event located at r11-48, size=OS_32
	str	r0,[r11, #-48]
# [119] RTLEventDestroy(PRTLEvent(Event));
	ldr	r0,[r0]
	bl	SYSTEM_$$_RTLEVENTDESTROY$PRTLEVENT(PLT)
# [123] Event := nil;
	ldr	r0,[r11, #-48]
	mov	r1,#0
	str	r1,[r0]
# [124] end;
	ldmea	r11,{r11,r13,r15}
.Le7:
	.size	ZGL_THREADS_$$_THREAD_EVENTDESTROY$POINTER, .Le7 - ZGL_THREADS_$$_THREAD_EVENTDESTROY$POINTER

.section .text.n_zgl_threads_$$_thread_eventset$pointer
	.balign 4
.globl	ZGL_THREADS_$$_THREAD_EVENTSET$POINTER
	.type	ZGL_THREADS_$$_THREAD_EVENTSET$POINTER,#function
ZGL_THREADS_$$_THREAD_EVENTSET$POINTER:
# [127] begin
	mov	r12,r13
	stmfd	r13!,{r11,r12,r14,r15}
	sub	r11,r12,#4
	sub	r13,r13,#48
# Var Event located at r11-48, size=OS_32
	str	r0,[r11, #-48]
# [129] RTLEventSetEvent(PRTLEvent(Event));
	ldr	r0,[r0]
	bl	SYSTEM_$$_RTLEVENTSETEVENT$PRTLEVENT(PLT)
# [133] end;
	ldmea	r11,{r11,r13,r15}
.Le8:
	.size	ZGL_THREADS_$$_THREAD_EVENTSET$POINTER, .Le8 - ZGL_THREADS_$$_THREAD_EVENTSET$POINTER

.section .text.n_zgl_threads_$$_thread_eventreset$pointer
	.balign 4
.globl	ZGL_THREADS_$$_THREAD_EVENTRESET$POINTER
	.type	ZGL_THREADS_$$_THREAD_EVENTRESET$POINTER,#function
ZGL_THREADS_$$_THREAD_EVENTRESET$POINTER:
# [136] begin
	mov	r12,r13
	stmfd	r13!,{r11,r12,r14,r15}
	sub	r11,r12,#4
	sub	r13,r13,#48
# Var Event located at r11-48, size=OS_32
	str	r0,[r11, #-48]
# [138] RTLEventResetEvent(PRTLEvent(Event));
	ldr	r0,[r0]
	bl	SYSTEM_$$_RTLEVENTRESETEVENT$PRTLEVENT(PLT)
# [142] end;
	ldmea	r11,{r11,r13,r15}
.Le9:
	.size	ZGL_THREADS_$$_THREAD_EVENTRESET$POINTER, .Le9 - ZGL_THREADS_$$_THREAD_EVENTRESET$POINTER

.section .text.n_zgl_threads_$$_thread_eventwait$pointer$longword
	.balign 4
.globl	ZGL_THREADS_$$_THREAD_EVENTWAIT$POINTER$LONGWORD
	.type	ZGL_THREADS_$$_THREAD_EVENTWAIT$POINTER$LONGWORD,#function
ZGL_THREADS_$$_THREAD_EVENTWAIT$POINTER$LONGWORD:
# [145] begin
	mov	r12,r13
	stmfd	r13!,{r11,r12,r14,r15}
	sub	r11,r12,#4
	sub	r13,r13,#56
# Var Event located at r11-48, size=OS_32
# Var Milliseconds located at r11-52, size=OS_32
	str	r0,[r11, #-48]
	str	r1,[r11, #-52]
# [147] if Milliseconds = $FFFFFFFF Then
	mov	r0,r1
	mvn	r1,#0
	cmp	r0,r1
	bne	.Lj26
# [148] RTLeventWaitFor(PRTLEvent(Event))
	ldr	r0,[r11, #-48]
	ldr	r0,[r0]
	bl	SYSTEM_$$_RTLEVENTWAITFOR$PRTLEVENT(PLT)
	b	.Lj27
.Lj26:
# [150] RTLeventWaitFor(PRTLEvent(Event), Milliseconds);
	ldr	r0,[r11, #-48]
	ldr	r0,[r0]
	ldr	r1,[r11, #-52]
	bl	SYSTEM_$$_RTLEVENTWAITFOR$PRTLEVENT$LONGINT(PLT)
.Lj27:
# [154] end;
	ldmea	r11,{r11,r13,r15}
.Le10:
	.size	ZGL_THREADS_$$_THREAD_EVENTWAIT$POINTER$LONGWORD, .Le10 - ZGL_THREADS_$$_THREAD_EVENTWAIT$POINTER$LONGWORD
# End asmlist al_procedures
# Begin asmlist al_rtti

.section .data.rel.ro.n_INIT_$ZGL_THREADS_$$_ZGLTTHREAD
	.balign 8
.globl	INIT_$ZGL_THREADS_$$_ZGLTTHREAD
	.type	INIT_$ZGL_THREADS_$$_ZGLTTHREAD,#object
INIT_$ZGL_THREADS_$$_ZGLTTHREAD:
	.byte	13,10
# [157] 
	.ascii	"zglTThread"
	.byte	0,0,0,0
	.long	0,8,0,0,0
	.byte	0,0,0,0
.Le11:
	.size	INIT_$ZGL_THREADS_$$_ZGLTTHREAD, .Le11 - INIT_$ZGL_THREADS_$$_ZGLTTHREAD

.section .data.rel.ro.n_RTTI_$ZGL_THREADS_$$_ZGLTTHREAD
	.balign 8
.globl	RTTI_$ZGL_THREADS_$$_ZGLTTHREAD
	.type	RTTI_$ZGL_THREADS_$$_ZGLTTHREAD,#object
RTTI_$ZGL_THREADS_$$_ZGLTTHREAD:
	.byte	13,10
	.ascii	"zglTThread"
	.byte	0,0,0,0
	.long	INIT_$ZGL_THREADS_$$_ZGLTTHREAD
	.long	8,2
	.long	RTTI_$SYSTEM_$$_LONGWORD$indirect
	.long	0
	.long	RTTI_$SYSTEM_$$_LONGWORD$indirect
	.long	4
	.byte	0,0,0,0
.Le12:
	.size	RTTI_$ZGL_THREADS_$$_ZGLTTHREAD, .Le12 - RTTI_$ZGL_THREADS_$$_ZGLTTHREAD
# End asmlist al_rtti
# Begin asmlist al_indirectglobals

.section .data.rel.ro.n_INIT_$ZGL_THREADS_$$_ZGLTTHREAD
	.balign 4
.globl	INIT_$ZGL_THREADS_$$_ZGLTTHREAD$indirect
	.type	INIT_$ZGL_THREADS_$$_ZGLTTHREAD$indirect,#object
INIT_$ZGL_THREADS_$$_ZGLTTHREAD$indirect:
	.long	INIT_$ZGL_THREADS_$$_ZGLTTHREAD
.Le13:
	.size	INIT_$ZGL_THREADS_$$_ZGLTTHREAD$indirect, .Le13 - INIT_$ZGL_THREADS_$$_ZGLTTHREAD$indirect

.section .data.rel.ro.n_RTTI_$ZGL_THREADS_$$_ZGLTTHREAD
	.balign 4
.globl	RTTI_$ZGL_THREADS_$$_ZGLTTHREAD$indirect
	.type	RTTI_$ZGL_THREADS_$$_ZGLTTHREAD$indirect,#object
RTTI_$ZGL_THREADS_$$_ZGLTTHREAD$indirect:
	.long	RTTI_$ZGL_THREADS_$$_ZGLTTHREAD
.Le14:
	.size	RTTI_$ZGL_THREADS_$$_ZGLTTHREAD$indirect, .Le14 - RTTI_$ZGL_THREADS_$$_ZGLTTHREAD$indirect
# End asmlist al_indirectglobals
.section .note.GNU-stack,"",%progbits

