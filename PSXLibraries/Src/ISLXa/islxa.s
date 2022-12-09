	.file	1 "C:\\psx\\Library\\ISLXa\\islxa.C"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	XAsetStatus
	.align	2
	.globl	XAgetStatus
	.rdata
	.align	2
$LC0:
	.ascii	"UnHandled Callback Occured\n\000"
	.text
	.align	2
	.sdata
	.align	2
$LC1:
	.ascii	"XA/%s\000"
	.align	2
$LC2:
	.ascii	"islxa.c\000"
	.align	2
$LC3:
	.ascii	"\\\000"
	.align	2
$LC4:
	.ascii	";1\000"
	.rdata
	.align	2
$LC5:
	.ascii	"XA file '%s' not found\n\000"
	.align	2
$LC6:
	.ascii	"XA track '%s' %d->%d\n\000"
	.text
	.align	2
	.globl	XAgetFileInfo
	.align	2
	.globl	XAstart
	.align	2
	.globl	XAstop
	.align	2
	.globl	XApause
	.rdata
	.align	2
$LC7:
	.ascii	"XAplayChannel: disabled\n\000"
	.align	2
$LC8:
	.ascii	"XAplayChannel: stream not found\n\000"
	.align	2
$LC9:
	.ascii	"XAplayChannel: %d->%d\n\000"
	.text
	.align	2
	.globl	XAplayChannelOffset
	.align	2
	.globl	XAcheckPlay
	.align	2
	.globl	XAstorePrevious
	.rdata
	.align	2
$LC10:
	.ascii	"XArestartPrevious: disabled\n\000"
	.align	2
$LC11:
	.ascii	"XArestartPrevious: stream not found\n\000"
	.align	2
$LC12:
	.ascii	"XArestartPrevious: %d [%d->%d]\n\000"
	.text
	.align	2
	.globl	XArestartPrevious

	.comm	XAData,2372

	.lcomm	XAenable,4

	.text
	.text
	.ent	XAsetStatus
XAsetStatus:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L3
	li	$2,1			# 0x1
	.set	macro
	.set	reorder

	sw	$2,XAenable
	j	$31
$L3:
	sw	$0,XAenable
	j	$31
	.end	XAsetStatus
	.text
	.ent	XAgetStatus
XAgetStatus:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,XAenable
	j	$31
	.end	XAgetStatus
	.text
	.ent	XAcallback
XAcallback:
	.frame	$sp,40,$31		# vars= 0, regs= 3/0, args= 24, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	lui	$2,%hi(XAData+4) # hi
	sw	$17,28($sp)
	addiu	$17,$2,%lo(XAData+4) # low
	li	$3,1			# 0x1
	sw	$31,32($sp)
	.set	noreorder
	.set	nomacro
	bne	$4,$3,$L7
	sw	$16,24($sp)
	.set	macro
	.set	reorder

	move	$4,$17
	.set	noreorder
	.set	nomacro
	jal	CdGetSector
	li	$5,8			# 0x8
	.set	macro
	.set	reorder

	addiu	$16,$17,-4
	lhu	$3,14($17)
	lw	$2,2352($16)
	andi	$3,$3,0x7c00
	sra	$5,$3,10
	addiu	$2,$2,1
	sw	$5,2344($16)
	sw	$2,2352($16)
	lhu	$4,12($17)
	li	$3,352			# 0x160
	bne	$4,$3,$L11
	#nop
	lw	$2,2348($16)
	#nop
	bne	$5,$2,$L11
	#nop

	li	$4,9			# 0x9
	.set	noreorder
	.set	nomacro
	jal	CdControlF
	move	$5,$0
	.set	macro
	.set	reorder

	lw	$3,2356($16)
	#nop
	lbu	$2,33($3)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L9
	move	$7,$2
	.set	macro
	.set	reorder

	lw	$2,36($3)
	move	$4,$3
	sw	$2,16($sp)
	lw	$6,2348($16)
	.set	noreorder
	.set	nomacro
	jal	XAplayChannelOffset
	move	$5,$0
	.set	macro
	.set	reorder

	j	$L11
$L9:
	sb	$0,32($3)
	.set	noreorder
	.set	nomacro
	jal	XAstop
	sw	$0,2356($16)
	.set	macro
	.set	reorder

	j	$L11
$L7:
	lui	$4,%hi($LC0) # high
	.set	noreorder
	.set	nomacro
	jal	printf
	addiu	$4,$4,%lo($LC0) # low
	.set	macro
	.set	reorder

