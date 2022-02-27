	.file "jni.pas"
# Begin asmlist al_procedures

.section .text.n_jni_$$_jni_onload$pjavavm$pointer$$longint
	.balign 4
	.type	JNI_$$_JNI_ONLOAD$PJAVAVM$POINTER$$LONGINT,#function
JNI_$$_JNI_ONLOAD$PJAVAVM$POINTER$$LONGINT:
# [jni.pas]
# [524] begin
	mov	r12,r13
	stmfd	r13!,{r11,r12,r14,r15}
	sub	r11,r12,#4
	sub	r13,r13,#56
	ldr	r12,_$JNI$_Ld1
.La1:
	add	r2,r15,r12
# Var vm located at r11-48, size=OS_32
# Var reserved located at r11-52, size=OS_32
# Var $result located at r11-56, size=OS_S32
	str	r0,[r11, #-48]
	str	r1,[r11, #-52]
# [525] curVM := vm;
	ldr	r1,[r11, #-48]
	ldr	r0,.Lj5
	ldr	r0,[r2, r0]
	str	r1,[r0]
# [526] result := JNI_VERSION_1_6;
	mov	r0,#6
	orr	r0,r0,#65536
	str	r0,[r11, #-56]
# [527] end;
	ldmea	r11,{r11,r13,r15}
.globl	_$JNI$_Ld1
_$JNI$_Ld1:
	.long	_GLOBAL_OFFSET_TABLE_-.La1-8
.Lj5:
	.word	TC_$JNI_$$_CURVM(GOT)
.Le0:
	.size	JNI_$$_JNI_ONLOAD$PJAVAVM$POINTER$$LONGINT, .Le0 - JNI_$$_JNI_ONLOAD$PJAVAVM$POINTER$$LONGINT

.section .text.n_jni_$$_jni_onunload$pjavavm$pointer
	.balign 4
	.type	JNI_$$_JNI_ONUNLOAD$PJAVAVM$POINTER,#function
JNI_$$_JNI_ONUNLOAD$PJAVAVM$POINTER:
# [530] begin
	mov	r12,r13
	stmfd	r13!,{r11,r12,r14,r15}
	sub	r11,r12,#4
	sub	r13,r13,#56
# Var vm located at r11-48, size=OS_32
# Var reserved located at r11-52, size=OS_32
	str	r0,[r11, #-48]
	str	r1,[r11, #-52]
# [531] end;
	ldmea	r11,{r11,r13,r15}
.Le1:
	.size	JNI_$$_JNI_ONUNLOAD$PJAVAVM$POINTER, .Le1 - JNI_$$_JNI_ONUNLOAD$PJAVAVM$POINTER
# End asmlist al_procedures
# Begin asmlist al_typedconsts

.section .data.rel.n_TC_$JNI_$$_CURVM
	.balign 4
.globl	TC_$JNI_$$_CURVM
	.type	TC_$JNI_$$_CURVM,#object
TC_$JNI_$$_CURVM:
	.long	0
# [515] curEnv: PJNIEnv = nil;
.Le2:
	.size	TC_$JNI_$$_CURVM, .Le2 - TC_$JNI_$$_CURVM

.section .data.rel.n_TC_$JNI_$$_CURENV
	.balign 4
.globl	TC_$JNI_$$_CURENV
	.type	TC_$JNI_$$_CURENV,#object
TC_$JNI_$$_CURENV:
	.long	0
# [521] implementation
.Le3:
	.size	TC_$JNI_$$_CURENV, .Le3 - TC_$JNI_$$_CURENV
# End asmlist al_typedconsts
# Begin asmlist al_rtti

.section .data.rel.ro.n_RTTI_$JNI_$$_PJBOOLEAN
	.balign 8
.globl	RTTI_$JNI_$$_PJBOOLEAN
	.type	RTTI_$JNI_$$_PJBOOLEAN,#object
RTTI_$JNI_$$_PJBOOLEAN:
	.byte	29,9
# [536] 
	.ascii	"Pjboolean"
	.byte	0,0,0,0,0
	.long	RTTI_$SYSTEM_$$_BYTE$indirect
	.byte	0,0,0,0
.Le4:
	.size	RTTI_$JNI_$$_PJBOOLEAN, .Le4 - RTTI_$JNI_$$_PJBOOLEAN

.section .data.rel.ro.n_RTTI_$JNI_$$_PJBYTE
	.balign 8
.globl	RTTI_$JNI_$$_PJBYTE
	.type	RTTI_$JNI_$$_PJBYTE,#object
RTTI_$JNI_$$_PJBYTE:
	.byte	29,6
	.ascii	"Pjbyte"
	.long	RTTI_$SYSTEM_$$_SHORTINT$indirect
	.byte	0,0,0,0
.Le5:
	.size	RTTI_$JNI_$$_PJBYTE, .Le5 - RTTI_$JNI_$$_PJBYTE

.section .data.rel.ro.n_RTTI_$JNI_$$_PJCHAR
	.balign 8
.globl	RTTI_$JNI_$$_PJCHAR
	.type	RTTI_$JNI_$$_PJCHAR,#object
RTTI_$JNI_$$_PJCHAR:
	.byte	29,6
	.ascii	"Pjchar"
	.long	RTTI_$SYSTEM_$$_WORD$indirect
	.byte	0,0,0,0
.Le6:
	.size	RTTI_$JNI_$$_PJCHAR, .Le6 - RTTI_$JNI_$$_PJCHAR

.section .data.rel.ro.n_RTTI_$JNI_$$_PJSHORT
	.balign 8
.globl	RTTI_$JNI_$$_PJSHORT
	.type	RTTI_$JNI_$$_PJSHORT,#object
RTTI_$JNI_$$_PJSHORT:
	.byte	29,7
	.ascii	"Pjshort"
	.byte	0,0,0,0,0,0,0
	.long	RTTI_$SYSTEM_$$_SMALLINT$indirect
	.byte	0,0,0,0
.Le7:
	.size	RTTI_$JNI_$$_PJSHORT, .Le7 - RTTI_$JNI_$$_PJSHORT

.section .data.rel.ro.n_RTTI_$JNI_$$_PJINT
	.balign 8
.globl	RTTI_$JNI_$$_PJINT
	.type	RTTI_$JNI_$$_PJINT,#object
RTTI_$JNI_$$_PJINT:
	.byte	29,5
	.ascii	"Pjint"
	.byte	0
	.long	RTTI_$SYSTEM_$$_LONGINT$indirect
	.byte	0,0,0,0
.Le8:
	.size	RTTI_$JNI_$$_PJINT, .Le8 - RTTI_$JNI_$$_PJINT

.section .data.rel.ro.n_RTTI_$JNI_$$_PJLONG
	.balign 8
.globl	RTTI_$JNI_$$_PJLONG
	.type	RTTI_$JNI_$$_PJLONG,#object
RTTI_$JNI_$$_PJLONG:
	.byte	29,6
	.ascii	"Pjlong"
	.long	RTTI_$SYSTEM_$$_INT64$indirect
	.byte	0,0,0,0
.Le9:
	.size	RTTI_$JNI_$$_PJLONG, .Le9 - RTTI_$JNI_$$_PJLONG

.section .data.rel.ro.n_RTTI_$JNI_$$_PJFLOAT
	.balign 8
.globl	RTTI_$JNI_$$_PJFLOAT
	.type	RTTI_$JNI_$$_PJFLOAT,#object
RTTI_$JNI_$$_PJFLOAT:
	.byte	29,7
	.ascii	"Pjfloat"
	.byte	0,0,0,0,0,0,0
	.long	RTTI_$SYSTEM_$$_SINGLE$indirect
	.byte	0,0,0,0
.Le10:
	.size	RTTI_$JNI_$$_PJFLOAT, .Le10 - RTTI_$JNI_$$_PJFLOAT

.section .data.rel.ro.n_RTTI_$JNI_$$_PJDOUBLE
	.balign 8
.globl	RTTI_$JNI_$$_PJDOUBLE
	.type	RTTI_$JNI_$$_PJDOUBLE,#object
RTTI_$JNI_$$_PJDOUBLE:
	.byte	29,8
	.ascii	"Pjdouble"
	.byte	0,0,0,0,0,0
	.long	RTTI_$SYSTEM_$$_DOUBLE$indirect
	.byte	0,0,0,0
.Le11:
	.size	RTTI_$JNI_$$_PJDOUBLE, .Le11 - RTTI_$JNI_$$_PJDOUBLE

.section .data.rel.ro.n_RTTI_$JNI_$$_PJSIZE
	.balign 8
.globl	RTTI_$JNI_$$_PJSIZE
	.type	RTTI_$JNI_$$_PJSIZE,#object
RTTI_$JNI_$$_PJSIZE:
	.byte	29,6
	.ascii	"Pjsize"
	.long	RTTI_$SYSTEM_$$_LONGINT$indirect
	.byte	0,0,0,0
.Le12:
	.size	RTTI_$JNI_$$_PJSIZE, .Le12 - RTTI_$JNI_$$_PJSIZE

.section .data.rel.ro.n_RTTI_$JNI_$$_PPOINTER
	.balign 8
.globl	RTTI_$JNI_$$_PPOINTER
	.type	RTTI_$JNI_$$_PPOINTER,#object
RTTI_$JNI_$$_PPOINTER:
	.byte	29,8
	.ascii	"PPointer"
	.byte	0,0,0,0,0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	0,0,0,0
.Le13:
	.size	RTTI_$JNI_$$_PPOINTER, .Le13 - RTTI_$JNI_$$_PPOINTER

.section .data.rel.ro.n_RTTI_$JNI_$$_PJOBJECT
	.balign 8
.globl	RTTI_$JNI_$$_PJOBJECT
	.type	RTTI_$JNI_$$_PJOBJECT,#object
RTTI_$JNI_$$_PJOBJECT:
	.byte	29,8
	.ascii	"Pjobject"
	.byte	0,0,0,0,0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	0,0,0,0
.Le14:
	.size	RTTI_$JNI_$$_PJOBJECT, .Le14 - RTTI_$JNI_$$_PJOBJECT

.section .data.rel.ro.n_RTTI_$JNI_$$_PJCLASS
	.balign 8
.globl	RTTI_$JNI_$$_PJCLASS
	.type	RTTI_$JNI_$$_PJCLASS,#object
RTTI_$JNI_$$_PJCLASS:
	.byte	29,7
	.ascii	"Pjclass"
	.byte	0,0,0,0,0,0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	0,0,0,0
.Le15:
	.size	RTTI_$JNI_$$_PJCLASS, .Le15 - RTTI_$JNI_$$_PJCLASS

.section .data.rel.ro.n_RTTI_$JNI_$$_PJSTRING
	.balign 8
.globl	RTTI_$JNI_$$_PJSTRING
	.type	RTTI_$JNI_$$_PJSTRING,#object
RTTI_$JNI_$$_PJSTRING:
	.byte	29,8
	.ascii	"Pjstring"
	.byte	0,0,0,0,0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	0,0,0,0
.Le16:
	.size	RTTI_$JNI_$$_PJSTRING, .Le16 - RTTI_$JNI_$$_PJSTRING

.section .data.rel.ro.n_RTTI_$JNI_$$_PJARRAY
	.balign 8
.globl	RTTI_$JNI_$$_PJARRAY
	.type	RTTI_$JNI_$$_PJARRAY,#object
RTTI_$JNI_$$_PJARRAY:
	.byte	29,7
	.ascii	"Pjarray"
	.byte	0,0,0,0,0,0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	0,0,0,0
.Le17:
	.size	RTTI_$JNI_$$_PJARRAY, .Le17 - RTTI_$JNI_$$_PJARRAY

.section .data.rel.ro.n_RTTI_$JNI_$$_PJOBJECTARRAY
	.balign 8
.globl	RTTI_$JNI_$$_PJOBJECTARRAY
	.type	RTTI_$JNI_$$_PJOBJECTARRAY,#object
RTTI_$JNI_$$_PJOBJECTARRAY:
	.byte	29,13
	.ascii	"PjobjectArray"
	.byte	0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	0,0,0,0
.Le18:
	.size	RTTI_$JNI_$$_PJOBJECTARRAY, .Le18 - RTTI_$JNI_$$_PJOBJECTARRAY

.section .data.rel.ro.n_RTTI_$JNI_$$_PJBOOLEANARRAY
	.balign 8
.globl	RTTI_$JNI_$$_PJBOOLEANARRAY
	.type	RTTI_$JNI_$$_PJBOOLEANARRAY,#object
RTTI_$JNI_$$_PJBOOLEANARRAY:
	.byte	29,14
	.ascii	"PjbooleanArray"
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	0,0,0,0
.Le19:
	.size	RTTI_$JNI_$$_PJBOOLEANARRAY, .Le19 - RTTI_$JNI_$$_PJBOOLEANARRAY

.section .data.rel.ro.n_RTTI_$JNI_$$_PJBYTEARRAY
	.balign 8
.globl	RTTI_$JNI_$$_PJBYTEARRAY
	.type	RTTI_$JNI_$$_PJBYTEARRAY,#object
RTTI_$JNI_$$_PJBYTEARRAY:
	.byte	29,11
	.ascii	"PjbyteArray"
	.byte	0,0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	0,0,0,0
.Le20:
	.size	RTTI_$JNI_$$_PJBYTEARRAY, .Le20 - RTTI_$JNI_$$_PJBYTEARRAY

.section .data.rel.ro.n_RTTI_$JNI_$$_PJCHARARRAY
	.balign 8
.globl	RTTI_$JNI_$$_PJCHARARRAY
	.type	RTTI_$JNI_$$_PJCHARARRAY,#object
RTTI_$JNI_$$_PJCHARARRAY:
	.byte	29,11
	.ascii	"PjcharArray"
	.byte	0,0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	0,0,0,0
.Le21:
	.size	RTTI_$JNI_$$_PJCHARARRAY, .Le21 - RTTI_$JNI_$$_PJCHARARRAY

.section .data.rel.ro.n_RTTI_$JNI_$$_PJSHORTARRAY
	.balign 8
.globl	RTTI_$JNI_$$_PJSHORTARRAY
	.type	RTTI_$JNI_$$_PJSHORTARRAY,#object
RTTI_$JNI_$$_PJSHORTARRAY:
	.byte	29,12
	.ascii	"PjshortArray"
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	0,0,0,0
.Le22:
	.size	RTTI_$JNI_$$_PJSHORTARRAY, .Le22 - RTTI_$JNI_$$_PJSHORTARRAY

.section .data.rel.ro.n_RTTI_$JNI_$$_PJINTARRAY
	.balign 8
.globl	RTTI_$JNI_$$_PJINTARRAY
	.type	RTTI_$JNI_$$_PJINTARRAY,#object
RTTI_$JNI_$$_PJINTARRAY:
	.byte	29,10
	.ascii	"PjintArray"
	.byte	0,0,0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	0,0,0,0
.Le23:
	.size	RTTI_$JNI_$$_PJINTARRAY, .Le23 - RTTI_$JNI_$$_PJINTARRAY

.section .data.rel.ro.n_RTTI_$JNI_$$_PJLONGARRAY
	.balign 8
.globl	RTTI_$JNI_$$_PJLONGARRAY
	.type	RTTI_$JNI_$$_PJLONGARRAY,#object
RTTI_$JNI_$$_PJLONGARRAY:
	.byte	29,11
	.ascii	"PjlongArray"
	.byte	0,0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	0,0,0,0
.Le24:
	.size	RTTI_$JNI_$$_PJLONGARRAY, .Le24 - RTTI_$JNI_$$_PJLONGARRAY

.section .data.rel.ro.n_RTTI_$JNI_$$_PJFLOATARRAY
	.balign 8
.globl	RTTI_$JNI_$$_PJFLOATARRAY
	.type	RTTI_$JNI_$$_PJFLOATARRAY,#object
RTTI_$JNI_$$_PJFLOATARRAY:
	.byte	29,12
	.ascii	"PjfloatArray"
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	0,0,0,0
.Le25:
	.size	RTTI_$JNI_$$_PJFLOATARRAY, .Le25 - RTTI_$JNI_$$_PJFLOATARRAY

.section .data.rel.ro.n_RTTI_$JNI_$$_PJDOUBLEARRAY
	.balign 8
.globl	RTTI_$JNI_$$_PJDOUBLEARRAY
	.type	RTTI_$JNI_$$_PJDOUBLEARRAY,#object
RTTI_$JNI_$$_PJDOUBLEARRAY:
	.byte	29,13
	.ascii	"PjdoubleArray"
	.byte	0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	0,0,0,0
.Le26:
	.size	RTTI_$JNI_$$_PJDOUBLEARRAY, .Le26 - RTTI_$JNI_$$_PJDOUBLEARRAY

.section .data.rel.ro.n_RTTI_$JNI_$$_PJTHROWABLE
	.balign 8
.globl	RTTI_$JNI_$$_PJTHROWABLE
	.type	RTTI_$JNI_$$_PJTHROWABLE,#object
RTTI_$JNI_$$_PJTHROWABLE:
	.byte	29,11
	.ascii	"Pjthrowable"
	.byte	0,0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	0,0,0,0
.Le27:
	.size	RTTI_$JNI_$$_PJTHROWABLE, .Le27 - RTTI_$JNI_$$_PJTHROWABLE

.section .data.rel.ro.n_RTTI_$JNI_$$_PJWEAK
	.balign 8
.globl	RTTI_$JNI_$$_PJWEAK
	.type	RTTI_$JNI_$$_PJWEAK,#object
RTTI_$JNI_$$_PJWEAK:
	.byte	29,6
	.ascii	"Pjweak"
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	0,0,0,0
.Le28:
	.size	RTTI_$JNI_$$_PJWEAK, .Le28 - RTTI_$JNI_$$_PJWEAK

.section .data.rel.ro.n_RTTI_$JNI_$$_PJREF
	.balign 8
.globl	RTTI_$JNI_$$_PJREF
	.type	RTTI_$JNI_$$_PJREF,#object
RTTI_$JNI_$$_PJREF:
	.byte	29,5
	.ascii	"Pjref"
	.byte	0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	0,0,0,0
.Le29:
	.size	RTTI_$JNI_$$_PJREF, .Le29 - RTTI_$JNI_$$_PJREF

.section .data.rel.ro.n_INIT_$JNI_$$__JFIELDID
	.balign 8
.globl	INIT_$JNI_$$__JFIELDID
	.type	INIT_$JNI_$$__JFIELDID,#object
INIT_$JNI_$$__JFIELDID:
	.byte	13,9
	.ascii	"_jfieldID"
	.byte	0,0,0,0,0
	.long	0,0,0,0,0
	.byte	0,0,0,0
.Le30:
	.size	INIT_$JNI_$$__JFIELDID, .Le30 - INIT_$JNI_$$__JFIELDID

.section .data.rel.ro.n_RTTI_$JNI_$$__JFIELDID
	.balign 8
.globl	RTTI_$JNI_$$__JFIELDID
	.type	RTTI_$JNI_$$__JFIELDID,#object
RTTI_$JNI_$$__JFIELDID:
	.byte	13,9
	.ascii	"_jfieldID"
	.byte	0,0,0,0,0
	.long	INIT_$JNI_$$__JFIELDID
	.long	0,0
	.byte	0,0,0,0
.Le31:
	.size	RTTI_$JNI_$$__JFIELDID, .Le31 - RTTI_$JNI_$$__JFIELDID

.section .data.rel.ro.n_RTTI_$JNI_$$_JFIELDID
	.balign 8
.globl	RTTI_$JNI_$$_JFIELDID
	.type	RTTI_$JNI_$$_JFIELDID,#object
RTTI_$JNI_$$_JFIELDID:
	.byte	29,8
	.ascii	"jfieldID"
	.byte	0,0,0,0,0,0
	.long	RTTI_$JNI_$$__JFIELDID$indirect
	.byte	0,0,0,0
.Le32:
	.size	RTTI_$JNI_$$_JFIELDID, .Le32 - RTTI_$JNI_$$_JFIELDID

.section .data.rel.ro.n_RTTI_$JNI_$$_PJFIELDID
	.balign 8
.globl	RTTI_$JNI_$$_PJFIELDID
	.type	RTTI_$JNI_$$_PJFIELDID,#object
RTTI_$JNI_$$_PJFIELDID:
	.byte	29,9
	.ascii	"PjfieldID"
	.byte	0,0,0,0,0
	.long	RTTI_$JNI_$$_JFIELDID$indirect
	.byte	0,0,0,0
.Le33:
	.size	RTTI_$JNI_$$_PJFIELDID, .Le33 - RTTI_$JNI_$$_PJFIELDID

.section .data.rel.ro.n_INIT_$JNI_$$__JMETHODID
	.balign 8
.globl	INIT_$JNI_$$__JMETHODID
	.type	INIT_$JNI_$$__JMETHODID,#object
INIT_$JNI_$$__JMETHODID:
	.byte	13,10
	.ascii	"_jmethodID"
	.byte	0,0,0,0
	.long	0,0,0,0,0
	.byte	0,0,0,0
.Le34:
	.size	INIT_$JNI_$$__JMETHODID, .Le34 - INIT_$JNI_$$__JMETHODID

.section .data.rel.ro.n_RTTI_$JNI_$$__JMETHODID
	.balign 8
.globl	RTTI_$JNI_$$__JMETHODID
	.type	RTTI_$JNI_$$__JMETHODID,#object
RTTI_$JNI_$$__JMETHODID:
	.byte	13,10
	.ascii	"_jmethodID"
	.byte	0,0,0,0
	.long	INIT_$JNI_$$__JMETHODID
	.long	0,0
	.byte	0,0,0,0
.Le35:
	.size	RTTI_$JNI_$$__JMETHODID, .Le35 - RTTI_$JNI_$$__JMETHODID

.section .data.rel.ro.n_RTTI_$JNI_$$_JMETHODID
	.balign 8
.globl	RTTI_$JNI_$$_JMETHODID
	.type	RTTI_$JNI_$$_JMETHODID,#object
RTTI_$JNI_$$_JMETHODID:
	.byte	29,9
	.ascii	"jmethodID"
	.byte	0,0,0,0,0
	.long	RTTI_$JNI_$$__JMETHODID$indirect
	.byte	0,0,0,0
.Le36:
	.size	RTTI_$JNI_$$_JMETHODID, .Le36 - RTTI_$JNI_$$_JMETHODID

.section .data.rel.ro.n_RTTI_$JNI_$$_PJMETHODID
	.balign 8
.globl	RTTI_$JNI_$$_PJMETHODID
	.type	RTTI_$JNI_$$_PJMETHODID,#object
RTTI_$JNI_$$_PJMETHODID:
	.byte	29,10
	.ascii	"PjmethodID"
	.byte	0,0,0,0
	.long	RTTI_$JNI_$$_JMETHODID$indirect
	.byte	0,0,0,0
.Le37:
	.size	RTTI_$JNI_$$_PJMETHODID, .Le37 - RTTI_$JNI_$$_PJMETHODID

.section .data.rel.ro.n_INIT_$JNI_$$_JNIINVOKEINTERFACE
	.balign 8
.globl	INIT_$JNI_$$_JNIINVOKEINTERFACE
	.type	INIT_$JNI_$$_JNIINVOKEINTERFACE,#object
INIT_$JNI_$$_JNIINVOKEINTERFACE:
	.byte	13,18
	.ascii	"JNIInvokeInterface"
	.byte	0,0,0,0
	.long	0,32,0,0,0
	.byte	0,0,0,0
.Le38:
	.size	INIT_$JNI_$$_JNIINVOKEINTERFACE, .Le38 - INIT_$JNI_$$_JNIINVOKEINTERFACE

.section .data.rel.ro.n_RTTI_$JNI_$$_JAVAVM
	.balign 8
.globl	RTTI_$JNI_$$_JAVAVM
	.type	RTTI_$JNI_$$_JAVAVM,#object
RTTI_$JNI_$$_JAVAVM:
	.byte	29,6
	.ascii	"JavaVM"
	.long	RTTI_$JNI_$$_JNIINVOKEINTERFACE$indirect
	.byte	0,0,0,0
.Le39:
	.size	RTTI_$JNI_$$_JAVAVM, .Le39 - RTTI_$JNI_$$_JAVAVM

.section .data.rel.ro.n_RTTI_$JNI_$$_PJAVAVM
	.balign 8
.globl	RTTI_$JNI_$$_PJAVAVM
	.type	RTTI_$JNI_$$_PJAVAVM,#object
RTTI_$JNI_$$_PJAVAVM:
	.byte	29,7
	.ascii	"PJavaVM"
	.byte	0,0,0,0,0,0,0
	.long	RTTI_$JNI_$$_JAVAVM$indirect
	.byte	0,0,0,0
.Le40:
	.size	RTTI_$JNI_$$_PJAVAVM, .Le40 - RTTI_$JNI_$$_PJAVAVM

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000118
	.balign 8
.globl	RTTI_$JNI_$$_def00000118
	.type	RTTI_$JNI_$$_def00000118,#object
RTTI_$JNI_$$_def00000118:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_LONGINT$indirect
	.byte	1,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJAVAVM$indirect
	.byte	3
	.ascii	"PVM"
.Le41:
	.size	RTTI_$JNI_$$_def00000118, .Le41 - RTTI_$JNI_$$_def00000118

.section .data.rel.ro.n_INIT_$JNI_$$_JNINATIVEINTERFACE
	.balign 8
.globl	INIT_$JNI_$$_JNINATIVEINTERFACE
	.type	INIT_$JNI_$$_JNINATIVEINTERFACE,#object
INIT_$JNI_$$_JNINATIVEINTERFACE:
	.byte	13,18
	.ascii	"JNINativeInterface"
	.byte	0,0,0,0
	.long	0,932,0,0,0
	.byte	0,0,0,0
.Le42:
	.size	INIT_$JNI_$$_JNINATIVEINTERFACE, .Le42 - INIT_$JNI_$$_JNINATIVEINTERFACE

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000032
	.balign 8
.globl	RTTI_$JNI_$$_def00000032
	.type	RTTI_$JNI_$$_def00000032,#object
RTTI_$JNI_$$_def00000032:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_LONGINT$indirect
	.byte	1,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
.Le43:
	.size	RTTI_$JNI_$$_def00000032, .Le43 - RTTI_$JNI_$$_def00000032

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000033
	.balign 8
.globl	RTTI_$JNI_$$_def00000033
	.type	RTTI_$JNI_$$_def00000033,#object
RTTI_$JNI_$$_def00000033:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	5,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	2
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_PCHAR$indirect
	.byte	4
	.ascii	"Name"
	.byte	0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"Loader"
	.byte	0
	.short	2
	.byte	0,0
	.long	RTTI_$JNI_$$_PJBYTE$indirect
	.byte	3
	.ascii	"Buf"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_LONGINT$indirect
	.byte	3
	.ascii	"Len"
.Le44:
	.size	RTTI_$JNI_$$_def00000033, .Le44 - RTTI_$JNI_$$_def00000033

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000034
	.balign 8
.globl	RTTI_$JNI_$$_def00000034
	.type	RTTI_$JNI_$$_def00000034,#object
RTTI_$JNI_$$_def00000034:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	2,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	2
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_PCHAR$indirect
	.byte	4
	.ascii	"Name"
	.byte	0,0,0
.Le45:
	.size	RTTI_$JNI_$$_def00000034, .Le45 - RTTI_$JNI_$$_def00000034

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000035
	.balign 8
.globl	RTTI_$JNI_$$_def00000035
	.type	RTTI_$JNI_$$_def00000035,#object
RTTI_$JNI_$$_def00000035:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$JNI_$$_JMETHODID$indirect
	.byte	2,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"Method"
	.byte	0
.Le46:
	.size	RTTI_$JNI_$$_def00000035, .Le46 - RTTI_$JNI_$$_def00000035

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000036
	.balign 8
.globl	RTTI_$JNI_$$_def00000036
	.type	RTTI_$JNI_$$_def00000036,#object
RTTI_$JNI_$$_def00000036:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$JNI_$$_JFIELDID$indirect
	.byte	2,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	5
	.ascii	"Field"
	.byte	0,0
.Le47:
	.size	RTTI_$JNI_$$_def00000036, .Le47 - RTTI_$JNI_$$_def00000036

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000037
	.balign 8
.globl	RTTI_$JNI_$$_def00000037
	.type	RTTI_$JNI_$$_def00000037,#object
RTTI_$JNI_$$_def00000037:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	4,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AClass"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JMETHODID$indirect
	.byte	8
	.ascii	"MethodID"
	.byte	0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_BYTE$indirect
	.byte	8
	.ascii	"IsStatic"
	.byte	0,0,0
.Le48:
	.size	RTTI_$JNI_$$_def00000037, .Le48 - RTTI_$JNI_$$_def00000037

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000038
	.balign 8
.globl	RTTI_$JNI_$$_def00000038
	.type	RTTI_$JNI_$$_def00000038,#object
RTTI_$JNI_$$_def00000038:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	2,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Sub"
	.byte	0,0,0,0
.Le49:
	.size	RTTI_$JNI_$$_def00000038, .Le49 - RTTI_$JNI_$$_def00000038

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000039
	.balign 8
.globl	RTTI_$JNI_$$_def00000039
	.type	RTTI_$JNI_$$_def00000039,#object
RTTI_$JNI_$$_def00000039:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_BYTE$indirect
	.byte	3,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Sub"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Sup"
.Le50:
	.size	RTTI_$JNI_$$_def00000039, .Le50 - RTTI_$JNI_$$_def00000039

.section .data.rel.ro.n_RTTI_$JNI_$$_def0000003A
	.balign 8
.globl	RTTI_$JNI_$$_def0000003A
	.type	RTTI_$JNI_$$_def0000003A,#object
RTTI_$JNI_$$_def0000003A:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	4,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AClass"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JFIELDID$indirect
	.byte	7
	.ascii	"FieldID"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_BYTE$indirect
	.byte	8
	.ascii	"IsStatic"
	.byte	0,0,0,0,0,0,0
.Le51:
	.size	RTTI_$JNI_$$_def0000003A, .Le51 - RTTI_$JNI_$$_def0000003A

.section .data.rel.ro.n_RTTI_$JNI_$$_def0000003B
	.balign 8
.globl	RTTI_$JNI_$$_def0000003B
	.type	RTTI_$JNI_$$_def0000003B,#object
RTTI_$JNI_$$_def0000003B:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_LONGINT$indirect
	.byte	2,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Obj"
	.byte	0,0,0,0
.Le52:
	.size	RTTI_$JNI_$$_def0000003B, .Le52 - RTTI_$JNI_$$_def0000003B

.section .data.rel.ro.n_RTTI_$JNI_$$_def0000003C
	.balign 8
.globl	RTTI_$JNI_$$_def0000003C
	.type	RTTI_$JNI_$$_def0000003C,#object
RTTI_$JNI_$$_def0000003C:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_LONGINT$indirect
	.byte	3,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AClass"
	.byte	0
	.short	2
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_PCHAR$indirect
	.byte	3
	.ascii	"Msg"
	.byte	0,0,0,0
.Le53:
	.size	RTTI_$JNI_$$_def0000003C, .Le53 - RTTI_$JNI_$$_def0000003C

.section .data.rel.ro.n_RTTI_$JNI_$$_def0000003D
	.balign 8
.globl	RTTI_$JNI_$$_def0000003D
	.type	RTTI_$JNI_$$_def0000003D,#object
RTTI_$JNI_$$_def0000003D:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	1,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
.Le54:
	.size	RTTI_$JNI_$$_def0000003D, .Le54 - RTTI_$JNI_$$_def0000003D

.section .data.rel.ro.n_RTTI_$JNI_$$_def0000003E
	.balign 8
.globl	RTTI_$JNI_$$_def0000003E
	.type	RTTI_$JNI_$$_def0000003E,#object
RTTI_$JNI_$$_def0000003E:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	0
	.byte	1,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
.Le55:
	.size	RTTI_$JNI_$$_def0000003E, .Le55 - RTTI_$JNI_$$_def0000003E

.section .data.rel.ro.n_RTTI_$JNI_$$_def0000003F
	.balign 8
.globl	RTTI_$JNI_$$_def0000003F
	.type	RTTI_$JNI_$$_def0000003F,#object
RTTI_$JNI_$$_def0000003F:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	0
	.byte	1,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
.Le56:
	.size	RTTI_$JNI_$$_def0000003F, .Le56 - RTTI_$JNI_$$_def0000003F

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000040
	.balign 8
.globl	RTTI_$JNI_$$_def00000040
	.type	RTTI_$JNI_$$_def00000040,#object
RTTI_$JNI_$$_def00000040:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	0
	.byte	2,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	2
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_PCHAR$indirect
	.byte	3
	.ascii	"Msg"
	.byte	0,0,0,0
.Le57:
	.size	RTTI_$JNI_$$_def00000040, .Le57 - RTTI_$JNI_$$_def00000040

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000041
	.balign 8
.globl	RTTI_$JNI_$$_def00000041
	.type	RTTI_$JNI_$$_def00000041,#object
RTTI_$JNI_$$_def00000041:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_LONGINT$indirect
	.byte	2,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_LONGINT$indirect
	.byte	8
	.ascii	"Capacity"
	.byte	0,0,0,0,0,0,0
.Le58:
	.size	RTTI_$JNI_$$_def00000041, .Le58 - RTTI_$JNI_$$_def00000041

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000042
	.balign 8
.globl	RTTI_$JNI_$$_def00000042
	.type	RTTI_$JNI_$$_def00000042,#object
RTTI_$JNI_$$_def00000042:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	2,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"Result"
	.byte	0
.Le59:
	.size	RTTI_$JNI_$$_def00000042, .Le59 - RTTI_$JNI_$$_def00000042

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000043
	.balign 8
.globl	RTTI_$JNI_$$_def00000043
	.type	RTTI_$JNI_$$_def00000043,#object
RTTI_$JNI_$$_def00000043:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	2,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	4
	.ascii	"LObj"
	.byte	0,0,0
.Le60:
	.size	RTTI_$JNI_$$_def00000043, .Le60 - RTTI_$JNI_$$_def00000043

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000044
	.balign 8
.globl	RTTI_$JNI_$$_def00000044
	.type	RTTI_$JNI_$$_def00000044,#object
RTTI_$JNI_$$_def00000044:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	0
	.byte	2,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	4
	.ascii	"GRef"
	.byte	0,0,0
.Le61:
	.size	RTTI_$JNI_$$_def00000044, .Le61 - RTTI_$JNI_$$_def00000044

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000045
	.balign 8
.globl	RTTI_$JNI_$$_def00000045
	.type	RTTI_$JNI_$$_def00000045,#object
RTTI_$JNI_$$_def00000045:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	0
	.byte	2,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Obj"
	.byte	0,0,0,0
.Le62:
	.size	RTTI_$JNI_$$_def00000045, .Le62 - RTTI_$JNI_$$_def00000045

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000046
	.balign 8
.globl	RTTI_$JNI_$$_def00000046
	.type	RTTI_$JNI_$$_def00000046,#object
RTTI_$JNI_$$_def00000046:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_BYTE$indirect
	.byte	3,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	4
	.ascii	"Obj1"
	.byte	0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	4
	.ascii	"Obj2"
	.byte	0,0,0
.Le63:
	.size	RTTI_$JNI_$$_def00000046, .Le63 - RTTI_$JNI_$$_def00000046

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000047
	.balign 8
.globl	RTTI_$JNI_$$_def00000047
	.type	RTTI_$JNI_$$_def00000047,#object
RTTI_$JNI_$$_def00000047:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	2,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Ref"
	.byte	0,0,0,0
.Le64:
	.size	RTTI_$JNI_$$_def00000047, .Le64 - RTTI_$JNI_$$_def00000047

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000048
	.balign 8
.globl	RTTI_$JNI_$$_def00000048
	.type	RTTI_$JNI_$$_def00000048,#object
RTTI_$JNI_$$_def00000048:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	2,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_LONGINT$indirect
	.byte	8
	.ascii	"Capacity"
	.byte	0,0,0,0,0,0,0
.Le65:
	.size	RTTI_$JNI_$$_def00000048, .Le65 - RTTI_$JNI_$$_def00000048

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000049
	.balign 8
.globl	RTTI_$JNI_$$_def00000049
	.type	RTTI_$JNI_$$_def00000049,#object
RTTI_$JNI_$$_def00000049:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	2,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AClass"
	.byte	0
.Le66:
	.size	RTTI_$JNI_$$_def00000049, .Le66 - RTTI_$JNI_$$_def00000049

.section .data.rel.ro.n_RTTI_$JNI_$$_def0000004A
	.balign 8
.globl	RTTI_$JNI_$$_def0000004A
	.type	RTTI_$JNI_$$_def0000004A,#object
RTTI_$JNI_$$_def0000004A:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AClass"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JMETHODID$indirect
	.byte	8
	.ascii	"MethodID"
	.byte	0,0,0,0,0,0,0
.Le67:
	.size	RTTI_$JNI_$$_def0000004A, .Le67 - RTTI_$JNI_$$_def0000004A

.section .data.rel.ro.n_RTTI_$JNI_$$_def0000004B
	.balign 8
.globl	RTTI_$JNI_$$_def0000004B
	.type	RTTI_$JNI_$$_def0000004B,#object
RTTI_$JNI_$$_def0000004B:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	4,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AClass"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JMETHODID$indirect
	.byte	8
	.ascii	"MethodID"
	.byte	0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	4
	.ascii	"Args"
	.byte	0,0,0,0,0,0,0
.Le68:
	.size	RTTI_$JNI_$$_def0000004B, .Le68 - RTTI_$JNI_$$_def0000004B

.section .data.rel.ro.n_INIT_$JNI_$$_JVALUE
	.balign 8
.globl	INIT_$JNI_$$_JVALUE
	.type	INIT_$JNI_$$_JVALUE,#object
INIT_$JNI_$$_JVALUE:
	.byte	13,6
	.ascii	"jvalue"
	.long	0,8,0,0,0
	.byte	0,0,0,0
.Le69:
	.size	INIT_$JNI_$$_JVALUE, .Le69 - INIT_$JNI_$$_JVALUE

.section .data.rel.ro.n_RTTI_$JNI_$$_JVALUE
	.balign 8
.globl	RTTI_$JNI_$$_JVALUE
	.type	RTTI_$JNI_$$_JVALUE,#object
RTTI_$JNI_$$_JVALUE:
	.byte	13,6
	.ascii	"jvalue"
	.long	INIT_$JNI_$$_JVALUE
	.long	8,9
	.long	RTTI_$SYSTEM_$$_BYTE$indirect
	.long	0
	.long	RTTI_$SYSTEM_$$_SHORTINT$indirect
	.long	0
	.long	RTTI_$SYSTEM_$$_WORD$indirect
	.long	0
	.long	RTTI_$SYSTEM_$$_SMALLINT$indirect
	.long	0
	.long	RTTI_$SYSTEM_$$_LONGINT$indirect
	.long	0
	.long	RTTI_$SYSTEM_$$_INT64$indirect
	.long	0
	.long	RTTI_$SYSTEM_$$_SINGLE$indirect
	.long	0
	.long	RTTI_$SYSTEM_$$_DOUBLE$indirect
	.long	0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.long	0
	.byte	0,0,0,0
.Le70:
	.size	RTTI_$JNI_$$_JVALUE, .Le70 - RTTI_$JNI_$$_JVALUE

.section .data.rel.ro.n_RTTI_$JNI_$$_PJVALUE
	.balign 8
.globl	RTTI_$JNI_$$_PJVALUE
	.type	RTTI_$JNI_$$_PJVALUE,#object
RTTI_$JNI_$$_PJVALUE:
	.byte	29,7
	.ascii	"Pjvalue"
	.byte	0,0,0,0,0,0,0
	.long	RTTI_$JNI_$$_JVALUE$indirect
	.byte	0,0,0,0
.Le71:
	.size	RTTI_$JNI_$$_PJVALUE, .Le71 - RTTI_$JNI_$$_PJVALUE

.section .data.rel.ro.n_RTTI_$JNI_$$_def0000004C
	.balign 8
.globl	RTTI_$JNI_$$_def0000004C
	.type	RTTI_$JNI_$$_def0000004C,#object
RTTI_$JNI_$$_def0000004C:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	4,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AClass"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JMETHODID$indirect
	.byte	8
	.ascii	"MethodID"
	.byte	0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJVALUE$indirect
	.byte	4
	.ascii	"Args"
	.byte	0,0,0,0,0,0,0
.Le72:
	.size	RTTI_$JNI_$$_def0000004C, .Le72 - RTTI_$JNI_$$_def0000004C

.section .data.rel.ro.n_RTTI_$JNI_$$_def0000004D
	.balign 8
.globl	RTTI_$JNI_$$_def0000004D
	.type	RTTI_$JNI_$$_def0000004D,#object
RTTI_$JNI_$$_def0000004D:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	2,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Obj"
	.byte	0,0,0,0
.Le73:
	.size	RTTI_$JNI_$$_def0000004D, .Le73 - RTTI_$JNI_$$_def0000004D

.section .data.rel.ro.n_RTTI_$JNI_$$_def0000004E
	.balign 8
.globl	RTTI_$JNI_$$_def0000004E
	.type	RTTI_$JNI_$$_def0000004E,#object
RTTI_$JNI_$$_def0000004E:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_BYTE$indirect
	.byte	3,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Obj"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AClass"
	.byte	0,0,0,0,0
.Le74:
	.size	RTTI_$JNI_$$_def0000004E, .Le74 - RTTI_$JNI_$$_def0000004E

.section .data.rel.ro.n_RTTI_$JNI_$$_def0000004F
	.balign 8
.globl	RTTI_$JNI_$$_def0000004F
	.type	RTTI_$JNI_$$_def0000004F,#object
RTTI_$JNI_$$_def0000004F:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$JNI_$$_JMETHODID$indirect
	.byte	4,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AClass"
	.byte	0
	.short	2
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_PCHAR$indirect
	.byte	4
	.ascii	"Name"
	.byte	0,0,0
	.short	2
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_PCHAR$indirect
	.byte	3
	.ascii	"Sig"
	.byte	0,0,0,0
.Le75:
	.size	RTTI_$JNI_$$_def0000004F, .Le75 - RTTI_$JNI_$$_def0000004F

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000050
	.balign 8
.globl	RTTI_$JNI_$$_def00000050
	.type	RTTI_$JNI_$$_def00000050,#object
RTTI_$JNI_$$_def00000050:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Obj"
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JMETHODID$indirect
	.byte	8
	.ascii	"MethodID"
	.byte	0,0,0
.Le76:
	.size	RTTI_$JNI_$$_def00000050, .Le76 - RTTI_$JNI_$$_def00000050

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000051
	.balign 8
.globl	RTTI_$JNI_$$_def00000051
	.type	RTTI_$JNI_$$_def00000051,#object
RTTI_$JNI_$$_def00000051:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	4,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Obj"
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JMETHODID$indirect
	.byte	8
	.ascii	"MethodID"
	.byte	0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	4
	.ascii	"Args"
	.byte	0,0,0
.Le77:
	.size	RTTI_$JNI_$$_def00000051, .Le77 - RTTI_$JNI_$$_def00000051

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000052
	.balign 8
.globl	RTTI_$JNI_$$_def00000052
	.type	RTTI_$JNI_$$_def00000052,#object
RTTI_$JNI_$$_def00000052:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	4,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Obj"
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JMETHODID$indirect
	.byte	8
	.ascii	"MethodID"
	.byte	0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJVALUE$indirect
	.byte	4
	.ascii	"Args"
	.byte	0,0,0
.Le78:
	.size	RTTI_$JNI_$$_def00000052, .Le78 - RTTI_$JNI_$$_def00000052

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000053
	.balign 8
.globl	RTTI_$JNI_$$_def00000053
	.type	RTTI_$JNI_$$_def00000053,#object
RTTI_$JNI_$$_def00000053:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_BYTE$indirect
	.byte	3,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Obj"
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JMETHODID$indirect
	.byte	8
	.ascii	"MethodID"
	.byte	0,0,0
.Le79:
	.size	RTTI_$JNI_$$_def00000053, .Le79 - RTTI_$JNI_$$_def00000053

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000054
	.balign 8
.globl	RTTI_$JNI_$$_def00000054
	.type	RTTI_$JNI_$$_def00000054,#object
RTTI_$JNI_$$_def00000054:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_BYTE$indirect
	.byte	4,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Obj"
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JMETHODID$indirect
	.byte	8
	.ascii	"MethodID"
	.byte	0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	4
	.ascii	"Args"
	.byte	0,0,0
.Le80:
	.size	RTTI_$JNI_$$_def00000054, .Le80 - RTTI_$JNI_$$_def00000054

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000055
	.balign 8
.globl	RTTI_$JNI_$$_def00000055
	.type	RTTI_$JNI_$$_def00000055,#object
RTTI_$JNI_$$_def00000055:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_BYTE$indirect
	.byte	4,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Obj"
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JMETHODID$indirect
	.byte	8
	.ascii	"MethodID"
	.byte	0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJVALUE$indirect
	.byte	4
	.ascii	"Args"
	.byte	0,0,0
.Le81:
	.size	RTTI_$JNI_$$_def00000055, .Le81 - RTTI_$JNI_$$_def00000055

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000056
	.balign 8
.globl	RTTI_$JNI_$$_def00000056
	.type	RTTI_$JNI_$$_def00000056,#object
RTTI_$JNI_$$_def00000056:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_SHORTINT$indirect
	.byte	3,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Obj"
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JMETHODID$indirect
	.byte	8
	.ascii	"MethodID"
	.byte	0,0,0
.Le82:
	.size	RTTI_$JNI_$$_def00000056, .Le82 - RTTI_$JNI_$$_def00000056

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000057
	.balign 8
.globl	RTTI_$JNI_$$_def00000057
	.type	RTTI_$JNI_$$_def00000057,#object
RTTI_$JNI_$$_def00000057:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_SHORTINT$indirect
	.byte	4,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Obj"
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JMETHODID$indirect
	.byte	8
	.ascii	"MethodID"
	.byte	0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	4
	.ascii	"Args"
	.byte	0,0,0
.Le83:
	.size	RTTI_$JNI_$$_def00000057, .Le83 - RTTI_$JNI_$$_def00000057

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000058
	.balign 8
.globl	RTTI_$JNI_$$_def00000058
	.type	RTTI_$JNI_$$_def00000058,#object
RTTI_$JNI_$$_def00000058:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_SHORTINT$indirect
	.byte	4,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Obj"
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JMETHODID$indirect
	.byte	8
	.ascii	"MethodID"
	.byte	0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJVALUE$indirect
	.byte	4
	.ascii	"Args"
	.byte	0,0,0
.Le84:
	.size	RTTI_$JNI_$$_def00000058, .Le84 - RTTI_$JNI_$$_def00000058

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000059
	.balign 8
.globl	RTTI_$JNI_$$_def00000059
	.type	RTTI_$JNI_$$_def00000059,#object
RTTI_$JNI_$$_def00000059:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_WORD$indirect
	.byte	3,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Obj"
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JMETHODID$indirect
	.byte	8
	.ascii	"MethodID"
	.byte	0,0,0
.Le85:
	.size	RTTI_$JNI_$$_def00000059, .Le85 - RTTI_$JNI_$$_def00000059

.section .data.rel.ro.n_RTTI_$JNI_$$_def0000005A
	.balign 8
.globl	RTTI_$JNI_$$_def0000005A
	.type	RTTI_$JNI_$$_def0000005A,#object
RTTI_$JNI_$$_def0000005A:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_WORD$indirect
	.byte	4,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Obj"
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JMETHODID$indirect
	.byte	8
	.ascii	"MethodID"
	.byte	0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	4
	.ascii	"Args"
	.byte	0,0,0
.Le86:
	.size	RTTI_$JNI_$$_def0000005A, .Le86 - RTTI_$JNI_$$_def0000005A

.section .data.rel.ro.n_RTTI_$JNI_$$_def0000005B
	.balign 8
.globl	RTTI_$JNI_$$_def0000005B
	.type	RTTI_$JNI_$$_def0000005B,#object
RTTI_$JNI_$$_def0000005B:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_WORD$indirect
	.byte	4,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Obj"
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JMETHODID$indirect
	.byte	8
	.ascii	"MethodID"
	.byte	0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJVALUE$indirect
	.byte	4
	.ascii	"Args"
	.byte	0,0,0
.Le87:
	.size	RTTI_$JNI_$$_def0000005B, .Le87 - RTTI_$JNI_$$_def0000005B

.section .data.rel.ro.n_RTTI_$JNI_$$_def0000005C
	.balign 8
.globl	RTTI_$JNI_$$_def0000005C
	.type	RTTI_$JNI_$$_def0000005C,#object
RTTI_$JNI_$$_def0000005C:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_SMALLINT$indirect
	.byte	3,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Obj"
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JMETHODID$indirect
	.byte	8
	.ascii	"MethodID"
	.byte	0,0,0
.Le88:
	.size	RTTI_$JNI_$$_def0000005C, .Le88 - RTTI_$JNI_$$_def0000005C

.section .data.rel.ro.n_RTTI_$JNI_$$_def0000005D
	.balign 8
.globl	RTTI_$JNI_$$_def0000005D
	.type	RTTI_$JNI_$$_def0000005D,#object
RTTI_$JNI_$$_def0000005D:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_SMALLINT$indirect
	.byte	4,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Obj"
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JMETHODID$indirect
	.byte	8
	.ascii	"MethodID"
	.byte	0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	4
	.ascii	"Args"
	.byte	0,0,0
.Le89:
	.size	RTTI_$JNI_$$_def0000005D, .Le89 - RTTI_$JNI_$$_def0000005D

.section .data.rel.ro.n_RTTI_$JNI_$$_def0000005E
	.balign 8
.globl	RTTI_$JNI_$$_def0000005E
	.type	RTTI_$JNI_$$_def0000005E,#object
RTTI_$JNI_$$_def0000005E:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_SMALLINT$indirect
	.byte	4,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Obj"
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JMETHODID$indirect
	.byte	8
	.ascii	"MethodID"
	.byte	0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJVALUE$indirect
	.byte	4
	.ascii	"Args"
	.byte	0,0,0
.Le90:
	.size	RTTI_$JNI_$$_def0000005E, .Le90 - RTTI_$JNI_$$_def0000005E

.section .data.rel.ro.n_RTTI_$JNI_$$_def0000005F
	.balign 8
.globl	RTTI_$JNI_$$_def0000005F
	.type	RTTI_$JNI_$$_def0000005F,#object
RTTI_$JNI_$$_def0000005F:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_LONGINT$indirect
	.byte	3,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Obj"
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JMETHODID$indirect
	.byte	8
	.ascii	"MethodID"
	.byte	0,0,0
.Le91:
	.size	RTTI_$JNI_$$_def0000005F, .Le91 - RTTI_$JNI_$$_def0000005F

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000060
	.balign 8
.globl	RTTI_$JNI_$$_def00000060
	.type	RTTI_$JNI_$$_def00000060,#object
RTTI_$JNI_$$_def00000060:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_LONGINT$indirect
	.byte	4,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Obj"
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JMETHODID$indirect
	.byte	8
	.ascii	"MethodID"
	.byte	0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	4
	.ascii	"Args"
	.byte	0,0,0
.Le92:
	.size	RTTI_$JNI_$$_def00000060, .Le92 - RTTI_$JNI_$$_def00000060

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000061
	.balign 8
.globl	RTTI_$JNI_$$_def00000061
	.type	RTTI_$JNI_$$_def00000061,#object
RTTI_$JNI_$$_def00000061:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_LONGINT$indirect
	.byte	4,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Obj"
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JMETHODID$indirect
	.byte	8
	.ascii	"MethodID"
	.byte	0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJVALUE$indirect
	.byte	4
	.ascii	"Args"
	.byte	0,0,0
.Le93:
	.size	RTTI_$JNI_$$_def00000061, .Le93 - RTTI_$JNI_$$_def00000061

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000062
	.balign 8
.globl	RTTI_$JNI_$$_def00000062
	.type	RTTI_$JNI_$$_def00000062,#object
RTTI_$JNI_$$_def00000062:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_INT64$indirect
	.byte	3,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Obj"
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JMETHODID$indirect
	.byte	8
	.ascii	"MethodID"
	.byte	0,0,0
.Le94:
	.size	RTTI_$JNI_$$_def00000062, .Le94 - RTTI_$JNI_$$_def00000062

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000063
	.balign 8
.globl	RTTI_$JNI_$$_def00000063
	.type	RTTI_$JNI_$$_def00000063,#object
RTTI_$JNI_$$_def00000063:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_INT64$indirect
	.byte	4,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Obj"
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JMETHODID$indirect
	.byte	8
	.ascii	"MethodID"
	.byte	0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	4
	.ascii	"Args"
	.byte	0,0,0
.Le95:
	.size	RTTI_$JNI_$$_def00000063, .Le95 - RTTI_$JNI_$$_def00000063

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000064
	.balign 8
.globl	RTTI_$JNI_$$_def00000064
	.type	RTTI_$JNI_$$_def00000064,#object
RTTI_$JNI_$$_def00000064:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_INT64$indirect
	.byte	4,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Obj"
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JMETHODID$indirect
	.byte	8
	.ascii	"MethodID"
	.byte	0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJVALUE$indirect
	.byte	4
	.ascii	"Args"
	.byte	0,0,0
.Le96:
	.size	RTTI_$JNI_$$_def00000064, .Le96 - RTTI_$JNI_$$_def00000064

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000065
	.balign 8
.globl	RTTI_$JNI_$$_def00000065
	.type	RTTI_$JNI_$$_def00000065,#object
RTTI_$JNI_$$_def00000065:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_SINGLE$indirect
	.byte	3,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Obj"
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JMETHODID$indirect
	.byte	8
	.ascii	"MethodID"
	.byte	0,0,0
.Le97:
	.size	RTTI_$JNI_$$_def00000065, .Le97 - RTTI_$JNI_$$_def00000065

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000066
	.balign 8
.globl	RTTI_$JNI_$$_def00000066
	.type	RTTI_$JNI_$$_def00000066,#object
RTTI_$JNI_$$_def00000066:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_SINGLE$indirect
	.byte	4,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Obj"
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JMETHODID$indirect
	.byte	8
	.ascii	"MethodID"
	.byte	0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	4
	.ascii	"Args"
	.byte	0,0,0
.Le98:
	.size	RTTI_$JNI_$$_def00000066, .Le98 - RTTI_$JNI_$$_def00000066

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000067
	.balign 8
.globl	RTTI_$JNI_$$_def00000067
	.type	RTTI_$JNI_$$_def00000067,#object
RTTI_$JNI_$$_def00000067:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_SINGLE$indirect
	.byte	4,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Obj"
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JMETHODID$indirect
	.byte	8
	.ascii	"MethodID"
	.byte	0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJVALUE$indirect
	.byte	4
	.ascii	"Args"
	.byte	0,0,0
.Le99:
	.size	RTTI_$JNI_$$_def00000067, .Le99 - RTTI_$JNI_$$_def00000067

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000068
	.balign 8
.globl	RTTI_$JNI_$$_def00000068
	.type	RTTI_$JNI_$$_def00000068,#object
RTTI_$JNI_$$_def00000068:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_DOUBLE$indirect
	.byte	3,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Obj"
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JMETHODID$indirect
	.byte	8
	.ascii	"MethodID"
	.byte	0,0,0
.Le100:
	.size	RTTI_$JNI_$$_def00000068, .Le100 - RTTI_$JNI_$$_def00000068

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000069
	.balign 8
.globl	RTTI_$JNI_$$_def00000069
	.type	RTTI_$JNI_$$_def00000069,#object
RTTI_$JNI_$$_def00000069:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_DOUBLE$indirect
	.byte	4,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Obj"
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JMETHODID$indirect
	.byte	8
	.ascii	"MethodID"
	.byte	0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	4
	.ascii	"Args"
	.byte	0,0,0
.Le101:
	.size	RTTI_$JNI_$$_def00000069, .Le101 - RTTI_$JNI_$$_def00000069

.section .data.rel.ro.n_RTTI_$JNI_$$_def0000006A
	.balign 8
.globl	RTTI_$JNI_$$_def0000006A
	.type	RTTI_$JNI_$$_def0000006A,#object
RTTI_$JNI_$$_def0000006A:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_DOUBLE$indirect
	.byte	4,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Obj"
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JMETHODID$indirect
	.byte	8
	.ascii	"MethodID"
	.byte	0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJVALUE$indirect
	.byte	4
	.ascii	"Args"
	.byte	0,0,0
.Le102:
	.size	RTTI_$JNI_$$_def0000006A, .Le102 - RTTI_$JNI_$$_def0000006A

.section .data.rel.ro.n_RTTI_$JNI_$$_def0000006B
	.balign 8
.globl	RTTI_$JNI_$$_def0000006B
	.type	RTTI_$JNI_$$_def0000006B,#object
RTTI_$JNI_$$_def0000006B:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	0
	.byte	3,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Obj"
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JMETHODID$indirect
	.byte	8
	.ascii	"MethodID"
	.byte	0,0,0
.Le103:
	.size	RTTI_$JNI_$$_def0000006B, .Le103 - RTTI_$JNI_$$_def0000006B

.section .data.rel.ro.n_RTTI_$JNI_$$_def0000006C
	.balign 8
.globl	RTTI_$JNI_$$_def0000006C
	.type	RTTI_$JNI_$$_def0000006C,#object
RTTI_$JNI_$$_def0000006C:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	0
	.byte	4,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Obj"
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JMETHODID$indirect
	.byte	8
	.ascii	"MethodID"
	.byte	0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	4
	.ascii	"Args"
	.byte	0,0,0
.Le104:
	.size	RTTI_$JNI_$$_def0000006C, .Le104 - RTTI_$JNI_$$_def0000006C

.section .data.rel.ro.n_RTTI_$JNI_$$_def0000006D
	.balign 8
.globl	RTTI_$JNI_$$_def0000006D
	.type	RTTI_$JNI_$$_def0000006D,#object
RTTI_$JNI_$$_def0000006D:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	0
	.byte	4,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Obj"
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JMETHODID$indirect
	.byte	8
	.ascii	"MethodID"
	.byte	0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJVALUE$indirect
	.byte	4
	.ascii	"Args"
	.byte	0,0,0
.Le105:
	.size	RTTI_$JNI_$$_def0000006D, .Le105 - RTTI_$JNI_$$_def0000006D

.section .data.rel.ro.n_RTTI_$JNI_$$_def0000006E
	.balign 8
.globl	RTTI_$JNI_$$_def0000006E
	.type	RTTI_$JNI_$$_def0000006E,#object
RTTI_$JNI_$$_def0000006E:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	4,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Obj"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AClass"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JMETHODID$indirect
	.byte	8
	.ascii	"MethodID"
	.byte	0,0,0
.Le106:
	.size	RTTI_$JNI_$$_def0000006E, .Le106 - RTTI_$JNI_$$_def0000006E

.section .data.rel.ro.n_RTTI_$JNI_$$_def0000006F
	.balign 8
.globl	RTTI_$JNI_$$_def0000006F
	.type	RTTI_$JNI_$$_def0000006F,#object
RTTI_$JNI_$$_def0000006F:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	5,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Obj"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AClass"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JMETHODID$indirect
	.byte	8
	.ascii	"MethodID"
	.byte	0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	4
	.ascii	"Args"
	.byte	0,0,0
.Le107:
	.size	RTTI_$JNI_$$_def0000006F, .Le107 - RTTI_$JNI_$$_def0000006F

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000070
	.balign 8
.globl	RTTI_$JNI_$$_def00000070
	.type	RTTI_$JNI_$$_def00000070,#object
RTTI_$JNI_$$_def00000070:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	5,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Obj"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AClass"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JMETHODID$indirect
	.byte	8
	.ascii	"MethodID"
	.byte	0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJVALUE$indirect
	.byte	4
	.ascii	"Args"
	.byte	0,0,0
.Le108:
	.size	RTTI_$JNI_$$_def00000070, .Le108 - RTTI_$JNI_$$_def00000070

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000071
	.balign 8
.globl	RTTI_$JNI_$$_def00000071
	.type	RTTI_$JNI_$$_def00000071,#object
RTTI_$JNI_$$_def00000071:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_BYTE$indirect
	.byte	4,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Obj"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AClass"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JMETHODID$indirect
	.byte	8
	.ascii	"MethodID"
	.byte	0,0,0
.Le109:
	.size	RTTI_$JNI_$$_def00000071, .Le109 - RTTI_$JNI_$$_def00000071

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000072
	.balign 8
.globl	RTTI_$JNI_$$_def00000072
	.type	RTTI_$JNI_$$_def00000072,#object
RTTI_$JNI_$$_def00000072:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_BYTE$indirect
	.byte	5,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Obj"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AClass"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JMETHODID$indirect
	.byte	8
	.ascii	"MethodID"
	.byte	0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	4
	.ascii	"Args"
	.byte	0,0,0
.Le110:
	.size	RTTI_$JNI_$$_def00000072, .Le110 - RTTI_$JNI_$$_def00000072

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000073
	.balign 8
.globl	RTTI_$JNI_$$_def00000073
	.type	RTTI_$JNI_$$_def00000073,#object
RTTI_$JNI_$$_def00000073:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_BYTE$indirect
	.byte	5,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Obj"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AClass"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JMETHODID$indirect
	.byte	8
	.ascii	"MethodID"
	.byte	0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJVALUE$indirect
	.byte	4
	.ascii	"Args"
	.byte	0,0,0
.Le111:
	.size	RTTI_$JNI_$$_def00000073, .Le111 - RTTI_$JNI_$$_def00000073

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000074
	.balign 8
.globl	RTTI_$JNI_$$_def00000074
	.type	RTTI_$JNI_$$_def00000074,#object
RTTI_$JNI_$$_def00000074:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_SHORTINT$indirect
	.byte	4,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Obj"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AClass"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JMETHODID$indirect
	.byte	8
	.ascii	"MethodID"
	.byte	0,0,0
.Le112:
	.size	RTTI_$JNI_$$_def00000074, .Le112 - RTTI_$JNI_$$_def00000074

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000075
	.balign 8
.globl	RTTI_$JNI_$$_def00000075
	.type	RTTI_$JNI_$$_def00000075,#object
RTTI_$JNI_$$_def00000075:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_SHORTINT$indirect
	.byte	5,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Obj"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AClass"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JMETHODID$indirect
	.byte	8
	.ascii	"MethodID"
	.byte	0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	4
	.ascii	"Args"
	.byte	0,0,0
.Le113:
	.size	RTTI_$JNI_$$_def00000075, .Le113 - RTTI_$JNI_$$_def00000075

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000076
	.balign 8
.globl	RTTI_$JNI_$$_def00000076
	.type	RTTI_$JNI_$$_def00000076,#object
RTTI_$JNI_$$_def00000076:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_SHORTINT$indirect
	.byte	5,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Obj"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AClass"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JMETHODID$indirect
	.byte	8
	.ascii	"MethodID"
	.byte	0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJVALUE$indirect
	.byte	4
	.ascii	"Args"
	.byte	0,0,0
.Le114:
	.size	RTTI_$JNI_$$_def00000076, .Le114 - RTTI_$JNI_$$_def00000076

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000077
	.balign 8
.globl	RTTI_$JNI_$$_def00000077
	.type	RTTI_$JNI_$$_def00000077,#object
RTTI_$JNI_$$_def00000077:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_WORD$indirect
	.byte	4,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Obj"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AClass"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JMETHODID$indirect
	.byte	8
	.ascii	"MethodID"
	.byte	0,0,0
.Le115:
	.size	RTTI_$JNI_$$_def00000077, .Le115 - RTTI_$JNI_$$_def00000077

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000078
	.balign 8
.globl	RTTI_$JNI_$$_def00000078
	.type	RTTI_$JNI_$$_def00000078,#object
RTTI_$JNI_$$_def00000078:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_WORD$indirect
	.byte	5,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Obj"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AClass"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JMETHODID$indirect
	.byte	8
	.ascii	"MethodID"
	.byte	0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	4
	.ascii	"Args"
	.byte	0,0,0
.Le116:
	.size	RTTI_$JNI_$$_def00000078, .Le116 - RTTI_$JNI_$$_def00000078

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000079
	.balign 8
.globl	RTTI_$JNI_$$_def00000079
	.type	RTTI_$JNI_$$_def00000079,#object
RTTI_$JNI_$$_def00000079:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_WORD$indirect
	.byte	5,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Obj"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AClass"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JMETHODID$indirect
	.byte	8
	.ascii	"MethodID"
	.byte	0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJVALUE$indirect
	.byte	4
	.ascii	"Args"
	.byte	0,0,0
.Le117:
	.size	RTTI_$JNI_$$_def00000079, .Le117 - RTTI_$JNI_$$_def00000079

.section .data.rel.ro.n_RTTI_$JNI_$$_def0000007A
	.balign 8
.globl	RTTI_$JNI_$$_def0000007A
	.type	RTTI_$JNI_$$_def0000007A,#object
RTTI_$JNI_$$_def0000007A:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_SMALLINT$indirect
	.byte	4,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Obj"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AClass"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JMETHODID$indirect
	.byte	8
	.ascii	"MethodID"
	.byte	0,0,0
.Le118:
	.size	RTTI_$JNI_$$_def0000007A, .Le118 - RTTI_$JNI_$$_def0000007A

.section .data.rel.ro.n_RTTI_$JNI_$$_def0000007B
	.balign 8
.globl	RTTI_$JNI_$$_def0000007B
	.type	RTTI_$JNI_$$_def0000007B,#object
RTTI_$JNI_$$_def0000007B:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_SMALLINT$indirect
	.byte	5,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Obj"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AClass"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JMETHODID$indirect
	.byte	8
	.ascii	"MethodID"
	.byte	0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	4
	.ascii	"Args"
	.byte	0,0,0
.Le119:
	.size	RTTI_$JNI_$$_def0000007B, .Le119 - RTTI_$JNI_$$_def0000007B

.section .data.rel.ro.n_RTTI_$JNI_$$_def0000007C
	.balign 8
.globl	RTTI_$JNI_$$_def0000007C
	.type	RTTI_$JNI_$$_def0000007C,#object
RTTI_$JNI_$$_def0000007C:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_SMALLINT$indirect
	.byte	5,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Obj"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AClass"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JMETHODID$indirect
	.byte	8
	.ascii	"MethodID"
	.byte	0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJVALUE$indirect
	.byte	4
	.ascii	"Args"
	.byte	0,0,0
.Le120:
	.size	RTTI_$JNI_$$_def0000007C, .Le120 - RTTI_$JNI_$$_def0000007C

.section .data.rel.ro.n_RTTI_$JNI_$$_def0000007D
	.balign 8
.globl	RTTI_$JNI_$$_def0000007D
	.type	RTTI_$JNI_$$_def0000007D,#object
RTTI_$JNI_$$_def0000007D:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_LONGINT$indirect
	.byte	4,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Obj"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AClass"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JMETHODID$indirect
	.byte	8
	.ascii	"MethodID"
	.byte	0,0,0
.Le121:
	.size	RTTI_$JNI_$$_def0000007D, .Le121 - RTTI_$JNI_$$_def0000007D

.section .data.rel.ro.n_RTTI_$JNI_$$_def0000007E
	.balign 8
.globl	RTTI_$JNI_$$_def0000007E
	.type	RTTI_$JNI_$$_def0000007E,#object
RTTI_$JNI_$$_def0000007E:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_LONGINT$indirect
	.byte	5,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Obj"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AClass"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JMETHODID$indirect
	.byte	8
	.ascii	"MethodID"
	.byte	0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	4
	.ascii	"Args"
	.byte	0,0,0
.Le122:
	.size	RTTI_$JNI_$$_def0000007E, .Le122 - RTTI_$JNI_$$_def0000007E

.section .data.rel.ro.n_RTTI_$JNI_$$_def0000007F
	.balign 8
.globl	RTTI_$JNI_$$_def0000007F
	.type	RTTI_$JNI_$$_def0000007F,#object
RTTI_$JNI_$$_def0000007F:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_LONGINT$indirect
	.byte	5,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Obj"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AClass"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JMETHODID$indirect
	.byte	8
	.ascii	"MethodID"
	.byte	0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJVALUE$indirect
	.byte	4
	.ascii	"Args"
	.byte	0,0,0
.Le123:
	.size	RTTI_$JNI_$$_def0000007F, .Le123 - RTTI_$JNI_$$_def0000007F

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000080
	.balign 8
.globl	RTTI_$JNI_$$_def00000080
	.type	RTTI_$JNI_$$_def00000080,#object
RTTI_$JNI_$$_def00000080:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_INT64$indirect
	.byte	4,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Obj"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AClass"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JMETHODID$indirect
	.byte	8
	.ascii	"MethodID"
	.byte	0,0,0
.Le124:
	.size	RTTI_$JNI_$$_def00000080, .Le124 - RTTI_$JNI_$$_def00000080

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000081
	.balign 8
.globl	RTTI_$JNI_$$_def00000081
	.type	RTTI_$JNI_$$_def00000081,#object
RTTI_$JNI_$$_def00000081:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_INT64$indirect
	.byte	5,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Obj"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AClass"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JMETHODID$indirect
	.byte	8
	.ascii	"MethodID"
	.byte	0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	4
	.ascii	"Args"
	.byte	0,0,0
.Le125:
	.size	RTTI_$JNI_$$_def00000081, .Le125 - RTTI_$JNI_$$_def00000081

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000082
	.balign 8
.globl	RTTI_$JNI_$$_def00000082
	.type	RTTI_$JNI_$$_def00000082,#object
RTTI_$JNI_$$_def00000082:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_INT64$indirect
	.byte	5,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Obj"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AClass"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JMETHODID$indirect
	.byte	8
	.ascii	"MethodID"
	.byte	0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJVALUE$indirect
	.byte	4
	.ascii	"Args"
	.byte	0,0,0
.Le126:
	.size	RTTI_$JNI_$$_def00000082, .Le126 - RTTI_$JNI_$$_def00000082

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000083
	.balign 8
.globl	RTTI_$JNI_$$_def00000083
	.type	RTTI_$JNI_$$_def00000083,#object
RTTI_$JNI_$$_def00000083:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_SINGLE$indirect
	.byte	4,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Obj"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AClass"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JMETHODID$indirect
	.byte	8
	.ascii	"MethodID"
	.byte	0,0,0
.Le127:
	.size	RTTI_$JNI_$$_def00000083, .Le127 - RTTI_$JNI_$$_def00000083

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000084
	.balign 8
.globl	RTTI_$JNI_$$_def00000084
	.type	RTTI_$JNI_$$_def00000084,#object
RTTI_$JNI_$$_def00000084:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_SINGLE$indirect
	.byte	5,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Obj"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AClass"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JMETHODID$indirect
	.byte	8
	.ascii	"MethodID"
	.byte	0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	4
	.ascii	"Args"
	.byte	0,0,0
.Le128:
	.size	RTTI_$JNI_$$_def00000084, .Le128 - RTTI_$JNI_$$_def00000084

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000085
	.balign 8
.globl	RTTI_$JNI_$$_def00000085
	.type	RTTI_$JNI_$$_def00000085,#object
RTTI_$JNI_$$_def00000085:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_SINGLE$indirect
	.byte	5,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Obj"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AClass"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JMETHODID$indirect
	.byte	8
	.ascii	"MethodID"
	.byte	0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJVALUE$indirect
	.byte	4
	.ascii	"Args"
	.byte	0,0,0
.Le129:
	.size	RTTI_$JNI_$$_def00000085, .Le129 - RTTI_$JNI_$$_def00000085

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000086
	.balign 8
.globl	RTTI_$JNI_$$_def00000086
	.type	RTTI_$JNI_$$_def00000086,#object
RTTI_$JNI_$$_def00000086:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_DOUBLE$indirect
	.byte	4,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Obj"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AClass"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JMETHODID$indirect
	.byte	8
	.ascii	"MethodID"
	.byte	0,0,0
.Le130:
	.size	RTTI_$JNI_$$_def00000086, .Le130 - RTTI_$JNI_$$_def00000086

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000087
	.balign 8
.globl	RTTI_$JNI_$$_def00000087
	.type	RTTI_$JNI_$$_def00000087,#object
RTTI_$JNI_$$_def00000087:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_DOUBLE$indirect
	.byte	5,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Obj"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AClass"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JMETHODID$indirect
	.byte	8
	.ascii	"MethodID"
	.byte	0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	4
	.ascii	"Args"
	.byte	0,0,0
.Le131:
	.size	RTTI_$JNI_$$_def00000087, .Le131 - RTTI_$JNI_$$_def00000087

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000088
	.balign 8
.globl	RTTI_$JNI_$$_def00000088
	.type	RTTI_$JNI_$$_def00000088,#object
RTTI_$JNI_$$_def00000088:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_DOUBLE$indirect
	.byte	5,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Obj"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AClass"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JMETHODID$indirect
	.byte	8
	.ascii	"MethodID"
	.byte	0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJVALUE$indirect
	.byte	4
	.ascii	"Args"
	.byte	0,0,0
.Le132:
	.size	RTTI_$JNI_$$_def00000088, .Le132 - RTTI_$JNI_$$_def00000088

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000089
	.balign 8
.globl	RTTI_$JNI_$$_def00000089
	.type	RTTI_$JNI_$$_def00000089,#object
RTTI_$JNI_$$_def00000089:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	0
	.byte	4,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Obj"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AClass"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JMETHODID$indirect
	.byte	8
	.ascii	"MethodID"
	.byte	0,0,0
.Le133:
	.size	RTTI_$JNI_$$_def00000089, .Le133 - RTTI_$JNI_$$_def00000089

.section .data.rel.ro.n_RTTI_$JNI_$$_def0000008A
	.balign 8
.globl	RTTI_$JNI_$$_def0000008A
	.type	RTTI_$JNI_$$_def0000008A,#object
RTTI_$JNI_$$_def0000008A:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	0
	.byte	5,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Obj"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AClass"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JMETHODID$indirect
	.byte	8
	.ascii	"MethodID"
	.byte	0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	4
	.ascii	"Args"
	.byte	0,0,0
.Le134:
	.size	RTTI_$JNI_$$_def0000008A, .Le134 - RTTI_$JNI_$$_def0000008A

.section .data.rel.ro.n_RTTI_$JNI_$$_def0000008B
	.balign 8
.globl	RTTI_$JNI_$$_def0000008B
	.type	RTTI_$JNI_$$_def0000008B,#object
RTTI_$JNI_$$_def0000008B:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	0
	.byte	5,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Obj"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AClass"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JMETHODID$indirect
	.byte	8
	.ascii	"MethodID"
	.byte	0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJVALUE$indirect
	.byte	4
	.ascii	"Args"
	.byte	0,0,0
.Le135:
	.size	RTTI_$JNI_$$_def0000008B, .Le135 - RTTI_$JNI_$$_def0000008B

.section .data.rel.ro.n_RTTI_$JNI_$$_def0000008C
	.balign 8
.globl	RTTI_$JNI_$$_def0000008C
	.type	RTTI_$JNI_$$_def0000008C,#object
RTTI_$JNI_$$_def0000008C:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$JNI_$$_JFIELDID$indirect
	.byte	4,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AClass"
	.byte	0
	.short	2
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_PCHAR$indirect
	.byte	4
	.ascii	"Name"
	.byte	0,0,0
	.short	2
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_PCHAR$indirect
	.byte	3
	.ascii	"Sig"
	.byte	0,0,0,0
.Le136:
	.size	RTTI_$JNI_$$_def0000008C, .Le136 - RTTI_$JNI_$$_def0000008C

.section .data.rel.ro.n_RTTI_$JNI_$$_def0000008D
	.balign 8
.globl	RTTI_$JNI_$$_def0000008D
	.type	RTTI_$JNI_$$_def0000008D,#object
RTTI_$JNI_$$_def0000008D:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Obj"
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JFIELDID$indirect
	.byte	7
	.ascii	"FieldID"
	.byte	0,0,0,0
.Le137:
	.size	RTTI_$JNI_$$_def0000008D, .Le137 - RTTI_$JNI_$$_def0000008D

.section .data.rel.ro.n_RTTI_$JNI_$$_def0000008E
	.balign 8
.globl	RTTI_$JNI_$$_def0000008E
	.type	RTTI_$JNI_$$_def0000008E,#object
RTTI_$JNI_$$_def0000008E:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_BYTE$indirect
	.byte	3,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Obj"
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JFIELDID$indirect
	.byte	7
	.ascii	"FieldID"
	.byte	0,0,0,0
.Le138:
	.size	RTTI_$JNI_$$_def0000008E, .Le138 - RTTI_$JNI_$$_def0000008E

.section .data.rel.ro.n_RTTI_$JNI_$$_def0000008F
	.balign 8
.globl	RTTI_$JNI_$$_def0000008F
	.type	RTTI_$JNI_$$_def0000008F,#object
RTTI_$JNI_$$_def0000008F:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_SHORTINT$indirect
	.byte	3,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Obj"
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JFIELDID$indirect
	.byte	7
	.ascii	"FieldID"
	.byte	0,0,0,0
.Le139:
	.size	RTTI_$JNI_$$_def0000008F, .Le139 - RTTI_$JNI_$$_def0000008F

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000090
	.balign 8
.globl	RTTI_$JNI_$$_def00000090
	.type	RTTI_$JNI_$$_def00000090,#object
RTTI_$JNI_$$_def00000090:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_WORD$indirect
	.byte	3,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Obj"
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JFIELDID$indirect
	.byte	7
	.ascii	"FieldID"
	.byte	0,0,0,0
.Le140:
	.size	RTTI_$JNI_$$_def00000090, .Le140 - RTTI_$JNI_$$_def00000090

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000091
	.balign 8
.globl	RTTI_$JNI_$$_def00000091
	.type	RTTI_$JNI_$$_def00000091,#object
RTTI_$JNI_$$_def00000091:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_SMALLINT$indirect
	.byte	3,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Obj"
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JFIELDID$indirect
	.byte	7
	.ascii	"FieldID"
	.byte	0,0,0,0
.Le141:
	.size	RTTI_$JNI_$$_def00000091, .Le141 - RTTI_$JNI_$$_def00000091

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000092
	.balign 8
.globl	RTTI_$JNI_$$_def00000092
	.type	RTTI_$JNI_$$_def00000092,#object
RTTI_$JNI_$$_def00000092:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_LONGINT$indirect
	.byte	3,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Obj"
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JFIELDID$indirect
	.byte	7
	.ascii	"FieldID"
	.byte	0,0,0,0
.Le142:
	.size	RTTI_$JNI_$$_def00000092, .Le142 - RTTI_$JNI_$$_def00000092

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000093
	.balign 8
.globl	RTTI_$JNI_$$_def00000093
	.type	RTTI_$JNI_$$_def00000093,#object
RTTI_$JNI_$$_def00000093:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_INT64$indirect
	.byte	3,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Obj"
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JFIELDID$indirect
	.byte	7
	.ascii	"FieldID"
	.byte	0,0,0,0
.Le143:
	.size	RTTI_$JNI_$$_def00000093, .Le143 - RTTI_$JNI_$$_def00000093

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000094
	.balign 8
.globl	RTTI_$JNI_$$_def00000094
	.type	RTTI_$JNI_$$_def00000094,#object
RTTI_$JNI_$$_def00000094:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_SINGLE$indirect
	.byte	3,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Obj"
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JFIELDID$indirect
	.byte	7
	.ascii	"FieldID"
	.byte	0,0,0,0
.Le144:
	.size	RTTI_$JNI_$$_def00000094, .Le144 - RTTI_$JNI_$$_def00000094

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000095
	.balign 8
.globl	RTTI_$JNI_$$_def00000095
	.type	RTTI_$JNI_$$_def00000095,#object
RTTI_$JNI_$$_def00000095:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_DOUBLE$indirect
	.byte	3,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Obj"
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JFIELDID$indirect
	.byte	7
	.ascii	"FieldID"
	.byte	0,0,0,0
.Le145:
	.size	RTTI_$JNI_$$_def00000095, .Le145 - RTTI_$JNI_$$_def00000095

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000096
	.balign 8
.globl	RTTI_$JNI_$$_def00000096
	.type	RTTI_$JNI_$$_def00000096,#object
RTTI_$JNI_$$_def00000096:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	0
	.byte	4,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Obj"
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JFIELDID$indirect
	.byte	7
	.ascii	"FieldID"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Val"
.Le146:
	.size	RTTI_$JNI_$$_def00000096, .Le146 - RTTI_$JNI_$$_def00000096

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000097
	.balign 8
.globl	RTTI_$JNI_$$_def00000097
	.type	RTTI_$JNI_$$_def00000097,#object
RTTI_$JNI_$$_def00000097:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	0
	.byte	4,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Obj"
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JFIELDID$indirect
	.byte	7
	.ascii	"FieldID"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_BYTE$indirect
	.byte	3
	.ascii	"Val"
.Le147:
	.size	RTTI_$JNI_$$_def00000097, .Le147 - RTTI_$JNI_$$_def00000097

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000098
	.balign 8
.globl	RTTI_$JNI_$$_def00000098
	.type	RTTI_$JNI_$$_def00000098,#object
RTTI_$JNI_$$_def00000098:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	0
	.byte	4,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Obj"
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JFIELDID$indirect
	.byte	7
	.ascii	"FieldID"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_SHORTINT$indirect
	.byte	3
	.ascii	"Val"
.Le148:
	.size	RTTI_$JNI_$$_def00000098, .Le148 - RTTI_$JNI_$$_def00000098

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000099
	.balign 8
.globl	RTTI_$JNI_$$_def00000099
	.type	RTTI_$JNI_$$_def00000099,#object
RTTI_$JNI_$$_def00000099:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	0
	.byte	4,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Obj"
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JFIELDID$indirect
	.byte	7
	.ascii	"FieldID"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_WORD$indirect
	.byte	3
	.ascii	"Val"
.Le149:
	.size	RTTI_$JNI_$$_def00000099, .Le149 - RTTI_$JNI_$$_def00000099

.section .data.rel.ro.n_RTTI_$JNI_$$_def0000009A
	.balign 8
.globl	RTTI_$JNI_$$_def0000009A
	.type	RTTI_$JNI_$$_def0000009A,#object
RTTI_$JNI_$$_def0000009A:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	0
	.byte	4,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Obj"
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JFIELDID$indirect
	.byte	7
	.ascii	"FieldID"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_SMALLINT$indirect
	.byte	3
	.ascii	"Val"
.Le150:
	.size	RTTI_$JNI_$$_def0000009A, .Le150 - RTTI_$JNI_$$_def0000009A

.section .data.rel.ro.n_RTTI_$JNI_$$_def0000009B
	.balign 8
.globl	RTTI_$JNI_$$_def0000009B
	.type	RTTI_$JNI_$$_def0000009B,#object
RTTI_$JNI_$$_def0000009B:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	0
	.byte	4,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Obj"
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JFIELDID$indirect
	.byte	7
	.ascii	"FieldID"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_LONGINT$indirect
	.byte	3
	.ascii	"Val"
.Le151:
	.size	RTTI_$JNI_$$_def0000009B, .Le151 - RTTI_$JNI_$$_def0000009B

.section .data.rel.ro.n_RTTI_$JNI_$$_def0000009C
	.balign 8
.globl	RTTI_$JNI_$$_def0000009C
	.type	RTTI_$JNI_$$_def0000009C,#object
RTTI_$JNI_$$_def0000009C:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	0
	.byte	4,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Obj"
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JFIELDID$indirect
	.byte	7
	.ascii	"FieldID"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_INT64$indirect
	.byte	3
	.ascii	"Val"
.Le152:
	.size	RTTI_$JNI_$$_def0000009C, .Le152 - RTTI_$JNI_$$_def0000009C

.section .data.rel.ro.n_RTTI_$JNI_$$_def0000009D
	.balign 8
.globl	RTTI_$JNI_$$_def0000009D
	.type	RTTI_$JNI_$$_def0000009D,#object
RTTI_$JNI_$$_def0000009D:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	0
	.byte	4,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Obj"
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JFIELDID$indirect
	.byte	7
	.ascii	"FieldID"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_SINGLE$indirect
	.byte	3
	.ascii	"Val"
.Le153:
	.size	RTTI_$JNI_$$_def0000009D, .Le153 - RTTI_$JNI_$$_def0000009D

.section .data.rel.ro.n_RTTI_$JNI_$$_def0000009E
	.balign 8
.globl	RTTI_$JNI_$$_def0000009E
	.type	RTTI_$JNI_$$_def0000009E,#object
RTTI_$JNI_$$_def0000009E:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	0
	.byte	4,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Obj"
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JFIELDID$indirect
	.byte	7
	.ascii	"FieldID"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_DOUBLE$indirect
	.byte	3
	.ascii	"Val"
.Le154:
	.size	RTTI_$JNI_$$_def0000009E, .Le154 - RTTI_$JNI_$$_def0000009E

.section .data.rel.ro.n_RTTI_$JNI_$$_def0000009F
	.balign 8
.globl	RTTI_$JNI_$$_def0000009F
	.type	RTTI_$JNI_$$_def0000009F,#object
RTTI_$JNI_$$_def0000009F:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$JNI_$$_JMETHODID$indirect
	.byte	4,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AClass"
	.byte	0
	.short	2
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_PCHAR$indirect
	.byte	4
	.ascii	"Name"
	.byte	0,0,0
	.short	2
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_PCHAR$indirect
	.byte	3
	.ascii	"Sig"
	.byte	0,0,0,0
.Le155:
	.size	RTTI_$JNI_$$_def0000009F, .Le155 - RTTI_$JNI_$$_def0000009F

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000A0
	.balign 8
.globl	RTTI_$JNI_$$_def000000A0
	.type	RTTI_$JNI_$$_def000000A0,#object
RTTI_$JNI_$$_def000000A0:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AClass"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JMETHODID$indirect
	.byte	8
	.ascii	"MethodID"
	.byte	0,0,0,0,0,0,0
.Le156:
	.size	RTTI_$JNI_$$_def000000A0, .Le156 - RTTI_$JNI_$$_def000000A0

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000A1
	.balign 8
.globl	RTTI_$JNI_$$_def000000A1
	.type	RTTI_$JNI_$$_def000000A1,#object
RTTI_$JNI_$$_def000000A1:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	4,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AClass"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JMETHODID$indirect
	.byte	8
	.ascii	"MethodID"
	.byte	0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	4
	.ascii	"Args"
	.byte	0,0,0,0,0,0,0
.Le157:
	.size	RTTI_$JNI_$$_def000000A1, .Le157 - RTTI_$JNI_$$_def000000A1

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000A2
	.balign 8
.globl	RTTI_$JNI_$$_def000000A2
	.type	RTTI_$JNI_$$_def000000A2,#object
RTTI_$JNI_$$_def000000A2:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	4,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AClass"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JMETHODID$indirect
	.byte	8
	.ascii	"MethodID"
	.byte	0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJVALUE$indirect
	.byte	4
	.ascii	"Args"
	.byte	0,0,0,0,0,0,0
.Le158:
	.size	RTTI_$JNI_$$_def000000A2, .Le158 - RTTI_$JNI_$$_def000000A2

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000A3
	.balign 8
.globl	RTTI_$JNI_$$_def000000A3
	.type	RTTI_$JNI_$$_def000000A3,#object
RTTI_$JNI_$$_def000000A3:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_BYTE$indirect
	.byte	3,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AClass"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JMETHODID$indirect
	.byte	8
	.ascii	"MethodID"
	.byte	0,0,0,0,0,0,0
.Le159:
	.size	RTTI_$JNI_$$_def000000A3, .Le159 - RTTI_$JNI_$$_def000000A3

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000A4
	.balign 8
.globl	RTTI_$JNI_$$_def000000A4
	.type	RTTI_$JNI_$$_def000000A4,#object
RTTI_$JNI_$$_def000000A4:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_BYTE$indirect
	.byte	4,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AClass"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JMETHODID$indirect
	.byte	8
	.ascii	"MethodID"
	.byte	0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	4
	.ascii	"Args"
	.byte	0,0,0,0,0,0,0
.Le160:
	.size	RTTI_$JNI_$$_def000000A4, .Le160 - RTTI_$JNI_$$_def000000A4

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000A5
	.balign 8
.globl	RTTI_$JNI_$$_def000000A5
	.type	RTTI_$JNI_$$_def000000A5,#object
RTTI_$JNI_$$_def000000A5:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_BYTE$indirect
	.byte	4,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AClass"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JMETHODID$indirect
	.byte	8
	.ascii	"MethodID"
	.byte	0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJVALUE$indirect
	.byte	4
	.ascii	"Args"
	.byte	0,0,0,0,0,0,0
.Le161:
	.size	RTTI_$JNI_$$_def000000A5, .Le161 - RTTI_$JNI_$$_def000000A5

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000A6
	.balign 8
.globl	RTTI_$JNI_$$_def000000A6
	.type	RTTI_$JNI_$$_def000000A6,#object
RTTI_$JNI_$$_def000000A6:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_SHORTINT$indirect
	.byte	3,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AClass"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JMETHODID$indirect
	.byte	8
	.ascii	"MethodID"
	.byte	0,0,0,0,0,0,0
.Le162:
	.size	RTTI_$JNI_$$_def000000A6, .Le162 - RTTI_$JNI_$$_def000000A6

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000A7
	.balign 8
.globl	RTTI_$JNI_$$_def000000A7
	.type	RTTI_$JNI_$$_def000000A7,#object
RTTI_$JNI_$$_def000000A7:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_SHORTINT$indirect
	.byte	4,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AClass"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JMETHODID$indirect
	.byte	8
	.ascii	"MethodID"
	.byte	0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	4
	.ascii	"Args"
	.byte	0,0,0,0,0,0,0
.Le163:
	.size	RTTI_$JNI_$$_def000000A7, .Le163 - RTTI_$JNI_$$_def000000A7

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000A8
	.balign 8
.globl	RTTI_$JNI_$$_def000000A8
	.type	RTTI_$JNI_$$_def000000A8,#object
RTTI_$JNI_$$_def000000A8:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_SHORTINT$indirect
	.byte	4,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AClass"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JMETHODID$indirect
	.byte	8
	.ascii	"MethodID"
	.byte	0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJVALUE$indirect
	.byte	4
	.ascii	"Args"
	.byte	0,0,0,0,0,0,0
.Le164:
	.size	RTTI_$JNI_$$_def000000A8, .Le164 - RTTI_$JNI_$$_def000000A8

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000A9
	.balign 8
.globl	RTTI_$JNI_$$_def000000A9
	.type	RTTI_$JNI_$$_def000000A9,#object
RTTI_$JNI_$$_def000000A9:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_WORD$indirect
	.byte	3,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AClass"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JMETHODID$indirect
	.byte	8
	.ascii	"MethodID"
	.byte	0,0,0,0,0,0,0
.Le165:
	.size	RTTI_$JNI_$$_def000000A9, .Le165 - RTTI_$JNI_$$_def000000A9

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000AA
	.balign 8
.globl	RTTI_$JNI_$$_def000000AA
	.type	RTTI_$JNI_$$_def000000AA,#object
RTTI_$JNI_$$_def000000AA:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_WORD$indirect
	.byte	4,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AClass"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JMETHODID$indirect
	.byte	8
	.ascii	"MethodID"
	.byte	0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	4
	.ascii	"Args"
	.byte	0,0,0,0,0,0,0
.Le166:
	.size	RTTI_$JNI_$$_def000000AA, .Le166 - RTTI_$JNI_$$_def000000AA

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000AB
	.balign 8
.globl	RTTI_$JNI_$$_def000000AB
	.type	RTTI_$JNI_$$_def000000AB,#object
RTTI_$JNI_$$_def000000AB:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_WORD$indirect
	.byte	4,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AClass"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JMETHODID$indirect
	.byte	8
	.ascii	"MethodID"
	.byte	0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJVALUE$indirect
	.byte	4
	.ascii	"Args"
	.byte	0,0,0,0,0,0,0
.Le167:
	.size	RTTI_$JNI_$$_def000000AB, .Le167 - RTTI_$JNI_$$_def000000AB

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000AC
	.balign 8
.globl	RTTI_$JNI_$$_def000000AC
	.type	RTTI_$JNI_$$_def000000AC,#object
RTTI_$JNI_$$_def000000AC:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_SMALLINT$indirect
	.byte	3,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AClass"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JMETHODID$indirect
	.byte	8
	.ascii	"MethodID"
	.byte	0,0,0,0,0,0,0
.Le168:
	.size	RTTI_$JNI_$$_def000000AC, .Le168 - RTTI_$JNI_$$_def000000AC

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000AD
	.balign 8
.globl	RTTI_$JNI_$$_def000000AD
	.type	RTTI_$JNI_$$_def000000AD,#object
RTTI_$JNI_$$_def000000AD:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_SMALLINT$indirect
	.byte	4,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AClass"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JMETHODID$indirect
	.byte	8
	.ascii	"MethodID"
	.byte	0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	4
	.ascii	"Args"
	.byte	0,0,0,0,0,0,0
.Le169:
	.size	RTTI_$JNI_$$_def000000AD, .Le169 - RTTI_$JNI_$$_def000000AD

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000AE
	.balign 8
.globl	RTTI_$JNI_$$_def000000AE
	.type	RTTI_$JNI_$$_def000000AE,#object
RTTI_$JNI_$$_def000000AE:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_SMALLINT$indirect
	.byte	4,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AClass"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JMETHODID$indirect
	.byte	8
	.ascii	"MethodID"
	.byte	0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJVALUE$indirect
	.byte	4
	.ascii	"Args"
	.byte	0,0,0,0,0,0,0
.Le170:
	.size	RTTI_$JNI_$$_def000000AE, .Le170 - RTTI_$JNI_$$_def000000AE

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000AF
	.balign 8
.globl	RTTI_$JNI_$$_def000000AF
	.type	RTTI_$JNI_$$_def000000AF,#object
RTTI_$JNI_$$_def000000AF:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_LONGINT$indirect
	.byte	3,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AClass"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JMETHODID$indirect
	.byte	8
	.ascii	"MethodID"
	.byte	0,0,0,0,0,0,0
.Le171:
	.size	RTTI_$JNI_$$_def000000AF, .Le171 - RTTI_$JNI_$$_def000000AF

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000B0
	.balign 8
.globl	RTTI_$JNI_$$_def000000B0
	.type	RTTI_$JNI_$$_def000000B0,#object
RTTI_$JNI_$$_def000000B0:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_LONGINT$indirect
	.byte	4,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AClass"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JMETHODID$indirect
	.byte	8
	.ascii	"MethodID"
	.byte	0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	4
	.ascii	"Args"
	.byte	0,0,0,0,0,0,0
.Le172:
	.size	RTTI_$JNI_$$_def000000B0, .Le172 - RTTI_$JNI_$$_def000000B0

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000B1
	.balign 8
.globl	RTTI_$JNI_$$_def000000B1
	.type	RTTI_$JNI_$$_def000000B1,#object
RTTI_$JNI_$$_def000000B1:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_LONGINT$indirect
	.byte	4,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AClass"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JMETHODID$indirect
	.byte	8
	.ascii	"MethodID"
	.byte	0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJVALUE$indirect
	.byte	4
	.ascii	"Args"
	.byte	0,0,0,0,0,0,0
.Le173:
	.size	RTTI_$JNI_$$_def000000B1, .Le173 - RTTI_$JNI_$$_def000000B1

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000B2
	.balign 8
.globl	RTTI_$JNI_$$_def000000B2
	.type	RTTI_$JNI_$$_def000000B2,#object
RTTI_$JNI_$$_def000000B2:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_INT64$indirect
	.byte	3,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AClass"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JMETHODID$indirect
	.byte	8
	.ascii	"MethodID"
	.byte	0,0,0,0,0,0,0
.Le174:
	.size	RTTI_$JNI_$$_def000000B2, .Le174 - RTTI_$JNI_$$_def000000B2

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000B3
	.balign 8
.globl	RTTI_$JNI_$$_def000000B3
	.type	RTTI_$JNI_$$_def000000B3,#object
RTTI_$JNI_$$_def000000B3:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_INT64$indirect
	.byte	4,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AClass"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JMETHODID$indirect
	.byte	8
	.ascii	"MethodID"
	.byte	0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	4
	.ascii	"Args"
	.byte	0,0,0,0,0,0,0
.Le175:
	.size	RTTI_$JNI_$$_def000000B3, .Le175 - RTTI_$JNI_$$_def000000B3

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000B4
	.balign 8
.globl	RTTI_$JNI_$$_def000000B4
	.type	RTTI_$JNI_$$_def000000B4,#object
RTTI_$JNI_$$_def000000B4:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_INT64$indirect
	.byte	4,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AClass"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JMETHODID$indirect
	.byte	8
	.ascii	"MethodID"
	.byte	0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJVALUE$indirect
	.byte	4
	.ascii	"Args"
	.byte	0,0,0,0,0,0,0
.Le176:
	.size	RTTI_$JNI_$$_def000000B4, .Le176 - RTTI_$JNI_$$_def000000B4

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000B5
	.balign 8
.globl	RTTI_$JNI_$$_def000000B5
	.type	RTTI_$JNI_$$_def000000B5,#object
RTTI_$JNI_$$_def000000B5:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_SINGLE$indirect
	.byte	3,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AClass"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JMETHODID$indirect
	.byte	8
	.ascii	"MethodID"
	.byte	0,0,0,0,0,0,0
.Le177:
	.size	RTTI_$JNI_$$_def000000B5, .Le177 - RTTI_$JNI_$$_def000000B5

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000B6
	.balign 8
.globl	RTTI_$JNI_$$_def000000B6
	.type	RTTI_$JNI_$$_def000000B6,#object
RTTI_$JNI_$$_def000000B6:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_SINGLE$indirect
	.byte	4,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AClass"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JMETHODID$indirect
	.byte	8
	.ascii	"MethodID"
	.byte	0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	4
	.ascii	"Args"
	.byte	0,0,0,0,0,0,0
.Le178:
	.size	RTTI_$JNI_$$_def000000B6, .Le178 - RTTI_$JNI_$$_def000000B6

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000B7
	.balign 8
.globl	RTTI_$JNI_$$_def000000B7
	.type	RTTI_$JNI_$$_def000000B7,#object
RTTI_$JNI_$$_def000000B7:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_SINGLE$indirect
	.byte	4,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AClass"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JMETHODID$indirect
	.byte	8
	.ascii	"MethodID"
	.byte	0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJVALUE$indirect
	.byte	4
	.ascii	"Args"
	.byte	0,0,0,0,0,0,0
.Le179:
	.size	RTTI_$JNI_$$_def000000B7, .Le179 - RTTI_$JNI_$$_def000000B7

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000B8
	.balign 8
.globl	RTTI_$JNI_$$_def000000B8
	.type	RTTI_$JNI_$$_def000000B8,#object
RTTI_$JNI_$$_def000000B8:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_DOUBLE$indirect
	.byte	3,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AClass"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JMETHODID$indirect
	.byte	8
	.ascii	"MethodID"
	.byte	0,0,0,0,0,0,0
.Le180:
	.size	RTTI_$JNI_$$_def000000B8, .Le180 - RTTI_$JNI_$$_def000000B8

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000B9
	.balign 8
.globl	RTTI_$JNI_$$_def000000B9
	.type	RTTI_$JNI_$$_def000000B9,#object
RTTI_$JNI_$$_def000000B9:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_DOUBLE$indirect
	.byte	4,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AClass"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JMETHODID$indirect
	.byte	8
	.ascii	"MethodID"
	.byte	0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	4
	.ascii	"Args"
	.byte	0,0,0,0,0,0,0
.Le181:
	.size	RTTI_$JNI_$$_def000000B9, .Le181 - RTTI_$JNI_$$_def000000B9

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000BA
	.balign 8
.globl	RTTI_$JNI_$$_def000000BA
	.type	RTTI_$JNI_$$_def000000BA,#object
RTTI_$JNI_$$_def000000BA:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_DOUBLE$indirect
	.byte	4,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AClass"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JMETHODID$indirect
	.byte	8
	.ascii	"MethodID"
	.byte	0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJVALUE$indirect
	.byte	4
	.ascii	"Args"
	.byte	0,0,0,0,0,0,0
.Le182:
	.size	RTTI_$JNI_$$_def000000BA, .Le182 - RTTI_$JNI_$$_def000000BA

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000BB
	.balign 8
.globl	RTTI_$JNI_$$_def000000BB
	.type	RTTI_$JNI_$$_def000000BB,#object
RTTI_$JNI_$$_def000000BB:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	0
	.byte	3,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AClass"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JMETHODID$indirect
	.byte	8
	.ascii	"MethodID"
	.byte	0,0,0,0,0,0,0
.Le183:
	.size	RTTI_$JNI_$$_def000000BB, .Le183 - RTTI_$JNI_$$_def000000BB

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000BC
	.balign 8
.globl	RTTI_$JNI_$$_def000000BC
	.type	RTTI_$JNI_$$_def000000BC,#object
RTTI_$JNI_$$_def000000BC:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	0
	.byte	4,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AClass"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JMETHODID$indirect
	.byte	8
	.ascii	"MethodID"
	.byte	0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	4
	.ascii	"Args"
	.byte	0,0,0,0,0,0,0
.Le184:
	.size	RTTI_$JNI_$$_def000000BC, .Le184 - RTTI_$JNI_$$_def000000BC

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000BD
	.balign 8
.globl	RTTI_$JNI_$$_def000000BD
	.type	RTTI_$JNI_$$_def000000BD,#object
RTTI_$JNI_$$_def000000BD:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	0
	.byte	4,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AClass"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JMETHODID$indirect
	.byte	8
	.ascii	"MethodID"
	.byte	0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJVALUE$indirect
	.byte	4
	.ascii	"Args"
	.byte	0,0,0,0,0,0,0
.Le185:
	.size	RTTI_$JNI_$$_def000000BD, .Le185 - RTTI_$JNI_$$_def000000BD

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000BE
	.balign 8
.globl	RTTI_$JNI_$$_def000000BE
	.type	RTTI_$JNI_$$_def000000BE,#object
RTTI_$JNI_$$_def000000BE:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$JNI_$$_JFIELDID$indirect
	.byte	4,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AClass"
	.byte	0
	.short	2
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_PCHAR$indirect
	.byte	4
	.ascii	"Name"
	.byte	0,0,0
	.short	2
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_PCHAR$indirect
	.byte	3
	.ascii	"Sig"
	.byte	0,0,0,0
.Le186:
	.size	RTTI_$JNI_$$_def000000BE, .Le186 - RTTI_$JNI_$$_def000000BE

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000BF
	.balign 8
.globl	RTTI_$JNI_$$_def000000BF
	.type	RTTI_$JNI_$$_def000000BF,#object
RTTI_$JNI_$$_def000000BF:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AClass"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JFIELDID$indirect
	.byte	7
	.ascii	"FieldID"
.Le187:
	.size	RTTI_$JNI_$$_def000000BF, .Le187 - RTTI_$JNI_$$_def000000BF

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000C0
	.balign 8
.globl	RTTI_$JNI_$$_def000000C0
	.type	RTTI_$JNI_$$_def000000C0,#object
RTTI_$JNI_$$_def000000C0:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_BYTE$indirect
	.byte	3,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AClass"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JFIELDID$indirect
	.byte	7
	.ascii	"FieldID"
.Le188:
	.size	RTTI_$JNI_$$_def000000C0, .Le188 - RTTI_$JNI_$$_def000000C0

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000C1
	.balign 8
.globl	RTTI_$JNI_$$_def000000C1
	.type	RTTI_$JNI_$$_def000000C1,#object
RTTI_$JNI_$$_def000000C1:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_SHORTINT$indirect
	.byte	3,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AClass"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JFIELDID$indirect
	.byte	7
	.ascii	"FieldID"
.Le189:
	.size	RTTI_$JNI_$$_def000000C1, .Le189 - RTTI_$JNI_$$_def000000C1

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000C2
	.balign 8
.globl	RTTI_$JNI_$$_def000000C2
	.type	RTTI_$JNI_$$_def000000C2,#object
RTTI_$JNI_$$_def000000C2:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_WORD$indirect
	.byte	3,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AClass"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JFIELDID$indirect
	.byte	7
	.ascii	"FieldID"
.Le190:
	.size	RTTI_$JNI_$$_def000000C2, .Le190 - RTTI_$JNI_$$_def000000C2

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000C3
	.balign 8
.globl	RTTI_$JNI_$$_def000000C3
	.type	RTTI_$JNI_$$_def000000C3,#object
RTTI_$JNI_$$_def000000C3:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_SMALLINT$indirect
	.byte	3,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AClass"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JFIELDID$indirect
	.byte	7
	.ascii	"FieldID"
.Le191:
	.size	RTTI_$JNI_$$_def000000C3, .Le191 - RTTI_$JNI_$$_def000000C3

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000C4
	.balign 8
.globl	RTTI_$JNI_$$_def000000C4
	.type	RTTI_$JNI_$$_def000000C4,#object
RTTI_$JNI_$$_def000000C4:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_LONGINT$indirect
	.byte	3,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AClass"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JFIELDID$indirect
	.byte	7
	.ascii	"FieldID"
.Le192:
	.size	RTTI_$JNI_$$_def000000C4, .Le192 - RTTI_$JNI_$$_def000000C4

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000C5
	.balign 8
.globl	RTTI_$JNI_$$_def000000C5
	.type	RTTI_$JNI_$$_def000000C5,#object
RTTI_$JNI_$$_def000000C5:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_INT64$indirect
	.byte	3,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AClass"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JFIELDID$indirect
	.byte	7
	.ascii	"FieldID"
.Le193:
	.size	RTTI_$JNI_$$_def000000C5, .Le193 - RTTI_$JNI_$$_def000000C5

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000C6
	.balign 8
.globl	RTTI_$JNI_$$_def000000C6
	.type	RTTI_$JNI_$$_def000000C6,#object
RTTI_$JNI_$$_def000000C6:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_SINGLE$indirect
	.byte	3,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AClass"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JFIELDID$indirect
	.byte	7
	.ascii	"FieldID"
.Le194:
	.size	RTTI_$JNI_$$_def000000C6, .Le194 - RTTI_$JNI_$$_def000000C6

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000C7
	.balign 8
.globl	RTTI_$JNI_$$_def000000C7
	.type	RTTI_$JNI_$$_def000000C7,#object
RTTI_$JNI_$$_def000000C7:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_DOUBLE$indirect
	.byte	3,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AClass"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JFIELDID$indirect
	.byte	7
	.ascii	"FieldID"
.Le195:
	.size	RTTI_$JNI_$$_def000000C7, .Le195 - RTTI_$JNI_$$_def000000C7

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000C8
	.balign 8
.globl	RTTI_$JNI_$$_def000000C8
	.type	RTTI_$JNI_$$_def000000C8,#object
RTTI_$JNI_$$_def000000C8:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	0
	.byte	4,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AClass"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JFIELDID$indirect
	.byte	7
	.ascii	"FieldID"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Val"
	.byte	0,0,0,0
.Le196:
	.size	RTTI_$JNI_$$_def000000C8, .Le196 - RTTI_$JNI_$$_def000000C8

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000C9
	.balign 8
.globl	RTTI_$JNI_$$_def000000C9
	.type	RTTI_$JNI_$$_def000000C9,#object
RTTI_$JNI_$$_def000000C9:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	0
	.byte	4,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AClass"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JFIELDID$indirect
	.byte	7
	.ascii	"FieldID"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_BYTE$indirect
	.byte	3
	.ascii	"Val"
	.byte	0,0,0,0
.Le197:
	.size	RTTI_$JNI_$$_def000000C9, .Le197 - RTTI_$JNI_$$_def000000C9

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000CA
	.balign 8
.globl	RTTI_$JNI_$$_def000000CA
	.type	RTTI_$JNI_$$_def000000CA,#object
RTTI_$JNI_$$_def000000CA:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	0
	.byte	4,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AClass"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JFIELDID$indirect
	.byte	7
	.ascii	"FieldID"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_SHORTINT$indirect
	.byte	3
	.ascii	"Val"
	.byte	0,0,0,0
.Le198:
	.size	RTTI_$JNI_$$_def000000CA, .Le198 - RTTI_$JNI_$$_def000000CA

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000CB
	.balign 8
.globl	RTTI_$JNI_$$_def000000CB
	.type	RTTI_$JNI_$$_def000000CB,#object
RTTI_$JNI_$$_def000000CB:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	0
	.byte	4,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AClass"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JFIELDID$indirect
	.byte	7
	.ascii	"FieldID"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_WORD$indirect
	.byte	3
	.ascii	"Val"
	.byte	0,0,0,0
.Le199:
	.size	RTTI_$JNI_$$_def000000CB, .Le199 - RTTI_$JNI_$$_def000000CB

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000CC
	.balign 8
.globl	RTTI_$JNI_$$_def000000CC
	.type	RTTI_$JNI_$$_def000000CC,#object
RTTI_$JNI_$$_def000000CC:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	0
	.byte	4,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AClass"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JFIELDID$indirect
	.byte	7
	.ascii	"FieldID"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_SMALLINT$indirect
	.byte	3
	.ascii	"Val"
	.byte	0,0,0,0
.Le200:
	.size	RTTI_$JNI_$$_def000000CC, .Le200 - RTTI_$JNI_$$_def000000CC

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000CD
	.balign 8
.globl	RTTI_$JNI_$$_def000000CD
	.type	RTTI_$JNI_$$_def000000CD,#object
RTTI_$JNI_$$_def000000CD:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	0
	.byte	4,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AClass"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JFIELDID$indirect
	.byte	7
	.ascii	"FieldID"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_LONGINT$indirect
	.byte	3
	.ascii	"Val"
	.byte	0,0,0,0
.Le201:
	.size	RTTI_$JNI_$$_def000000CD, .Le201 - RTTI_$JNI_$$_def000000CD

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000CE
	.balign 8
.globl	RTTI_$JNI_$$_def000000CE
	.type	RTTI_$JNI_$$_def000000CE,#object
RTTI_$JNI_$$_def000000CE:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	0
	.byte	4,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AClass"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JFIELDID$indirect
	.byte	7
	.ascii	"FieldID"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_INT64$indirect
	.byte	3
	.ascii	"Val"
	.byte	0,0,0,0
.Le202:
	.size	RTTI_$JNI_$$_def000000CE, .Le202 - RTTI_$JNI_$$_def000000CE

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000CF
	.balign 8
.globl	RTTI_$JNI_$$_def000000CF
	.type	RTTI_$JNI_$$_def000000CF,#object
RTTI_$JNI_$$_def000000CF:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	0
	.byte	4,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AClass"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JFIELDID$indirect
	.byte	7
	.ascii	"FieldID"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_SINGLE$indirect
	.byte	3
	.ascii	"Val"
	.byte	0,0,0,0
.Le203:
	.size	RTTI_$JNI_$$_def000000CF, .Le203 - RTTI_$JNI_$$_def000000CF

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000D0
	.balign 8
.globl	RTTI_$JNI_$$_def000000D0
	.type	RTTI_$JNI_$$_def000000D0,#object
RTTI_$JNI_$$_def000000D0:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	0
	.byte	4,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AClass"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_JFIELDID$indirect
	.byte	7
	.ascii	"FieldID"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_DOUBLE$indirect
	.byte	3
	.ascii	"Val"
	.byte	0,0,0,0
.Le204:
	.size	RTTI_$JNI_$$_def000000D0, .Le204 - RTTI_$JNI_$$_def000000D0

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000D1
	.balign 8
.globl	RTTI_$JNI_$$_def000000D1
	.type	RTTI_$JNI_$$_def000000D1,#object
RTTI_$JNI_$$_def000000D1:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	2
	.byte	0,0
	.long	RTTI_$JNI_$$_PJCHAR$indirect
	.byte	7
	.ascii	"Unicode"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_LONGINT$indirect
	.byte	3
	.ascii	"Len"
	.byte	0,0,0,0
.Le205:
	.size	RTTI_$JNI_$$_def000000D1, .Le205 - RTTI_$JNI_$$_def000000D1

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000D2
	.balign 8
.globl	RTTI_$JNI_$$_def000000D2
	.type	RTTI_$JNI_$$_def000000D2,#object
RTTI_$JNI_$$_def000000D2:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_LONGINT$indirect
	.byte	2,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Str"
	.byte	0,0,0,0
.Le206:
	.size	RTTI_$JNI_$$_def000000D2, .Le206 - RTTI_$JNI_$$_def000000D2

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000D3
	.balign 8
.globl	RTTI_$JNI_$$_def000000D3
	.type	RTTI_$JNI_$$_def000000D3,#object
RTTI_$JNI_$$_def000000D3:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$JNI_$$_PJCHAR$indirect
	.byte	3,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Str"
	.short	1
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_BYTE$indirect
	.byte	6
	.ascii	"IsCopy"
	.byte	0,0,0,0,0
.Le207:
	.size	RTTI_$JNI_$$_def000000D3, .Le207 - RTTI_$JNI_$$_def000000D3

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000D4
	.balign 8
.globl	RTTI_$JNI_$$_def000000D4
	.type	RTTI_$JNI_$$_def000000D4,#object
RTTI_$JNI_$$_def000000D4:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	0
	.byte	3,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Str"
	.short	2
	.byte	0,0
	.long	RTTI_$JNI_$$_PJCHAR$indirect
	.byte	5
	.ascii	"Chars"
	.byte	0,0,0,0,0,0
.Le208:
	.size	RTTI_$JNI_$$_def000000D4, .Le208 - RTTI_$JNI_$$_def000000D4

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000D5
	.balign 8
.globl	RTTI_$JNI_$$_def000000D5
	.type	RTTI_$JNI_$$_def000000D5,#object
RTTI_$JNI_$$_def000000D5:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	2,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	2
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_PCHAR$indirect
	.byte	3
	.ascii	"UTF"
	.byte	0,0,0,0
.Le209:
	.size	RTTI_$JNI_$$_def000000D5, .Le209 - RTTI_$JNI_$$_def000000D5

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000D6
	.balign 8
.globl	RTTI_$JNI_$$_def000000D6
	.type	RTTI_$JNI_$$_def000000D6,#object
RTTI_$JNI_$$_def000000D6:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_LONGINT$indirect
	.byte	2,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Str"
	.byte	0,0,0,0
.Le210:
	.size	RTTI_$JNI_$$_def000000D6, .Le210 - RTTI_$JNI_$$_def000000D6

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000D7
	.balign 8
.globl	RTTI_$JNI_$$_def000000D7
	.type	RTTI_$JNI_$$_def000000D7,#object
RTTI_$JNI_$$_def000000D7:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_PCHAR$indirect
	.byte	3,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Str"
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJBOOLEAN$indirect
	.byte	6
	.ascii	"IsCopy"
	.byte	0,0,0,0,0
.Le211:
	.size	RTTI_$JNI_$$_def000000D7, .Le211 - RTTI_$JNI_$$_def000000D7

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000D8
	.balign 8
.globl	RTTI_$JNI_$$_def000000D8
	.type	RTTI_$JNI_$$_def000000D8,#object
RTTI_$JNI_$$_def000000D8:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	0
	.byte	3,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Str"
	.short	2
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_PCHAR$indirect
	.byte	5
	.ascii	"Chars"
	.byte	0,0,0,0,0,0
.Le212:
	.size	RTTI_$JNI_$$_def000000D8, .Le212 - RTTI_$JNI_$$_def000000D8

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000D9
	.balign 8
.globl	RTTI_$JNI_$$_def000000D9
	.type	RTTI_$JNI_$$_def000000D9,#object
RTTI_$JNI_$$_def000000D9:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_LONGINT$indirect
	.byte	2,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AArray"
	.byte	0
.Le213:
	.size	RTTI_$JNI_$$_def000000D9, .Le213 - RTTI_$JNI_$$_def000000D9

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000DA
	.balign 8
.globl	RTTI_$JNI_$$_def000000DA
	.type	RTTI_$JNI_$$_def000000DA,#object
RTTI_$JNI_$$_def000000DA:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	4,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_LONGINT$indirect
	.byte	3
	.ascii	"Len"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AClass"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	4
	.ascii	"Init"
	.byte	0,0,0,0,0,0,0
.Le214:
	.size	RTTI_$JNI_$$_def000000DA, .Le214 - RTTI_$JNI_$$_def000000DA

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000DB
	.balign 8
.globl	RTTI_$JNI_$$_def000000DB
	.type	RTTI_$JNI_$$_def000000DB,#object
RTTI_$JNI_$$_def000000DB:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AArray"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_LONGINT$indirect
	.byte	5
	.ascii	"Index"
	.byte	0,0
.Le215:
	.size	RTTI_$JNI_$$_def000000DB, .Le215 - RTTI_$JNI_$$_def000000DB

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000DC
	.balign 8
.globl	RTTI_$JNI_$$_def000000DC
	.type	RTTI_$JNI_$$_def000000DC,#object
RTTI_$JNI_$$_def000000DC:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	0
	.byte	4,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AArray"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_LONGINT$indirect
	.byte	5
	.ascii	"Index"
	.byte	0,0
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Val"
	.byte	0,0,0,0
.Le216:
	.size	RTTI_$JNI_$$_def000000DC, .Le216 - RTTI_$JNI_$$_def000000DC

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000DD
	.balign 8
.globl	RTTI_$JNI_$$_def000000DD
	.type	RTTI_$JNI_$$_def000000DD,#object
RTTI_$JNI_$$_def000000DD:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	2,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_LONGINT$indirect
	.byte	3
	.ascii	"Len"
	.byte	0,0,0,0
.Le217:
	.size	RTTI_$JNI_$$_def000000DD, .Le217 - RTTI_$JNI_$$_def000000DD

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000DE
	.balign 8
.globl	RTTI_$JNI_$$_def000000DE
	.type	RTTI_$JNI_$$_def000000DE,#object
RTTI_$JNI_$$_def000000DE:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	2,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_LONGINT$indirect
	.byte	3
	.ascii	"Len"
	.byte	0,0,0,0
.Le218:
	.size	RTTI_$JNI_$$_def000000DE, .Le218 - RTTI_$JNI_$$_def000000DE

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000DF
	.balign 8
.globl	RTTI_$JNI_$$_def000000DF
	.type	RTTI_$JNI_$$_def000000DF,#object
RTTI_$JNI_$$_def000000DF:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	2,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_LONGINT$indirect
	.byte	3
	.ascii	"Len"
	.byte	0,0,0,0
.Le219:
	.size	RTTI_$JNI_$$_def000000DF, .Le219 - RTTI_$JNI_$$_def000000DF

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000E0
	.balign 8
.globl	RTTI_$JNI_$$_def000000E0
	.type	RTTI_$JNI_$$_def000000E0,#object
RTTI_$JNI_$$_def000000E0:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	2,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_LONGINT$indirect
	.byte	3
	.ascii	"Len"
	.byte	0,0,0,0
.Le220:
	.size	RTTI_$JNI_$$_def000000E0, .Le220 - RTTI_$JNI_$$_def000000E0

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000E1
	.balign 8
.globl	RTTI_$JNI_$$_def000000E1
	.type	RTTI_$JNI_$$_def000000E1,#object
RTTI_$JNI_$$_def000000E1:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	2,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_LONGINT$indirect
	.byte	3
	.ascii	"Len"
	.byte	0,0,0,0
.Le221:
	.size	RTTI_$JNI_$$_def000000E1, .Le221 - RTTI_$JNI_$$_def000000E1

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000E2
	.balign 8
.globl	RTTI_$JNI_$$_def000000E2
	.type	RTTI_$JNI_$$_def000000E2,#object
RTTI_$JNI_$$_def000000E2:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	2,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_LONGINT$indirect
	.byte	3
	.ascii	"Len"
	.byte	0,0,0,0
.Le222:
	.size	RTTI_$JNI_$$_def000000E2, .Le222 - RTTI_$JNI_$$_def000000E2

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000E3
	.balign 8
.globl	RTTI_$JNI_$$_def000000E3
	.type	RTTI_$JNI_$$_def000000E3,#object
RTTI_$JNI_$$_def000000E3:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	2,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_LONGINT$indirect
	.byte	3
	.ascii	"Len"
	.byte	0,0,0,0
.Le223:
	.size	RTTI_$JNI_$$_def000000E3, .Le223 - RTTI_$JNI_$$_def000000E3

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000E4
	.balign 8
.globl	RTTI_$JNI_$$_def000000E4
	.type	RTTI_$JNI_$$_def000000E4,#object
RTTI_$JNI_$$_def000000E4:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	2,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_LONGINT$indirect
	.byte	3
	.ascii	"Len"
	.byte	0,0,0,0
.Le224:
	.size	RTTI_$JNI_$$_def000000E4, .Le224 - RTTI_$JNI_$$_def000000E4

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000E5
	.balign 8
.globl	RTTI_$JNI_$$_def000000E5
	.type	RTTI_$JNI_$$_def000000E5,#object
RTTI_$JNI_$$_def000000E5:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$JNI_$$_PJBOOLEAN$indirect
	.byte	3,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AArray"
	.byte	0
	.short	1
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_BYTE$indirect
	.byte	6
	.ascii	"IsCopy"
	.byte	0
.Le225:
	.size	RTTI_$JNI_$$_def000000E5, .Le225 - RTTI_$JNI_$$_def000000E5

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000E6
	.balign 8
.globl	RTTI_$JNI_$$_def000000E6
	.type	RTTI_$JNI_$$_def000000E6,#object
RTTI_$JNI_$$_def000000E6:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$JNI_$$_PJBYTE$indirect
	.byte	3,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AArray"
	.byte	0
	.short	1
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_BYTE$indirect
	.byte	6
	.ascii	"IsCopy"
	.byte	0
.Le226:
	.size	RTTI_$JNI_$$_def000000E6, .Le226 - RTTI_$JNI_$$_def000000E6

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000E7
	.balign 8
.globl	RTTI_$JNI_$$_def000000E7
	.type	RTTI_$JNI_$$_def000000E7,#object
RTTI_$JNI_$$_def000000E7:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$JNI_$$_PJCHAR$indirect
	.byte	3,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AArray"
	.byte	0
	.short	1
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_BYTE$indirect
	.byte	6
	.ascii	"IsCopy"
	.byte	0
.Le227:
	.size	RTTI_$JNI_$$_def000000E7, .Le227 - RTTI_$JNI_$$_def000000E7

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000E8
	.balign 8
.globl	RTTI_$JNI_$$_def000000E8
	.type	RTTI_$JNI_$$_def000000E8,#object
RTTI_$JNI_$$_def000000E8:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$JNI_$$_PJSHORT$indirect
	.byte	3,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AArray"
	.byte	0
	.short	1
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_BYTE$indirect
	.byte	6
	.ascii	"IsCopy"
	.byte	0
.Le228:
	.size	RTTI_$JNI_$$_def000000E8, .Le228 - RTTI_$JNI_$$_def000000E8

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000E9
	.balign 8
.globl	RTTI_$JNI_$$_def000000E9
	.type	RTTI_$JNI_$$_def000000E9,#object
RTTI_$JNI_$$_def000000E9:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$JNI_$$_PJINT$indirect
	.byte	3,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AArray"
	.byte	0
	.short	1
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_BYTE$indirect
	.byte	6
	.ascii	"IsCopy"
	.byte	0
.Le229:
	.size	RTTI_$JNI_$$_def000000E9, .Le229 - RTTI_$JNI_$$_def000000E9

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000EA
	.balign 8
.globl	RTTI_$JNI_$$_def000000EA
	.type	RTTI_$JNI_$$_def000000EA,#object
RTTI_$JNI_$$_def000000EA:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$JNI_$$_PJLONG$indirect
	.byte	3,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AArray"
	.byte	0
	.short	1
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_BYTE$indirect
	.byte	6
	.ascii	"IsCopy"
	.byte	0
.Le230:
	.size	RTTI_$JNI_$$_def000000EA, .Le230 - RTTI_$JNI_$$_def000000EA

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000EB
	.balign 8
.globl	RTTI_$JNI_$$_def000000EB
	.type	RTTI_$JNI_$$_def000000EB,#object
RTTI_$JNI_$$_def000000EB:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$JNI_$$_PJFLOAT$indirect
	.byte	3,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AArray"
	.byte	0
	.short	1
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_BYTE$indirect
	.byte	6
	.ascii	"IsCopy"
	.byte	0
.Le231:
	.size	RTTI_$JNI_$$_def000000EB, .Le231 - RTTI_$JNI_$$_def000000EB

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000EC
	.balign 8
.globl	RTTI_$JNI_$$_def000000EC
	.type	RTTI_$JNI_$$_def000000EC,#object
RTTI_$JNI_$$_def000000EC:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$JNI_$$_PJDOUBLE$indirect
	.byte	3,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AArray"
	.byte	0
	.short	1
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_BYTE$indirect
	.byte	6
	.ascii	"IsCopy"
	.byte	0
.Le232:
	.size	RTTI_$JNI_$$_def000000EC, .Le232 - RTTI_$JNI_$$_def000000EC

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000ED
	.balign 8
.globl	RTTI_$JNI_$$_def000000ED
	.type	RTTI_$JNI_$$_def000000ED,#object
RTTI_$JNI_$$_def000000ED:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	0
	.byte	4,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AArray"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJBOOLEAN$indirect
	.byte	5
	.ascii	"Elems"
	.byte	0,0
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_LONGINT$indirect
	.byte	4
	.ascii	"Mode"
	.byte	0,0,0
.Le233:
	.size	RTTI_$JNI_$$_def000000ED, .Le233 - RTTI_$JNI_$$_def000000ED

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000EE
	.balign 8
.globl	RTTI_$JNI_$$_def000000EE
	.type	RTTI_$JNI_$$_def000000EE,#object
RTTI_$JNI_$$_def000000EE:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	0
	.byte	4,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AArray"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJBYTE$indirect
	.byte	5
	.ascii	"Elems"
	.byte	0,0
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_LONGINT$indirect
	.byte	4
	.ascii	"Mode"
	.byte	0,0,0
.Le234:
	.size	RTTI_$JNI_$$_def000000EE, .Le234 - RTTI_$JNI_$$_def000000EE

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000EF
	.balign 8
.globl	RTTI_$JNI_$$_def000000EF
	.type	RTTI_$JNI_$$_def000000EF,#object
RTTI_$JNI_$$_def000000EF:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	0
	.byte	4,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AArray"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJCHAR$indirect
	.byte	5
	.ascii	"Elems"
	.byte	0,0
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_LONGINT$indirect
	.byte	4
	.ascii	"Mode"
	.byte	0,0,0
.Le235:
	.size	RTTI_$JNI_$$_def000000EF, .Le235 - RTTI_$JNI_$$_def000000EF

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000F0
	.balign 8
.globl	RTTI_$JNI_$$_def000000F0
	.type	RTTI_$JNI_$$_def000000F0,#object
RTTI_$JNI_$$_def000000F0:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	0
	.byte	4,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AArray"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJSHORT$indirect
	.byte	5
	.ascii	"Elems"
	.byte	0,0
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_LONGINT$indirect
	.byte	4
	.ascii	"Mode"
	.byte	0,0,0
.Le236:
	.size	RTTI_$JNI_$$_def000000F0, .Le236 - RTTI_$JNI_$$_def000000F0

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000F1
	.balign 8
.globl	RTTI_$JNI_$$_def000000F1
	.type	RTTI_$JNI_$$_def000000F1,#object
RTTI_$JNI_$$_def000000F1:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	0
	.byte	4,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AArray"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJINT$indirect
	.byte	5
	.ascii	"Elems"
	.byte	0,0
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_LONGINT$indirect
	.byte	4
	.ascii	"Mode"
	.byte	0,0,0
.Le237:
	.size	RTTI_$JNI_$$_def000000F1, .Le237 - RTTI_$JNI_$$_def000000F1

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000F2
	.balign 8
.globl	RTTI_$JNI_$$_def000000F2
	.type	RTTI_$JNI_$$_def000000F2,#object
RTTI_$JNI_$$_def000000F2:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	0
	.byte	4,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AArray"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJLONG$indirect
	.byte	5
	.ascii	"Elems"
	.byte	0,0
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_LONGINT$indirect
	.byte	4
	.ascii	"Mode"
	.byte	0,0,0
.Le238:
	.size	RTTI_$JNI_$$_def000000F2, .Le238 - RTTI_$JNI_$$_def000000F2

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000F3
	.balign 8
.globl	RTTI_$JNI_$$_def000000F3
	.type	RTTI_$JNI_$$_def000000F3,#object
RTTI_$JNI_$$_def000000F3:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	0
	.byte	4,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AArray"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJFLOAT$indirect
	.byte	5
	.ascii	"Elems"
	.byte	0,0
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_LONGINT$indirect
	.byte	4
	.ascii	"Mode"
	.byte	0,0,0
.Le239:
	.size	RTTI_$JNI_$$_def000000F3, .Le239 - RTTI_$JNI_$$_def000000F3

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000F4
	.balign 8
.globl	RTTI_$JNI_$$_def000000F4
	.type	RTTI_$JNI_$$_def000000F4,#object
RTTI_$JNI_$$_def000000F4:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	0
	.byte	4,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AArray"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJDOUBLE$indirect
	.byte	5
	.ascii	"Elems"
	.byte	0,0
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_LONGINT$indirect
	.byte	4
	.ascii	"Mode"
	.byte	0,0,0
.Le240:
	.size	RTTI_$JNI_$$_def000000F4, .Le240 - RTTI_$JNI_$$_def000000F4

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000F5
	.balign 8
.globl	RTTI_$JNI_$$_def000000F5
	.type	RTTI_$JNI_$$_def000000F5,#object
RTTI_$JNI_$$_def000000F5:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	0
	.byte	5,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AArray"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_LONGINT$indirect
	.byte	5
	.ascii	"Start"
	.byte	0,0
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_LONGINT$indirect
	.byte	3
	.ascii	"Len"
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJBOOLEAN$indirect
	.byte	3
	.ascii	"Buf"
.Le241:
	.size	RTTI_$JNI_$$_def000000F5, .Le241 - RTTI_$JNI_$$_def000000F5

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000F6
	.balign 8
.globl	RTTI_$JNI_$$_def000000F6
	.type	RTTI_$JNI_$$_def000000F6,#object
RTTI_$JNI_$$_def000000F6:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	0
	.byte	5,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AArray"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_LONGINT$indirect
	.byte	5
	.ascii	"Start"
	.byte	0,0
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_LONGINT$indirect
	.byte	3
	.ascii	"Len"
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJBYTE$indirect
	.byte	3
	.ascii	"Buf"
.Le242:
	.size	RTTI_$JNI_$$_def000000F6, .Le242 - RTTI_$JNI_$$_def000000F6

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000F7
	.balign 8
.globl	RTTI_$JNI_$$_def000000F7
	.type	RTTI_$JNI_$$_def000000F7,#object
RTTI_$JNI_$$_def000000F7:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	0
	.byte	5,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AArray"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_LONGINT$indirect
	.byte	5
	.ascii	"Start"
	.byte	0,0
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_LONGINT$indirect
	.byte	3
	.ascii	"Len"
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJCHAR$indirect
	.byte	3
	.ascii	"Buf"
.Le243:
	.size	RTTI_$JNI_$$_def000000F7, .Le243 - RTTI_$JNI_$$_def000000F7

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000F8
	.balign 8
.globl	RTTI_$JNI_$$_def000000F8
	.type	RTTI_$JNI_$$_def000000F8,#object
RTTI_$JNI_$$_def000000F8:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	0
	.byte	5,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AArray"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_LONGINT$indirect
	.byte	5
	.ascii	"Start"
	.byte	0,0
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_LONGINT$indirect
	.byte	3
	.ascii	"Len"
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJSHORT$indirect
	.byte	3
	.ascii	"Buf"
.Le244:
	.size	RTTI_$JNI_$$_def000000F8, .Le244 - RTTI_$JNI_$$_def000000F8

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000F9
	.balign 8
.globl	RTTI_$JNI_$$_def000000F9
	.type	RTTI_$JNI_$$_def000000F9,#object
RTTI_$JNI_$$_def000000F9:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	0
	.byte	5,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AArray"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_LONGINT$indirect
	.byte	5
	.ascii	"Start"
	.byte	0,0
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_LONGINT$indirect
	.byte	3
	.ascii	"Len"
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJINT$indirect
	.byte	3
	.ascii	"Buf"
.Le245:
	.size	RTTI_$JNI_$$_def000000F9, .Le245 - RTTI_$JNI_$$_def000000F9

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000FA
	.balign 8
.globl	RTTI_$JNI_$$_def000000FA
	.type	RTTI_$JNI_$$_def000000FA,#object
RTTI_$JNI_$$_def000000FA:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	0
	.byte	5,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AArray"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_LONGINT$indirect
	.byte	5
	.ascii	"Start"
	.byte	0,0
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_LONGINT$indirect
	.byte	3
	.ascii	"Len"
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJLONG$indirect
	.byte	3
	.ascii	"Buf"
.Le246:
	.size	RTTI_$JNI_$$_def000000FA, .Le246 - RTTI_$JNI_$$_def000000FA

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000FB
	.balign 8
.globl	RTTI_$JNI_$$_def000000FB
	.type	RTTI_$JNI_$$_def000000FB,#object
RTTI_$JNI_$$_def000000FB:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	0
	.byte	5,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AArray"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_LONGINT$indirect
	.byte	5
	.ascii	"Start"
	.byte	0,0
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_LONGINT$indirect
	.byte	3
	.ascii	"Len"
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJFLOAT$indirect
	.byte	3
	.ascii	"Buf"
.Le247:
	.size	RTTI_$JNI_$$_def000000FB, .Le247 - RTTI_$JNI_$$_def000000FB

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000FC
	.balign 8
.globl	RTTI_$JNI_$$_def000000FC
	.type	RTTI_$JNI_$$_def000000FC,#object
RTTI_$JNI_$$_def000000FC:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	0
	.byte	5,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AArray"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_LONGINT$indirect
	.byte	5
	.ascii	"Start"
	.byte	0,0
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_LONGINT$indirect
	.byte	3
	.ascii	"Len"
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJDOUBLE$indirect
	.byte	3
	.ascii	"Buf"
.Le248:
	.size	RTTI_$JNI_$$_def000000FC, .Le248 - RTTI_$JNI_$$_def000000FC

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000FD
	.balign 8
.globl	RTTI_$JNI_$$_def000000FD
	.type	RTTI_$JNI_$$_def000000FD,#object
RTTI_$JNI_$$_def000000FD:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	0
	.byte	5,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AArray"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_LONGINT$indirect
	.byte	5
	.ascii	"Start"
	.byte	0,0
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_LONGINT$indirect
	.byte	3
	.ascii	"Len"
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJBOOLEAN$indirect
	.byte	3
	.ascii	"Buf"
.Le249:
	.size	RTTI_$JNI_$$_def000000FD, .Le249 - RTTI_$JNI_$$_def000000FD

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000FE
	.balign 8
.globl	RTTI_$JNI_$$_def000000FE
	.type	RTTI_$JNI_$$_def000000FE,#object
RTTI_$JNI_$$_def000000FE:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	0
	.byte	5,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AArray"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_LONGINT$indirect
	.byte	5
	.ascii	"Start"
	.byte	0,0
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_LONGINT$indirect
	.byte	3
	.ascii	"Len"
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJBYTE$indirect
	.byte	3
	.ascii	"Buf"
.Le250:
	.size	RTTI_$JNI_$$_def000000FE, .Le250 - RTTI_$JNI_$$_def000000FE

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000FF
	.balign 8
.globl	RTTI_$JNI_$$_def000000FF
	.type	RTTI_$JNI_$$_def000000FF,#object
RTTI_$JNI_$$_def000000FF:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	0
	.byte	5,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AArray"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_LONGINT$indirect
	.byte	5
	.ascii	"Start"
	.byte	0,0
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_LONGINT$indirect
	.byte	3
	.ascii	"Len"
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJCHAR$indirect
	.byte	3
	.ascii	"Buf"
.Le251:
	.size	RTTI_$JNI_$$_def000000FF, .Le251 - RTTI_$JNI_$$_def000000FF

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000100
	.balign 8
.globl	RTTI_$JNI_$$_def00000100
	.type	RTTI_$JNI_$$_def00000100,#object
RTTI_$JNI_$$_def00000100:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	0
	.byte	5,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AArray"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_LONGINT$indirect
	.byte	5
	.ascii	"Start"
	.byte	0,0
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_LONGINT$indirect
	.byte	3
	.ascii	"Len"
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJSHORT$indirect
	.byte	3
	.ascii	"Buf"
.Le252:
	.size	RTTI_$JNI_$$_def00000100, .Le252 - RTTI_$JNI_$$_def00000100

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000101
	.balign 8
.globl	RTTI_$JNI_$$_def00000101
	.type	RTTI_$JNI_$$_def00000101,#object
RTTI_$JNI_$$_def00000101:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	0
	.byte	5,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AArray"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_LONGINT$indirect
	.byte	5
	.ascii	"Start"
	.byte	0,0
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_LONGINT$indirect
	.byte	3
	.ascii	"Len"
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJINT$indirect
	.byte	3
	.ascii	"Buf"
.Le253:
	.size	RTTI_$JNI_$$_def00000101, .Le253 - RTTI_$JNI_$$_def00000101

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000102
	.balign 8
.globl	RTTI_$JNI_$$_def00000102
	.type	RTTI_$JNI_$$_def00000102,#object
RTTI_$JNI_$$_def00000102:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	0
	.byte	5,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AArray"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_LONGINT$indirect
	.byte	5
	.ascii	"Start"
	.byte	0,0
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_LONGINT$indirect
	.byte	3
	.ascii	"Len"
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJLONG$indirect
	.byte	3
	.ascii	"Buf"
.Le254:
	.size	RTTI_$JNI_$$_def00000102, .Le254 - RTTI_$JNI_$$_def00000102

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000103
	.balign 8
.globl	RTTI_$JNI_$$_def00000103
	.type	RTTI_$JNI_$$_def00000103,#object
RTTI_$JNI_$$_def00000103:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	0
	.byte	5,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AArray"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_LONGINT$indirect
	.byte	5
	.ascii	"Start"
	.byte	0,0
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_LONGINT$indirect
	.byte	3
	.ascii	"Len"
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJFLOAT$indirect
	.byte	3
	.ascii	"Buf"
.Le255:
	.size	RTTI_$JNI_$$_def00000103, .Le255 - RTTI_$JNI_$$_def00000103

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000104
	.balign 8
.globl	RTTI_$JNI_$$_def00000104
	.type	RTTI_$JNI_$$_def00000104,#object
RTTI_$JNI_$$_def00000104:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	0
	.byte	5,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AArray"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_LONGINT$indirect
	.byte	5
	.ascii	"Start"
	.byte	0,0
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_LONGINT$indirect
	.byte	3
	.ascii	"Len"
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJDOUBLE$indirect
	.byte	3
	.ascii	"Buf"
.Le256:
	.size	RTTI_$JNI_$$_def00000104, .Le256 - RTTI_$JNI_$$_def00000104

.section .data.rel.ro.n_INIT_$JNI_$$_JNINATIVEMETHOD
	.balign 8
.globl	INIT_$JNI_$$_JNINATIVEMETHOD
	.type	INIT_$JNI_$$_JNINATIVEMETHOD,#object
INIT_$JNI_$$_JNINATIVEMETHOD:
	.byte	13,15
	.ascii	"JNINativeMethod"
	.byte	0,0,0,0,0,0,0
	.long	0,12,0,0,0
	.byte	0,0,0,0
.Le257:
	.size	INIT_$JNI_$$_JNINATIVEMETHOD, .Le257 - INIT_$JNI_$$_JNINATIVEMETHOD

.section .data.rel.ro.n_RTTI_$JNI_$$_JNINATIVEMETHOD
	.balign 8
.globl	RTTI_$JNI_$$_JNINATIVEMETHOD
	.type	RTTI_$JNI_$$_JNINATIVEMETHOD,#object
RTTI_$JNI_$$_JNINATIVEMETHOD:
	.byte	13,15
	.ascii	"JNINativeMethod"
	.byte	0,0,0,0,0,0,0
	.long	INIT_$JNI_$$_JNINATIVEMETHOD
	.long	12,3
	.long	RTTI_$SYSTEM_$$_PCHAR$indirect
	.long	0
	.long	RTTI_$SYSTEM_$$_PCHAR$indirect
	.long	4
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.long	8
	.byte	0,0,0,0
.Le258:
	.size	RTTI_$JNI_$$_JNINATIVEMETHOD, .Le258 - RTTI_$JNI_$$_JNINATIVEMETHOD

.section .data.rel.ro.n_RTTI_$JNI_$$_PJNINATIVEMETHOD
	.balign 8
.globl	RTTI_$JNI_$$_PJNINATIVEMETHOD
	.type	RTTI_$JNI_$$_PJNINATIVEMETHOD,#object
RTTI_$JNI_$$_PJNINATIVEMETHOD:
	.byte	29,16
	.ascii	"PJNINativeMethod"
	.byte	0,0,0,0,0,0
	.long	RTTI_$JNI_$$_JNINATIVEMETHOD$indirect
	.byte	0,0,0,0
.Le259:
	.size	RTTI_$JNI_$$_PJNINATIVEMETHOD, .Le259 - RTTI_$JNI_$$_PJNINATIVEMETHOD

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000105
	.balign 8
.globl	RTTI_$JNI_$$_def00000105
	.type	RTTI_$JNI_$$_def00000105,#object
RTTI_$JNI_$$_def00000105:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_LONGINT$indirect
	.byte	4,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AClass"
	.byte	0
	.short	2
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNINATIVEMETHOD$indirect
	.byte	7
	.ascii	"Methods"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_LONGINT$indirect
	.byte	8
	.ascii	"NMethods"
	.byte	0,0,0,0,0,0,0
.Le260:
	.size	RTTI_$JNI_$$_def00000105, .Le260 - RTTI_$JNI_$$_def00000105

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000106
	.balign 8
.globl	RTTI_$JNI_$$_def00000106
	.type	RTTI_$JNI_$$_def00000106,#object
RTTI_$JNI_$$_def00000106:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_LONGINT$indirect
	.byte	2,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AClass"
	.byte	0
.Le261:
	.size	RTTI_$JNI_$$_def00000106, .Le261 - RTTI_$JNI_$$_def00000106

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000107
	.balign 8
.globl	RTTI_$JNI_$$_def00000107
	.type	RTTI_$JNI_$$_def00000107,#object
RTTI_$JNI_$$_def00000107:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_LONGINT$indirect
	.byte	2,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Obj"
	.byte	0,0,0,0
.Le262:
	.size	RTTI_$JNI_$$_def00000107, .Le262 - RTTI_$JNI_$$_def00000107

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000108
	.balign 8
.globl	RTTI_$JNI_$$_def00000108
	.type	RTTI_$JNI_$$_def00000108,#object
RTTI_$JNI_$$_def00000108:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_LONGINT$indirect
	.byte	2,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Obj"
	.byte	0,0,0,0
.Le263:
	.size	RTTI_$JNI_$$_def00000108, .Le263 - RTTI_$JNI_$$_def00000108

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000109
	.balign 8
.globl	RTTI_$JNI_$$_def00000109
	.type	RTTI_$JNI_$$_def00000109,#object
RTTI_$JNI_$$_def00000109:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_LONGINT$indirect
	.byte	2,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	1
	.byte	0,0
	.long	RTTI_$JNI_$$_JAVAVM$indirect
	.byte	2
	.ascii	"VM"
	.byte	0,0,0,0,0
.Le264:
	.size	RTTI_$JNI_$$_def00000109, .Le264 - RTTI_$JNI_$$_def00000109

.section .data.rel.ro.n_RTTI_$JNI_$$_def0000010A
	.balign 8
.globl	RTTI_$JNI_$$_def0000010A
	.type	RTTI_$JNI_$$_def0000010A,#object
RTTI_$JNI_$$_def0000010A:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	0
	.byte	5,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Str"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_LONGINT$indirect
	.byte	5
	.ascii	"Start"
	.byte	0,0
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_LONGINT$indirect
	.byte	3
	.ascii	"Len"
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJCHAR$indirect
	.byte	3
	.ascii	"Buf"
	.byte	0,0,0,0
.Le265:
	.size	RTTI_$JNI_$$_def0000010A, .Le265 - RTTI_$JNI_$$_def0000010A

.section .data.rel.ro.n_RTTI_$JNI_$$_def0000010B
	.balign 8
.globl	RTTI_$JNI_$$_def0000010B
	.type	RTTI_$JNI_$$_def0000010B,#object
RTTI_$JNI_$$_def0000010B:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	0
	.byte	5,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Str"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_LONGINT$indirect
	.byte	5
	.ascii	"Start"
	.byte	0,0
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_LONGINT$indirect
	.byte	3
	.ascii	"Len"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_PCHAR$indirect
	.byte	3
	.ascii	"Buf"
	.byte	0,0,0,0
.Le266:
	.size	RTTI_$JNI_$$_def0000010B, .Le266 - RTTI_$JNI_$$_def0000010B

.section .data.rel.ro.n_RTTI_$JNI_$$_def0000010C
	.balign 8
.globl	RTTI_$JNI_$$_def0000010C
	.type	RTTI_$JNI_$$_def0000010C,#object
RTTI_$JNI_$$_def0000010C:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AArray"
	.byte	0
	.short	1
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_BYTE$indirect
	.byte	6
	.ascii	"IsCopy"
	.byte	0
.Le267:
	.size	RTTI_$JNI_$$_def0000010C, .Le267 - RTTI_$JNI_$$_def0000010C

.section .data.rel.ro.n_RTTI_$JNI_$$_def0000010D
	.balign 8
.globl	RTTI_$JNI_$$_def0000010D
	.type	RTTI_$JNI_$$_def0000010D,#object
RTTI_$JNI_$$_def0000010D:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	0
	.byte	4,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"AArray"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	6
	.ascii	"CArray"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_LONGINT$indirect
	.byte	4
	.ascii	"Mode"
	.byte	0,0,0
.Le268:
	.size	RTTI_$JNI_$$_def0000010D, .Le268 - RTTI_$JNI_$$_def0000010D

.section .data.rel.ro.n_RTTI_$JNI_$$_def0000010E
	.balign 8
.globl	RTTI_$JNI_$$_def0000010E
	.type	RTTI_$JNI_$$_def0000010E,#object
RTTI_$JNI_$$_def0000010E:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$JNI_$$_PJCHAR$indirect
	.byte	3,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Str"
	.short	1
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_BYTE$indirect
	.byte	6
	.ascii	"IsCopy"
	.byte	0,0,0,0,0
.Le269:
	.size	RTTI_$JNI_$$_def0000010E, .Le269 - RTTI_$JNI_$$_def0000010E

.section .data.rel.ro.n_RTTI_$JNI_$$_def0000010F
	.balign 8
.globl	RTTI_$JNI_$$_def0000010F
	.type	RTTI_$JNI_$$_def0000010F,#object
RTTI_$JNI_$$_def0000010F:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	0
	.byte	3,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Str"
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJCHAR$indirect
	.byte	7
	.ascii	"CString"
	.byte	0,0,0,0
.Le270:
	.size	RTTI_$JNI_$$_def0000010F, .Le270 - RTTI_$JNI_$$_def0000010F

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000110
	.balign 8
.globl	RTTI_$JNI_$$_def00000110
	.type	RTTI_$JNI_$$_def00000110,#object
RTTI_$JNI_$$_def00000110:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	2,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Obj"
	.byte	0,0,0,0
.Le271:
	.size	RTTI_$JNI_$$_def00000110, .Le271 - RTTI_$JNI_$$_def00000110

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000111
	.balign 8
.globl	RTTI_$JNI_$$_def00000111
	.type	RTTI_$JNI_$$_def00000111,#object
RTTI_$JNI_$$_def00000111:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	0
	.byte	2,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Ref"
	.byte	0,0,0,0
.Le272:
	.size	RTTI_$JNI_$$_def00000111, .Le272 - RTTI_$JNI_$$_def00000111

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000112
	.balign 8
.globl	RTTI_$JNI_$$_def00000112
	.type	RTTI_$JNI_$$_def00000112,#object
RTTI_$JNI_$$_def00000112:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_BYTE$indirect
	.byte	1,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
.Le273:
	.size	RTTI_$JNI_$$_def00000112, .Le273 - RTTI_$JNI_$$_def00000112

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000113
	.balign 8
.globl	RTTI_$JNI_$$_def00000113
	.type	RTTI_$JNI_$$_def00000113,#object
RTTI_$JNI_$$_def00000113:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	7
	.ascii	"Address"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_INT64$indirect
	.byte	8
	.ascii	"Capacity"
	.byte	0,0,0,0,0,0,0
.Le274:
	.size	RTTI_$JNI_$$_def00000113, .Le274 - RTTI_$JNI_$$_def00000113

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000114
	.balign 8
.globl	RTTI_$JNI_$$_def00000114
	.type	RTTI_$JNI_$$_def00000114,#object
RTTI_$JNI_$$_def00000114:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	2,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Buf"
	.byte	0,0,0,0
.Le275:
	.size	RTTI_$JNI_$$_def00000114, .Le275 - RTTI_$JNI_$$_def00000114

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000115
	.balign 8
.globl	RTTI_$JNI_$$_def00000115
	.type	RTTI_$JNI_$$_def00000115,#object
RTTI_$JNI_$$_def00000115:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_INT64$indirect
	.byte	2,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	3
	.ascii	"Buf"
	.byte	0,0,0,0
.Le276:
	.size	RTTI_$JNI_$$_def00000115, .Le276 - RTTI_$JNI_$$_def00000115

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000116
	.balign 8
.globl	RTTI_$JNI_$$_def00000116
	.type	RTTI_$JNI_$$_def00000116,#object
RTTI_$JNI_$$_def00000116:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$JNI_$$_JOBJECTREFTYPE$indirect
	.byte	2,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	3
	.ascii	"Env"
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	7
	.ascii	"AObject"
.Le277:
	.size	RTTI_$JNI_$$_def00000116, .Le277 - RTTI_$JNI_$$_def00000116

.section .data.rel.ro.n_RTTI_$JNI_$$_JNINATIVEINTERFACE
	.balign 8
.globl	RTTI_$JNI_$$_JNINATIVEINTERFACE
	.type	RTTI_$JNI_$$_JNINATIVEINTERFACE,#object
RTTI_$JNI_$$_JNINATIVEINTERFACE:
	.byte	13,18
	.ascii	"JNINativeInterface"
	.byte	0,0,0,0
	.long	INIT_$JNI_$$_JNINATIVEINTERFACE
	.long	932,233
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.long	0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.long	4
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.long	8
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.long	12
	.long	RTTI_$JNI_$$_def00000032$indirect
	.long	16
	.long	RTTI_$JNI_$$_def00000033$indirect
	.long	20
	.long	RTTI_$JNI_$$_def00000034$indirect
	.long	24
	.long	RTTI_$JNI_$$_def00000035$indirect
	.long	28
	.long	RTTI_$JNI_$$_def00000036$indirect
	.long	32
	.long	RTTI_$JNI_$$_def00000037$indirect
	.long	36
	.long	RTTI_$JNI_$$_def00000038$indirect
	.long	40
	.long	RTTI_$JNI_$$_def00000039$indirect
	.long	44
	.long	RTTI_$JNI_$$_def0000003A$indirect
	.long	48
	.long	RTTI_$JNI_$$_def0000003B$indirect
	.long	52
	.long	RTTI_$JNI_$$_def0000003C$indirect
	.long	56
	.long	RTTI_$JNI_$$_def0000003D$indirect
	.long	60
	.long	RTTI_$JNI_$$_def0000003E$indirect
	.long	64
	.long	RTTI_$JNI_$$_def0000003F$indirect
	.long	68
	.long	RTTI_$JNI_$$_def00000040$indirect
	.long	72
	.long	RTTI_$JNI_$$_def00000041$indirect
	.long	76
	.long	RTTI_$JNI_$$_def00000042$indirect
	.long	80
	.long	RTTI_$JNI_$$_def00000043$indirect
	.long	84
	.long	RTTI_$JNI_$$_def00000044$indirect
	.long	88
	.long	RTTI_$JNI_$$_def00000045$indirect
	.long	92
	.long	RTTI_$JNI_$$_def00000046$indirect
	.long	96
	.long	RTTI_$JNI_$$_def00000047$indirect
	.long	100
	.long	RTTI_$JNI_$$_def00000048$indirect
	.long	104
	.long	RTTI_$JNI_$$_def00000049$indirect
	.long	108
	.long	RTTI_$JNI_$$_def0000004A$indirect
	.long	112
	.long	RTTI_$JNI_$$_def0000004B$indirect
	.long	116
	.long	RTTI_$JNI_$$_def0000004C$indirect
	.long	120
	.long	RTTI_$JNI_$$_def0000004D$indirect
	.long	124
	.long	RTTI_$JNI_$$_def0000004E$indirect
	.long	128
	.long	RTTI_$JNI_$$_def0000004F$indirect
	.long	132
	.long	RTTI_$JNI_$$_def00000050$indirect
	.long	136
	.long	RTTI_$JNI_$$_def00000051$indirect
	.long	140
	.long	RTTI_$JNI_$$_def00000052$indirect
	.long	144
	.long	RTTI_$JNI_$$_def00000053$indirect
	.long	148
	.long	RTTI_$JNI_$$_def00000054$indirect
	.long	152
	.long	RTTI_$JNI_$$_def00000055$indirect
	.long	156
	.long	RTTI_$JNI_$$_def00000056$indirect
	.long	160
	.long	RTTI_$JNI_$$_def00000057$indirect
	.long	164
	.long	RTTI_$JNI_$$_def00000058$indirect
	.long	168
	.long	RTTI_$JNI_$$_def00000059$indirect
	.long	172
	.long	RTTI_$JNI_$$_def0000005A$indirect
	.long	176
	.long	RTTI_$JNI_$$_def0000005B$indirect
	.long	180
	.long	RTTI_$JNI_$$_def0000005C$indirect
	.long	184
	.long	RTTI_$JNI_$$_def0000005D$indirect
	.long	188
	.long	RTTI_$JNI_$$_def0000005E$indirect
	.long	192
	.long	RTTI_$JNI_$$_def0000005F$indirect
	.long	196
	.long	RTTI_$JNI_$$_def00000060$indirect
	.long	200
	.long	RTTI_$JNI_$$_def00000061$indirect
	.long	204
	.long	RTTI_$JNI_$$_def00000062$indirect
	.long	208
	.long	RTTI_$JNI_$$_def00000063$indirect
	.long	212
	.long	RTTI_$JNI_$$_def00000064$indirect
	.long	216
	.long	RTTI_$JNI_$$_def00000065$indirect
	.long	220
	.long	RTTI_$JNI_$$_def00000066$indirect
	.long	224
	.long	RTTI_$JNI_$$_def00000067$indirect
	.long	228
	.long	RTTI_$JNI_$$_def00000068$indirect
	.long	232
	.long	RTTI_$JNI_$$_def00000069$indirect
	.long	236
	.long	RTTI_$JNI_$$_def0000006A$indirect
	.long	240
	.long	RTTI_$JNI_$$_def0000006B$indirect
	.long	244
	.long	RTTI_$JNI_$$_def0000006C$indirect
	.long	248
	.long	RTTI_$JNI_$$_def0000006D$indirect
	.long	252
	.long	RTTI_$JNI_$$_def0000006E$indirect
	.long	256
	.long	RTTI_$JNI_$$_def0000006F$indirect
	.long	260
	.long	RTTI_$JNI_$$_def00000070$indirect
	.long	264
	.long	RTTI_$JNI_$$_def00000071$indirect
	.long	268
	.long	RTTI_$JNI_$$_def00000072$indirect
	.long	272
	.long	RTTI_$JNI_$$_def00000073$indirect
	.long	276
	.long	RTTI_$JNI_$$_def00000074$indirect
	.long	280
	.long	RTTI_$JNI_$$_def00000075$indirect
	.long	284
	.long	RTTI_$JNI_$$_def00000076$indirect
	.long	288
	.long	RTTI_$JNI_$$_def00000077$indirect
	.long	292
	.long	RTTI_$JNI_$$_def00000078$indirect
	.long	296
	.long	RTTI_$JNI_$$_def00000079$indirect
	.long	300
	.long	RTTI_$JNI_$$_def0000007A$indirect
	.long	304
	.long	RTTI_$JNI_$$_def0000007B$indirect
	.long	308
	.long	RTTI_$JNI_$$_def0000007C$indirect
	.long	312
	.long	RTTI_$JNI_$$_def0000007D$indirect
	.long	316
	.long	RTTI_$JNI_$$_def0000007E$indirect
	.long	320
	.long	RTTI_$JNI_$$_def0000007F$indirect
	.long	324
	.long	RTTI_$JNI_$$_def00000080$indirect
	.long	328
	.long	RTTI_$JNI_$$_def00000081$indirect
	.long	332
	.long	RTTI_$JNI_$$_def00000082$indirect
	.long	336
	.long	RTTI_$JNI_$$_def00000083$indirect
	.long	340
	.long	RTTI_$JNI_$$_def00000084$indirect
	.long	344
	.long	RTTI_$JNI_$$_def00000085$indirect
	.long	348
	.long	RTTI_$JNI_$$_def00000086$indirect
	.long	352
	.long	RTTI_$JNI_$$_def00000087$indirect
	.long	356
	.long	RTTI_$JNI_$$_def00000088$indirect
	.long	360
	.long	RTTI_$JNI_$$_def00000089$indirect
	.long	364
	.long	RTTI_$JNI_$$_def0000008A$indirect
	.long	368
	.long	RTTI_$JNI_$$_def0000008B$indirect
	.long	372
	.long	RTTI_$JNI_$$_def0000008C$indirect
	.long	376
	.long	RTTI_$JNI_$$_def0000008D$indirect
	.long	380
	.long	RTTI_$JNI_$$_def0000008E$indirect
	.long	384
	.long	RTTI_$JNI_$$_def0000008F$indirect
	.long	388
	.long	RTTI_$JNI_$$_def00000090$indirect
	.long	392
	.long	RTTI_$JNI_$$_def00000091$indirect
	.long	396
	.long	RTTI_$JNI_$$_def00000092$indirect
	.long	400
	.long	RTTI_$JNI_$$_def00000093$indirect
	.long	404
	.long	RTTI_$JNI_$$_def00000094$indirect
	.long	408
	.long	RTTI_$JNI_$$_def00000095$indirect
	.long	412
	.long	RTTI_$JNI_$$_def00000096$indirect
	.long	416
	.long	RTTI_$JNI_$$_def00000097$indirect
	.long	420
	.long	RTTI_$JNI_$$_def00000098$indirect
	.long	424
	.long	RTTI_$JNI_$$_def00000099$indirect
	.long	428
	.long	RTTI_$JNI_$$_def0000009A$indirect
	.long	432
	.long	RTTI_$JNI_$$_def0000009B$indirect
	.long	436
	.long	RTTI_$JNI_$$_def0000009C$indirect
	.long	440
	.long	RTTI_$JNI_$$_def0000009D$indirect
	.long	444
	.long	RTTI_$JNI_$$_def0000009E$indirect
	.long	448
	.long	RTTI_$JNI_$$_def0000009F$indirect
	.long	452
	.long	RTTI_$JNI_$$_def000000A0$indirect
	.long	456
	.long	RTTI_$JNI_$$_def000000A1$indirect
	.long	460
	.long	RTTI_$JNI_$$_def000000A2$indirect
	.long	464
	.long	RTTI_$JNI_$$_def000000A3$indirect
	.long	468
	.long	RTTI_$JNI_$$_def000000A4$indirect
	.long	472
	.long	RTTI_$JNI_$$_def000000A5$indirect
	.long	476
	.long	RTTI_$JNI_$$_def000000A6$indirect
	.long	480
	.long	RTTI_$JNI_$$_def000000A7$indirect
	.long	484
	.long	RTTI_$JNI_$$_def000000A8$indirect
	.long	488
	.long	RTTI_$JNI_$$_def000000A9$indirect
	.long	492
	.long	RTTI_$JNI_$$_def000000AA$indirect
	.long	496
	.long	RTTI_$JNI_$$_def000000AB$indirect
	.long	500
	.long	RTTI_$JNI_$$_def000000AC$indirect
	.long	504
	.long	RTTI_$JNI_$$_def000000AD$indirect
	.long	508
	.long	RTTI_$JNI_$$_def000000AE$indirect
	.long	512
	.long	RTTI_$JNI_$$_def000000AF$indirect
	.long	516
	.long	RTTI_$JNI_$$_def000000B0$indirect
	.long	520
	.long	RTTI_$JNI_$$_def000000B1$indirect
	.long	524
	.long	RTTI_$JNI_$$_def000000B2$indirect
	.long	528
	.long	RTTI_$JNI_$$_def000000B3$indirect
	.long	532
	.long	RTTI_$JNI_$$_def000000B4$indirect
	.long	536
	.long	RTTI_$JNI_$$_def000000B5$indirect
	.long	540
	.long	RTTI_$JNI_$$_def000000B6$indirect
	.long	544
	.long	RTTI_$JNI_$$_def000000B7$indirect
	.long	548
	.long	RTTI_$JNI_$$_def000000B8$indirect
	.long	552
	.long	RTTI_$JNI_$$_def000000B9$indirect
	.long	556
	.long	RTTI_$JNI_$$_def000000BA$indirect
	.long	560
	.long	RTTI_$JNI_$$_def000000BB$indirect
	.long	564
	.long	RTTI_$JNI_$$_def000000BC$indirect
	.long	568
	.long	RTTI_$JNI_$$_def000000BD$indirect
	.long	572
	.long	RTTI_$JNI_$$_def000000BE$indirect
	.long	576
	.long	RTTI_$JNI_$$_def000000BF$indirect
	.long	580
	.long	RTTI_$JNI_$$_def000000C0$indirect
	.long	584
	.long	RTTI_$JNI_$$_def000000C1$indirect
	.long	588
	.long	RTTI_$JNI_$$_def000000C2$indirect
	.long	592
	.long	RTTI_$JNI_$$_def000000C3$indirect
	.long	596
	.long	RTTI_$JNI_$$_def000000C4$indirect
	.long	600
	.long	RTTI_$JNI_$$_def000000C5$indirect
	.long	604
	.long	RTTI_$JNI_$$_def000000C6$indirect
	.long	608
	.long	RTTI_$JNI_$$_def000000C7$indirect
	.long	612
	.long	RTTI_$JNI_$$_def000000C8$indirect
	.long	616
	.long	RTTI_$JNI_$$_def000000C9$indirect
	.long	620
	.long	RTTI_$JNI_$$_def000000CA$indirect
	.long	624
	.long	RTTI_$JNI_$$_def000000CB$indirect
	.long	628
	.long	RTTI_$JNI_$$_def000000CC$indirect
	.long	632
	.long	RTTI_$JNI_$$_def000000CD$indirect
	.long	636
	.long	RTTI_$JNI_$$_def000000CE$indirect
	.long	640
	.long	RTTI_$JNI_$$_def000000CF$indirect
	.long	644
	.long	RTTI_$JNI_$$_def000000D0$indirect
	.long	648
	.long	RTTI_$JNI_$$_def000000D1$indirect
	.long	652
	.long	RTTI_$JNI_$$_def000000D2$indirect
	.long	656
	.long	RTTI_$JNI_$$_def000000D3$indirect
	.long	660
	.long	RTTI_$JNI_$$_def000000D4$indirect
	.long	664
	.long	RTTI_$JNI_$$_def000000D5$indirect
	.long	668
	.long	RTTI_$JNI_$$_def000000D6$indirect
	.long	672
	.long	RTTI_$JNI_$$_def000000D7$indirect
	.long	676
	.long	RTTI_$JNI_$$_def000000D8$indirect
	.long	680
	.long	RTTI_$JNI_$$_def000000D9$indirect
	.long	684
	.long	RTTI_$JNI_$$_def000000DA$indirect
	.long	688
	.long	RTTI_$JNI_$$_def000000DB$indirect
	.long	692
	.long	RTTI_$JNI_$$_def000000DC$indirect
	.long	696
	.long	RTTI_$JNI_$$_def000000DD$indirect
	.long	700
	.long	RTTI_$JNI_$$_def000000DE$indirect
	.long	704
	.long	RTTI_$JNI_$$_def000000DF$indirect
	.long	708
	.long	RTTI_$JNI_$$_def000000E0$indirect
	.long	712
	.long	RTTI_$JNI_$$_def000000E1$indirect
	.long	716
	.long	RTTI_$JNI_$$_def000000E2$indirect
	.long	720
	.long	RTTI_$JNI_$$_def000000E3$indirect
	.long	724
	.long	RTTI_$JNI_$$_def000000E4$indirect
	.long	728
	.long	RTTI_$JNI_$$_def000000E5$indirect
	.long	732
	.long	RTTI_$JNI_$$_def000000E6$indirect
	.long	736
	.long	RTTI_$JNI_$$_def000000E7$indirect
	.long	740
	.long	RTTI_$JNI_$$_def000000E8$indirect
	.long	744
	.long	RTTI_$JNI_$$_def000000E9$indirect
	.long	748
	.long	RTTI_$JNI_$$_def000000EA$indirect
	.long	752
	.long	RTTI_$JNI_$$_def000000EB$indirect
	.long	756
	.long	RTTI_$JNI_$$_def000000EC$indirect
	.long	760
	.long	RTTI_$JNI_$$_def000000ED$indirect
	.long	764
	.long	RTTI_$JNI_$$_def000000EE$indirect
	.long	768
	.long	RTTI_$JNI_$$_def000000EF$indirect
	.long	772
	.long	RTTI_$JNI_$$_def000000F0$indirect
	.long	776
	.long	RTTI_$JNI_$$_def000000F1$indirect
	.long	780
	.long	RTTI_$JNI_$$_def000000F2$indirect
	.long	784
	.long	RTTI_$JNI_$$_def000000F3$indirect
	.long	788
	.long	RTTI_$JNI_$$_def000000F4$indirect
	.long	792
	.long	RTTI_$JNI_$$_def000000F5$indirect
	.long	796
	.long	RTTI_$JNI_$$_def000000F6$indirect
	.long	800
	.long	RTTI_$JNI_$$_def000000F7$indirect
	.long	804
	.long	RTTI_$JNI_$$_def000000F8$indirect
	.long	808
	.long	RTTI_$JNI_$$_def000000F9$indirect
	.long	812
	.long	RTTI_$JNI_$$_def000000FA$indirect
	.long	816
	.long	RTTI_$JNI_$$_def000000FB$indirect
	.long	820
	.long	RTTI_$JNI_$$_def000000FC$indirect
	.long	824
	.long	RTTI_$JNI_$$_def000000FD$indirect
	.long	828
	.long	RTTI_$JNI_$$_def000000FE$indirect
	.long	832
	.long	RTTI_$JNI_$$_def000000FF$indirect
	.long	836
	.long	RTTI_$JNI_$$_def00000100$indirect
	.long	840
	.long	RTTI_$JNI_$$_def00000101$indirect
	.long	844
	.long	RTTI_$JNI_$$_def00000102$indirect
	.long	848
	.long	RTTI_$JNI_$$_def00000103$indirect
	.long	852
	.long	RTTI_$JNI_$$_def00000104$indirect
	.long	856
	.long	RTTI_$JNI_$$_def00000105$indirect
	.long	860
	.long	RTTI_$JNI_$$_def00000106$indirect
	.long	864
	.long	RTTI_$JNI_$$_def00000107$indirect
	.long	868
	.long	RTTI_$JNI_$$_def00000108$indirect
	.long	872
	.long	RTTI_$JNI_$$_def00000109$indirect
	.long	876
	.long	RTTI_$JNI_$$_def0000010A$indirect
	.long	880
	.long	RTTI_$JNI_$$_def0000010B$indirect
	.long	884
	.long	RTTI_$JNI_$$_def0000010C$indirect
	.long	888
	.long	RTTI_$JNI_$$_def0000010D$indirect
	.long	892
	.long	RTTI_$JNI_$$_def0000010E$indirect
	.long	896
	.long	RTTI_$JNI_$$_def0000010F$indirect
	.long	900
	.long	RTTI_$JNI_$$_def00000110$indirect
	.long	904
	.long	RTTI_$JNI_$$_def00000111$indirect
	.long	908
	.long	RTTI_$JNI_$$_def00000112$indirect
	.long	912
	.long	RTTI_$JNI_$$_def00000113$indirect
	.long	916
	.long	RTTI_$JNI_$$_def00000114$indirect
	.long	920
	.long	RTTI_$JNI_$$_def00000115$indirect
	.long	924
	.long	RTTI_$JNI_$$_def00000116$indirect
	.long	928
	.byte	0,0,0,0
.Le278:
	.size	RTTI_$JNI_$$_JNINATIVEINTERFACE, .Le278 - RTTI_$JNI_$$_JNINATIVEINTERFACE

.section .data.rel.ro.n_RTTI_$JNI_$$_JNIENV
	.balign 8
.globl	RTTI_$JNI_$$_JNIENV
	.type	RTTI_$JNI_$$_JNIENV,#object
RTTI_$JNI_$$_JNIENV:
	.byte	29,6
	.ascii	"JNIEnv"
	.long	RTTI_$JNI_$$_JNINATIVEINTERFACE$indirect
	.byte	0,0,0,0
.Le279:
	.size	RTTI_$JNI_$$_JNIENV, .Le279 - RTTI_$JNI_$$_JNIENV

.section .data.rel.ro.n_RTTI_$JNI_$$_PJNIENV
	.balign 8
.globl	RTTI_$JNI_$$_PJNIENV
	.type	RTTI_$JNI_$$_PJNIENV,#object
RTTI_$JNI_$$_PJNIENV:
	.byte	29,7
	.ascii	"PJNIEnv"
	.byte	0,0,0,0,0,0,0
	.long	RTTI_$JNI_$$_JNIENV$indirect
	.byte	0,0,0,0
.Le280:
	.size	RTTI_$JNI_$$_PJNIENV, .Le280 - RTTI_$JNI_$$_PJNIENV

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000119
	.balign 8
.globl	RTTI_$JNI_$$_def00000119
	.type	RTTI_$JNI_$$_def00000119,#object
RTTI_$JNI_$$_def00000119:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_LONGINT$indirect
	.byte	3,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJAVAVM$indirect
	.byte	3
	.ascii	"PVM"
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	4
	.ascii	"PEnv"
	.byte	0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	4
	.ascii	"Args"
	.byte	0,0,0
.Le281:
	.size	RTTI_$JNI_$$_def00000119, .Le281 - RTTI_$JNI_$$_def00000119

.section .data.rel.ro.n_RTTI_$JNI_$$_def0000011A
	.balign 8
.globl	RTTI_$JNI_$$_def0000011A
	.type	RTTI_$JNI_$$_def0000011A,#object
RTTI_$JNI_$$_def0000011A:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_LONGINT$indirect
	.byte	1,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJAVAVM$indirect
	.byte	3
	.ascii	"PVM"
.Le282:
	.size	RTTI_$JNI_$$_def0000011A, .Le282 - RTTI_$JNI_$$_def0000011A

.section .data.rel.ro.n_RTTI_$JNI_$$_def0000011B
	.balign 8
.globl	RTTI_$JNI_$$_def0000011B
	.type	RTTI_$JNI_$$_def0000011B,#object
RTTI_$JNI_$$_def0000011B:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_LONGINT$indirect
	.byte	3,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJAVAVM$indirect
	.byte	3
	.ascii	"PVM"
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PPOINTER$indirect
	.byte	4
	.ascii	"PEnv"
	.byte	0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_LONGINT$indirect
	.byte	7
	.ascii	"Version"
.Le283:
	.size	RTTI_$JNI_$$_def0000011B, .Le283 - RTTI_$JNI_$$_def0000011B

.section .data.rel.ro.n_RTTI_$JNI_$$_def0000011C
	.balign 8
.globl	RTTI_$JNI_$$_def0000011C
	.type	RTTI_$JNI_$$_def0000011C,#object
RTTI_$JNI_$$_def0000011C:
	.byte	23,0,0,0,0,0,0,0,0,1,0,0
	.long	RTTI_$SYSTEM_$$_LONGINT$indirect
	.byte	3,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJAVAVM$indirect
	.byte	3
	.ascii	"PVM"
	.short	0
	.byte	0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	4
	.ascii	"PEnv"
	.byte	0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.byte	4
	.ascii	"Args"
	.byte	0,0,0
.Le284:
	.size	RTTI_$JNI_$$_def0000011C, .Le284 - RTTI_$JNI_$$_def0000011C

.section .data.rel.ro.n_RTTI_$JNI_$$_JNIINVOKEINTERFACE
	.balign 8
.globl	RTTI_$JNI_$$_JNIINVOKEINTERFACE
	.type	RTTI_$JNI_$$_JNIINVOKEINTERFACE,#object
RTTI_$JNI_$$_JNIINVOKEINTERFACE:
	.byte	13,18
	.ascii	"JNIInvokeInterface"
	.byte	0,0,0,0
	.long	INIT_$JNI_$$_JNIINVOKEINTERFACE
	.long	32,8
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.long	0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.long	4
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.long	8
	.long	RTTI_$JNI_$$_def00000118$indirect
	.long	12
	.long	RTTI_$JNI_$$_def00000119$indirect
	.long	16
	.long	RTTI_$JNI_$$_def0000011A$indirect
	.long	20
	.long	RTTI_$JNI_$$_def0000011B$indirect
	.long	24
	.long	RTTI_$JNI_$$_def0000011C$indirect
	.long	28
	.byte	0,0,0,0
.Le285:
	.size	RTTI_$JNI_$$_JNIINVOKEINTERFACE, .Le285 - RTTI_$JNI_$$_JNIINVOKEINTERFACE

.section .data.rel.ro.n_RTTI_$JNI_$$_PJNIINVOKEINTERFACE
	.balign 8
.globl	RTTI_$JNI_$$_PJNIINVOKEINTERFACE
	.type	RTTI_$JNI_$$_PJNIINVOKEINTERFACE,#object
RTTI_$JNI_$$_PJNIINVOKEINTERFACE:
	.byte	29,19
	.ascii	"PJNIInvokeInterface"
	.byte	0,0,0
	.long	RTTI_$JNI_$$_JNIINVOKEINTERFACE$indirect
	.byte	0,0,0,0
.Le286:
	.size	RTTI_$JNI_$$_PJNIINVOKEINTERFACE, .Le286 - RTTI_$JNI_$$_PJNIINVOKEINTERFACE

.section .data.rel.ro.n_RTTI_$JNI_$$_JOBJECTREFTYPE
	.balign 8
.globl	RTTI_$JNI_$$_JOBJECTREFTYPE
	.type	RTTI_$JNI_$$_JOBJECTREFTYPE,#object
RTTI_$JNI_$$_JOBJECTREFTYPE:
	.byte	3,14
	.ascii	"jobjectRefType"
	.byte	1,0,0,0,0,0,0,0
	.long	0,3,0
	.byte	17
	.ascii	"JNIInvalidRefType"
	.byte	15
	.ascii	"JNILocalRefType"
	.byte	16
	.ascii	"JNIGlobalRefType"
	.byte	20
	.ascii	"JNIWeakGlobalRefType"
	.byte	3
	.ascii	"jni"
	.byte	0,0,0,0,0,0,0,0
.Le287:
	.size	RTTI_$JNI_$$_JOBJECTREFTYPE, .Le287 - RTTI_$JNI_$$_JOBJECTREFTYPE

.section .data.rel.ro.n_RTTI_$JNI_$$_JOBJECTREFTYPE_s2o
	.balign 4
.globl	RTTI_$JNI_$$_JOBJECTREFTYPE_s2o
	.type	RTTI_$JNI_$$_JOBJECTREFTYPE_s2o,#object
RTTI_$JNI_$$_JOBJECTREFTYPE_s2o:
	.long	4,2
	.long	RTTI_$JNI_$$_JOBJECTREFTYPE+70
	.long	0
	.long	RTTI_$JNI_$$_JOBJECTREFTYPE+36
	.long	1
	.long	RTTI_$JNI_$$_JOBJECTREFTYPE+54
	.long	3
	.long	RTTI_$JNI_$$_JOBJECTREFTYPE+87
.Le288:
	.size	RTTI_$JNI_$$_JOBJECTREFTYPE_s2o, .Le288 - RTTI_$JNI_$$_JOBJECTREFTYPE_s2o

.section .data.rel.ro.n_RTTI_$JNI_$$_JOBJECTREFTYPE_o2s
	.balign 4
.globl	RTTI_$JNI_$$_JOBJECTREFTYPE_o2s
	.type	RTTI_$JNI_$$_JOBJECTREFTYPE_o2s,#object
RTTI_$JNI_$$_JOBJECTREFTYPE_o2s:
	.long	0
	.long	RTTI_$JNI_$$_JOBJECTREFTYPE+36
	.long	RTTI_$JNI_$$_JOBJECTREFTYPE+54
	.long	RTTI_$JNI_$$_JOBJECTREFTYPE+70
	.long	RTTI_$JNI_$$_JOBJECTREFTYPE+87
.Le289:
	.size	RTTI_$JNI_$$_JOBJECTREFTYPE_o2s, .Le289 - RTTI_$JNI_$$_JOBJECTREFTYPE_o2s

.section .data.rel.ro.n_RTTI_$JNI_$$_PJNINATIVEINTERFACE
	.balign 8
.globl	RTTI_$JNI_$$_PJNINATIVEINTERFACE
	.type	RTTI_$JNI_$$_PJNINATIVEINTERFACE,#object
RTTI_$JNI_$$_PJNINATIVEINTERFACE:
	.byte	29,19
	.ascii	"PJNINativeInterface"
	.byte	0,0,0
	.long	RTTI_$JNI_$$_JNINATIVEINTERFACE$indirect
	.byte	0,0,0,0
.Le290:
	.size	RTTI_$JNI_$$_PJNINATIVEINTERFACE, .Le290 - RTTI_$JNI_$$_PJNINATIVEINTERFACE

.section .data.rel.ro.n_INIT_$JNI_$$__JNIENV
	.balign 8
.globl	INIT_$JNI_$$__JNIENV
	.type	INIT_$JNI_$$__JNIENV,#object
INIT_$JNI_$$__JNIENV:
	.byte	13,7
	.ascii	"_JNIEnv"
	.byte	0,0,0,0,0,0,0
	.long	0,4,0,0,0
	.byte	0,0,0,0
.Le291:
	.size	INIT_$JNI_$$__JNIENV, .Le291 - INIT_$JNI_$$__JNIENV

.section .data.rel.ro.n_RTTI_$JNI_$$__JNIENV
	.balign 8
.globl	RTTI_$JNI_$$__JNIENV
	.type	RTTI_$JNI_$$__JNIENV,#object
RTTI_$JNI_$$__JNIENV:
	.byte	13,7
	.ascii	"_JNIEnv"
	.byte	0,0,0,0,0,0,0
	.long	INIT_$JNI_$$__JNIENV
	.long	4,1
	.long	RTTI_$JNI_$$_PJNINATIVEINTERFACE$indirect
	.long	0
	.byte	0,0,0,0
.Le292:
	.size	RTTI_$JNI_$$__JNIENV, .Le292 - RTTI_$JNI_$$__JNIENV

.section .data.rel.ro.n_INIT_$JNI_$$__JAVAVM
	.balign 8
.globl	INIT_$JNI_$$__JAVAVM
	.type	INIT_$JNI_$$__JAVAVM,#object
INIT_$JNI_$$__JAVAVM:
	.byte	13,7
	.ascii	"_JavaVM"
	.byte	0,0,0,0,0,0,0
	.long	0,4,0,0,0
	.byte	0,0,0,0
.Le293:
	.size	INIT_$JNI_$$__JAVAVM, .Le293 - INIT_$JNI_$$__JAVAVM

.section .data.rel.ro.n_RTTI_$JNI_$$__JAVAVM
	.balign 8
.globl	RTTI_$JNI_$$__JAVAVM
	.type	RTTI_$JNI_$$__JAVAVM,#object
RTTI_$JNI_$$__JAVAVM:
	.byte	13,7
	.ascii	"_JavaVM"
	.byte	0,0,0,0,0,0,0
	.long	INIT_$JNI_$$__JAVAVM
	.long	4,1
	.long	RTTI_$JNI_$$_PJNIINVOKEINTERFACE$indirect
	.long	0
	.byte	0,0,0,0
.Le294:
	.size	RTTI_$JNI_$$__JAVAVM, .Le294 - RTTI_$JNI_$$__JAVAVM

.section .data.rel.ro.n_RTTI_$JNI_$$_C_JNIENV
	.balign 8
.globl	RTTI_$JNI_$$_C_JNIENV
	.type	RTTI_$JNI_$$_C_JNIENV,#object
RTTI_$JNI_$$_C_JNIENV:
	.byte	29,8
	.ascii	"C_JNIEnv"
	.byte	0,0,0,0,0,0
	.long	RTTI_$JNI_$$_JNINATIVEINTERFACE$indirect
	.byte	0,0,0,0
.Le295:
	.size	RTTI_$JNI_$$_C_JNIENV, .Le295 - RTTI_$JNI_$$_C_JNIENV

.section .data.rel.ro.n_RTTI_$JNI_$$_PPJNIENV
	.balign 8
.globl	RTTI_$JNI_$$_PPJNIENV
	.type	RTTI_$JNI_$$_PPJNIENV,#object
RTTI_$JNI_$$_PPJNIENV:
	.byte	29,8
	.ascii	"PPJNIEnv"
	.byte	0,0,0,0,0,0
	.long	RTTI_$JNI_$$_PJNIENV$indirect
	.byte	0,0,0,0
.Le296:
	.size	RTTI_$JNI_$$_PPJNIENV, .Le296 - RTTI_$JNI_$$_PPJNIENV

.section .data.rel.ro.n_RTTI_$JNI_$$_PPJAVAVM
	.balign 8
.globl	RTTI_$JNI_$$_PPJAVAVM
	.type	RTTI_$JNI_$$_PPJAVAVM,#object
RTTI_$JNI_$$_PPJAVAVM:
	.byte	29,8
	.ascii	"PPJavaVM"
	.byte	0,0,0,0,0,0
	.long	RTTI_$JNI_$$_PJAVAVM$indirect
	.byte	0,0,0,0
.Le297:
	.size	RTTI_$JNI_$$_PPJAVAVM, .Le297 - RTTI_$JNI_$$_PPJAVAVM

.section .data.rel.ro.n_INIT_$JNI_$$_JAVAVMATTACHARGS
	.balign 8
.globl	INIT_$JNI_$$_JAVAVMATTACHARGS
	.type	INIT_$JNI_$$_JAVAVMATTACHARGS,#object
INIT_$JNI_$$_JAVAVMATTACHARGS:
	.byte	13,16
	.ascii	"JavaVMAttachArgs"
	.byte	0,0,0,0,0,0
	.long	0,12,0,0,0
	.byte	0,0,0,0
.Le298:
	.size	INIT_$JNI_$$_JAVAVMATTACHARGS, .Le298 - INIT_$JNI_$$_JAVAVMATTACHARGS

.section .data.rel.ro.n_RTTI_$JNI_$$_JAVAVMATTACHARGS
	.balign 8
.globl	RTTI_$JNI_$$_JAVAVMATTACHARGS
	.type	RTTI_$JNI_$$_JAVAVMATTACHARGS,#object
RTTI_$JNI_$$_JAVAVMATTACHARGS:
	.byte	13,16
	.ascii	"JavaVMAttachArgs"
	.byte	0,0,0,0,0,0
	.long	INIT_$JNI_$$_JAVAVMATTACHARGS
	.long	12,3
	.long	RTTI_$SYSTEM_$$_LONGINT$indirect
	.long	0
	.long	RTTI_$SYSTEM_$$_PCHAR$indirect
	.long	4
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.long	8
	.byte	0,0,0,0
.Le299:
	.size	RTTI_$JNI_$$_JAVAVMATTACHARGS, .Le299 - RTTI_$JNI_$$_JAVAVMATTACHARGS

.section .data.rel.ro.n_INIT_$JNI_$$_JAVAVMOPTION
	.balign 8
.globl	INIT_$JNI_$$_JAVAVMOPTION
	.type	INIT_$JNI_$$_JAVAVMOPTION,#object
INIT_$JNI_$$_JAVAVMOPTION:
	.byte	13,12
	.ascii	"JavaVMOption"
	.byte	0,0
	.long	0,8,0,0,0
	.byte	0,0,0,0
.Le300:
	.size	INIT_$JNI_$$_JAVAVMOPTION, .Le300 - INIT_$JNI_$$_JAVAVMOPTION

.section .data.rel.ro.n_RTTI_$JNI_$$_JAVAVMOPTION
	.balign 8
.globl	RTTI_$JNI_$$_JAVAVMOPTION
	.type	RTTI_$JNI_$$_JAVAVMOPTION,#object
RTTI_$JNI_$$_JAVAVMOPTION:
	.byte	13,12
	.ascii	"JavaVMOption"
	.byte	0,0
	.long	INIT_$JNI_$$_JAVAVMOPTION
	.long	8,2
	.long	RTTI_$SYSTEM_$$_PCHAR$indirect
	.long	0
	.long	RTTI_$SYSTEM_$$_POINTER$indirect
	.long	4
	.byte	0,0,0,0
.Le301:
	.size	RTTI_$JNI_$$_JAVAVMOPTION, .Le301 - RTTI_$JNI_$$_JAVAVMOPTION

.section .data.rel.ro.n_RTTI_$JNI_$$_PJAVAVMOPTION
	.balign 8
.globl	RTTI_$JNI_$$_PJAVAVMOPTION
	.type	RTTI_$JNI_$$_PJAVAVMOPTION,#object
RTTI_$JNI_$$_PJAVAVMOPTION:
	.byte	29,13
	.ascii	"PJavaVMOption"
	.byte	0
	.long	RTTI_$JNI_$$_JAVAVMOPTION$indirect
	.byte	0,0,0,0
.Le302:
	.size	RTTI_$JNI_$$_PJAVAVMOPTION, .Le302 - RTTI_$JNI_$$_PJAVAVMOPTION

.section .data.rel.ro.n_INIT_$JNI_$$_JAVAVMINITARGS
	.balign 8
.globl	INIT_$JNI_$$_JAVAVMINITARGS
	.type	INIT_$JNI_$$_JAVAVMINITARGS,#object
INIT_$JNI_$$_JAVAVMINITARGS:
	.byte	13,14
	.ascii	"JavaVMInitArgs"
	.long	0,16,0,0,0
	.byte	0,0,0,0
.Le303:
	.size	INIT_$JNI_$$_JAVAVMINITARGS, .Le303 - INIT_$JNI_$$_JAVAVMINITARGS

.section .data.rel.ro.n_RTTI_$JNI_$$_JAVAVMINITARGS
	.balign 8
.globl	RTTI_$JNI_$$_JAVAVMINITARGS
	.type	RTTI_$JNI_$$_JAVAVMINITARGS,#object
RTTI_$JNI_$$_JAVAVMINITARGS:
	.byte	13,14
	.ascii	"JavaVMInitArgs"
	.long	INIT_$JNI_$$_JAVAVMINITARGS
	.long	16,4
	.long	RTTI_$SYSTEM_$$_LONGINT$indirect
	.long	0
	.long	RTTI_$SYSTEM_$$_LONGINT$indirect
	.long	4
	.long	RTTI_$JNI_$$_PJAVAVMOPTION$indirect
	.long	8
	.long	RTTI_$JNI_$$_PJBOOLEAN$indirect
	.long	12
	.byte	0,0,0,0
.Le304:
	.size	RTTI_$JNI_$$_JAVAVMINITARGS, .Le304 - RTTI_$JNI_$$_JAVAVMINITARGS
# End asmlist al_rtti
# Begin asmlist al_indirectglobals

.section .data.rel.ro.n_RTTI_$JNI_$$_PJBOOLEAN
	.balign 4
.globl	RTTI_$JNI_$$_PJBOOLEAN$indirect
	.type	RTTI_$JNI_$$_PJBOOLEAN$indirect,#object
RTTI_$JNI_$$_PJBOOLEAN$indirect:
	.long	RTTI_$JNI_$$_PJBOOLEAN
.Le305:
	.size	RTTI_$JNI_$$_PJBOOLEAN$indirect, .Le305 - RTTI_$JNI_$$_PJBOOLEAN$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_PJBYTE
	.balign 4
.globl	RTTI_$JNI_$$_PJBYTE$indirect
	.type	RTTI_$JNI_$$_PJBYTE$indirect,#object
RTTI_$JNI_$$_PJBYTE$indirect:
	.long	RTTI_$JNI_$$_PJBYTE
.Le306:
	.size	RTTI_$JNI_$$_PJBYTE$indirect, .Le306 - RTTI_$JNI_$$_PJBYTE$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_PJCHAR
	.balign 4
.globl	RTTI_$JNI_$$_PJCHAR$indirect
	.type	RTTI_$JNI_$$_PJCHAR$indirect,#object
RTTI_$JNI_$$_PJCHAR$indirect:
	.long	RTTI_$JNI_$$_PJCHAR
.Le307:
	.size	RTTI_$JNI_$$_PJCHAR$indirect, .Le307 - RTTI_$JNI_$$_PJCHAR$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_PJSHORT
	.balign 4
.globl	RTTI_$JNI_$$_PJSHORT$indirect
	.type	RTTI_$JNI_$$_PJSHORT$indirect,#object
RTTI_$JNI_$$_PJSHORT$indirect:
	.long	RTTI_$JNI_$$_PJSHORT
.Le308:
	.size	RTTI_$JNI_$$_PJSHORT$indirect, .Le308 - RTTI_$JNI_$$_PJSHORT$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_PJINT
	.balign 4
.globl	RTTI_$JNI_$$_PJINT$indirect
	.type	RTTI_$JNI_$$_PJINT$indirect,#object
RTTI_$JNI_$$_PJINT$indirect:
	.long	RTTI_$JNI_$$_PJINT
.Le309:
	.size	RTTI_$JNI_$$_PJINT$indirect, .Le309 - RTTI_$JNI_$$_PJINT$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_PJLONG
	.balign 4
.globl	RTTI_$JNI_$$_PJLONG$indirect
	.type	RTTI_$JNI_$$_PJLONG$indirect,#object
RTTI_$JNI_$$_PJLONG$indirect:
	.long	RTTI_$JNI_$$_PJLONG
.Le310:
	.size	RTTI_$JNI_$$_PJLONG$indirect, .Le310 - RTTI_$JNI_$$_PJLONG$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_PJFLOAT
	.balign 4
.globl	RTTI_$JNI_$$_PJFLOAT$indirect
	.type	RTTI_$JNI_$$_PJFLOAT$indirect,#object
RTTI_$JNI_$$_PJFLOAT$indirect:
	.long	RTTI_$JNI_$$_PJFLOAT
.Le311:
	.size	RTTI_$JNI_$$_PJFLOAT$indirect, .Le311 - RTTI_$JNI_$$_PJFLOAT$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_PJDOUBLE
	.balign 4
.globl	RTTI_$JNI_$$_PJDOUBLE$indirect
	.type	RTTI_$JNI_$$_PJDOUBLE$indirect,#object
RTTI_$JNI_$$_PJDOUBLE$indirect:
	.long	RTTI_$JNI_$$_PJDOUBLE
.Le312:
	.size	RTTI_$JNI_$$_PJDOUBLE$indirect, .Le312 - RTTI_$JNI_$$_PJDOUBLE$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_PJSIZE
	.balign 4
.globl	RTTI_$JNI_$$_PJSIZE$indirect
	.type	RTTI_$JNI_$$_PJSIZE$indirect,#object
RTTI_$JNI_$$_PJSIZE$indirect:
	.long	RTTI_$JNI_$$_PJSIZE
.Le313:
	.size	RTTI_$JNI_$$_PJSIZE$indirect, .Le313 - RTTI_$JNI_$$_PJSIZE$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_PPOINTER
	.balign 4
.globl	RTTI_$JNI_$$_PPOINTER$indirect
	.type	RTTI_$JNI_$$_PPOINTER$indirect,#object
RTTI_$JNI_$$_PPOINTER$indirect:
	.long	RTTI_$JNI_$$_PPOINTER
.Le314:
	.size	RTTI_$JNI_$$_PPOINTER$indirect, .Le314 - RTTI_$JNI_$$_PPOINTER$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_PJOBJECT
	.balign 4
.globl	RTTI_$JNI_$$_PJOBJECT$indirect
	.type	RTTI_$JNI_$$_PJOBJECT$indirect,#object
RTTI_$JNI_$$_PJOBJECT$indirect:
	.long	RTTI_$JNI_$$_PJOBJECT
.Le315:
	.size	RTTI_$JNI_$$_PJOBJECT$indirect, .Le315 - RTTI_$JNI_$$_PJOBJECT$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_PJCLASS
	.balign 4
.globl	RTTI_$JNI_$$_PJCLASS$indirect
	.type	RTTI_$JNI_$$_PJCLASS$indirect,#object
RTTI_$JNI_$$_PJCLASS$indirect:
	.long	RTTI_$JNI_$$_PJCLASS
.Le316:
	.size	RTTI_$JNI_$$_PJCLASS$indirect, .Le316 - RTTI_$JNI_$$_PJCLASS$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_PJSTRING
	.balign 4
.globl	RTTI_$JNI_$$_PJSTRING$indirect
	.type	RTTI_$JNI_$$_PJSTRING$indirect,#object
RTTI_$JNI_$$_PJSTRING$indirect:
	.long	RTTI_$JNI_$$_PJSTRING
.Le317:
	.size	RTTI_$JNI_$$_PJSTRING$indirect, .Le317 - RTTI_$JNI_$$_PJSTRING$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_PJARRAY
	.balign 4
.globl	RTTI_$JNI_$$_PJARRAY$indirect
	.type	RTTI_$JNI_$$_PJARRAY$indirect,#object
RTTI_$JNI_$$_PJARRAY$indirect:
	.long	RTTI_$JNI_$$_PJARRAY
.Le318:
	.size	RTTI_$JNI_$$_PJARRAY$indirect, .Le318 - RTTI_$JNI_$$_PJARRAY$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_PJOBJECTARRAY
	.balign 4
.globl	RTTI_$JNI_$$_PJOBJECTARRAY$indirect
	.type	RTTI_$JNI_$$_PJOBJECTARRAY$indirect,#object
RTTI_$JNI_$$_PJOBJECTARRAY$indirect:
	.long	RTTI_$JNI_$$_PJOBJECTARRAY
.Le319:
	.size	RTTI_$JNI_$$_PJOBJECTARRAY$indirect, .Le319 - RTTI_$JNI_$$_PJOBJECTARRAY$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_PJBOOLEANARRAY
	.balign 4
.globl	RTTI_$JNI_$$_PJBOOLEANARRAY$indirect
	.type	RTTI_$JNI_$$_PJBOOLEANARRAY$indirect,#object
RTTI_$JNI_$$_PJBOOLEANARRAY$indirect:
	.long	RTTI_$JNI_$$_PJBOOLEANARRAY
.Le320:
	.size	RTTI_$JNI_$$_PJBOOLEANARRAY$indirect, .Le320 - RTTI_$JNI_$$_PJBOOLEANARRAY$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_PJBYTEARRAY
	.balign 4
.globl	RTTI_$JNI_$$_PJBYTEARRAY$indirect
	.type	RTTI_$JNI_$$_PJBYTEARRAY$indirect,#object
RTTI_$JNI_$$_PJBYTEARRAY$indirect:
	.long	RTTI_$JNI_$$_PJBYTEARRAY
.Le321:
	.size	RTTI_$JNI_$$_PJBYTEARRAY$indirect, .Le321 - RTTI_$JNI_$$_PJBYTEARRAY$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_PJCHARARRAY
	.balign 4
.globl	RTTI_$JNI_$$_PJCHARARRAY$indirect
	.type	RTTI_$JNI_$$_PJCHARARRAY$indirect,#object
RTTI_$JNI_$$_PJCHARARRAY$indirect:
	.long	RTTI_$JNI_$$_PJCHARARRAY
.Le322:
	.size	RTTI_$JNI_$$_PJCHARARRAY$indirect, .Le322 - RTTI_$JNI_$$_PJCHARARRAY$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_PJSHORTARRAY
	.balign 4
.globl	RTTI_$JNI_$$_PJSHORTARRAY$indirect
	.type	RTTI_$JNI_$$_PJSHORTARRAY$indirect,#object
RTTI_$JNI_$$_PJSHORTARRAY$indirect:
	.long	RTTI_$JNI_$$_PJSHORTARRAY
.Le323:
	.size	RTTI_$JNI_$$_PJSHORTARRAY$indirect, .Le323 - RTTI_$JNI_$$_PJSHORTARRAY$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_PJINTARRAY
	.balign 4
.globl	RTTI_$JNI_$$_PJINTARRAY$indirect
	.type	RTTI_$JNI_$$_PJINTARRAY$indirect,#object
RTTI_$JNI_$$_PJINTARRAY$indirect:
	.long	RTTI_$JNI_$$_PJINTARRAY
.Le324:
	.size	RTTI_$JNI_$$_PJINTARRAY$indirect, .Le324 - RTTI_$JNI_$$_PJINTARRAY$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_PJLONGARRAY
	.balign 4
.globl	RTTI_$JNI_$$_PJLONGARRAY$indirect
	.type	RTTI_$JNI_$$_PJLONGARRAY$indirect,#object
RTTI_$JNI_$$_PJLONGARRAY$indirect:
	.long	RTTI_$JNI_$$_PJLONGARRAY
.Le325:
	.size	RTTI_$JNI_$$_PJLONGARRAY$indirect, .Le325 - RTTI_$JNI_$$_PJLONGARRAY$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_PJFLOATARRAY
	.balign 4
.globl	RTTI_$JNI_$$_PJFLOATARRAY$indirect
	.type	RTTI_$JNI_$$_PJFLOATARRAY$indirect,#object
RTTI_$JNI_$$_PJFLOATARRAY$indirect:
	.long	RTTI_$JNI_$$_PJFLOATARRAY
.Le326:
	.size	RTTI_$JNI_$$_PJFLOATARRAY$indirect, .Le326 - RTTI_$JNI_$$_PJFLOATARRAY$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_PJDOUBLEARRAY
	.balign 4
.globl	RTTI_$JNI_$$_PJDOUBLEARRAY$indirect
	.type	RTTI_$JNI_$$_PJDOUBLEARRAY$indirect,#object
RTTI_$JNI_$$_PJDOUBLEARRAY$indirect:
	.long	RTTI_$JNI_$$_PJDOUBLEARRAY
.Le327:
	.size	RTTI_$JNI_$$_PJDOUBLEARRAY$indirect, .Le327 - RTTI_$JNI_$$_PJDOUBLEARRAY$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_PJTHROWABLE
	.balign 4
.globl	RTTI_$JNI_$$_PJTHROWABLE$indirect
	.type	RTTI_$JNI_$$_PJTHROWABLE$indirect,#object
RTTI_$JNI_$$_PJTHROWABLE$indirect:
	.long	RTTI_$JNI_$$_PJTHROWABLE
.Le328:
	.size	RTTI_$JNI_$$_PJTHROWABLE$indirect, .Le328 - RTTI_$JNI_$$_PJTHROWABLE$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_PJWEAK
	.balign 4
.globl	RTTI_$JNI_$$_PJWEAK$indirect
	.type	RTTI_$JNI_$$_PJWEAK$indirect,#object
RTTI_$JNI_$$_PJWEAK$indirect:
	.long	RTTI_$JNI_$$_PJWEAK
.Le329:
	.size	RTTI_$JNI_$$_PJWEAK$indirect, .Le329 - RTTI_$JNI_$$_PJWEAK$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_PJREF
	.balign 4
.globl	RTTI_$JNI_$$_PJREF$indirect
	.type	RTTI_$JNI_$$_PJREF$indirect,#object
RTTI_$JNI_$$_PJREF$indirect:
	.long	RTTI_$JNI_$$_PJREF
.Le330:
	.size	RTTI_$JNI_$$_PJREF$indirect, .Le330 - RTTI_$JNI_$$_PJREF$indirect

.section .data.rel.ro.n_INIT_$JNI_$$__JFIELDID
	.balign 4
.globl	INIT_$JNI_$$__JFIELDID$indirect
	.type	INIT_$JNI_$$__JFIELDID$indirect,#object
INIT_$JNI_$$__JFIELDID$indirect:
	.long	INIT_$JNI_$$__JFIELDID
.Le331:
	.size	INIT_$JNI_$$__JFIELDID$indirect, .Le331 - INIT_$JNI_$$__JFIELDID$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$__JFIELDID
	.balign 4
.globl	RTTI_$JNI_$$__JFIELDID$indirect
	.type	RTTI_$JNI_$$__JFIELDID$indirect,#object
RTTI_$JNI_$$__JFIELDID$indirect:
	.long	RTTI_$JNI_$$__JFIELDID
.Le332:
	.size	RTTI_$JNI_$$__JFIELDID$indirect, .Le332 - RTTI_$JNI_$$__JFIELDID$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_JFIELDID
	.balign 4
.globl	RTTI_$JNI_$$_JFIELDID$indirect
	.type	RTTI_$JNI_$$_JFIELDID$indirect,#object
RTTI_$JNI_$$_JFIELDID$indirect:
	.long	RTTI_$JNI_$$_JFIELDID
.Le333:
	.size	RTTI_$JNI_$$_JFIELDID$indirect, .Le333 - RTTI_$JNI_$$_JFIELDID$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_PJFIELDID
	.balign 4
.globl	RTTI_$JNI_$$_PJFIELDID$indirect
	.type	RTTI_$JNI_$$_PJFIELDID$indirect,#object
RTTI_$JNI_$$_PJFIELDID$indirect:
	.long	RTTI_$JNI_$$_PJFIELDID
.Le334:
	.size	RTTI_$JNI_$$_PJFIELDID$indirect, .Le334 - RTTI_$JNI_$$_PJFIELDID$indirect

.section .data.rel.ro.n_INIT_$JNI_$$__JMETHODID
	.balign 4
.globl	INIT_$JNI_$$__JMETHODID$indirect
	.type	INIT_$JNI_$$__JMETHODID$indirect,#object
INIT_$JNI_$$__JMETHODID$indirect:
	.long	INIT_$JNI_$$__JMETHODID
.Le335:
	.size	INIT_$JNI_$$__JMETHODID$indirect, .Le335 - INIT_$JNI_$$__JMETHODID$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$__JMETHODID
	.balign 4
.globl	RTTI_$JNI_$$__JMETHODID$indirect
	.type	RTTI_$JNI_$$__JMETHODID$indirect,#object
RTTI_$JNI_$$__JMETHODID$indirect:
	.long	RTTI_$JNI_$$__JMETHODID
.Le336:
	.size	RTTI_$JNI_$$__JMETHODID$indirect, .Le336 - RTTI_$JNI_$$__JMETHODID$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_JMETHODID
	.balign 4
.globl	RTTI_$JNI_$$_JMETHODID$indirect
	.type	RTTI_$JNI_$$_JMETHODID$indirect,#object
RTTI_$JNI_$$_JMETHODID$indirect:
	.long	RTTI_$JNI_$$_JMETHODID
.Le337:
	.size	RTTI_$JNI_$$_JMETHODID$indirect, .Le337 - RTTI_$JNI_$$_JMETHODID$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_PJMETHODID
	.balign 4
.globl	RTTI_$JNI_$$_PJMETHODID$indirect
	.type	RTTI_$JNI_$$_PJMETHODID$indirect,#object
RTTI_$JNI_$$_PJMETHODID$indirect:
	.long	RTTI_$JNI_$$_PJMETHODID
.Le338:
	.size	RTTI_$JNI_$$_PJMETHODID$indirect, .Le338 - RTTI_$JNI_$$_PJMETHODID$indirect

.section .data.rel.ro.n_INIT_$JNI_$$_JNIINVOKEINTERFACE
	.balign 4
.globl	INIT_$JNI_$$_JNIINVOKEINTERFACE$indirect
	.type	INIT_$JNI_$$_JNIINVOKEINTERFACE$indirect,#object
INIT_$JNI_$$_JNIINVOKEINTERFACE$indirect:
	.long	INIT_$JNI_$$_JNIINVOKEINTERFACE
.Le339:
	.size	INIT_$JNI_$$_JNIINVOKEINTERFACE$indirect, .Le339 - INIT_$JNI_$$_JNIINVOKEINTERFACE$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_JAVAVM
	.balign 4
.globl	RTTI_$JNI_$$_JAVAVM$indirect
	.type	RTTI_$JNI_$$_JAVAVM$indirect,#object
RTTI_$JNI_$$_JAVAVM$indirect:
	.long	RTTI_$JNI_$$_JAVAVM
.Le340:
	.size	RTTI_$JNI_$$_JAVAVM$indirect, .Le340 - RTTI_$JNI_$$_JAVAVM$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_PJAVAVM
	.balign 4
.globl	RTTI_$JNI_$$_PJAVAVM$indirect
	.type	RTTI_$JNI_$$_PJAVAVM$indirect,#object
RTTI_$JNI_$$_PJAVAVM$indirect:
	.long	RTTI_$JNI_$$_PJAVAVM
.Le341:
	.size	RTTI_$JNI_$$_PJAVAVM$indirect, .Le341 - RTTI_$JNI_$$_PJAVAVM$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000118
	.balign 4
.globl	RTTI_$JNI_$$_def00000118$indirect
	.type	RTTI_$JNI_$$_def00000118$indirect,#object
RTTI_$JNI_$$_def00000118$indirect:
	.long	RTTI_$JNI_$$_def00000118
.Le342:
	.size	RTTI_$JNI_$$_def00000118$indirect, .Le342 - RTTI_$JNI_$$_def00000118$indirect

.section .data.rel.ro.n_INIT_$JNI_$$_JNINATIVEINTERFACE
	.balign 4
.globl	INIT_$JNI_$$_JNINATIVEINTERFACE$indirect
	.type	INIT_$JNI_$$_JNINATIVEINTERFACE$indirect,#object
INIT_$JNI_$$_JNINATIVEINTERFACE$indirect:
	.long	INIT_$JNI_$$_JNINATIVEINTERFACE
.Le343:
	.size	INIT_$JNI_$$_JNINATIVEINTERFACE$indirect, .Le343 - INIT_$JNI_$$_JNINATIVEINTERFACE$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000032
	.balign 4
.globl	RTTI_$JNI_$$_def00000032$indirect
	.type	RTTI_$JNI_$$_def00000032$indirect,#object
RTTI_$JNI_$$_def00000032$indirect:
	.long	RTTI_$JNI_$$_def00000032
.Le344:
	.size	RTTI_$JNI_$$_def00000032$indirect, .Le344 - RTTI_$JNI_$$_def00000032$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000033
	.balign 4
.globl	RTTI_$JNI_$$_def00000033$indirect
	.type	RTTI_$JNI_$$_def00000033$indirect,#object
RTTI_$JNI_$$_def00000033$indirect:
	.long	RTTI_$JNI_$$_def00000033
.Le345:
	.size	RTTI_$JNI_$$_def00000033$indirect, .Le345 - RTTI_$JNI_$$_def00000033$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000034
	.balign 4
.globl	RTTI_$JNI_$$_def00000034$indirect
	.type	RTTI_$JNI_$$_def00000034$indirect,#object
RTTI_$JNI_$$_def00000034$indirect:
	.long	RTTI_$JNI_$$_def00000034
.Le346:
	.size	RTTI_$JNI_$$_def00000034$indirect, .Le346 - RTTI_$JNI_$$_def00000034$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000035
	.balign 4
.globl	RTTI_$JNI_$$_def00000035$indirect
	.type	RTTI_$JNI_$$_def00000035$indirect,#object
RTTI_$JNI_$$_def00000035$indirect:
	.long	RTTI_$JNI_$$_def00000035
.Le347:
	.size	RTTI_$JNI_$$_def00000035$indirect, .Le347 - RTTI_$JNI_$$_def00000035$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000036
	.balign 4
.globl	RTTI_$JNI_$$_def00000036$indirect
	.type	RTTI_$JNI_$$_def00000036$indirect,#object
RTTI_$JNI_$$_def00000036$indirect:
	.long	RTTI_$JNI_$$_def00000036
.Le348:
	.size	RTTI_$JNI_$$_def00000036$indirect, .Le348 - RTTI_$JNI_$$_def00000036$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000037
	.balign 4
.globl	RTTI_$JNI_$$_def00000037$indirect
	.type	RTTI_$JNI_$$_def00000037$indirect,#object
RTTI_$JNI_$$_def00000037$indirect:
	.long	RTTI_$JNI_$$_def00000037
.Le349:
	.size	RTTI_$JNI_$$_def00000037$indirect, .Le349 - RTTI_$JNI_$$_def00000037$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000038
	.balign 4
.globl	RTTI_$JNI_$$_def00000038$indirect
	.type	RTTI_$JNI_$$_def00000038$indirect,#object
RTTI_$JNI_$$_def00000038$indirect:
	.long	RTTI_$JNI_$$_def00000038
.Le350:
	.size	RTTI_$JNI_$$_def00000038$indirect, .Le350 - RTTI_$JNI_$$_def00000038$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000039
	.balign 4
.globl	RTTI_$JNI_$$_def00000039$indirect
	.type	RTTI_$JNI_$$_def00000039$indirect,#object
RTTI_$JNI_$$_def00000039$indirect:
	.long	RTTI_$JNI_$$_def00000039
.Le351:
	.size	RTTI_$JNI_$$_def00000039$indirect, .Le351 - RTTI_$JNI_$$_def00000039$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def0000003A
	.balign 4
.globl	RTTI_$JNI_$$_def0000003A$indirect
	.type	RTTI_$JNI_$$_def0000003A$indirect,#object
RTTI_$JNI_$$_def0000003A$indirect:
	.long	RTTI_$JNI_$$_def0000003A
.Le352:
	.size	RTTI_$JNI_$$_def0000003A$indirect, .Le352 - RTTI_$JNI_$$_def0000003A$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def0000003B
	.balign 4
.globl	RTTI_$JNI_$$_def0000003B$indirect
	.type	RTTI_$JNI_$$_def0000003B$indirect,#object
RTTI_$JNI_$$_def0000003B$indirect:
	.long	RTTI_$JNI_$$_def0000003B
.Le353:
	.size	RTTI_$JNI_$$_def0000003B$indirect, .Le353 - RTTI_$JNI_$$_def0000003B$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def0000003C
	.balign 4
.globl	RTTI_$JNI_$$_def0000003C$indirect
	.type	RTTI_$JNI_$$_def0000003C$indirect,#object
RTTI_$JNI_$$_def0000003C$indirect:
	.long	RTTI_$JNI_$$_def0000003C
.Le354:
	.size	RTTI_$JNI_$$_def0000003C$indirect, .Le354 - RTTI_$JNI_$$_def0000003C$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def0000003D
	.balign 4
.globl	RTTI_$JNI_$$_def0000003D$indirect
	.type	RTTI_$JNI_$$_def0000003D$indirect,#object
RTTI_$JNI_$$_def0000003D$indirect:
	.long	RTTI_$JNI_$$_def0000003D
.Le355:
	.size	RTTI_$JNI_$$_def0000003D$indirect, .Le355 - RTTI_$JNI_$$_def0000003D$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def0000003E
	.balign 4
.globl	RTTI_$JNI_$$_def0000003E$indirect
	.type	RTTI_$JNI_$$_def0000003E$indirect,#object
RTTI_$JNI_$$_def0000003E$indirect:
	.long	RTTI_$JNI_$$_def0000003E
.Le356:
	.size	RTTI_$JNI_$$_def0000003E$indirect, .Le356 - RTTI_$JNI_$$_def0000003E$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def0000003F
	.balign 4
.globl	RTTI_$JNI_$$_def0000003F$indirect
	.type	RTTI_$JNI_$$_def0000003F$indirect,#object
RTTI_$JNI_$$_def0000003F$indirect:
	.long	RTTI_$JNI_$$_def0000003F
.Le357:
	.size	RTTI_$JNI_$$_def0000003F$indirect, .Le357 - RTTI_$JNI_$$_def0000003F$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000040
	.balign 4
.globl	RTTI_$JNI_$$_def00000040$indirect
	.type	RTTI_$JNI_$$_def00000040$indirect,#object
RTTI_$JNI_$$_def00000040$indirect:
	.long	RTTI_$JNI_$$_def00000040
.Le358:
	.size	RTTI_$JNI_$$_def00000040$indirect, .Le358 - RTTI_$JNI_$$_def00000040$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000041
	.balign 4
.globl	RTTI_$JNI_$$_def00000041$indirect
	.type	RTTI_$JNI_$$_def00000041$indirect,#object
RTTI_$JNI_$$_def00000041$indirect:
	.long	RTTI_$JNI_$$_def00000041
.Le359:
	.size	RTTI_$JNI_$$_def00000041$indirect, .Le359 - RTTI_$JNI_$$_def00000041$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000042
	.balign 4
.globl	RTTI_$JNI_$$_def00000042$indirect
	.type	RTTI_$JNI_$$_def00000042$indirect,#object
RTTI_$JNI_$$_def00000042$indirect:
	.long	RTTI_$JNI_$$_def00000042
.Le360:
	.size	RTTI_$JNI_$$_def00000042$indirect, .Le360 - RTTI_$JNI_$$_def00000042$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000043
	.balign 4
.globl	RTTI_$JNI_$$_def00000043$indirect
	.type	RTTI_$JNI_$$_def00000043$indirect,#object
RTTI_$JNI_$$_def00000043$indirect:
	.long	RTTI_$JNI_$$_def00000043
.Le361:
	.size	RTTI_$JNI_$$_def00000043$indirect, .Le361 - RTTI_$JNI_$$_def00000043$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000044
	.balign 4
.globl	RTTI_$JNI_$$_def00000044$indirect
	.type	RTTI_$JNI_$$_def00000044$indirect,#object
RTTI_$JNI_$$_def00000044$indirect:
	.long	RTTI_$JNI_$$_def00000044
.Le362:
	.size	RTTI_$JNI_$$_def00000044$indirect, .Le362 - RTTI_$JNI_$$_def00000044$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000045
	.balign 4
.globl	RTTI_$JNI_$$_def00000045$indirect
	.type	RTTI_$JNI_$$_def00000045$indirect,#object
RTTI_$JNI_$$_def00000045$indirect:
	.long	RTTI_$JNI_$$_def00000045
.Le363:
	.size	RTTI_$JNI_$$_def00000045$indirect, .Le363 - RTTI_$JNI_$$_def00000045$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000046
	.balign 4
.globl	RTTI_$JNI_$$_def00000046$indirect
	.type	RTTI_$JNI_$$_def00000046$indirect,#object
RTTI_$JNI_$$_def00000046$indirect:
	.long	RTTI_$JNI_$$_def00000046
.Le364:
	.size	RTTI_$JNI_$$_def00000046$indirect, .Le364 - RTTI_$JNI_$$_def00000046$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000047
	.balign 4
.globl	RTTI_$JNI_$$_def00000047$indirect
	.type	RTTI_$JNI_$$_def00000047$indirect,#object
RTTI_$JNI_$$_def00000047$indirect:
	.long	RTTI_$JNI_$$_def00000047
.Le365:
	.size	RTTI_$JNI_$$_def00000047$indirect, .Le365 - RTTI_$JNI_$$_def00000047$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000048
	.balign 4
.globl	RTTI_$JNI_$$_def00000048$indirect
	.type	RTTI_$JNI_$$_def00000048$indirect,#object
RTTI_$JNI_$$_def00000048$indirect:
	.long	RTTI_$JNI_$$_def00000048
.Le366:
	.size	RTTI_$JNI_$$_def00000048$indirect, .Le366 - RTTI_$JNI_$$_def00000048$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000049
	.balign 4
.globl	RTTI_$JNI_$$_def00000049$indirect
	.type	RTTI_$JNI_$$_def00000049$indirect,#object
RTTI_$JNI_$$_def00000049$indirect:
	.long	RTTI_$JNI_$$_def00000049
.Le367:
	.size	RTTI_$JNI_$$_def00000049$indirect, .Le367 - RTTI_$JNI_$$_def00000049$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def0000004A
	.balign 4
.globl	RTTI_$JNI_$$_def0000004A$indirect
	.type	RTTI_$JNI_$$_def0000004A$indirect,#object
RTTI_$JNI_$$_def0000004A$indirect:
	.long	RTTI_$JNI_$$_def0000004A
.Le368:
	.size	RTTI_$JNI_$$_def0000004A$indirect, .Le368 - RTTI_$JNI_$$_def0000004A$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def0000004B
	.balign 4
.globl	RTTI_$JNI_$$_def0000004B$indirect
	.type	RTTI_$JNI_$$_def0000004B$indirect,#object
RTTI_$JNI_$$_def0000004B$indirect:
	.long	RTTI_$JNI_$$_def0000004B
.Le369:
	.size	RTTI_$JNI_$$_def0000004B$indirect, .Le369 - RTTI_$JNI_$$_def0000004B$indirect

.section .data.rel.ro.n_INIT_$JNI_$$_JVALUE
	.balign 4
.globl	INIT_$JNI_$$_JVALUE$indirect
	.type	INIT_$JNI_$$_JVALUE$indirect,#object
INIT_$JNI_$$_JVALUE$indirect:
	.long	INIT_$JNI_$$_JVALUE
.Le370:
	.size	INIT_$JNI_$$_JVALUE$indirect, .Le370 - INIT_$JNI_$$_JVALUE$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_JVALUE
	.balign 4
.globl	RTTI_$JNI_$$_JVALUE$indirect
	.type	RTTI_$JNI_$$_JVALUE$indirect,#object
RTTI_$JNI_$$_JVALUE$indirect:
	.long	RTTI_$JNI_$$_JVALUE
.Le371:
	.size	RTTI_$JNI_$$_JVALUE$indirect, .Le371 - RTTI_$JNI_$$_JVALUE$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_PJVALUE
	.balign 4
.globl	RTTI_$JNI_$$_PJVALUE$indirect
	.type	RTTI_$JNI_$$_PJVALUE$indirect,#object
RTTI_$JNI_$$_PJVALUE$indirect:
	.long	RTTI_$JNI_$$_PJVALUE
.Le372:
	.size	RTTI_$JNI_$$_PJVALUE$indirect, .Le372 - RTTI_$JNI_$$_PJVALUE$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def0000004C
	.balign 4
.globl	RTTI_$JNI_$$_def0000004C$indirect
	.type	RTTI_$JNI_$$_def0000004C$indirect,#object
RTTI_$JNI_$$_def0000004C$indirect:
	.long	RTTI_$JNI_$$_def0000004C
.Le373:
	.size	RTTI_$JNI_$$_def0000004C$indirect, .Le373 - RTTI_$JNI_$$_def0000004C$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def0000004D
	.balign 4
.globl	RTTI_$JNI_$$_def0000004D$indirect
	.type	RTTI_$JNI_$$_def0000004D$indirect,#object
RTTI_$JNI_$$_def0000004D$indirect:
	.long	RTTI_$JNI_$$_def0000004D
.Le374:
	.size	RTTI_$JNI_$$_def0000004D$indirect, .Le374 - RTTI_$JNI_$$_def0000004D$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def0000004E
	.balign 4
.globl	RTTI_$JNI_$$_def0000004E$indirect
	.type	RTTI_$JNI_$$_def0000004E$indirect,#object
RTTI_$JNI_$$_def0000004E$indirect:
	.long	RTTI_$JNI_$$_def0000004E
.Le375:
	.size	RTTI_$JNI_$$_def0000004E$indirect, .Le375 - RTTI_$JNI_$$_def0000004E$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def0000004F
	.balign 4
.globl	RTTI_$JNI_$$_def0000004F$indirect
	.type	RTTI_$JNI_$$_def0000004F$indirect,#object
RTTI_$JNI_$$_def0000004F$indirect:
	.long	RTTI_$JNI_$$_def0000004F
.Le376:
	.size	RTTI_$JNI_$$_def0000004F$indirect, .Le376 - RTTI_$JNI_$$_def0000004F$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000050
	.balign 4
.globl	RTTI_$JNI_$$_def00000050$indirect
	.type	RTTI_$JNI_$$_def00000050$indirect,#object
RTTI_$JNI_$$_def00000050$indirect:
	.long	RTTI_$JNI_$$_def00000050
.Le377:
	.size	RTTI_$JNI_$$_def00000050$indirect, .Le377 - RTTI_$JNI_$$_def00000050$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000051
	.balign 4
.globl	RTTI_$JNI_$$_def00000051$indirect
	.type	RTTI_$JNI_$$_def00000051$indirect,#object
RTTI_$JNI_$$_def00000051$indirect:
	.long	RTTI_$JNI_$$_def00000051
.Le378:
	.size	RTTI_$JNI_$$_def00000051$indirect, .Le378 - RTTI_$JNI_$$_def00000051$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000052
	.balign 4
.globl	RTTI_$JNI_$$_def00000052$indirect
	.type	RTTI_$JNI_$$_def00000052$indirect,#object
RTTI_$JNI_$$_def00000052$indirect:
	.long	RTTI_$JNI_$$_def00000052
.Le379:
	.size	RTTI_$JNI_$$_def00000052$indirect, .Le379 - RTTI_$JNI_$$_def00000052$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000053
	.balign 4
.globl	RTTI_$JNI_$$_def00000053$indirect
	.type	RTTI_$JNI_$$_def00000053$indirect,#object
RTTI_$JNI_$$_def00000053$indirect:
	.long	RTTI_$JNI_$$_def00000053
.Le380:
	.size	RTTI_$JNI_$$_def00000053$indirect, .Le380 - RTTI_$JNI_$$_def00000053$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000054
	.balign 4
.globl	RTTI_$JNI_$$_def00000054$indirect
	.type	RTTI_$JNI_$$_def00000054$indirect,#object
RTTI_$JNI_$$_def00000054$indirect:
	.long	RTTI_$JNI_$$_def00000054
.Le381:
	.size	RTTI_$JNI_$$_def00000054$indirect, .Le381 - RTTI_$JNI_$$_def00000054$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000055
	.balign 4
.globl	RTTI_$JNI_$$_def00000055$indirect
	.type	RTTI_$JNI_$$_def00000055$indirect,#object
RTTI_$JNI_$$_def00000055$indirect:
	.long	RTTI_$JNI_$$_def00000055
.Le382:
	.size	RTTI_$JNI_$$_def00000055$indirect, .Le382 - RTTI_$JNI_$$_def00000055$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000056
	.balign 4
.globl	RTTI_$JNI_$$_def00000056$indirect
	.type	RTTI_$JNI_$$_def00000056$indirect,#object
RTTI_$JNI_$$_def00000056$indirect:
	.long	RTTI_$JNI_$$_def00000056
.Le383:
	.size	RTTI_$JNI_$$_def00000056$indirect, .Le383 - RTTI_$JNI_$$_def00000056$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000057
	.balign 4
.globl	RTTI_$JNI_$$_def00000057$indirect
	.type	RTTI_$JNI_$$_def00000057$indirect,#object
RTTI_$JNI_$$_def00000057$indirect:
	.long	RTTI_$JNI_$$_def00000057
.Le384:
	.size	RTTI_$JNI_$$_def00000057$indirect, .Le384 - RTTI_$JNI_$$_def00000057$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000058
	.balign 4
.globl	RTTI_$JNI_$$_def00000058$indirect
	.type	RTTI_$JNI_$$_def00000058$indirect,#object
RTTI_$JNI_$$_def00000058$indirect:
	.long	RTTI_$JNI_$$_def00000058
.Le385:
	.size	RTTI_$JNI_$$_def00000058$indirect, .Le385 - RTTI_$JNI_$$_def00000058$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000059
	.balign 4
.globl	RTTI_$JNI_$$_def00000059$indirect
	.type	RTTI_$JNI_$$_def00000059$indirect,#object
RTTI_$JNI_$$_def00000059$indirect:
	.long	RTTI_$JNI_$$_def00000059
.Le386:
	.size	RTTI_$JNI_$$_def00000059$indirect, .Le386 - RTTI_$JNI_$$_def00000059$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def0000005A
	.balign 4
.globl	RTTI_$JNI_$$_def0000005A$indirect
	.type	RTTI_$JNI_$$_def0000005A$indirect,#object
RTTI_$JNI_$$_def0000005A$indirect:
	.long	RTTI_$JNI_$$_def0000005A
.Le387:
	.size	RTTI_$JNI_$$_def0000005A$indirect, .Le387 - RTTI_$JNI_$$_def0000005A$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def0000005B
	.balign 4
.globl	RTTI_$JNI_$$_def0000005B$indirect
	.type	RTTI_$JNI_$$_def0000005B$indirect,#object
RTTI_$JNI_$$_def0000005B$indirect:
	.long	RTTI_$JNI_$$_def0000005B
.Le388:
	.size	RTTI_$JNI_$$_def0000005B$indirect, .Le388 - RTTI_$JNI_$$_def0000005B$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def0000005C
	.balign 4
.globl	RTTI_$JNI_$$_def0000005C$indirect
	.type	RTTI_$JNI_$$_def0000005C$indirect,#object
RTTI_$JNI_$$_def0000005C$indirect:
	.long	RTTI_$JNI_$$_def0000005C
.Le389:
	.size	RTTI_$JNI_$$_def0000005C$indirect, .Le389 - RTTI_$JNI_$$_def0000005C$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def0000005D
	.balign 4
.globl	RTTI_$JNI_$$_def0000005D$indirect
	.type	RTTI_$JNI_$$_def0000005D$indirect,#object
RTTI_$JNI_$$_def0000005D$indirect:
	.long	RTTI_$JNI_$$_def0000005D
.Le390:
	.size	RTTI_$JNI_$$_def0000005D$indirect, .Le390 - RTTI_$JNI_$$_def0000005D$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def0000005E
	.balign 4
.globl	RTTI_$JNI_$$_def0000005E$indirect
	.type	RTTI_$JNI_$$_def0000005E$indirect,#object
RTTI_$JNI_$$_def0000005E$indirect:
	.long	RTTI_$JNI_$$_def0000005E
.Le391:
	.size	RTTI_$JNI_$$_def0000005E$indirect, .Le391 - RTTI_$JNI_$$_def0000005E$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def0000005F
	.balign 4
.globl	RTTI_$JNI_$$_def0000005F$indirect
	.type	RTTI_$JNI_$$_def0000005F$indirect,#object
RTTI_$JNI_$$_def0000005F$indirect:
	.long	RTTI_$JNI_$$_def0000005F
.Le392:
	.size	RTTI_$JNI_$$_def0000005F$indirect, .Le392 - RTTI_$JNI_$$_def0000005F$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000060
	.balign 4
.globl	RTTI_$JNI_$$_def00000060$indirect
	.type	RTTI_$JNI_$$_def00000060$indirect,#object
RTTI_$JNI_$$_def00000060$indirect:
	.long	RTTI_$JNI_$$_def00000060
.Le393:
	.size	RTTI_$JNI_$$_def00000060$indirect, .Le393 - RTTI_$JNI_$$_def00000060$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000061
	.balign 4
.globl	RTTI_$JNI_$$_def00000061$indirect
	.type	RTTI_$JNI_$$_def00000061$indirect,#object
RTTI_$JNI_$$_def00000061$indirect:
	.long	RTTI_$JNI_$$_def00000061
.Le394:
	.size	RTTI_$JNI_$$_def00000061$indirect, .Le394 - RTTI_$JNI_$$_def00000061$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000062
	.balign 4
.globl	RTTI_$JNI_$$_def00000062$indirect
	.type	RTTI_$JNI_$$_def00000062$indirect,#object
RTTI_$JNI_$$_def00000062$indirect:
	.long	RTTI_$JNI_$$_def00000062
.Le395:
	.size	RTTI_$JNI_$$_def00000062$indirect, .Le395 - RTTI_$JNI_$$_def00000062$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000063
	.balign 4
.globl	RTTI_$JNI_$$_def00000063$indirect
	.type	RTTI_$JNI_$$_def00000063$indirect,#object
RTTI_$JNI_$$_def00000063$indirect:
	.long	RTTI_$JNI_$$_def00000063
.Le396:
	.size	RTTI_$JNI_$$_def00000063$indirect, .Le396 - RTTI_$JNI_$$_def00000063$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000064
	.balign 4
.globl	RTTI_$JNI_$$_def00000064$indirect
	.type	RTTI_$JNI_$$_def00000064$indirect,#object
RTTI_$JNI_$$_def00000064$indirect:
	.long	RTTI_$JNI_$$_def00000064
.Le397:
	.size	RTTI_$JNI_$$_def00000064$indirect, .Le397 - RTTI_$JNI_$$_def00000064$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000065
	.balign 4
.globl	RTTI_$JNI_$$_def00000065$indirect
	.type	RTTI_$JNI_$$_def00000065$indirect,#object
RTTI_$JNI_$$_def00000065$indirect:
	.long	RTTI_$JNI_$$_def00000065
.Le398:
	.size	RTTI_$JNI_$$_def00000065$indirect, .Le398 - RTTI_$JNI_$$_def00000065$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000066
	.balign 4
.globl	RTTI_$JNI_$$_def00000066$indirect
	.type	RTTI_$JNI_$$_def00000066$indirect,#object
RTTI_$JNI_$$_def00000066$indirect:
	.long	RTTI_$JNI_$$_def00000066
.Le399:
	.size	RTTI_$JNI_$$_def00000066$indirect, .Le399 - RTTI_$JNI_$$_def00000066$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000067
	.balign 4
.globl	RTTI_$JNI_$$_def00000067$indirect
	.type	RTTI_$JNI_$$_def00000067$indirect,#object
RTTI_$JNI_$$_def00000067$indirect:
	.long	RTTI_$JNI_$$_def00000067
.Le400:
	.size	RTTI_$JNI_$$_def00000067$indirect, .Le400 - RTTI_$JNI_$$_def00000067$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000068
	.balign 4
.globl	RTTI_$JNI_$$_def00000068$indirect
	.type	RTTI_$JNI_$$_def00000068$indirect,#object
RTTI_$JNI_$$_def00000068$indirect:
	.long	RTTI_$JNI_$$_def00000068
.Le401:
	.size	RTTI_$JNI_$$_def00000068$indirect, .Le401 - RTTI_$JNI_$$_def00000068$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000069
	.balign 4
.globl	RTTI_$JNI_$$_def00000069$indirect
	.type	RTTI_$JNI_$$_def00000069$indirect,#object
RTTI_$JNI_$$_def00000069$indirect:
	.long	RTTI_$JNI_$$_def00000069
.Le402:
	.size	RTTI_$JNI_$$_def00000069$indirect, .Le402 - RTTI_$JNI_$$_def00000069$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def0000006A
	.balign 4
.globl	RTTI_$JNI_$$_def0000006A$indirect
	.type	RTTI_$JNI_$$_def0000006A$indirect,#object
RTTI_$JNI_$$_def0000006A$indirect:
	.long	RTTI_$JNI_$$_def0000006A
.Le403:
	.size	RTTI_$JNI_$$_def0000006A$indirect, .Le403 - RTTI_$JNI_$$_def0000006A$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def0000006B
	.balign 4
.globl	RTTI_$JNI_$$_def0000006B$indirect
	.type	RTTI_$JNI_$$_def0000006B$indirect,#object
RTTI_$JNI_$$_def0000006B$indirect:
	.long	RTTI_$JNI_$$_def0000006B
.Le404:
	.size	RTTI_$JNI_$$_def0000006B$indirect, .Le404 - RTTI_$JNI_$$_def0000006B$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def0000006C
	.balign 4
.globl	RTTI_$JNI_$$_def0000006C$indirect
	.type	RTTI_$JNI_$$_def0000006C$indirect,#object
RTTI_$JNI_$$_def0000006C$indirect:
	.long	RTTI_$JNI_$$_def0000006C
.Le405:
	.size	RTTI_$JNI_$$_def0000006C$indirect, .Le405 - RTTI_$JNI_$$_def0000006C$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def0000006D
	.balign 4
.globl	RTTI_$JNI_$$_def0000006D$indirect
	.type	RTTI_$JNI_$$_def0000006D$indirect,#object
RTTI_$JNI_$$_def0000006D$indirect:
	.long	RTTI_$JNI_$$_def0000006D
.Le406:
	.size	RTTI_$JNI_$$_def0000006D$indirect, .Le406 - RTTI_$JNI_$$_def0000006D$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def0000006E
	.balign 4
.globl	RTTI_$JNI_$$_def0000006E$indirect
	.type	RTTI_$JNI_$$_def0000006E$indirect,#object
RTTI_$JNI_$$_def0000006E$indirect:
	.long	RTTI_$JNI_$$_def0000006E
.Le407:
	.size	RTTI_$JNI_$$_def0000006E$indirect, .Le407 - RTTI_$JNI_$$_def0000006E$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def0000006F
	.balign 4
.globl	RTTI_$JNI_$$_def0000006F$indirect
	.type	RTTI_$JNI_$$_def0000006F$indirect,#object
RTTI_$JNI_$$_def0000006F$indirect:
	.long	RTTI_$JNI_$$_def0000006F
.Le408:
	.size	RTTI_$JNI_$$_def0000006F$indirect, .Le408 - RTTI_$JNI_$$_def0000006F$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000070
	.balign 4
.globl	RTTI_$JNI_$$_def00000070$indirect
	.type	RTTI_$JNI_$$_def00000070$indirect,#object
RTTI_$JNI_$$_def00000070$indirect:
	.long	RTTI_$JNI_$$_def00000070
.Le409:
	.size	RTTI_$JNI_$$_def00000070$indirect, .Le409 - RTTI_$JNI_$$_def00000070$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000071
	.balign 4
.globl	RTTI_$JNI_$$_def00000071$indirect
	.type	RTTI_$JNI_$$_def00000071$indirect,#object
RTTI_$JNI_$$_def00000071$indirect:
	.long	RTTI_$JNI_$$_def00000071
.Le410:
	.size	RTTI_$JNI_$$_def00000071$indirect, .Le410 - RTTI_$JNI_$$_def00000071$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000072
	.balign 4
.globl	RTTI_$JNI_$$_def00000072$indirect
	.type	RTTI_$JNI_$$_def00000072$indirect,#object
RTTI_$JNI_$$_def00000072$indirect:
	.long	RTTI_$JNI_$$_def00000072
.Le411:
	.size	RTTI_$JNI_$$_def00000072$indirect, .Le411 - RTTI_$JNI_$$_def00000072$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000073
	.balign 4
.globl	RTTI_$JNI_$$_def00000073$indirect
	.type	RTTI_$JNI_$$_def00000073$indirect,#object
RTTI_$JNI_$$_def00000073$indirect:
	.long	RTTI_$JNI_$$_def00000073
.Le412:
	.size	RTTI_$JNI_$$_def00000073$indirect, .Le412 - RTTI_$JNI_$$_def00000073$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000074
	.balign 4
.globl	RTTI_$JNI_$$_def00000074$indirect
	.type	RTTI_$JNI_$$_def00000074$indirect,#object
RTTI_$JNI_$$_def00000074$indirect:
	.long	RTTI_$JNI_$$_def00000074
.Le413:
	.size	RTTI_$JNI_$$_def00000074$indirect, .Le413 - RTTI_$JNI_$$_def00000074$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000075
	.balign 4
.globl	RTTI_$JNI_$$_def00000075$indirect
	.type	RTTI_$JNI_$$_def00000075$indirect,#object
RTTI_$JNI_$$_def00000075$indirect:
	.long	RTTI_$JNI_$$_def00000075
.Le414:
	.size	RTTI_$JNI_$$_def00000075$indirect, .Le414 - RTTI_$JNI_$$_def00000075$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000076
	.balign 4
.globl	RTTI_$JNI_$$_def00000076$indirect
	.type	RTTI_$JNI_$$_def00000076$indirect,#object
RTTI_$JNI_$$_def00000076$indirect:
	.long	RTTI_$JNI_$$_def00000076
.Le415:
	.size	RTTI_$JNI_$$_def00000076$indirect, .Le415 - RTTI_$JNI_$$_def00000076$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000077
	.balign 4
.globl	RTTI_$JNI_$$_def00000077$indirect
	.type	RTTI_$JNI_$$_def00000077$indirect,#object
RTTI_$JNI_$$_def00000077$indirect:
	.long	RTTI_$JNI_$$_def00000077
.Le416:
	.size	RTTI_$JNI_$$_def00000077$indirect, .Le416 - RTTI_$JNI_$$_def00000077$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000078
	.balign 4
.globl	RTTI_$JNI_$$_def00000078$indirect
	.type	RTTI_$JNI_$$_def00000078$indirect,#object
RTTI_$JNI_$$_def00000078$indirect:
	.long	RTTI_$JNI_$$_def00000078
.Le417:
	.size	RTTI_$JNI_$$_def00000078$indirect, .Le417 - RTTI_$JNI_$$_def00000078$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000079
	.balign 4
.globl	RTTI_$JNI_$$_def00000079$indirect
	.type	RTTI_$JNI_$$_def00000079$indirect,#object
RTTI_$JNI_$$_def00000079$indirect:
	.long	RTTI_$JNI_$$_def00000079
.Le418:
	.size	RTTI_$JNI_$$_def00000079$indirect, .Le418 - RTTI_$JNI_$$_def00000079$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def0000007A
	.balign 4
.globl	RTTI_$JNI_$$_def0000007A$indirect
	.type	RTTI_$JNI_$$_def0000007A$indirect,#object
RTTI_$JNI_$$_def0000007A$indirect:
	.long	RTTI_$JNI_$$_def0000007A
.Le419:
	.size	RTTI_$JNI_$$_def0000007A$indirect, .Le419 - RTTI_$JNI_$$_def0000007A$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def0000007B
	.balign 4
.globl	RTTI_$JNI_$$_def0000007B$indirect
	.type	RTTI_$JNI_$$_def0000007B$indirect,#object
RTTI_$JNI_$$_def0000007B$indirect:
	.long	RTTI_$JNI_$$_def0000007B
.Le420:
	.size	RTTI_$JNI_$$_def0000007B$indirect, .Le420 - RTTI_$JNI_$$_def0000007B$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def0000007C
	.balign 4
.globl	RTTI_$JNI_$$_def0000007C$indirect
	.type	RTTI_$JNI_$$_def0000007C$indirect,#object
RTTI_$JNI_$$_def0000007C$indirect:
	.long	RTTI_$JNI_$$_def0000007C
.Le421:
	.size	RTTI_$JNI_$$_def0000007C$indirect, .Le421 - RTTI_$JNI_$$_def0000007C$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def0000007D
	.balign 4
.globl	RTTI_$JNI_$$_def0000007D$indirect
	.type	RTTI_$JNI_$$_def0000007D$indirect,#object
RTTI_$JNI_$$_def0000007D$indirect:
	.long	RTTI_$JNI_$$_def0000007D
.Le422:
	.size	RTTI_$JNI_$$_def0000007D$indirect, .Le422 - RTTI_$JNI_$$_def0000007D$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def0000007E
	.balign 4
.globl	RTTI_$JNI_$$_def0000007E$indirect
	.type	RTTI_$JNI_$$_def0000007E$indirect,#object
RTTI_$JNI_$$_def0000007E$indirect:
	.long	RTTI_$JNI_$$_def0000007E
.Le423:
	.size	RTTI_$JNI_$$_def0000007E$indirect, .Le423 - RTTI_$JNI_$$_def0000007E$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def0000007F
	.balign 4
.globl	RTTI_$JNI_$$_def0000007F$indirect
	.type	RTTI_$JNI_$$_def0000007F$indirect,#object
RTTI_$JNI_$$_def0000007F$indirect:
	.long	RTTI_$JNI_$$_def0000007F
.Le424:
	.size	RTTI_$JNI_$$_def0000007F$indirect, .Le424 - RTTI_$JNI_$$_def0000007F$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000080
	.balign 4
.globl	RTTI_$JNI_$$_def00000080$indirect
	.type	RTTI_$JNI_$$_def00000080$indirect,#object
RTTI_$JNI_$$_def00000080$indirect:
	.long	RTTI_$JNI_$$_def00000080
.Le425:
	.size	RTTI_$JNI_$$_def00000080$indirect, .Le425 - RTTI_$JNI_$$_def00000080$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000081
	.balign 4
.globl	RTTI_$JNI_$$_def00000081$indirect
	.type	RTTI_$JNI_$$_def00000081$indirect,#object
RTTI_$JNI_$$_def00000081$indirect:
	.long	RTTI_$JNI_$$_def00000081
.Le426:
	.size	RTTI_$JNI_$$_def00000081$indirect, .Le426 - RTTI_$JNI_$$_def00000081$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000082
	.balign 4
.globl	RTTI_$JNI_$$_def00000082$indirect
	.type	RTTI_$JNI_$$_def00000082$indirect,#object
RTTI_$JNI_$$_def00000082$indirect:
	.long	RTTI_$JNI_$$_def00000082
.Le427:
	.size	RTTI_$JNI_$$_def00000082$indirect, .Le427 - RTTI_$JNI_$$_def00000082$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000083
	.balign 4
.globl	RTTI_$JNI_$$_def00000083$indirect
	.type	RTTI_$JNI_$$_def00000083$indirect,#object
RTTI_$JNI_$$_def00000083$indirect:
	.long	RTTI_$JNI_$$_def00000083
.Le428:
	.size	RTTI_$JNI_$$_def00000083$indirect, .Le428 - RTTI_$JNI_$$_def00000083$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000084
	.balign 4
.globl	RTTI_$JNI_$$_def00000084$indirect
	.type	RTTI_$JNI_$$_def00000084$indirect,#object
RTTI_$JNI_$$_def00000084$indirect:
	.long	RTTI_$JNI_$$_def00000084
.Le429:
	.size	RTTI_$JNI_$$_def00000084$indirect, .Le429 - RTTI_$JNI_$$_def00000084$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000085
	.balign 4
.globl	RTTI_$JNI_$$_def00000085$indirect
	.type	RTTI_$JNI_$$_def00000085$indirect,#object
RTTI_$JNI_$$_def00000085$indirect:
	.long	RTTI_$JNI_$$_def00000085
.Le430:
	.size	RTTI_$JNI_$$_def00000085$indirect, .Le430 - RTTI_$JNI_$$_def00000085$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000086
	.balign 4
.globl	RTTI_$JNI_$$_def00000086$indirect
	.type	RTTI_$JNI_$$_def00000086$indirect,#object
RTTI_$JNI_$$_def00000086$indirect:
	.long	RTTI_$JNI_$$_def00000086
.Le431:
	.size	RTTI_$JNI_$$_def00000086$indirect, .Le431 - RTTI_$JNI_$$_def00000086$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000087
	.balign 4
.globl	RTTI_$JNI_$$_def00000087$indirect
	.type	RTTI_$JNI_$$_def00000087$indirect,#object
RTTI_$JNI_$$_def00000087$indirect:
	.long	RTTI_$JNI_$$_def00000087
.Le432:
	.size	RTTI_$JNI_$$_def00000087$indirect, .Le432 - RTTI_$JNI_$$_def00000087$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000088
	.balign 4
.globl	RTTI_$JNI_$$_def00000088$indirect
	.type	RTTI_$JNI_$$_def00000088$indirect,#object
RTTI_$JNI_$$_def00000088$indirect:
	.long	RTTI_$JNI_$$_def00000088
.Le433:
	.size	RTTI_$JNI_$$_def00000088$indirect, .Le433 - RTTI_$JNI_$$_def00000088$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000089
	.balign 4
.globl	RTTI_$JNI_$$_def00000089$indirect
	.type	RTTI_$JNI_$$_def00000089$indirect,#object
RTTI_$JNI_$$_def00000089$indirect:
	.long	RTTI_$JNI_$$_def00000089
.Le434:
	.size	RTTI_$JNI_$$_def00000089$indirect, .Le434 - RTTI_$JNI_$$_def00000089$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def0000008A
	.balign 4
.globl	RTTI_$JNI_$$_def0000008A$indirect
	.type	RTTI_$JNI_$$_def0000008A$indirect,#object
RTTI_$JNI_$$_def0000008A$indirect:
	.long	RTTI_$JNI_$$_def0000008A
.Le435:
	.size	RTTI_$JNI_$$_def0000008A$indirect, .Le435 - RTTI_$JNI_$$_def0000008A$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def0000008B
	.balign 4
.globl	RTTI_$JNI_$$_def0000008B$indirect
	.type	RTTI_$JNI_$$_def0000008B$indirect,#object
RTTI_$JNI_$$_def0000008B$indirect:
	.long	RTTI_$JNI_$$_def0000008B
.Le436:
	.size	RTTI_$JNI_$$_def0000008B$indirect, .Le436 - RTTI_$JNI_$$_def0000008B$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def0000008C
	.balign 4
.globl	RTTI_$JNI_$$_def0000008C$indirect
	.type	RTTI_$JNI_$$_def0000008C$indirect,#object
RTTI_$JNI_$$_def0000008C$indirect:
	.long	RTTI_$JNI_$$_def0000008C
.Le437:
	.size	RTTI_$JNI_$$_def0000008C$indirect, .Le437 - RTTI_$JNI_$$_def0000008C$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def0000008D
	.balign 4
.globl	RTTI_$JNI_$$_def0000008D$indirect
	.type	RTTI_$JNI_$$_def0000008D$indirect,#object
RTTI_$JNI_$$_def0000008D$indirect:
	.long	RTTI_$JNI_$$_def0000008D
.Le438:
	.size	RTTI_$JNI_$$_def0000008D$indirect, .Le438 - RTTI_$JNI_$$_def0000008D$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def0000008E
	.balign 4
.globl	RTTI_$JNI_$$_def0000008E$indirect
	.type	RTTI_$JNI_$$_def0000008E$indirect,#object
RTTI_$JNI_$$_def0000008E$indirect:
	.long	RTTI_$JNI_$$_def0000008E
.Le439:
	.size	RTTI_$JNI_$$_def0000008E$indirect, .Le439 - RTTI_$JNI_$$_def0000008E$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def0000008F
	.balign 4
.globl	RTTI_$JNI_$$_def0000008F$indirect
	.type	RTTI_$JNI_$$_def0000008F$indirect,#object
RTTI_$JNI_$$_def0000008F$indirect:
	.long	RTTI_$JNI_$$_def0000008F
.Le440:
	.size	RTTI_$JNI_$$_def0000008F$indirect, .Le440 - RTTI_$JNI_$$_def0000008F$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000090
	.balign 4
.globl	RTTI_$JNI_$$_def00000090$indirect
	.type	RTTI_$JNI_$$_def00000090$indirect,#object
RTTI_$JNI_$$_def00000090$indirect:
	.long	RTTI_$JNI_$$_def00000090
.Le441:
	.size	RTTI_$JNI_$$_def00000090$indirect, .Le441 - RTTI_$JNI_$$_def00000090$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000091
	.balign 4
.globl	RTTI_$JNI_$$_def00000091$indirect
	.type	RTTI_$JNI_$$_def00000091$indirect,#object
RTTI_$JNI_$$_def00000091$indirect:
	.long	RTTI_$JNI_$$_def00000091
.Le442:
	.size	RTTI_$JNI_$$_def00000091$indirect, .Le442 - RTTI_$JNI_$$_def00000091$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000092
	.balign 4
.globl	RTTI_$JNI_$$_def00000092$indirect
	.type	RTTI_$JNI_$$_def00000092$indirect,#object
RTTI_$JNI_$$_def00000092$indirect:
	.long	RTTI_$JNI_$$_def00000092
.Le443:
	.size	RTTI_$JNI_$$_def00000092$indirect, .Le443 - RTTI_$JNI_$$_def00000092$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000093
	.balign 4
.globl	RTTI_$JNI_$$_def00000093$indirect
	.type	RTTI_$JNI_$$_def00000093$indirect,#object
RTTI_$JNI_$$_def00000093$indirect:
	.long	RTTI_$JNI_$$_def00000093
.Le444:
	.size	RTTI_$JNI_$$_def00000093$indirect, .Le444 - RTTI_$JNI_$$_def00000093$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000094
	.balign 4
.globl	RTTI_$JNI_$$_def00000094$indirect
	.type	RTTI_$JNI_$$_def00000094$indirect,#object
RTTI_$JNI_$$_def00000094$indirect:
	.long	RTTI_$JNI_$$_def00000094
.Le445:
	.size	RTTI_$JNI_$$_def00000094$indirect, .Le445 - RTTI_$JNI_$$_def00000094$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000095
	.balign 4
.globl	RTTI_$JNI_$$_def00000095$indirect
	.type	RTTI_$JNI_$$_def00000095$indirect,#object
RTTI_$JNI_$$_def00000095$indirect:
	.long	RTTI_$JNI_$$_def00000095
.Le446:
	.size	RTTI_$JNI_$$_def00000095$indirect, .Le446 - RTTI_$JNI_$$_def00000095$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000096
	.balign 4
.globl	RTTI_$JNI_$$_def00000096$indirect
	.type	RTTI_$JNI_$$_def00000096$indirect,#object
RTTI_$JNI_$$_def00000096$indirect:
	.long	RTTI_$JNI_$$_def00000096
.Le447:
	.size	RTTI_$JNI_$$_def00000096$indirect, .Le447 - RTTI_$JNI_$$_def00000096$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000097
	.balign 4
.globl	RTTI_$JNI_$$_def00000097$indirect
	.type	RTTI_$JNI_$$_def00000097$indirect,#object
RTTI_$JNI_$$_def00000097$indirect:
	.long	RTTI_$JNI_$$_def00000097
.Le448:
	.size	RTTI_$JNI_$$_def00000097$indirect, .Le448 - RTTI_$JNI_$$_def00000097$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000098
	.balign 4
.globl	RTTI_$JNI_$$_def00000098$indirect
	.type	RTTI_$JNI_$$_def00000098$indirect,#object
RTTI_$JNI_$$_def00000098$indirect:
	.long	RTTI_$JNI_$$_def00000098
.Le449:
	.size	RTTI_$JNI_$$_def00000098$indirect, .Le449 - RTTI_$JNI_$$_def00000098$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000099
	.balign 4
.globl	RTTI_$JNI_$$_def00000099$indirect
	.type	RTTI_$JNI_$$_def00000099$indirect,#object
RTTI_$JNI_$$_def00000099$indirect:
	.long	RTTI_$JNI_$$_def00000099
.Le450:
	.size	RTTI_$JNI_$$_def00000099$indirect, .Le450 - RTTI_$JNI_$$_def00000099$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def0000009A
	.balign 4
.globl	RTTI_$JNI_$$_def0000009A$indirect
	.type	RTTI_$JNI_$$_def0000009A$indirect,#object
RTTI_$JNI_$$_def0000009A$indirect:
	.long	RTTI_$JNI_$$_def0000009A
.Le451:
	.size	RTTI_$JNI_$$_def0000009A$indirect, .Le451 - RTTI_$JNI_$$_def0000009A$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def0000009B
	.balign 4
.globl	RTTI_$JNI_$$_def0000009B$indirect
	.type	RTTI_$JNI_$$_def0000009B$indirect,#object
RTTI_$JNI_$$_def0000009B$indirect:
	.long	RTTI_$JNI_$$_def0000009B
.Le452:
	.size	RTTI_$JNI_$$_def0000009B$indirect, .Le452 - RTTI_$JNI_$$_def0000009B$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def0000009C
	.balign 4
.globl	RTTI_$JNI_$$_def0000009C$indirect
	.type	RTTI_$JNI_$$_def0000009C$indirect,#object
RTTI_$JNI_$$_def0000009C$indirect:
	.long	RTTI_$JNI_$$_def0000009C
.Le453:
	.size	RTTI_$JNI_$$_def0000009C$indirect, .Le453 - RTTI_$JNI_$$_def0000009C$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def0000009D
	.balign 4
.globl	RTTI_$JNI_$$_def0000009D$indirect
	.type	RTTI_$JNI_$$_def0000009D$indirect,#object
RTTI_$JNI_$$_def0000009D$indirect:
	.long	RTTI_$JNI_$$_def0000009D
.Le454:
	.size	RTTI_$JNI_$$_def0000009D$indirect, .Le454 - RTTI_$JNI_$$_def0000009D$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def0000009E
	.balign 4
.globl	RTTI_$JNI_$$_def0000009E$indirect
	.type	RTTI_$JNI_$$_def0000009E$indirect,#object
RTTI_$JNI_$$_def0000009E$indirect:
	.long	RTTI_$JNI_$$_def0000009E
.Le455:
	.size	RTTI_$JNI_$$_def0000009E$indirect, .Le455 - RTTI_$JNI_$$_def0000009E$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def0000009F
	.balign 4
.globl	RTTI_$JNI_$$_def0000009F$indirect
	.type	RTTI_$JNI_$$_def0000009F$indirect,#object
RTTI_$JNI_$$_def0000009F$indirect:
	.long	RTTI_$JNI_$$_def0000009F
.Le456:
	.size	RTTI_$JNI_$$_def0000009F$indirect, .Le456 - RTTI_$JNI_$$_def0000009F$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000A0
	.balign 4
.globl	RTTI_$JNI_$$_def000000A0$indirect
	.type	RTTI_$JNI_$$_def000000A0$indirect,#object
RTTI_$JNI_$$_def000000A0$indirect:
	.long	RTTI_$JNI_$$_def000000A0
.Le457:
	.size	RTTI_$JNI_$$_def000000A0$indirect, .Le457 - RTTI_$JNI_$$_def000000A0$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000A1
	.balign 4
.globl	RTTI_$JNI_$$_def000000A1$indirect
	.type	RTTI_$JNI_$$_def000000A1$indirect,#object
RTTI_$JNI_$$_def000000A1$indirect:
	.long	RTTI_$JNI_$$_def000000A1
.Le458:
	.size	RTTI_$JNI_$$_def000000A1$indirect, .Le458 - RTTI_$JNI_$$_def000000A1$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000A2
	.balign 4
.globl	RTTI_$JNI_$$_def000000A2$indirect
	.type	RTTI_$JNI_$$_def000000A2$indirect,#object
RTTI_$JNI_$$_def000000A2$indirect:
	.long	RTTI_$JNI_$$_def000000A2
.Le459:
	.size	RTTI_$JNI_$$_def000000A2$indirect, .Le459 - RTTI_$JNI_$$_def000000A2$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000A3
	.balign 4
.globl	RTTI_$JNI_$$_def000000A3$indirect
	.type	RTTI_$JNI_$$_def000000A3$indirect,#object
RTTI_$JNI_$$_def000000A3$indirect:
	.long	RTTI_$JNI_$$_def000000A3
.Le460:
	.size	RTTI_$JNI_$$_def000000A3$indirect, .Le460 - RTTI_$JNI_$$_def000000A3$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000A4
	.balign 4
.globl	RTTI_$JNI_$$_def000000A4$indirect
	.type	RTTI_$JNI_$$_def000000A4$indirect,#object
RTTI_$JNI_$$_def000000A4$indirect:
	.long	RTTI_$JNI_$$_def000000A4
.Le461:
	.size	RTTI_$JNI_$$_def000000A4$indirect, .Le461 - RTTI_$JNI_$$_def000000A4$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000A5
	.balign 4
.globl	RTTI_$JNI_$$_def000000A5$indirect
	.type	RTTI_$JNI_$$_def000000A5$indirect,#object
RTTI_$JNI_$$_def000000A5$indirect:
	.long	RTTI_$JNI_$$_def000000A5
.Le462:
	.size	RTTI_$JNI_$$_def000000A5$indirect, .Le462 - RTTI_$JNI_$$_def000000A5$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000A6
	.balign 4
.globl	RTTI_$JNI_$$_def000000A6$indirect
	.type	RTTI_$JNI_$$_def000000A6$indirect,#object
RTTI_$JNI_$$_def000000A6$indirect:
	.long	RTTI_$JNI_$$_def000000A6
.Le463:
	.size	RTTI_$JNI_$$_def000000A6$indirect, .Le463 - RTTI_$JNI_$$_def000000A6$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000A7
	.balign 4
.globl	RTTI_$JNI_$$_def000000A7$indirect
	.type	RTTI_$JNI_$$_def000000A7$indirect,#object
RTTI_$JNI_$$_def000000A7$indirect:
	.long	RTTI_$JNI_$$_def000000A7
.Le464:
	.size	RTTI_$JNI_$$_def000000A7$indirect, .Le464 - RTTI_$JNI_$$_def000000A7$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000A8
	.balign 4
.globl	RTTI_$JNI_$$_def000000A8$indirect
	.type	RTTI_$JNI_$$_def000000A8$indirect,#object
RTTI_$JNI_$$_def000000A8$indirect:
	.long	RTTI_$JNI_$$_def000000A8
.Le465:
	.size	RTTI_$JNI_$$_def000000A8$indirect, .Le465 - RTTI_$JNI_$$_def000000A8$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000A9
	.balign 4
.globl	RTTI_$JNI_$$_def000000A9$indirect
	.type	RTTI_$JNI_$$_def000000A9$indirect,#object
RTTI_$JNI_$$_def000000A9$indirect:
	.long	RTTI_$JNI_$$_def000000A9
.Le466:
	.size	RTTI_$JNI_$$_def000000A9$indirect, .Le466 - RTTI_$JNI_$$_def000000A9$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000AA
	.balign 4
.globl	RTTI_$JNI_$$_def000000AA$indirect
	.type	RTTI_$JNI_$$_def000000AA$indirect,#object
RTTI_$JNI_$$_def000000AA$indirect:
	.long	RTTI_$JNI_$$_def000000AA
.Le467:
	.size	RTTI_$JNI_$$_def000000AA$indirect, .Le467 - RTTI_$JNI_$$_def000000AA$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000AB
	.balign 4
.globl	RTTI_$JNI_$$_def000000AB$indirect
	.type	RTTI_$JNI_$$_def000000AB$indirect,#object
RTTI_$JNI_$$_def000000AB$indirect:
	.long	RTTI_$JNI_$$_def000000AB
.Le468:
	.size	RTTI_$JNI_$$_def000000AB$indirect, .Le468 - RTTI_$JNI_$$_def000000AB$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000AC
	.balign 4
.globl	RTTI_$JNI_$$_def000000AC$indirect
	.type	RTTI_$JNI_$$_def000000AC$indirect,#object
RTTI_$JNI_$$_def000000AC$indirect:
	.long	RTTI_$JNI_$$_def000000AC
.Le469:
	.size	RTTI_$JNI_$$_def000000AC$indirect, .Le469 - RTTI_$JNI_$$_def000000AC$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000AD
	.balign 4
.globl	RTTI_$JNI_$$_def000000AD$indirect
	.type	RTTI_$JNI_$$_def000000AD$indirect,#object
RTTI_$JNI_$$_def000000AD$indirect:
	.long	RTTI_$JNI_$$_def000000AD
.Le470:
	.size	RTTI_$JNI_$$_def000000AD$indirect, .Le470 - RTTI_$JNI_$$_def000000AD$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000AE
	.balign 4
.globl	RTTI_$JNI_$$_def000000AE$indirect
	.type	RTTI_$JNI_$$_def000000AE$indirect,#object
RTTI_$JNI_$$_def000000AE$indirect:
	.long	RTTI_$JNI_$$_def000000AE
.Le471:
	.size	RTTI_$JNI_$$_def000000AE$indirect, .Le471 - RTTI_$JNI_$$_def000000AE$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000AF
	.balign 4
.globl	RTTI_$JNI_$$_def000000AF$indirect
	.type	RTTI_$JNI_$$_def000000AF$indirect,#object
RTTI_$JNI_$$_def000000AF$indirect:
	.long	RTTI_$JNI_$$_def000000AF
.Le472:
	.size	RTTI_$JNI_$$_def000000AF$indirect, .Le472 - RTTI_$JNI_$$_def000000AF$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000B0
	.balign 4
.globl	RTTI_$JNI_$$_def000000B0$indirect
	.type	RTTI_$JNI_$$_def000000B0$indirect,#object
RTTI_$JNI_$$_def000000B0$indirect:
	.long	RTTI_$JNI_$$_def000000B0
.Le473:
	.size	RTTI_$JNI_$$_def000000B0$indirect, .Le473 - RTTI_$JNI_$$_def000000B0$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000B1
	.balign 4
.globl	RTTI_$JNI_$$_def000000B1$indirect
	.type	RTTI_$JNI_$$_def000000B1$indirect,#object
RTTI_$JNI_$$_def000000B1$indirect:
	.long	RTTI_$JNI_$$_def000000B1
.Le474:
	.size	RTTI_$JNI_$$_def000000B1$indirect, .Le474 - RTTI_$JNI_$$_def000000B1$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000B2
	.balign 4
.globl	RTTI_$JNI_$$_def000000B2$indirect
	.type	RTTI_$JNI_$$_def000000B2$indirect,#object
RTTI_$JNI_$$_def000000B2$indirect:
	.long	RTTI_$JNI_$$_def000000B2
.Le475:
	.size	RTTI_$JNI_$$_def000000B2$indirect, .Le475 - RTTI_$JNI_$$_def000000B2$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000B3
	.balign 4
.globl	RTTI_$JNI_$$_def000000B3$indirect
	.type	RTTI_$JNI_$$_def000000B3$indirect,#object
RTTI_$JNI_$$_def000000B3$indirect:
	.long	RTTI_$JNI_$$_def000000B3
.Le476:
	.size	RTTI_$JNI_$$_def000000B3$indirect, .Le476 - RTTI_$JNI_$$_def000000B3$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000B4
	.balign 4
.globl	RTTI_$JNI_$$_def000000B4$indirect
	.type	RTTI_$JNI_$$_def000000B4$indirect,#object
RTTI_$JNI_$$_def000000B4$indirect:
	.long	RTTI_$JNI_$$_def000000B4
.Le477:
	.size	RTTI_$JNI_$$_def000000B4$indirect, .Le477 - RTTI_$JNI_$$_def000000B4$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000B5
	.balign 4
.globl	RTTI_$JNI_$$_def000000B5$indirect
	.type	RTTI_$JNI_$$_def000000B5$indirect,#object
RTTI_$JNI_$$_def000000B5$indirect:
	.long	RTTI_$JNI_$$_def000000B5
.Le478:
	.size	RTTI_$JNI_$$_def000000B5$indirect, .Le478 - RTTI_$JNI_$$_def000000B5$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000B6
	.balign 4
.globl	RTTI_$JNI_$$_def000000B6$indirect
	.type	RTTI_$JNI_$$_def000000B6$indirect,#object
RTTI_$JNI_$$_def000000B6$indirect:
	.long	RTTI_$JNI_$$_def000000B6
.Le479:
	.size	RTTI_$JNI_$$_def000000B6$indirect, .Le479 - RTTI_$JNI_$$_def000000B6$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000B7
	.balign 4
.globl	RTTI_$JNI_$$_def000000B7$indirect
	.type	RTTI_$JNI_$$_def000000B7$indirect,#object
RTTI_$JNI_$$_def000000B7$indirect:
	.long	RTTI_$JNI_$$_def000000B7
.Le480:
	.size	RTTI_$JNI_$$_def000000B7$indirect, .Le480 - RTTI_$JNI_$$_def000000B7$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000B8
	.balign 4
.globl	RTTI_$JNI_$$_def000000B8$indirect
	.type	RTTI_$JNI_$$_def000000B8$indirect,#object
RTTI_$JNI_$$_def000000B8$indirect:
	.long	RTTI_$JNI_$$_def000000B8
.Le481:
	.size	RTTI_$JNI_$$_def000000B8$indirect, .Le481 - RTTI_$JNI_$$_def000000B8$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000B9
	.balign 4
.globl	RTTI_$JNI_$$_def000000B9$indirect
	.type	RTTI_$JNI_$$_def000000B9$indirect,#object
RTTI_$JNI_$$_def000000B9$indirect:
	.long	RTTI_$JNI_$$_def000000B9
.Le482:
	.size	RTTI_$JNI_$$_def000000B9$indirect, .Le482 - RTTI_$JNI_$$_def000000B9$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000BA
	.balign 4
.globl	RTTI_$JNI_$$_def000000BA$indirect
	.type	RTTI_$JNI_$$_def000000BA$indirect,#object
RTTI_$JNI_$$_def000000BA$indirect:
	.long	RTTI_$JNI_$$_def000000BA
.Le483:
	.size	RTTI_$JNI_$$_def000000BA$indirect, .Le483 - RTTI_$JNI_$$_def000000BA$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000BB
	.balign 4
.globl	RTTI_$JNI_$$_def000000BB$indirect
	.type	RTTI_$JNI_$$_def000000BB$indirect,#object
RTTI_$JNI_$$_def000000BB$indirect:
	.long	RTTI_$JNI_$$_def000000BB
.Le484:
	.size	RTTI_$JNI_$$_def000000BB$indirect, .Le484 - RTTI_$JNI_$$_def000000BB$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000BC
	.balign 4
.globl	RTTI_$JNI_$$_def000000BC$indirect
	.type	RTTI_$JNI_$$_def000000BC$indirect,#object
RTTI_$JNI_$$_def000000BC$indirect:
	.long	RTTI_$JNI_$$_def000000BC
.Le485:
	.size	RTTI_$JNI_$$_def000000BC$indirect, .Le485 - RTTI_$JNI_$$_def000000BC$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000BD
	.balign 4
.globl	RTTI_$JNI_$$_def000000BD$indirect
	.type	RTTI_$JNI_$$_def000000BD$indirect,#object
RTTI_$JNI_$$_def000000BD$indirect:
	.long	RTTI_$JNI_$$_def000000BD
.Le486:
	.size	RTTI_$JNI_$$_def000000BD$indirect, .Le486 - RTTI_$JNI_$$_def000000BD$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000BE
	.balign 4
.globl	RTTI_$JNI_$$_def000000BE$indirect
	.type	RTTI_$JNI_$$_def000000BE$indirect,#object
RTTI_$JNI_$$_def000000BE$indirect:
	.long	RTTI_$JNI_$$_def000000BE
.Le487:
	.size	RTTI_$JNI_$$_def000000BE$indirect, .Le487 - RTTI_$JNI_$$_def000000BE$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000BF
	.balign 4
.globl	RTTI_$JNI_$$_def000000BF$indirect
	.type	RTTI_$JNI_$$_def000000BF$indirect,#object
RTTI_$JNI_$$_def000000BF$indirect:
	.long	RTTI_$JNI_$$_def000000BF
.Le488:
	.size	RTTI_$JNI_$$_def000000BF$indirect, .Le488 - RTTI_$JNI_$$_def000000BF$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000C0
	.balign 4
.globl	RTTI_$JNI_$$_def000000C0$indirect
	.type	RTTI_$JNI_$$_def000000C0$indirect,#object
RTTI_$JNI_$$_def000000C0$indirect:
	.long	RTTI_$JNI_$$_def000000C0
.Le489:
	.size	RTTI_$JNI_$$_def000000C0$indirect, .Le489 - RTTI_$JNI_$$_def000000C0$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000C1
	.balign 4
.globl	RTTI_$JNI_$$_def000000C1$indirect
	.type	RTTI_$JNI_$$_def000000C1$indirect,#object
RTTI_$JNI_$$_def000000C1$indirect:
	.long	RTTI_$JNI_$$_def000000C1
.Le490:
	.size	RTTI_$JNI_$$_def000000C1$indirect, .Le490 - RTTI_$JNI_$$_def000000C1$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000C2
	.balign 4
.globl	RTTI_$JNI_$$_def000000C2$indirect
	.type	RTTI_$JNI_$$_def000000C2$indirect,#object
RTTI_$JNI_$$_def000000C2$indirect:
	.long	RTTI_$JNI_$$_def000000C2
.Le491:
	.size	RTTI_$JNI_$$_def000000C2$indirect, .Le491 - RTTI_$JNI_$$_def000000C2$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000C3
	.balign 4
.globl	RTTI_$JNI_$$_def000000C3$indirect
	.type	RTTI_$JNI_$$_def000000C3$indirect,#object
RTTI_$JNI_$$_def000000C3$indirect:
	.long	RTTI_$JNI_$$_def000000C3
.Le492:
	.size	RTTI_$JNI_$$_def000000C3$indirect, .Le492 - RTTI_$JNI_$$_def000000C3$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000C4
	.balign 4
.globl	RTTI_$JNI_$$_def000000C4$indirect
	.type	RTTI_$JNI_$$_def000000C4$indirect,#object
RTTI_$JNI_$$_def000000C4$indirect:
	.long	RTTI_$JNI_$$_def000000C4
.Le493:
	.size	RTTI_$JNI_$$_def000000C4$indirect, .Le493 - RTTI_$JNI_$$_def000000C4$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000C5
	.balign 4
.globl	RTTI_$JNI_$$_def000000C5$indirect
	.type	RTTI_$JNI_$$_def000000C5$indirect,#object
RTTI_$JNI_$$_def000000C5$indirect:
	.long	RTTI_$JNI_$$_def000000C5
.Le494:
	.size	RTTI_$JNI_$$_def000000C5$indirect, .Le494 - RTTI_$JNI_$$_def000000C5$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000C6
	.balign 4
.globl	RTTI_$JNI_$$_def000000C6$indirect
	.type	RTTI_$JNI_$$_def000000C6$indirect,#object
RTTI_$JNI_$$_def000000C6$indirect:
	.long	RTTI_$JNI_$$_def000000C6
.Le495:
	.size	RTTI_$JNI_$$_def000000C6$indirect, .Le495 - RTTI_$JNI_$$_def000000C6$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000C7
	.balign 4
.globl	RTTI_$JNI_$$_def000000C7$indirect
	.type	RTTI_$JNI_$$_def000000C7$indirect,#object
RTTI_$JNI_$$_def000000C7$indirect:
	.long	RTTI_$JNI_$$_def000000C7
.Le496:
	.size	RTTI_$JNI_$$_def000000C7$indirect, .Le496 - RTTI_$JNI_$$_def000000C7$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000C8
	.balign 4
.globl	RTTI_$JNI_$$_def000000C8$indirect
	.type	RTTI_$JNI_$$_def000000C8$indirect,#object
RTTI_$JNI_$$_def000000C8$indirect:
	.long	RTTI_$JNI_$$_def000000C8
.Le497:
	.size	RTTI_$JNI_$$_def000000C8$indirect, .Le497 - RTTI_$JNI_$$_def000000C8$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000C9
	.balign 4
.globl	RTTI_$JNI_$$_def000000C9$indirect
	.type	RTTI_$JNI_$$_def000000C9$indirect,#object
RTTI_$JNI_$$_def000000C9$indirect:
	.long	RTTI_$JNI_$$_def000000C9
.Le498:
	.size	RTTI_$JNI_$$_def000000C9$indirect, .Le498 - RTTI_$JNI_$$_def000000C9$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000CA
	.balign 4
.globl	RTTI_$JNI_$$_def000000CA$indirect
	.type	RTTI_$JNI_$$_def000000CA$indirect,#object
RTTI_$JNI_$$_def000000CA$indirect:
	.long	RTTI_$JNI_$$_def000000CA
.Le499:
	.size	RTTI_$JNI_$$_def000000CA$indirect, .Le499 - RTTI_$JNI_$$_def000000CA$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000CB
	.balign 4
.globl	RTTI_$JNI_$$_def000000CB$indirect
	.type	RTTI_$JNI_$$_def000000CB$indirect,#object
RTTI_$JNI_$$_def000000CB$indirect:
	.long	RTTI_$JNI_$$_def000000CB
.Le500:
	.size	RTTI_$JNI_$$_def000000CB$indirect, .Le500 - RTTI_$JNI_$$_def000000CB$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000CC
	.balign 4
.globl	RTTI_$JNI_$$_def000000CC$indirect
	.type	RTTI_$JNI_$$_def000000CC$indirect,#object
RTTI_$JNI_$$_def000000CC$indirect:
	.long	RTTI_$JNI_$$_def000000CC
.Le501:
	.size	RTTI_$JNI_$$_def000000CC$indirect, .Le501 - RTTI_$JNI_$$_def000000CC$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000CD
	.balign 4
.globl	RTTI_$JNI_$$_def000000CD$indirect
	.type	RTTI_$JNI_$$_def000000CD$indirect,#object
RTTI_$JNI_$$_def000000CD$indirect:
	.long	RTTI_$JNI_$$_def000000CD
.Le502:
	.size	RTTI_$JNI_$$_def000000CD$indirect, .Le502 - RTTI_$JNI_$$_def000000CD$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000CE
	.balign 4
.globl	RTTI_$JNI_$$_def000000CE$indirect
	.type	RTTI_$JNI_$$_def000000CE$indirect,#object
RTTI_$JNI_$$_def000000CE$indirect:
	.long	RTTI_$JNI_$$_def000000CE
.Le503:
	.size	RTTI_$JNI_$$_def000000CE$indirect, .Le503 - RTTI_$JNI_$$_def000000CE$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000CF
	.balign 4
.globl	RTTI_$JNI_$$_def000000CF$indirect
	.type	RTTI_$JNI_$$_def000000CF$indirect,#object
RTTI_$JNI_$$_def000000CF$indirect:
	.long	RTTI_$JNI_$$_def000000CF
.Le504:
	.size	RTTI_$JNI_$$_def000000CF$indirect, .Le504 - RTTI_$JNI_$$_def000000CF$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000D0
	.balign 4
.globl	RTTI_$JNI_$$_def000000D0$indirect
	.type	RTTI_$JNI_$$_def000000D0$indirect,#object
RTTI_$JNI_$$_def000000D0$indirect:
	.long	RTTI_$JNI_$$_def000000D0
.Le505:
	.size	RTTI_$JNI_$$_def000000D0$indirect, .Le505 - RTTI_$JNI_$$_def000000D0$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000D1
	.balign 4
.globl	RTTI_$JNI_$$_def000000D1$indirect
	.type	RTTI_$JNI_$$_def000000D1$indirect,#object
RTTI_$JNI_$$_def000000D1$indirect:
	.long	RTTI_$JNI_$$_def000000D1
.Le506:
	.size	RTTI_$JNI_$$_def000000D1$indirect, .Le506 - RTTI_$JNI_$$_def000000D1$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000D2
	.balign 4
.globl	RTTI_$JNI_$$_def000000D2$indirect
	.type	RTTI_$JNI_$$_def000000D2$indirect,#object
RTTI_$JNI_$$_def000000D2$indirect:
	.long	RTTI_$JNI_$$_def000000D2
.Le507:
	.size	RTTI_$JNI_$$_def000000D2$indirect, .Le507 - RTTI_$JNI_$$_def000000D2$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000D3
	.balign 4
.globl	RTTI_$JNI_$$_def000000D3$indirect
	.type	RTTI_$JNI_$$_def000000D3$indirect,#object
RTTI_$JNI_$$_def000000D3$indirect:
	.long	RTTI_$JNI_$$_def000000D3
.Le508:
	.size	RTTI_$JNI_$$_def000000D3$indirect, .Le508 - RTTI_$JNI_$$_def000000D3$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000D4
	.balign 4
.globl	RTTI_$JNI_$$_def000000D4$indirect
	.type	RTTI_$JNI_$$_def000000D4$indirect,#object
RTTI_$JNI_$$_def000000D4$indirect:
	.long	RTTI_$JNI_$$_def000000D4
.Le509:
	.size	RTTI_$JNI_$$_def000000D4$indirect, .Le509 - RTTI_$JNI_$$_def000000D4$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000D5
	.balign 4
.globl	RTTI_$JNI_$$_def000000D5$indirect
	.type	RTTI_$JNI_$$_def000000D5$indirect,#object
RTTI_$JNI_$$_def000000D5$indirect:
	.long	RTTI_$JNI_$$_def000000D5
.Le510:
	.size	RTTI_$JNI_$$_def000000D5$indirect, .Le510 - RTTI_$JNI_$$_def000000D5$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000D6
	.balign 4
.globl	RTTI_$JNI_$$_def000000D6$indirect
	.type	RTTI_$JNI_$$_def000000D6$indirect,#object
RTTI_$JNI_$$_def000000D6$indirect:
	.long	RTTI_$JNI_$$_def000000D6
.Le511:
	.size	RTTI_$JNI_$$_def000000D6$indirect, .Le511 - RTTI_$JNI_$$_def000000D6$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000D7
	.balign 4
.globl	RTTI_$JNI_$$_def000000D7$indirect
	.type	RTTI_$JNI_$$_def000000D7$indirect,#object
RTTI_$JNI_$$_def000000D7$indirect:
	.long	RTTI_$JNI_$$_def000000D7
.Le512:
	.size	RTTI_$JNI_$$_def000000D7$indirect, .Le512 - RTTI_$JNI_$$_def000000D7$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000D8
	.balign 4
.globl	RTTI_$JNI_$$_def000000D8$indirect
	.type	RTTI_$JNI_$$_def000000D8$indirect,#object
RTTI_$JNI_$$_def000000D8$indirect:
	.long	RTTI_$JNI_$$_def000000D8
.Le513:
	.size	RTTI_$JNI_$$_def000000D8$indirect, .Le513 - RTTI_$JNI_$$_def000000D8$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000D9
	.balign 4
.globl	RTTI_$JNI_$$_def000000D9$indirect
	.type	RTTI_$JNI_$$_def000000D9$indirect,#object
RTTI_$JNI_$$_def000000D9$indirect:
	.long	RTTI_$JNI_$$_def000000D9
.Le514:
	.size	RTTI_$JNI_$$_def000000D9$indirect, .Le514 - RTTI_$JNI_$$_def000000D9$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000DA
	.balign 4
.globl	RTTI_$JNI_$$_def000000DA$indirect
	.type	RTTI_$JNI_$$_def000000DA$indirect,#object
RTTI_$JNI_$$_def000000DA$indirect:
	.long	RTTI_$JNI_$$_def000000DA
.Le515:
	.size	RTTI_$JNI_$$_def000000DA$indirect, .Le515 - RTTI_$JNI_$$_def000000DA$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000DB
	.balign 4
.globl	RTTI_$JNI_$$_def000000DB$indirect
	.type	RTTI_$JNI_$$_def000000DB$indirect,#object
RTTI_$JNI_$$_def000000DB$indirect:
	.long	RTTI_$JNI_$$_def000000DB
.Le516:
	.size	RTTI_$JNI_$$_def000000DB$indirect, .Le516 - RTTI_$JNI_$$_def000000DB$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000DC
	.balign 4
.globl	RTTI_$JNI_$$_def000000DC$indirect
	.type	RTTI_$JNI_$$_def000000DC$indirect,#object
RTTI_$JNI_$$_def000000DC$indirect:
	.long	RTTI_$JNI_$$_def000000DC
.Le517:
	.size	RTTI_$JNI_$$_def000000DC$indirect, .Le517 - RTTI_$JNI_$$_def000000DC$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000DD
	.balign 4
.globl	RTTI_$JNI_$$_def000000DD$indirect
	.type	RTTI_$JNI_$$_def000000DD$indirect,#object
RTTI_$JNI_$$_def000000DD$indirect:
	.long	RTTI_$JNI_$$_def000000DD
.Le518:
	.size	RTTI_$JNI_$$_def000000DD$indirect, .Le518 - RTTI_$JNI_$$_def000000DD$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000DE
	.balign 4
.globl	RTTI_$JNI_$$_def000000DE$indirect
	.type	RTTI_$JNI_$$_def000000DE$indirect,#object
RTTI_$JNI_$$_def000000DE$indirect:
	.long	RTTI_$JNI_$$_def000000DE
.Le519:
	.size	RTTI_$JNI_$$_def000000DE$indirect, .Le519 - RTTI_$JNI_$$_def000000DE$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000DF
	.balign 4
.globl	RTTI_$JNI_$$_def000000DF$indirect
	.type	RTTI_$JNI_$$_def000000DF$indirect,#object
RTTI_$JNI_$$_def000000DF$indirect:
	.long	RTTI_$JNI_$$_def000000DF
.Le520:
	.size	RTTI_$JNI_$$_def000000DF$indirect, .Le520 - RTTI_$JNI_$$_def000000DF$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000E0
	.balign 4
.globl	RTTI_$JNI_$$_def000000E0$indirect
	.type	RTTI_$JNI_$$_def000000E0$indirect,#object
RTTI_$JNI_$$_def000000E0$indirect:
	.long	RTTI_$JNI_$$_def000000E0
.Le521:
	.size	RTTI_$JNI_$$_def000000E0$indirect, .Le521 - RTTI_$JNI_$$_def000000E0$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000E1
	.balign 4
.globl	RTTI_$JNI_$$_def000000E1$indirect
	.type	RTTI_$JNI_$$_def000000E1$indirect,#object
RTTI_$JNI_$$_def000000E1$indirect:
	.long	RTTI_$JNI_$$_def000000E1
.Le522:
	.size	RTTI_$JNI_$$_def000000E1$indirect, .Le522 - RTTI_$JNI_$$_def000000E1$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000E2
	.balign 4
.globl	RTTI_$JNI_$$_def000000E2$indirect
	.type	RTTI_$JNI_$$_def000000E2$indirect,#object
RTTI_$JNI_$$_def000000E2$indirect:
	.long	RTTI_$JNI_$$_def000000E2
.Le523:
	.size	RTTI_$JNI_$$_def000000E2$indirect, .Le523 - RTTI_$JNI_$$_def000000E2$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000E3
	.balign 4
.globl	RTTI_$JNI_$$_def000000E3$indirect
	.type	RTTI_$JNI_$$_def000000E3$indirect,#object
RTTI_$JNI_$$_def000000E3$indirect:
	.long	RTTI_$JNI_$$_def000000E3
.Le524:
	.size	RTTI_$JNI_$$_def000000E3$indirect, .Le524 - RTTI_$JNI_$$_def000000E3$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000E4
	.balign 4
.globl	RTTI_$JNI_$$_def000000E4$indirect
	.type	RTTI_$JNI_$$_def000000E4$indirect,#object
RTTI_$JNI_$$_def000000E4$indirect:
	.long	RTTI_$JNI_$$_def000000E4
.Le525:
	.size	RTTI_$JNI_$$_def000000E4$indirect, .Le525 - RTTI_$JNI_$$_def000000E4$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000E5
	.balign 4
.globl	RTTI_$JNI_$$_def000000E5$indirect
	.type	RTTI_$JNI_$$_def000000E5$indirect,#object
RTTI_$JNI_$$_def000000E5$indirect:
	.long	RTTI_$JNI_$$_def000000E5
.Le526:
	.size	RTTI_$JNI_$$_def000000E5$indirect, .Le526 - RTTI_$JNI_$$_def000000E5$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000E6
	.balign 4
.globl	RTTI_$JNI_$$_def000000E6$indirect
	.type	RTTI_$JNI_$$_def000000E6$indirect,#object
RTTI_$JNI_$$_def000000E6$indirect:
	.long	RTTI_$JNI_$$_def000000E6
.Le527:
	.size	RTTI_$JNI_$$_def000000E6$indirect, .Le527 - RTTI_$JNI_$$_def000000E6$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000E7
	.balign 4
.globl	RTTI_$JNI_$$_def000000E7$indirect
	.type	RTTI_$JNI_$$_def000000E7$indirect,#object
RTTI_$JNI_$$_def000000E7$indirect:
	.long	RTTI_$JNI_$$_def000000E7
.Le528:
	.size	RTTI_$JNI_$$_def000000E7$indirect, .Le528 - RTTI_$JNI_$$_def000000E7$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000E8
	.balign 4
.globl	RTTI_$JNI_$$_def000000E8$indirect
	.type	RTTI_$JNI_$$_def000000E8$indirect,#object
RTTI_$JNI_$$_def000000E8$indirect:
	.long	RTTI_$JNI_$$_def000000E8
.Le529:
	.size	RTTI_$JNI_$$_def000000E8$indirect, .Le529 - RTTI_$JNI_$$_def000000E8$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000E9
	.balign 4
.globl	RTTI_$JNI_$$_def000000E9$indirect
	.type	RTTI_$JNI_$$_def000000E9$indirect,#object
RTTI_$JNI_$$_def000000E9$indirect:
	.long	RTTI_$JNI_$$_def000000E9
.Le530:
	.size	RTTI_$JNI_$$_def000000E9$indirect, .Le530 - RTTI_$JNI_$$_def000000E9$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000EA
	.balign 4
.globl	RTTI_$JNI_$$_def000000EA$indirect
	.type	RTTI_$JNI_$$_def000000EA$indirect,#object
RTTI_$JNI_$$_def000000EA$indirect:
	.long	RTTI_$JNI_$$_def000000EA
.Le531:
	.size	RTTI_$JNI_$$_def000000EA$indirect, .Le531 - RTTI_$JNI_$$_def000000EA$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000EB
	.balign 4
.globl	RTTI_$JNI_$$_def000000EB$indirect
	.type	RTTI_$JNI_$$_def000000EB$indirect,#object
RTTI_$JNI_$$_def000000EB$indirect:
	.long	RTTI_$JNI_$$_def000000EB
.Le532:
	.size	RTTI_$JNI_$$_def000000EB$indirect, .Le532 - RTTI_$JNI_$$_def000000EB$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000EC
	.balign 4
.globl	RTTI_$JNI_$$_def000000EC$indirect
	.type	RTTI_$JNI_$$_def000000EC$indirect,#object
RTTI_$JNI_$$_def000000EC$indirect:
	.long	RTTI_$JNI_$$_def000000EC
.Le533:
	.size	RTTI_$JNI_$$_def000000EC$indirect, .Le533 - RTTI_$JNI_$$_def000000EC$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000ED
	.balign 4
.globl	RTTI_$JNI_$$_def000000ED$indirect
	.type	RTTI_$JNI_$$_def000000ED$indirect,#object
RTTI_$JNI_$$_def000000ED$indirect:
	.long	RTTI_$JNI_$$_def000000ED
.Le534:
	.size	RTTI_$JNI_$$_def000000ED$indirect, .Le534 - RTTI_$JNI_$$_def000000ED$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000EE
	.balign 4
.globl	RTTI_$JNI_$$_def000000EE$indirect
	.type	RTTI_$JNI_$$_def000000EE$indirect,#object
RTTI_$JNI_$$_def000000EE$indirect:
	.long	RTTI_$JNI_$$_def000000EE
.Le535:
	.size	RTTI_$JNI_$$_def000000EE$indirect, .Le535 - RTTI_$JNI_$$_def000000EE$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000EF
	.balign 4
.globl	RTTI_$JNI_$$_def000000EF$indirect
	.type	RTTI_$JNI_$$_def000000EF$indirect,#object
RTTI_$JNI_$$_def000000EF$indirect:
	.long	RTTI_$JNI_$$_def000000EF
.Le536:
	.size	RTTI_$JNI_$$_def000000EF$indirect, .Le536 - RTTI_$JNI_$$_def000000EF$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000F0
	.balign 4
.globl	RTTI_$JNI_$$_def000000F0$indirect
	.type	RTTI_$JNI_$$_def000000F0$indirect,#object
RTTI_$JNI_$$_def000000F0$indirect:
	.long	RTTI_$JNI_$$_def000000F0
.Le537:
	.size	RTTI_$JNI_$$_def000000F0$indirect, .Le537 - RTTI_$JNI_$$_def000000F0$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000F1
	.balign 4
.globl	RTTI_$JNI_$$_def000000F1$indirect
	.type	RTTI_$JNI_$$_def000000F1$indirect,#object
RTTI_$JNI_$$_def000000F1$indirect:
	.long	RTTI_$JNI_$$_def000000F1
.Le538:
	.size	RTTI_$JNI_$$_def000000F1$indirect, .Le538 - RTTI_$JNI_$$_def000000F1$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000F2
	.balign 4
.globl	RTTI_$JNI_$$_def000000F2$indirect
	.type	RTTI_$JNI_$$_def000000F2$indirect,#object
RTTI_$JNI_$$_def000000F2$indirect:
	.long	RTTI_$JNI_$$_def000000F2
.Le539:
	.size	RTTI_$JNI_$$_def000000F2$indirect, .Le539 - RTTI_$JNI_$$_def000000F2$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000F3
	.balign 4
.globl	RTTI_$JNI_$$_def000000F3$indirect
	.type	RTTI_$JNI_$$_def000000F3$indirect,#object
RTTI_$JNI_$$_def000000F3$indirect:
	.long	RTTI_$JNI_$$_def000000F3
.Le540:
	.size	RTTI_$JNI_$$_def000000F3$indirect, .Le540 - RTTI_$JNI_$$_def000000F3$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000F4
	.balign 4
.globl	RTTI_$JNI_$$_def000000F4$indirect
	.type	RTTI_$JNI_$$_def000000F4$indirect,#object
RTTI_$JNI_$$_def000000F4$indirect:
	.long	RTTI_$JNI_$$_def000000F4
.Le541:
	.size	RTTI_$JNI_$$_def000000F4$indirect, .Le541 - RTTI_$JNI_$$_def000000F4$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000F5
	.balign 4
.globl	RTTI_$JNI_$$_def000000F5$indirect
	.type	RTTI_$JNI_$$_def000000F5$indirect,#object
RTTI_$JNI_$$_def000000F5$indirect:
	.long	RTTI_$JNI_$$_def000000F5
.Le542:
	.size	RTTI_$JNI_$$_def000000F5$indirect, .Le542 - RTTI_$JNI_$$_def000000F5$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000F6
	.balign 4
.globl	RTTI_$JNI_$$_def000000F6$indirect
	.type	RTTI_$JNI_$$_def000000F6$indirect,#object
RTTI_$JNI_$$_def000000F6$indirect:
	.long	RTTI_$JNI_$$_def000000F6
.Le543:
	.size	RTTI_$JNI_$$_def000000F6$indirect, .Le543 - RTTI_$JNI_$$_def000000F6$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000F7
	.balign 4
.globl	RTTI_$JNI_$$_def000000F7$indirect
	.type	RTTI_$JNI_$$_def000000F7$indirect,#object
RTTI_$JNI_$$_def000000F7$indirect:
	.long	RTTI_$JNI_$$_def000000F7
.Le544:
	.size	RTTI_$JNI_$$_def000000F7$indirect, .Le544 - RTTI_$JNI_$$_def000000F7$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000F8
	.balign 4
.globl	RTTI_$JNI_$$_def000000F8$indirect
	.type	RTTI_$JNI_$$_def000000F8$indirect,#object
RTTI_$JNI_$$_def000000F8$indirect:
	.long	RTTI_$JNI_$$_def000000F8
.Le545:
	.size	RTTI_$JNI_$$_def000000F8$indirect, .Le545 - RTTI_$JNI_$$_def000000F8$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000F9
	.balign 4
.globl	RTTI_$JNI_$$_def000000F9$indirect
	.type	RTTI_$JNI_$$_def000000F9$indirect,#object
RTTI_$JNI_$$_def000000F9$indirect:
	.long	RTTI_$JNI_$$_def000000F9
.Le546:
	.size	RTTI_$JNI_$$_def000000F9$indirect, .Le546 - RTTI_$JNI_$$_def000000F9$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000FA
	.balign 4
.globl	RTTI_$JNI_$$_def000000FA$indirect
	.type	RTTI_$JNI_$$_def000000FA$indirect,#object
RTTI_$JNI_$$_def000000FA$indirect:
	.long	RTTI_$JNI_$$_def000000FA
.Le547:
	.size	RTTI_$JNI_$$_def000000FA$indirect, .Le547 - RTTI_$JNI_$$_def000000FA$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000FB
	.balign 4
.globl	RTTI_$JNI_$$_def000000FB$indirect
	.type	RTTI_$JNI_$$_def000000FB$indirect,#object
RTTI_$JNI_$$_def000000FB$indirect:
	.long	RTTI_$JNI_$$_def000000FB
.Le548:
	.size	RTTI_$JNI_$$_def000000FB$indirect, .Le548 - RTTI_$JNI_$$_def000000FB$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000FC
	.balign 4
.globl	RTTI_$JNI_$$_def000000FC$indirect
	.type	RTTI_$JNI_$$_def000000FC$indirect,#object
RTTI_$JNI_$$_def000000FC$indirect:
	.long	RTTI_$JNI_$$_def000000FC
.Le549:
	.size	RTTI_$JNI_$$_def000000FC$indirect, .Le549 - RTTI_$JNI_$$_def000000FC$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000FD
	.balign 4
.globl	RTTI_$JNI_$$_def000000FD$indirect
	.type	RTTI_$JNI_$$_def000000FD$indirect,#object
RTTI_$JNI_$$_def000000FD$indirect:
	.long	RTTI_$JNI_$$_def000000FD
.Le550:
	.size	RTTI_$JNI_$$_def000000FD$indirect, .Le550 - RTTI_$JNI_$$_def000000FD$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000FE
	.balign 4
.globl	RTTI_$JNI_$$_def000000FE$indirect
	.type	RTTI_$JNI_$$_def000000FE$indirect,#object
RTTI_$JNI_$$_def000000FE$indirect:
	.long	RTTI_$JNI_$$_def000000FE
.Le551:
	.size	RTTI_$JNI_$$_def000000FE$indirect, .Le551 - RTTI_$JNI_$$_def000000FE$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def000000FF
	.balign 4
.globl	RTTI_$JNI_$$_def000000FF$indirect
	.type	RTTI_$JNI_$$_def000000FF$indirect,#object
RTTI_$JNI_$$_def000000FF$indirect:
	.long	RTTI_$JNI_$$_def000000FF
.Le552:
	.size	RTTI_$JNI_$$_def000000FF$indirect, .Le552 - RTTI_$JNI_$$_def000000FF$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000100
	.balign 4
.globl	RTTI_$JNI_$$_def00000100$indirect
	.type	RTTI_$JNI_$$_def00000100$indirect,#object
RTTI_$JNI_$$_def00000100$indirect:
	.long	RTTI_$JNI_$$_def00000100
.Le553:
	.size	RTTI_$JNI_$$_def00000100$indirect, .Le553 - RTTI_$JNI_$$_def00000100$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000101
	.balign 4
.globl	RTTI_$JNI_$$_def00000101$indirect
	.type	RTTI_$JNI_$$_def00000101$indirect,#object
RTTI_$JNI_$$_def00000101$indirect:
	.long	RTTI_$JNI_$$_def00000101
.Le554:
	.size	RTTI_$JNI_$$_def00000101$indirect, .Le554 - RTTI_$JNI_$$_def00000101$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000102
	.balign 4
.globl	RTTI_$JNI_$$_def00000102$indirect
	.type	RTTI_$JNI_$$_def00000102$indirect,#object
RTTI_$JNI_$$_def00000102$indirect:
	.long	RTTI_$JNI_$$_def00000102
.Le555:
	.size	RTTI_$JNI_$$_def00000102$indirect, .Le555 - RTTI_$JNI_$$_def00000102$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000103
	.balign 4
.globl	RTTI_$JNI_$$_def00000103$indirect
	.type	RTTI_$JNI_$$_def00000103$indirect,#object
RTTI_$JNI_$$_def00000103$indirect:
	.long	RTTI_$JNI_$$_def00000103
.Le556:
	.size	RTTI_$JNI_$$_def00000103$indirect, .Le556 - RTTI_$JNI_$$_def00000103$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000104
	.balign 4
.globl	RTTI_$JNI_$$_def00000104$indirect
	.type	RTTI_$JNI_$$_def00000104$indirect,#object
RTTI_$JNI_$$_def00000104$indirect:
	.long	RTTI_$JNI_$$_def00000104
.Le557:
	.size	RTTI_$JNI_$$_def00000104$indirect, .Le557 - RTTI_$JNI_$$_def00000104$indirect

.section .data.rel.ro.n_INIT_$JNI_$$_JNINATIVEMETHOD
	.balign 4
.globl	INIT_$JNI_$$_JNINATIVEMETHOD$indirect
	.type	INIT_$JNI_$$_JNINATIVEMETHOD$indirect,#object
INIT_$JNI_$$_JNINATIVEMETHOD$indirect:
	.long	INIT_$JNI_$$_JNINATIVEMETHOD
.Le558:
	.size	INIT_$JNI_$$_JNINATIVEMETHOD$indirect, .Le558 - INIT_$JNI_$$_JNINATIVEMETHOD$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_JNINATIVEMETHOD
	.balign 4
.globl	RTTI_$JNI_$$_JNINATIVEMETHOD$indirect
	.type	RTTI_$JNI_$$_JNINATIVEMETHOD$indirect,#object
RTTI_$JNI_$$_JNINATIVEMETHOD$indirect:
	.long	RTTI_$JNI_$$_JNINATIVEMETHOD
.Le559:
	.size	RTTI_$JNI_$$_JNINATIVEMETHOD$indirect, .Le559 - RTTI_$JNI_$$_JNINATIVEMETHOD$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_PJNINATIVEMETHOD
	.balign 4
.globl	RTTI_$JNI_$$_PJNINATIVEMETHOD$indirect
	.type	RTTI_$JNI_$$_PJNINATIVEMETHOD$indirect,#object
RTTI_$JNI_$$_PJNINATIVEMETHOD$indirect:
	.long	RTTI_$JNI_$$_PJNINATIVEMETHOD
.Le560:
	.size	RTTI_$JNI_$$_PJNINATIVEMETHOD$indirect, .Le560 - RTTI_$JNI_$$_PJNINATIVEMETHOD$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000105
	.balign 4
.globl	RTTI_$JNI_$$_def00000105$indirect
	.type	RTTI_$JNI_$$_def00000105$indirect,#object
RTTI_$JNI_$$_def00000105$indirect:
	.long	RTTI_$JNI_$$_def00000105
.Le561:
	.size	RTTI_$JNI_$$_def00000105$indirect, .Le561 - RTTI_$JNI_$$_def00000105$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000106
	.balign 4
.globl	RTTI_$JNI_$$_def00000106$indirect
	.type	RTTI_$JNI_$$_def00000106$indirect,#object
RTTI_$JNI_$$_def00000106$indirect:
	.long	RTTI_$JNI_$$_def00000106
.Le562:
	.size	RTTI_$JNI_$$_def00000106$indirect, .Le562 - RTTI_$JNI_$$_def00000106$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000107
	.balign 4
.globl	RTTI_$JNI_$$_def00000107$indirect
	.type	RTTI_$JNI_$$_def00000107$indirect,#object
RTTI_$JNI_$$_def00000107$indirect:
	.long	RTTI_$JNI_$$_def00000107
.Le563:
	.size	RTTI_$JNI_$$_def00000107$indirect, .Le563 - RTTI_$JNI_$$_def00000107$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000108
	.balign 4
.globl	RTTI_$JNI_$$_def00000108$indirect
	.type	RTTI_$JNI_$$_def00000108$indirect,#object
RTTI_$JNI_$$_def00000108$indirect:
	.long	RTTI_$JNI_$$_def00000108
.Le564:
	.size	RTTI_$JNI_$$_def00000108$indirect, .Le564 - RTTI_$JNI_$$_def00000108$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000109
	.balign 4
.globl	RTTI_$JNI_$$_def00000109$indirect
	.type	RTTI_$JNI_$$_def00000109$indirect,#object
RTTI_$JNI_$$_def00000109$indirect:
	.long	RTTI_$JNI_$$_def00000109
.Le565:
	.size	RTTI_$JNI_$$_def00000109$indirect, .Le565 - RTTI_$JNI_$$_def00000109$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def0000010A
	.balign 4
.globl	RTTI_$JNI_$$_def0000010A$indirect
	.type	RTTI_$JNI_$$_def0000010A$indirect,#object
RTTI_$JNI_$$_def0000010A$indirect:
	.long	RTTI_$JNI_$$_def0000010A
.Le566:
	.size	RTTI_$JNI_$$_def0000010A$indirect, .Le566 - RTTI_$JNI_$$_def0000010A$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def0000010B
	.balign 4
.globl	RTTI_$JNI_$$_def0000010B$indirect
	.type	RTTI_$JNI_$$_def0000010B$indirect,#object
RTTI_$JNI_$$_def0000010B$indirect:
	.long	RTTI_$JNI_$$_def0000010B
.Le567:
	.size	RTTI_$JNI_$$_def0000010B$indirect, .Le567 - RTTI_$JNI_$$_def0000010B$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def0000010C
	.balign 4
.globl	RTTI_$JNI_$$_def0000010C$indirect
	.type	RTTI_$JNI_$$_def0000010C$indirect,#object
RTTI_$JNI_$$_def0000010C$indirect:
	.long	RTTI_$JNI_$$_def0000010C
.Le568:
	.size	RTTI_$JNI_$$_def0000010C$indirect, .Le568 - RTTI_$JNI_$$_def0000010C$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def0000010D
	.balign 4
.globl	RTTI_$JNI_$$_def0000010D$indirect
	.type	RTTI_$JNI_$$_def0000010D$indirect,#object
RTTI_$JNI_$$_def0000010D$indirect:
	.long	RTTI_$JNI_$$_def0000010D
.Le569:
	.size	RTTI_$JNI_$$_def0000010D$indirect, .Le569 - RTTI_$JNI_$$_def0000010D$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def0000010E
	.balign 4
.globl	RTTI_$JNI_$$_def0000010E$indirect
	.type	RTTI_$JNI_$$_def0000010E$indirect,#object
RTTI_$JNI_$$_def0000010E$indirect:
	.long	RTTI_$JNI_$$_def0000010E
.Le570:
	.size	RTTI_$JNI_$$_def0000010E$indirect, .Le570 - RTTI_$JNI_$$_def0000010E$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def0000010F
	.balign 4
.globl	RTTI_$JNI_$$_def0000010F$indirect
	.type	RTTI_$JNI_$$_def0000010F$indirect,#object
RTTI_$JNI_$$_def0000010F$indirect:
	.long	RTTI_$JNI_$$_def0000010F
.Le571:
	.size	RTTI_$JNI_$$_def0000010F$indirect, .Le571 - RTTI_$JNI_$$_def0000010F$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000110
	.balign 4
.globl	RTTI_$JNI_$$_def00000110$indirect
	.type	RTTI_$JNI_$$_def00000110$indirect,#object
RTTI_$JNI_$$_def00000110$indirect:
	.long	RTTI_$JNI_$$_def00000110
.Le572:
	.size	RTTI_$JNI_$$_def00000110$indirect, .Le572 - RTTI_$JNI_$$_def00000110$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000111
	.balign 4
.globl	RTTI_$JNI_$$_def00000111$indirect
	.type	RTTI_$JNI_$$_def00000111$indirect,#object
RTTI_$JNI_$$_def00000111$indirect:
	.long	RTTI_$JNI_$$_def00000111
.Le573:
	.size	RTTI_$JNI_$$_def00000111$indirect, .Le573 - RTTI_$JNI_$$_def00000111$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000112
	.balign 4
.globl	RTTI_$JNI_$$_def00000112$indirect
	.type	RTTI_$JNI_$$_def00000112$indirect,#object
RTTI_$JNI_$$_def00000112$indirect:
	.long	RTTI_$JNI_$$_def00000112
.Le574:
	.size	RTTI_$JNI_$$_def00000112$indirect, .Le574 - RTTI_$JNI_$$_def00000112$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000113
	.balign 4
.globl	RTTI_$JNI_$$_def00000113$indirect
	.type	RTTI_$JNI_$$_def00000113$indirect,#object
RTTI_$JNI_$$_def00000113$indirect:
	.long	RTTI_$JNI_$$_def00000113
.Le575:
	.size	RTTI_$JNI_$$_def00000113$indirect, .Le575 - RTTI_$JNI_$$_def00000113$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000114
	.balign 4
.globl	RTTI_$JNI_$$_def00000114$indirect
	.type	RTTI_$JNI_$$_def00000114$indirect,#object
RTTI_$JNI_$$_def00000114$indirect:
	.long	RTTI_$JNI_$$_def00000114
.Le576:
	.size	RTTI_$JNI_$$_def00000114$indirect, .Le576 - RTTI_$JNI_$$_def00000114$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000115
	.balign 4
.globl	RTTI_$JNI_$$_def00000115$indirect
	.type	RTTI_$JNI_$$_def00000115$indirect,#object
RTTI_$JNI_$$_def00000115$indirect:
	.long	RTTI_$JNI_$$_def00000115
.Le577:
	.size	RTTI_$JNI_$$_def00000115$indirect, .Le577 - RTTI_$JNI_$$_def00000115$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000116
	.balign 4
.globl	RTTI_$JNI_$$_def00000116$indirect
	.type	RTTI_$JNI_$$_def00000116$indirect,#object
RTTI_$JNI_$$_def00000116$indirect:
	.long	RTTI_$JNI_$$_def00000116
.Le578:
	.size	RTTI_$JNI_$$_def00000116$indirect, .Le578 - RTTI_$JNI_$$_def00000116$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_JNINATIVEINTERFACE
	.balign 4
.globl	RTTI_$JNI_$$_JNINATIVEINTERFACE$indirect
	.type	RTTI_$JNI_$$_JNINATIVEINTERFACE$indirect,#object
RTTI_$JNI_$$_JNINATIVEINTERFACE$indirect:
	.long	RTTI_$JNI_$$_JNINATIVEINTERFACE
.Le579:
	.size	RTTI_$JNI_$$_JNINATIVEINTERFACE$indirect, .Le579 - RTTI_$JNI_$$_JNINATIVEINTERFACE$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_JNIENV
	.balign 4
.globl	RTTI_$JNI_$$_JNIENV$indirect
	.type	RTTI_$JNI_$$_JNIENV$indirect,#object
RTTI_$JNI_$$_JNIENV$indirect:
	.long	RTTI_$JNI_$$_JNIENV
.Le580:
	.size	RTTI_$JNI_$$_JNIENV$indirect, .Le580 - RTTI_$JNI_$$_JNIENV$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_PJNIENV
	.balign 4
.globl	RTTI_$JNI_$$_PJNIENV$indirect
	.type	RTTI_$JNI_$$_PJNIENV$indirect,#object
RTTI_$JNI_$$_PJNIENV$indirect:
	.long	RTTI_$JNI_$$_PJNIENV
.Le581:
	.size	RTTI_$JNI_$$_PJNIENV$indirect, .Le581 - RTTI_$JNI_$$_PJNIENV$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def00000119
	.balign 4
.globl	RTTI_$JNI_$$_def00000119$indirect
	.type	RTTI_$JNI_$$_def00000119$indirect,#object
RTTI_$JNI_$$_def00000119$indirect:
	.long	RTTI_$JNI_$$_def00000119
.Le582:
	.size	RTTI_$JNI_$$_def00000119$indirect, .Le582 - RTTI_$JNI_$$_def00000119$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def0000011A
	.balign 4
.globl	RTTI_$JNI_$$_def0000011A$indirect
	.type	RTTI_$JNI_$$_def0000011A$indirect,#object
RTTI_$JNI_$$_def0000011A$indirect:
	.long	RTTI_$JNI_$$_def0000011A
.Le583:
	.size	RTTI_$JNI_$$_def0000011A$indirect, .Le583 - RTTI_$JNI_$$_def0000011A$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def0000011B
	.balign 4
.globl	RTTI_$JNI_$$_def0000011B$indirect
	.type	RTTI_$JNI_$$_def0000011B$indirect,#object
RTTI_$JNI_$$_def0000011B$indirect:
	.long	RTTI_$JNI_$$_def0000011B
.Le584:
	.size	RTTI_$JNI_$$_def0000011B$indirect, .Le584 - RTTI_$JNI_$$_def0000011B$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_def0000011C
	.balign 4
.globl	RTTI_$JNI_$$_def0000011C$indirect
	.type	RTTI_$JNI_$$_def0000011C$indirect,#object
RTTI_$JNI_$$_def0000011C$indirect:
	.long	RTTI_$JNI_$$_def0000011C
.Le585:
	.size	RTTI_$JNI_$$_def0000011C$indirect, .Le585 - RTTI_$JNI_$$_def0000011C$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_JNIINVOKEINTERFACE
	.balign 4
.globl	RTTI_$JNI_$$_JNIINVOKEINTERFACE$indirect
	.type	RTTI_$JNI_$$_JNIINVOKEINTERFACE$indirect,#object
RTTI_$JNI_$$_JNIINVOKEINTERFACE$indirect:
	.long	RTTI_$JNI_$$_JNIINVOKEINTERFACE
.Le586:
	.size	RTTI_$JNI_$$_JNIINVOKEINTERFACE$indirect, .Le586 - RTTI_$JNI_$$_JNIINVOKEINTERFACE$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_PJNIINVOKEINTERFACE
	.balign 4
.globl	RTTI_$JNI_$$_PJNIINVOKEINTERFACE$indirect
	.type	RTTI_$JNI_$$_PJNIINVOKEINTERFACE$indirect,#object
RTTI_$JNI_$$_PJNIINVOKEINTERFACE$indirect:
	.long	RTTI_$JNI_$$_PJNIINVOKEINTERFACE
.Le587:
	.size	RTTI_$JNI_$$_PJNIINVOKEINTERFACE$indirect, .Le587 - RTTI_$JNI_$$_PJNIINVOKEINTERFACE$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_JOBJECTREFTYPE
	.balign 4
.globl	RTTI_$JNI_$$_JOBJECTREFTYPE$indirect
	.type	RTTI_$JNI_$$_JOBJECTREFTYPE$indirect,#object
RTTI_$JNI_$$_JOBJECTREFTYPE$indirect:
	.long	RTTI_$JNI_$$_JOBJECTREFTYPE
.Le588:
	.size	RTTI_$JNI_$$_JOBJECTREFTYPE$indirect, .Le588 - RTTI_$JNI_$$_JOBJECTREFTYPE$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_JOBJECTREFTYPE_s2o
	.balign 4
.globl	RTTI_$JNI_$$_JOBJECTREFTYPE_s2o$indirect
	.type	RTTI_$JNI_$$_JOBJECTREFTYPE_s2o$indirect,#object
RTTI_$JNI_$$_JOBJECTREFTYPE_s2o$indirect:
	.long	RTTI_$JNI_$$_JOBJECTREFTYPE_s2o
.Le589:
	.size	RTTI_$JNI_$$_JOBJECTREFTYPE_s2o$indirect, .Le589 - RTTI_$JNI_$$_JOBJECTREFTYPE_s2o$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_JOBJECTREFTYPE_o2s
	.balign 4
.globl	RTTI_$JNI_$$_JOBJECTREFTYPE_o2s$indirect
	.type	RTTI_$JNI_$$_JOBJECTREFTYPE_o2s$indirect,#object
RTTI_$JNI_$$_JOBJECTREFTYPE_o2s$indirect:
	.long	RTTI_$JNI_$$_JOBJECTREFTYPE_o2s
.Le590:
	.size	RTTI_$JNI_$$_JOBJECTREFTYPE_o2s$indirect, .Le590 - RTTI_$JNI_$$_JOBJECTREFTYPE_o2s$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_PJNINATIVEINTERFACE
	.balign 4
.globl	RTTI_$JNI_$$_PJNINATIVEINTERFACE$indirect
	.type	RTTI_$JNI_$$_PJNINATIVEINTERFACE$indirect,#object
RTTI_$JNI_$$_PJNINATIVEINTERFACE$indirect:
	.long	RTTI_$JNI_$$_PJNINATIVEINTERFACE
.Le591:
	.size	RTTI_$JNI_$$_PJNINATIVEINTERFACE$indirect, .Le591 - RTTI_$JNI_$$_PJNINATIVEINTERFACE$indirect

.section .data.rel.ro.n_INIT_$JNI_$$__JNIENV
	.balign 4
.globl	INIT_$JNI_$$__JNIENV$indirect
	.type	INIT_$JNI_$$__JNIENV$indirect,#object
INIT_$JNI_$$__JNIENV$indirect:
	.long	INIT_$JNI_$$__JNIENV
.Le592:
	.size	INIT_$JNI_$$__JNIENV$indirect, .Le592 - INIT_$JNI_$$__JNIENV$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$__JNIENV
	.balign 4
.globl	RTTI_$JNI_$$__JNIENV$indirect
	.type	RTTI_$JNI_$$__JNIENV$indirect,#object
RTTI_$JNI_$$__JNIENV$indirect:
	.long	RTTI_$JNI_$$__JNIENV
.Le593:
	.size	RTTI_$JNI_$$__JNIENV$indirect, .Le593 - RTTI_$JNI_$$__JNIENV$indirect

.section .data.rel.ro.n_INIT_$JNI_$$__JAVAVM
	.balign 4
.globl	INIT_$JNI_$$__JAVAVM$indirect
	.type	INIT_$JNI_$$__JAVAVM$indirect,#object
INIT_$JNI_$$__JAVAVM$indirect:
	.long	INIT_$JNI_$$__JAVAVM
.Le594:
	.size	INIT_$JNI_$$__JAVAVM$indirect, .Le594 - INIT_$JNI_$$__JAVAVM$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$__JAVAVM
	.balign 4
.globl	RTTI_$JNI_$$__JAVAVM$indirect
	.type	RTTI_$JNI_$$__JAVAVM$indirect,#object
RTTI_$JNI_$$__JAVAVM$indirect:
	.long	RTTI_$JNI_$$__JAVAVM
.Le595:
	.size	RTTI_$JNI_$$__JAVAVM$indirect, .Le595 - RTTI_$JNI_$$__JAVAVM$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_C_JNIENV
	.balign 4
.globl	RTTI_$JNI_$$_C_JNIENV$indirect
	.type	RTTI_$JNI_$$_C_JNIENV$indirect,#object
RTTI_$JNI_$$_C_JNIENV$indirect:
	.long	RTTI_$JNI_$$_C_JNIENV
.Le596:
	.size	RTTI_$JNI_$$_C_JNIENV$indirect, .Le596 - RTTI_$JNI_$$_C_JNIENV$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_PPJNIENV
	.balign 4
.globl	RTTI_$JNI_$$_PPJNIENV$indirect
	.type	RTTI_$JNI_$$_PPJNIENV$indirect,#object
RTTI_$JNI_$$_PPJNIENV$indirect:
	.long	RTTI_$JNI_$$_PPJNIENV
.Le597:
	.size	RTTI_$JNI_$$_PPJNIENV$indirect, .Le597 - RTTI_$JNI_$$_PPJNIENV$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_PPJAVAVM
	.balign 4
.globl	RTTI_$JNI_$$_PPJAVAVM$indirect
	.type	RTTI_$JNI_$$_PPJAVAVM$indirect,#object
RTTI_$JNI_$$_PPJAVAVM$indirect:
	.long	RTTI_$JNI_$$_PPJAVAVM
.Le598:
	.size	RTTI_$JNI_$$_PPJAVAVM$indirect, .Le598 - RTTI_$JNI_$$_PPJAVAVM$indirect

.section .data.rel.ro.n_INIT_$JNI_$$_JAVAVMATTACHARGS
	.balign 4
.globl	INIT_$JNI_$$_JAVAVMATTACHARGS$indirect
	.type	INIT_$JNI_$$_JAVAVMATTACHARGS$indirect,#object
INIT_$JNI_$$_JAVAVMATTACHARGS$indirect:
	.long	INIT_$JNI_$$_JAVAVMATTACHARGS
.Le599:
	.size	INIT_$JNI_$$_JAVAVMATTACHARGS$indirect, .Le599 - INIT_$JNI_$$_JAVAVMATTACHARGS$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_JAVAVMATTACHARGS
	.balign 4
.globl	RTTI_$JNI_$$_JAVAVMATTACHARGS$indirect
	.type	RTTI_$JNI_$$_JAVAVMATTACHARGS$indirect,#object
RTTI_$JNI_$$_JAVAVMATTACHARGS$indirect:
	.long	RTTI_$JNI_$$_JAVAVMATTACHARGS
.Le600:
	.size	RTTI_$JNI_$$_JAVAVMATTACHARGS$indirect, .Le600 - RTTI_$JNI_$$_JAVAVMATTACHARGS$indirect

.section .data.rel.ro.n_INIT_$JNI_$$_JAVAVMOPTION
	.balign 4
.globl	INIT_$JNI_$$_JAVAVMOPTION$indirect
	.type	INIT_$JNI_$$_JAVAVMOPTION$indirect,#object
INIT_$JNI_$$_JAVAVMOPTION$indirect:
	.long	INIT_$JNI_$$_JAVAVMOPTION
.Le601:
	.size	INIT_$JNI_$$_JAVAVMOPTION$indirect, .Le601 - INIT_$JNI_$$_JAVAVMOPTION$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_JAVAVMOPTION
	.balign 4
.globl	RTTI_$JNI_$$_JAVAVMOPTION$indirect
	.type	RTTI_$JNI_$$_JAVAVMOPTION$indirect,#object
RTTI_$JNI_$$_JAVAVMOPTION$indirect:
	.long	RTTI_$JNI_$$_JAVAVMOPTION
.Le602:
	.size	RTTI_$JNI_$$_JAVAVMOPTION$indirect, .Le602 - RTTI_$JNI_$$_JAVAVMOPTION$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_PJAVAVMOPTION
	.balign 4
.globl	RTTI_$JNI_$$_PJAVAVMOPTION$indirect
	.type	RTTI_$JNI_$$_PJAVAVMOPTION$indirect,#object
RTTI_$JNI_$$_PJAVAVMOPTION$indirect:
	.long	RTTI_$JNI_$$_PJAVAVMOPTION
.Le603:
	.size	RTTI_$JNI_$$_PJAVAVMOPTION$indirect, .Le603 - RTTI_$JNI_$$_PJAVAVMOPTION$indirect

.section .data.rel.ro.n_INIT_$JNI_$$_JAVAVMINITARGS
	.balign 4
.globl	INIT_$JNI_$$_JAVAVMINITARGS$indirect
	.type	INIT_$JNI_$$_JAVAVMINITARGS$indirect,#object
INIT_$JNI_$$_JAVAVMINITARGS$indirect:
	.long	INIT_$JNI_$$_JAVAVMINITARGS
.Le604:
	.size	INIT_$JNI_$$_JAVAVMINITARGS$indirect, .Le604 - INIT_$JNI_$$_JAVAVMINITARGS$indirect

.section .data.rel.ro.n_RTTI_$JNI_$$_JAVAVMINITARGS
	.balign 4
.globl	RTTI_$JNI_$$_JAVAVMINITARGS$indirect
	.type	RTTI_$JNI_$$_JAVAVMINITARGS$indirect,#object
RTTI_$JNI_$$_JAVAVMINITARGS$indirect:
	.long	RTTI_$JNI_$$_JAVAVMINITARGS
.Le605:
	.size	RTTI_$JNI_$$_JAVAVMINITARGS$indirect, .Le605 - RTTI_$JNI_$$_JAVAVMINITARGS$indirect
# End asmlist al_indirectglobals
.section .note.GNU-stack,"",%progbits