$L11:
	lw	$31,32($sp)
	lw	$17,28($sp)
	lw	$16,24($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,40
	.set	macro
	.set	reorder

	.end	XAcallback
	.text
	.ent	XAgetFileInfo
XAgetFileInfo:
	.frame	$sp,72,$31		# vars= 40, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,64
	sw	$16,56($sp)
	move	$16,$4
	addu	$4,$sp,16
	lui	$5,%hi($LC1) # high
	addiu	$5,$5,%lo($LC1) # low
	sw	$31,60($sp)
	.set	noreorder
	.set	nomacro
	jal	sprintf
	move	$6,$16
	.set	macro
	.set	reorder

	li	$4,40			# 0x28
	lui	$5,%hi($LC2) # high
	addiu	$5,$5,%lo($LC2) # low
	.set	noreorder
	.set	nomacro
	jal	memoryAllocate
	li	$6,123			# 0x7b
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	lui	$3,%hi($LC3) # high
	move	$5,$16
	lhu	$6,%lo($LC3)($3)
	move	$16,$2
	.set	noreorder
	.set	nomacro
	jal	strcat
	sh	$6,16($sp)
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	lui	$5,%hi($LC4) # high
	.set	noreorder
	.set	nomacro
	jal	strcat
	addiu	$5,$5,%lo($LC4) # low
	.set	macro
	.set	reorder

	lw	$3,XAenable
	#nop
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L13
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L15
	move	$2,$16
	.set	macro
	.set	reorder

$L13:
	.set	noreorder
	.set	nomacro
	jal	CdSearchFile
	addu	$5,$sp,16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L14
	lui	$4,%hi($LC5) # high
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	CdPosToInt
	move	$4,$16
	.set	macro
	.set	reorder

	lui	$4,%hi($LC6) # high
	addiu	$4,$4,%lo($LC6) # low
	addu	$5,$sp,16
	lw	$3,4($16)
	move	$6,$2
	sw	$2,24($16)
	sb	$0,32($16)
	srl	$3,$3,11
	addu	$2,$2,$3
	addu	$2,$2,-1
	move	$7,$2
	.set	noreorder
	.set	nomacro
	jal	printf
	sw	$2,28($16)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L15
	move	$2,$16
	.set	macro
	.set	reorder

$L14:
	addiu	$4,$4,%lo($LC5) # low
	.set	noreorder
	.set	nomacro
	jal	printf
	addu	$5,$sp,16
	.set	macro
	.set	reorder

	move	$2,$0
$L15:
	lw	$31,60($sp)
	lw	$16,56($sp)

	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,64
	.set	macro
	.set	reorder

	.end	XAgetFileInfo
	.text
	.ent	XAstart
XAstart:
	.frame	$sp,32,$31		# vars= 8, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	lw	$2,XAenable
	subu	$sp,$sp,32
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L16
	sw	$31,24($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$4,$0,$L18
	li	$2,232			# 0xe8
	.set	macro
	.set	reorder

	li	$2,104			# 0x68
$L18:
	sb	$2,16($sp)
	li	$4,14			# 0xe
	addu	$5,$sp,16
	.set	noreorder
	.set	nomacro
	jal	CdControlB
	move	$6,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	VSync
	li	$4,3			# 0x3
	.set	macro
	.set	reorder

	li	$4,9			# 0x9
	.set	noreorder
	.set	nomacro
	jal	CdControlF
	move	$5,$0
	.set	macro
	.set	reorder

	lui	$4,%hi(XAcallback) # high
	.set	noreorder
	.set	nomacro
	jal	CdReadyCallback
	addiu	$4,$4,%lo(XAcallback) # low
	.set	macro
	.set	reorder

	lui	$3,%hi(XAData) # high
	sw	$2,%lo(XAData)($3)
	addiu	$3,$3,%lo(XAData) # low
	sw	$0,2356($3)
$L16:
	lw	$31,24($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	XAstart
	.text
	.ent	XAstop
XAstop:
	.frame	$sp,32,$31		# vars= 8, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	lw	$2,XAenable
	subu	$sp,$sp,32
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L21
	sw	$31,24($sp)
	.set	macro
	.set	reorder

	move	$4,$0
	.set	noreorder
	.set	nomacro
	jal	SpuSetCommonCDVolume
	move	$5,$0
	.set	macro
	.set	reorder

	li	$4,9			# 0x9
	.set	noreorder
	.set	nomacro
	jal	CdControlF
	move	$5,$0
	.set	macro
	.set	reorder

	lui	$3,%hi(XAData) # high
	lw	$4,%lo(XAData)($3)
	jal	CdReadyCallback
	li	$4,14			# 0xe
	addu	$5,$sp,16
	li	$2,128			# 0x80
	move	$6,$0
	.set	noreorder
	.set	nomacro
	jal	CdControlB
	sb	$2,16($sp)
	.set	macro
	.set	reorder

$L21:
	lw	$31,24($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	XAstop
	.text
	.ent	XApause
XApause:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	lw	$2,XAenable
	subu	$sp,$sp,24
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L23
	sw	$31,16($sp)
	.set	macro
	.set	reorder

	move	$4,$0
	.set	noreorder
	.set	nomacro
	jal	SpuSetCommonCDVolume
	move	$5,$0
	.set	macro
	.set	reorder

	li	$4,9			# 0x9
	.set	noreorder
	.set	nomacro
	jal	CdControlF
	move	$5,$0
	.set	macro
	.set	reorder

$L23:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	XApause
	.text
	.ent	XAplayChannelOffset
XAplayChannelOffset:
	.frame	$sp,64,$31		# vars= 16, regs= 8/0, args= 16, extra= 0
	.mask	0x807f0000,-4
	.fmask	0x00000000,0
	lw	$2,XAenable
	subu	$sp,$sp,64
	sw	$20,48($sp)
	lw	$20,80($sp)
	sw	$19,44($sp)
	move	$19,$4
	sw	$21,52($sp)
	move	$21,$5
	sw	$22,56($sp)
	move	$22,$7
	sw	$31,60($sp)
	sw	$18,40($sp)
	sw	$17,36($sp)
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L26
	sw	$16,32($sp)
	.set	macro
	.set	reorder

	lui	$4,%hi($LC7) # high
	.set	noreorder
	.set	nomacro
	jal	printf
	addiu	$4,$4,%lo($LC7) # low
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L25
	sb	$0,32($19)
	.set	macro
	.set	reorder

$L26:
	.set	noreorder
	.set	nomacro
	bne	$19,$0,$L27
	li	$4,13			# 0xd
	.set	macro
	.set	reorder

	lui	$4,%hi($LC8) # high
	.set	noreorder
	.set	nomacro
	jal	printf
	addiu	$4,$4,%lo($LC8) # low
	.set	macro
	.set	reorder

	j	$L25
$L27:
	addu	$5,$sp,24
	li	$18,1			# 0x1
	lui	$17,%hi(XAData) # high
	addiu	$17,$17,%lo(XAData) # low
	sb	$18,24($sp)
	sb	$6,25($sp)
	.set	noreorder
	.set	nomacro
	jal	CdControlF
	sw	$6,2348($17)
	.set	macro
	.set	reorder

	lw	$16,24($19)
	addu	$5,$sp,16
	addu	$16,$16,$21
	.set	noreorder
	.set	nomacro
	jal	CdIntToPos
	move	$4,$16
	.set	macro
	.set	reorder

	li	$4,27			# 0x1b
	.set	noreorder
	.set	nomacro
	jal	CdControlF
	addu	$5,$sp,16
	.set	macro
	.set	reorder

	lui	$4,%hi($LC9) # high
	addiu	$4,$4,%lo($LC9) # low
	sw	$19,2356($17)
	sw	$16,2352($17)
	lw	$6,28($19)
	move	$5,$16
	sb	$18,32($19)
	sb	$22,33($19)
	.set	noreorder
	.set	nomacro
	jal	printf
	sw	$20,36($19)
	.set	macro
	.set	reorder

	li	$4,1374355456			# 0x51eb0000
	ori	$4,$4,0x851f
	sll	$2,$20,15
	subu	$2,$2,$20
	mult	$2,$4
	sra	$2,$2,31
	mfhi	$4
	#nop
	#nop
	sra	$4,$4,5
	subu	$4,$4,$2
	sll	$4,$4,16
	sra	$4,$4,16
	.set	noreorder
	.set	nomacro
	jal	SpuSetCommonCDVolume
	move	$5,$4
	.set	macro
	.set	reorder

$L25:
	lw	$31,60($sp)
	lw	$22,56($sp)
	lw	$21,52($sp)
	lw	$20,48($sp)
	lw	$19,44($sp)
	lw	$18,40($sp)
	lw	$17,36($sp)
	lw	$16,32($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,64
	.set	macro
	.set	reorder

	.end	XAplayChannelOffset
	.text
	.ent	XAcheckPlay
XAcheckPlay:
	.frame	$sp,32,$31		# vars= 8, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	lw	$2,XAenable
	subu	$sp,$sp,32
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L29
	sw	$31,24($sp)
	.set	macro
	.set	reorder

	li	$4,1			# 0x1
	move	$5,$0
	.set	noreorder
	.set	nomacro
	jal	CdControlB
	addu	$6,$sp,16
	.set	macro
	.set	reorder

	lbu	$2,16($sp)
	#nop
	andi	$2,$2,0x60
	xori	$2,$2,0x20
	.set	noreorder
	.set	nomacro
	j	$L30
	sltu	$2,$2,1
	.set	macro
	.set	reorder

$L29:
	li	$2,1			# 0x1
$L30:
	lw	$31,24($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	XAcheckPlay
	.text
	.ent	XAstorePrevious
XAstorePrevious:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$2,%hi(XAData) # high
	addiu	$2,$2,%lo(XAData) # low
	lw	$3,2356($2)
	lw	$4,2348($2)
	lw	$5,2352($2)
	sw	$3,2360($2)
	sw	$4,2364($2)
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$5,2368($2)
	.set	macro
	.set	reorder

	.end	XAstorePrevious
	.text
	.ent	XArestartPrevious
XArestartPrevious:
	.frame	$sp,48,$31		# vars= 16, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	lw	$2,XAenable
	subu	$sp,$sp,48
	sw	$31,40($sp)
	sw	$17,36($sp)
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L33
	sw	$16,32($sp)
	.set	macro
	.set	reorder

	lui	$4,%hi($LC10) # high
	.set	noreorder
	.set	nomacro
	jal	printf
	addiu	$4,$4,%lo($LC10) # low
	.set	macro
	.set	reorder

	lui	$3,%hi(XAData+2360) # high
	lw	$2,%lo(XAData+2360)($3)
	.set	noreorder
	.set	nomacro
	j	$L32
	sb	$0,32($2)
	.set	macro
	.set	reorder

$L33:
	lui	$2,%hi(XAData) # high
	addiu	$17,$2,%lo(XAData) # low
	lw	$3,2360($17)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L34
	li	$4,13			# 0xd
	.set	macro
	.set	reorder

	lui	$4,%hi($LC11) # high
	.set	noreorder
	.set	nomacro
	jal	printf
	addiu	$4,$4,%lo($LC11) # low
	.set	macro
	.set	reorder

	j	$L32
$L34:
	addu	$5,$sp,24
	lbu	$2,2364($17)
	lw	$3,2364($17)
	li	$16,1			# 0x1
	sb	$16,24($sp)
	sb	$2,25($sp)
	.set	noreorder
	.set	nomacro
	jal	CdControlF
	sw	$3,2348($17)
	.set	macro
	.set	reorder

	lw	$4,2368($17)
	.set	noreorder
	.set	nomacro
	jal	CdIntToPos
	addu	$5,$sp,16
	.set	macro
	.set	reorder

	li	$4,27			# 0x1b
	.set	noreorder
	.set	nomacro
	jal	CdControlF
	addu	$5,$sp,16
	.set	macro
	.set	reorder

	lw	$3,2360($17)
	lw	$2,2368($17)
	lui	$4,%hi($LC12) # high
	sw	$3,2356($17)
	sw	$2,2352($17)
	sb	$16,32($3)
	lw	$2,2360($17)
	lw	$5,2368($17)
	lw	$6,24($2)
	lw	$7,28($2)
	.set	noreorder
	.set	nomacro
	jal	printf
	addiu	$4,$4,%lo($LC12) # low
	.set	macro
	.set	reorder

	lw	$3,2356($17)
	li	$4,1374355456			# 0x51eb0000
	lw	$5,36($3)
	ori	$4,$4,0x851f
	sll	$2,$5,15
	subu	$2,$2,$5
	mult	$2,$4
	sra	$2,$2,31
	mfhi	$4
	#nop
	#nop
	sra	$4,$4,5
	subu	$4,$4,$2
	sll	$4,$4,16
	sra	$4,$4,16
	.set	noreorder
	.set	nomacro
	jal	SpuSetCommonCDVolume
	move	$5,$4
	.set	macro
	.set	reorder

$L32:
	lw	$31,40($sp)
	lw	$17,36($sp)
	lw	$16,32($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,48
	.set	macro
	.set	reorder

	.end	XArestartPrevious
