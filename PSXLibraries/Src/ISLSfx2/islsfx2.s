	.file	1 "islsfx2.c"
gcc2_compiled.:
__gnu_compiled_c:
	.text
	.align	2
	.globl	sfxInitialise
	.align	2
	.globl	sfxDestroy
	.align	2
	.globl	sfxUpdate
	.align	2
	.globl	sfxFixupSampleBankHeader
	.sdata
	.align	2
$LC0:
	.ascii	"%s.SBB\000"
	.rdata
	.align	2
$LC1:
	.ascii	"islsfx2.c\000"
	.text
	.align	2
	.globl	sfxLoadSampleBankBody
	.sdata
	.align	2
$LC2:
	.ascii	"%s.SBH\000"
	.text
	.align	2
	.globl	sfxLoadSampleBank
	.align	2
	.globl	sfxFindSampleInBankCRC
	.align	2
	.globl	sfxFindSampleInBank
	.align	2
	.globl	sfxFindSampleInAllBanksCRC
	.align	2
	.globl	sfxFindSampleInAllBanks
	.align	2
	.globl	sfxDownloadSample
	.align	2
	.globl	sfxDownloadSampleBank
	.align	2
	.globl	sfxDestroySampleBank
	.align	2
	.globl	sfxUnloadSample
	.align	2
	.globl	sfxUnloadSampleBank
	.align	2
	.globl	sfxRemoveSampleBank
	.align	2
	.globl	sfxOn
	.align	2
	.globl	sfxOff
	.align	2
	.globl	sfxStartSound
	.align	2
	.globl	sfxStopSound
	.align	2
	.globl	sfxSetGlobalVolume
	.align	2
	.globl	sfxSetReverb
	.align	2
	.globl	sfxPlaySample
	.align	2
	.globl	sfxStopSample
	.align	2
	.globl	sfxStopChannel
	.align	2
	.globl	sfxGetSampleStatus
	.align	2
	.globl	sfxGetChannelStatus
	.align	2
	.globl	sfxSetChannelReverb
	.align	2
	.globl	sfxGetChannelReverb
	.align	2
	.globl	sfxSetChannelPitch
	.align	2
	.globl	sfxSetChannelVolume
	.align	2
	.globl	sfxSetSampleVolume
	.align	2
	.globl	sfxSetSamplePitch
	.rdata
	.align	2
$LC3:
	.ascii	"sfxGetFreeSoundMemory:\n"
	.ascii	"----------------------\n"
	.ascii	"Total: %d bytes used (%d bytes available)\n\000"
	.align	2
$LC4:
	.ascii	"Samples: %d bytes used\n\000"
	.align	2
$LC5:
	.ascii	"Reverb: %d bytes used\n\000"
	.text
	.align	2
	.globl	sfxGetFreeSoundMemory

	.lcomm	sfx2Data,980

	.text
	.text
	.ent	sfxInitialise
sfxInitialise:
	.frame	$sp,64,$31		# vars= 32, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,64
	sw	$18,56($sp)
	move	$18,$4
	move	$4,$0
	sw	$16,48($sp)
	lui	$16,%hi(sfx2Data) # high
	addiu	$3,$16,%lo(sfx2Data) # low
	sw	$31,60($sp)
	sw	$17,52($sp)
$L5:
	sw	$0,0($3)
	addu	$4,$4,1
	slti	$2,$4,16
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L5
	addu	$3,$3,4
	.set	macro
	.set	reorder

	jal	SpuInit
	#nop
	li	$4,16383			# 0x00003fff
	.set	noreorder
	.set	nomacro
	jal	SpuSetCommonMasterVolume
	li	$5,16383			# 0x00003fff
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	SpuSetCommonCDMix
	li	$4,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	SpuSetTransferCallback
	move	$4,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	SpuSetTransferMode
	li	$4,1			# 0x00000001
	.set	macro
	.set	reorder

	li	$4,100			# 0x00000064
	lui	$2,%hi(sfx2Data+64) # high
	addiu	$17,$2,%lo(sfx2Data+64) # low
	.set	noreorder
	.set	nomacro
	jal	SpuInitMalloc
	move	$5,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$18,$0,$L999
	addu	$4,$sp,16
	.set	macro
	.set	reorder

	li	$2,25			# 0x00000019
	li	$3,0x7fff
	li	$5,64
	sw	$2,16($sp)
	sw	$18,20($sp)
	sh	$3,24($sp)
	sh	$3,26($sp)
	sw	$5,28($sp)
	.set	noreorder
	.set	nomacro
	jal	SpuSetReverbModeParam
	sw	$5,32($sp)
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	.set	noreorder
	.set	nomacro
	jal	SpuSetReverbDepth
	sw	$0,16($sp)
	.set	macro
	.set	reorder

	li	$4,1			# 0x00000001
	li	$5,16711680			# 0x00ff0000
	.set	noreorder
	.set	nomacro
	jal	SpuSetReverbVoice
	ori	$5,$5,0xffff
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	SpuSetReverb
	li	$4,1			# 0x00000001
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L8
	li	$2,4112			# 0x00001010
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	SpuReserveReverbWorkArea
	li	$4,1			# 0x00000001
	.set	macro
	.set	reorder

	addu	$3,$18,-1
	sltu	$2,$3,9
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L999
	sw	$18,812($17)
	.set	macro
	.set	reorder

	lui	$2,%hi($L19) # high
	addiu	$2,$2,%lo($L19) # low
	sll	$3,$3,2
	addu	$3,$3,$2
	lw	$4,0($3)
	#nop
	j	$4
	#nop
	.rdata
	.align	3
$L19:
	.word	$L10
	.word	$L11
	.word	$L12
	.word	$L13
	.word	$L14
	.word	$L15
	.word	$L17
	.word	$L17
	.word	$L18
	.text
$L10:
	addiu	$3,$16,%lo(sfx2Data) # low
	li	$2,14032			# 0x000036d0
	.set	noreorder
	.set	nomacro
	j	$L7
	sw	$2,976($3)
	.set	macro
	.set	reorder

$L11:
	addiu	$3,$16,%lo(sfx2Data) # low
	li	$2,12112			# 0x00002f50
	.set	noreorder
	.set	nomacro
	j	$L7
	sw	$2,976($3)
	.set	macro
	.set	reorder

$L12:
	addiu	$3,$16,%lo(sfx2Data) # low
	li	$2,22608			# 0x00005850
	.set	noreorder
	.set	nomacro
	j	$L7
	sw	$2,976($3)
	.set	macro
	.set	reorder

$L13:
	addiu	$3,$16,%lo(sfx2Data) # low
	li	$2,32752			# 0x00007ff0
	.set	noreorder
	.set	nomacro
	j	$L7
	sw	$2,976($3)
	.set	macro
	.set	reorder

$L14:
	addiu	$3,$16,%lo(sfx2Data) # low
	li	$2,48624			# 0x0000bdf0
	.set	noreorder
	.set	nomacro
	j	$L7
	sw	$2,976($3)
	.set	macro
	.set	reorder

$L15:
	li	$2,65536			# 0x00010000
	.set	noreorder
	.set	nomacro
	j	$L22
	ori	$2,$2,0x06d0
	.set	macro
	.set	reorder

$L17:
	li	$2,65536			# 0x00010000
	ori	$2,$2,0x9050
$L22:
	addiu	$3,$16,%lo(sfx2Data) # low
	.set	noreorder
	.set	nomacro
	j	$L7
	sw	$2,976($3)
	.set	macro
	.set	reorder

$L18:
	addiu	$3,$16,%lo(sfx2Data) # low
	li	$2,19472			# 0x00004c10
	.set	noreorder
	.set	nomacro
	j	$L7
	sw	$2,976($3)
	.set	macro
	.set	reorder

$L8:
	sw	$2,912($17)
$L999:
	addiu	$3,$16,%lo(sfx2Data) # low
$L7:
	lw	$31,60($sp)
	lw	$18,56($sp)
	lw	$17,52($sp)
	lw	$16,48($sp)
	li	$2,255			# 0x000000ff
	sw	$2,872($3)

	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,64
	.set	macro
	.set	reorder

	.end	sfxInitialise
	.text
	.ent	sfxDestroy
sfxDestroy:
	.frame	$sp,56,$31		# vars= 24, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,56
	move	$4,$0
	li	$5,-1			# 0xffffffff
	sw	$31,48($sp)
	sw	$17,44($sp)
	.set	noreorder
	.set	nomacro
	jal	SpuSetKey
	sw	$16,40($sp)
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	li	$2,1			# 0x00000001
	sw	$2,16($sp)
	.set	noreorder
	.set	nomacro
	jal	SpuSetReverbModeParam
	sw	$0,20($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	SpuReserveReverbWorkArea
	move	$4,$0
	.set	macro
	.set	reorder

	move	$17,$0
	lui	$2,%hi(sfx2Data) # high
	addiu	$16,$2,%lo(sfx2Data) # low
$L27:
	lw	$4,0($16)
	#nop
	beq	$4,$0,$L26
	jal	sfxUnloadSampleBank
$L26:
	addu	$17,$17,1
	slt	$2,$17,16
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L27
	addu	$16,$16,4
	.set	macro
	.set	reorder

	lw	$31,48($sp)
	lw	$17,44($sp)
	lw	$16,40($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,56
	.set	macro
	.set	reorder

	.end	sfxDestroy
	.text
	.ent	sfxUpdate
sfxUpdate:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	j	$31
	.end	sfxUpdate
	.text
	.ent	sfxFixupSampleBankHeader
sfxFixupSampleBankHeader:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	bne	$4,$0,$L32
	move	$7,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$0
	.set	macro
	.set	reorder

$L45:
	.set	noreorder
	.set	nomacro
	j	$L34
	sw	$4,0($3)
	.set	macro
	.set	reorder

$L32:
	lui	$2,%hi(sfx2Data) # high
	addiu	$3,$2,%lo(sfx2Data) # low
$L36:
	lw	$2,0($3)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L45
	addu	$7,$7,1
	.set	macro
	.set	reorder

	slt	$2,$7,16
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L36
	addu	$3,$3,4
	.set	macro
	.set	reorder

$L34:
	move	$7,$0
	lw	$3,0($4)
	addu	$2,$4,16
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L40
	sw	$2,8($4)
	.set	macro
	.set	reorder

	li	$8,1			# 0x00000001
	move	$6,$7
$L42:
	lw	$2,8($4)
	#nop
	addu	$2,$6,$2
	sb	$8,0($2)
	lw	$3,8($4)
	#nop
	addu	$3,$6,$3
	lw	$2,16($3)
	addu	$7,$7,1
	addu	$2,$2,$5
	sw	$2,4($3)
	lw	$2,0($4)
	#nop
	sltu	$2,$7,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L42
	addu	$6,$6,20
	.set	macro
	.set	reorder

$L40:
	sw	$5,4($4)
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$4
	.set	macro
	.set	reorder

	.end	sfxFixupSampleBankHeader
	.text
	.ent	sfxLoadSampleBankBody
sfxLoadSampleBankBody:
	.frame	$sp,104,$31		# vars= 72, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,104
	move	$6,$4
	addu	$4,$sp,16
	lui	$5,%hi($LC0) # high
	addiu	$5,$5,%lo($LC0) # low
	sw	$31,96($sp)
	sw	$17,92($sp)
	.set	noreorder
	.set	nomacro
	jal	sprintf
	sw	$16,88($sp)
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	.set	noreorder
	.set	nomacro
	jal	fileLoad
	addu	$5,$sp,80
	.set	macro
	.set	reorder

	move	$16,$2
	.set	noreorder
	.set	nomacro
	beq	$16,$0,$L47
	move	$2,$0
	.set	macro
	.set	reorder

	lw	$4,80($sp)
	jal	SpuMalloc
	move	$17,$2
	beq	$17,$0,$L48
	.set	noreorder
	.set	nomacro
	jal	SpuSetTransferStartAddr
	move	$4,$17
	.set	macro
	.set	reorder

	lw	$5,80($sp)
	.set	noreorder
	.set	nomacro
	jal	SpuWrite
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	SpuIsTransferCompleted
	li	$4,1			# 0x00000001
	.set	macro
	.set	reorder

	move	$4,$16
	lui	$5,%hi($LC1) # high
	addiu	$5,$5,%lo($LC1) # low
	.set	noreorder
	.set	nomacro
	jal	memoryFree
	li	$6,251			# 0x000000fb
	.set	macro
	.set	reorder

	lui	$3,%hi(sfx2Data) # high
	addiu	$3,$3,%lo(sfx2Data) # low
	lw	$2,976($3)
	lw	$4,80($sp)
	#nop
	addu	$2,$2,$4
	sw	$2,976($3)
$L48:
	move	$2,$17
$L47:
	lw	$31,96($sp)
	lw	$17,92($sp)
	lw	$16,88($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,104
	.set	macro
	.set	reorder

	.end	sfxLoadSampleBankBody
	.text
	.ent	sfxLoadSampleBank
sfxLoadSampleBank:
	.frame	$sp,152,$31		# vars= 128, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,152
	sw	$16,144($sp)
	move	$16,$4
	addu	$4,$sp,16
	lui	$5,%hi($LC2) # high
	addiu	$5,$5,%lo($LC2) # low
	sw	$31,148($sp)
	.set	noreorder
	.set	nomacro
	jal	sprintf
	move	$6,$16
	.set	macro
	.set	reorder

	addu	$4,$sp,80
	lui	$5,%hi($LC0) # high
	addiu	$5,$5,%lo($LC0) # low
	.set	noreorder
	.set	nomacro
	jal	sprintf
	move	$6,$16
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	.set	noreorder
	.set	nomacro
	jal	fileLoad
	move	$5,$0
	.set	macro
	.set	reorder

	move	$16,$2
	.set	noreorder
	.set	nomacro
	beq	$16,$0,$L52
	move	$5,$0
	.set	macro
	.set	reorder

	lui	$2,%hi(sfx2Data) # high
	addiu	$4,$2,%lo(sfx2Data) # low
$L56:
	move	$3,$4
	lw	$2,0($3)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L67
	addu	$5,$5,1
	.set	macro
	.set	reorder

	slt	$2,$5,16
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L56
	addu	$4,$3,4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L68
	addu	$4,$sp,80
	.set	macro
	.set	reorder

$L52:
	.set	noreorder
	.set	nomacro
	j	$L66
	move	$2,$0
	.set	macro
	.set	reorder

$L67:
	sw	$16,0($4)
	addu	$4,$sp,80
$L68:
	.set	noreorder
	.set	nomacro
	jal	fileLoad
	move	$5,$0
	.set	macro
	.set	reorder

	move	$7,$2
	.set	noreorder
	.set	nomacro
	beq	$7,$0,$L60
	addu	$2,$16,16
	.set	macro
	.set	reorder

	move	$5,$0
	lw	$3,0($16)
	sw	$7,12($16)
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L60
	sw	$2,8($16)
	.set	macro
	.set	reorder

	move	$6,$0
$L64:
	lw	$2,8($16)
	#nop
	addu	$2,$6,$2
	lw	$3,16($2)
	addu	$5,$5,1
	addu	$3,$3,$7
	sw	$3,16($2)
	lw	$4,0($16)
	#nop
	sltu	$4,$5,$4
	.set	noreorder
	.set	nomacro
	bne	$4,$0,$L64
	addu	$6,$6,20
	.set	macro
	.set	reorder

$L60:
	move	$2,$16
$L66:
	lw	$31,148($sp)
	lw	$16,144($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,152
	.set	macro
	.set	reorder

	.end	sfxLoadSampleBank
	.text
	.ent	sfxFindSampleInBankCRC
sfxFindSampleInBankCRC:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$6,0($5)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$6,$0,$L71
	move	$3,$0
	.set	macro
	.set	reorder

	lw	$5,8($5)
$L73:
	lw	$2,8($5)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$4,$L72
	addu	$3,$3,1
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$5
	.set	macro
	.set	reorder

$L72:
	sltu	$2,$3,$6
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L73
	addu	$5,$5,20
	.set	macro
	.set	reorder

$L71:
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$0
	.set	macro
	.set	reorder

	.end	sfxFindSampleInBankCRC
	.text
	.ent	sfxFindSampleInBank
sfxFindSampleInBank:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	utilStr2CRC
	move	$16,$5
	.set	macro
	.set	reorder

	move	$4,$2
	.set	noreorder
	.set	nomacro
	jal	sfxFindSampleInBankCRC
	move	$5,$16
	.set	macro
	.set	reorder

	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	sfxFindSampleInBank
	.text
	.ent	sfxFindSampleInAllBanksCRC
sfxFindSampleInAllBanksCRC:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$18,24($sp)
	move	$18,$4
	sw	$17,20($sp)
	move	$17,$0
	lui	$2,%hi(sfx2Data) # high
	sw	$16,16($sp)
	addiu	$16,$2,%lo(sfx2Data) # low
	sw	$31,28($sp)
$L82:
	lw	$5,0($16)
	#nop
	beq	$5,$0,$L81
	.set	noreorder
	.set	nomacro
	jal	sfxFindSampleInBankCRC
	move	$4,$18
	.set	macro
	.set	reorder

	bne	$2,$0,$L86
$L81:
	addu	$17,$17,1
	slt	$2,$17,16
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L82
	addu	$16,$16,4
	.set	macro
	.set	reorder

	move	$2,$0
$L86:
	lw	$31,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	sfxFindSampleInAllBanksCRC
	.text
	.ent	sfxFindSampleInAllBanks
sfxFindSampleInAllBanks:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	utilStr2CRC
	.set	noreorder
	.set	nomacro
	jal	sfxFindSampleInAllBanksCRC
	move	$4,$2
	.set	macro
	.set	reorder

	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	sfxFindSampleInAllBanks
	.text
	.ent	sfxDownloadSample
sfxDownloadSample:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$4
	sw	$31,24($sp)
	sw	$16,16($sp)
	lbu	$2,0($17)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L92
	move	$2,$17
	.set	macro
	.set	reorder

	lw	$4,12($17)
	jal	SpuMalloc
	#nop
	move	$16,$2
	.set	noreorder
	.set	nomacro
	beq	$16,$0,$L92
	move	$2,$0
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	SpuSetTransferStartAddr
	move	$4,$16
	.set	macro
	.set	reorder

	lw	$4,16($17)
	lw	$5,12($17)
	jal	SpuWrite
	#nop
	lw	$3,12($17)
	move $5,$2
	
	.set	noreorder
	.set	nomacro
	bne	$5,$3,$L91
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

	lui	$4,%hi(sfx2Data) # high
	addiu	$4,$4,%lo(sfx2Data) # low
	sb	$2,0($17)
	sw	$16,4($17)
	lw	$3,976($4)
	move	$2,$17
	addu	$3,$3,$5
	.set	noreorder
	.set	nomacro
	j	$L92
	sw	$3,976($4)
	.set	macro
	.set	reorder

$L91:
	.set	noreorder
	.set	nomacro
	jal	SpuFree
	move	$4,$16
	.set	macro
	.set	reorder

	move	$2,$0
$L92:
	lw	$31,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	sfxDownloadSample
	.text
	.ent	sfxDownloadSampleBank
sfxDownloadSampleBank:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$18,24($sp)
	move	$18,$4
	sw	$31,28($sp)
	sw	$17,20($sp)
	.set	noreorder
	.set	nomacro
	beq	$18,$0,$L94
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	lw	$2,0($18)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L96
	move	$16,$0
	.set	macro
	.set	reorder

	move	$17,$16
$L98:
	lw	$4,8($18)
	.set	noreorder
	.set	nomacro
	jal	sfxDownloadSample
	addu	$4,$4,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L94
	addu	$16,$16,1
	.set	macro
	.set	reorder

	lw	$2,0($18)
	#nop
	sltu	$2,$16,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L98
	addu	$17,$17,20
	.set	macro
	.set	reorder

$L96:
	.set	noreorder
	.set	nomacro
	j	$L101
	move	$2,$18
	.set	macro
	.set	reorder

$L94:
	move	$2,$0
$L101:
	lw	$31,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	sfxDownloadSampleBank
	.text
	.ent	sfxDestroySampleBank
sfxDestroySampleBank:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	.set	noreorder
	.set	nomacro
	beq	$16,$0,$L104
	sw	$31,20($sp)
	.set	macro
	.set	reorder

	lw	$4,12($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L104
	lui	$5,%hi($LC1) # high
	.set	macro
	.set	reorder

	addiu	$5,$5,%lo($LC1) # low
	.set	noreorder
	.set	nomacro
	jal	memoryFree
	li	$6,471			# 0x000001d7
	.set	macro
	.set	reorder

	sw	$0,12($16)
	.set	noreorder
	.set	nomacro
	j	$L106
	move	$2,$16
	.set	macro
	.set	reorder

$L104:
	move	$2,$0
$L106:
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	sfxDestroySampleBank
	.text
	.ent	sfxUnloadSample
sfxUnloadSample:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	sw	$31,20($sp)
	lbu	$2,0($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L108
	move	$2,$0
	.set	macro
	.set	reorder

	lw	$4,4($16)
	jal	SpuFree
	lui	$3,%hi(sfx2Data) # high
	addiu	$3,$3,%lo(sfx2Data) # low
	lw	$4,976($3)
	lw	$5,12($16)
	move	$2,$16
	subu	$4,$4,$5
	sw	$4,976($3)
	sb	$0,0($16)
	sw	$0,4($16)
$L108:
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	sfxUnloadSample
	.text
	.ent	sfxUnloadSampleBank
sfxUnloadSampleBank:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$18,24($sp)
	move	$18,$4
	sw	$31,28($sp)
	sw	$17,20($sp)
	.set	noreorder
	.set	nomacro
	beq	$18,$0,$L111
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	lw	$2,0($18)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L113
	move	$17,$0
	.set	macro
	.set	reorder

	move	$16,$0
$L115:
	lw	$4,8($18)
	addu	$17,$17,1
	.set	noreorder
	.set	nomacro
	jal	sfxUnloadSample
	addu	$4,$4,$16
	.set	macro
	.set	reorder

	lw	$3,0($18)
	#nop
	sltu	$3,$17,$3
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L115
	addu	$16,$16,20
	.set	macro
	.set	reorder

$L113:
	.set	noreorder
	.set	nomacro
	j	$L117
	move	$2,$18
	.set	macro
	.set	reorder

$L111:
	move	$2,$0
$L117:
	lw	$31,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	sfxUnloadSampleBank
	.text
	.ent	sfxRemoveSampleBank
sfxRemoveSampleBank:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$0
	move	$6,$0
	lui	$2,%hi(sfx2Data) # high
	addiu	$3,$2,%lo(sfx2Data) # low
	sw	$31,20($sp)
$L122:
	lw	$2,0($3)
	#nop
	bne	$2,$4,$L121
	sw	$0,0($3)
	li	$16,1			# 0x00000001
$L121:
	addu	$6,$6,1
	slt	$2,$6,16
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L122
	addu	$3,$3,4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$5,$0,$L125
	lui	$5,%hi($LC1) # high
	.set	macro
	.set	reorder

	addiu	$5,$5,%lo($LC1) # low
	.set	noreorder
	.set	nomacro
	jal	memoryFree
	li	$6,555			# 0x0000022b
	.set	macro
	.set	reorder

$L125:
	move	$2,$16
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	sfxRemoveSampleBank
	.text
	.ent	sfxOn
sfxOn:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	jal	SpuSetMute
	move	$4,$0
	.set	macro
	.set	reorder

	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	sfxOn
	.text
	.ent	sfxOff
sfxOff:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	jal	SpuSetMute
	li	$4,1			# 0x00000001
	.set	macro
	.set	reorder

	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	sfxOff
	.text
	.ent	sfxStartSound
sfxStartSound:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	SpuStart
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	sfxStartSound
	.text
	.ent	sfxStopSound
sfxStopSound:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	SpuQuit
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	sfxStopSound
	.text
	.ent	sfxSetGlobalVolume
sfxSetGlobalVolume:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$2,%hi(sfx2Data+872) # high
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$4,%lo(sfx2Data+872)($2)
	.set	macro
	.set	reorder

	.end	sfxSetGlobalVolume
	.text
	.ent	sfxSetReverb
sfxSetReverb:
	.frame	$sp,48,$31		# vars= 24, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	lui	$2,%hi(sfx2Data+876) # high
	lw	$3,%lo(sfx2Data+876)($2)
	move	$6,$4
	sw	$16,40($sp)
	move	$16,$5
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L132
	sw	$31,44($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L133
	move	$2,$0
	.set	macro
	.set	reorder

$L132:
	addu	$4,$sp,16
	li	$2,25			# 0x00000019
	sw	$2,16($sp)
	sw	$3,20($sp)
	sw	$6,28($sp)
	.set	noreorder
	.set	nomacro
	jal	SpuSetReverbModeParam
	sw	$6,32($sp)
	.set	macro
	.set	reorder

	addu	$4,$sp,16
	sll	$2,$16,7
	sw	$0,16($sp)
	sh	$2,24($sp)
	.set	noreorder
	.set	nomacro
	jal	SpuSetReverbDepth
	sh	$2,26($sp)
	.set	macro
	.set	reorder

	li	$2,1			# 0x00000001
$L133:
	lw	$31,44($sp)
	lw	$16,40($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,48
	.set	macro
	.set	reorder

	.end	sfxSetReverb
	.text
	.ent	sfxPlaySample
sfxPlaySample:
	.frame	$sp,56,$31		# vars= 0, regs= 10/0, args= 16, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,64
	sw	$20,40($sp)
	move	$20,$4
	sw	$19,36($sp)
	move	$19,$5
	sw	$21,44($sp)
	move	$21,$6
	sw	$31,60($sp)
	sw	$fp,56($sp)
	sw	$23,52($sp)
	sw	$22,48($sp)
	sw	$18,32($sp)
	sw	$17,28($sp)
	sw	$16,24($sp)
	lbu	$2,0($20)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L153
	move	$23,$7
	.set	macro
	.set	reorder

	lui	$3,0x2f8d # high
	ori	$3,$3,0xf18f
	sll	$4,$23,12
	mult	$4,$3
	move	$16,$0
	li	$22,1
	sra	$4,$4,31
	
	sw $4,16($sp)
	lui	$2,%hi(sfx2Data) # high
	addiu	$17,$2,%lo(sfx2Data) # low
	addiu	$18,$17,880
	mfhi	$3
	sra	$fp,$3,13
$L139:
	.set	noreorder
	.set	nomacro
	jal	SpuGetKeyStatus
	sll	$4,$22,$16
	.set	macro
	.set	reorder

	beq	$2,$22,$L138
	#nop
	.set	noreorder
	.set	nomacro
	beq	$19,$0,$L141
	move	$5,$0
	.set	macro
	.set	reorder

	lw	$2,872($17)
	#nop
	mult	$19,$2
	mflo	$3
	bgez	$3,$L142
	#nop
	addu	$3,$3,255
$L142:
	sra	$3,$3,8
	sll	$2,$3,14
	subu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bgez	$2,$L144
	sra	$5,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	sra	$5,$2,8
$L141:
$L144:
	.set	noreorder
	.set	nomacro
	beq	$21,$0,$L148
	move	$2,$0
	.set	macro
	.set	reorder

	lw	$2,872($17)
	#nop
	mult	$21,$2
	mflo	$3
	bgez	$3,$L145
	#nop
	addu	$3,$3,255
$L145:
	sra	$3,$3,8
$L146:
	sll	$2,$3,14
	subu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bgez	$2,$L147
	nop
	.set	macro
	.set	reorder

	addu	$2,$2,255
$L147:
	sra	$2,$2,8
$L148:
	.set	noreorder
	.set	nomacro
	beq	$23,$0,$L149
	nop
	.set	macro
	.set	reorder
	
	lw	$8,16($sp)
	.set	noreorder
	.set	nomacro
	j	$L150
	subu	$17,$fp,$8
	.set	macro
	.set	reorder

$L149:
	lhu	$17,2($20)
$L150:
	move	$4,$16
	sll	$5,$5,16
	sra	$5,$5,16
	sll	$6,$2,16
	.set	noreorder
	.set	nomacro
	jal	SpuSetVoiceVolume
	sra	$6,$6,16
	.set	macro
	.set	reorder

	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	SpuSetVoicePitch
	andi	$5,$17,0xffff
	.set	macro
	.set	reorder

	lw	$5,4($20)
	.set	noreorder
	.set	nomacro
	jal	SpuSetVoiceStartAddr
	move	$4,$16
	.set	macro
	.set	reorder

	li	$4,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	jal	SpuSetKey
	sll	$5,$22,$16
	.set	macro
	.set	reorder

	move	$2,$16
	.set	noreorder
	.set	nomacro
	j	$L152
	sw	$20,0($18)
	.set	macro
	.set	reorder

$L138:
	addu	$16,$16,1
	slt	$2,$16,24
	
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L139
	addiu	$18,$18,4
	.set	macro
	.set	reorder
$L153:
	li	$2,-1			# 0xffffffff
$L152:
	lw	$31,60($sp)
	lw	$fp,56($sp)
	lw	$23,52($sp)
	lw	$22,48($sp)
	lw	$21,44($sp)
	lw	$20,40($sp)
	lw	$19,36($sp)
	lw	$18,32($sp)
	lw	$17,28($sp)
	lw	$16,24($sp)

	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,64
	.set	macro
	.set	reorder

	.end	sfxPlaySample
	.text
	.ent	sfxStopSample
sfxStopSample:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$18,24($sp)
	move	$18,$4
	move	$4,$5
	sltu	$2,$4,24
	sw	$31,28($sp)
	sw	$17,20($sp)
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L155
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	lui	$2,%hi(sfx2Data) # high
	addiu	$2,$2,%lo(sfx2Data) # low
	sll	$3,$4,2
	addu	$3,$3,$2
	lw	$2,880($3)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$18,$L165
	move	$2,$0
	.set	macro
	.set	reorder

	jal	sfxStopChannel
	.set	noreorder
	.set	nomacro
	j	$L165
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

$L155:
	li	$2,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	bne	$4,$2,$L157
	move	$2,$0
	.set	macro
	.set	reorder

	move	$3,$0
	move	$16,$3
	lui	$2,%hi(sfx2Data) # high
	addiu	$17,$2,%lo(sfx2Data) # low
$L162:
	lw	$2,880($17)
	#nop
	bne	$2,$18,$L161
	.set	noreorder
	.set	nomacro
	jal	sfxStopChannel
	move	$4,$16
	.set	macro
	.set	reorder

	li	$3,1			# 0x00000001
$L161:
	addu	$16,$16,1
	slt	$2,$16,24
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L162
	addu	$17,$17,4
	.set	macro
	.set	reorder

	move	$2,$3
$L157:
$L165:
	lw	$31,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	sfxStopSample
	.text
	.ent	sfxStopChannel
sfxStopChannel:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$4
	li	$2,-1			# 0xffffffff
	sw	$31,24($sp)
	.set	noreorder
	.set	nomacro
	bne	$16,$2,$L167
	sw	$17,20($sp)
	.set	macro
	.set	reorder

	move	$16,$0
	li	$17,1			# 0x00000001
	move	$4,$0
$L174:
	.set	noreorder
	.set	nomacro
	jal	SpuSetKey
	sll	$5,$17,$16
	.set	macro
	.set	reorder

	move	$4,$16
	move	$5,$0
	.set	noreorder
	.set	nomacro
	jal	SpuSetVoiceVolume
	move	$6,$0
	.set	macro
	.set	reorder

	addu	$16,$16,1
	slt	$2,$16,24
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L174
	move	$4,$0
	.set	macro
	.set	reorder

	j	$L173
$L167:
	move	$4,$0
	li	$5,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	jal	SpuSetKey
	sll	$5,$5,$16
	.set	macro
	.set	reorder

	move	$4,$16
	move	$5,$0
	.set	noreorder
	.set	nomacro
	jal	SpuSetVoiceVolume
	move	$6,$0
	.set	macro
	.set	reorder

$L173:
	lw	$31,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	sfxStopChannel
	.text
	.ent	sfxGetSampleStatus
sfxGetSampleStatus:
	.frame	$sp,48,$31		# vars= 0, regs= 7/0, args= 16, extra= 0
	.mask	0x803f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	sw	$21,36($sp)
	move	$21,$4
	sw	$19,28($sp)
	move	$19,$0
	sw	$17,20($sp)
	move	$17,$19
	sw	$20,32($sp)
	li	$20,1			# 0x00000001
	lui	$2,%hi(sfx2Data) # high
	sw	$18,24($sp)
	addiu	$18,$2,%lo(sfx2Data) # low
	sw	$31,40($sp)
	sw	$16,16($sp)
$L179:
	lw	$2,880($18)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$21,$L178
	sll	$16,$20,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	SpuGetKeyStatus
	move	$4,$16
	.set	macro
	.set	reorder

	bne	$2,$20,$L178
	or	$19,$19,$16
$L178:
	addu	$17,$17,1
	slt	$2,$17,24
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L179
	addu	$18,$18,4
	.set	macro
	.set	reorder

	move	$2,$19
	lw	$31,40($sp)
	lw	$21,36($sp)
	lw	$20,32($sp)
	lw	$19,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,48
	.set	macro
	.set	reorder

	.end	sfxGetSampleStatus
	.text
	.ent	sfxGetChannelStatus
sfxGetChannelStatus:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	move	$17,$4
	sltu	$2,$17,24
	sw	$31,24($sp)
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L184
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	li	$16,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	jal	SpuGetKeyStatus
	sll	$4,$16,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$16,$L186
	move	$2,$0
	.set	macro
	.set	reorder

	lui	$3,%hi(sfx2Data) # high
	addiu	$3,$3,%lo(sfx2Data) # low
	sll	$2,$17,2
	addu	$2,$2,$3
	lw	$2,880($2)
	j	$L186
$L184:
	move	$2,$0
$L186:
	lw	$31,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	sfxGetChannelStatus
	.text
	.ent	sfxSetChannelReverb
sfxSetChannelReverb:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	move	$3,$4
	sltu	$2,$3,24
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L188
	sw	$31,16($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$5,$0,$L189
	move	$4,$0
	.set	macro
	.set	reorder

	li	$4,1			# 0x00000001
$L189:
	li	$5,1			# 0x00000001
	.set	noreorder
	.set	nomacro
	jal	SpuSetReverbVoice
	sll	$5,$5,$3
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L191
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

$L188:
	move	$2,$0
$L191:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	sfxSetChannelReverb
	.text
	.ent	sfxGetChannelReverb
sfxGetChannelReverb:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$16,16($sp)
	move	$16,$4
	sltu	$2,$16,24
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L194
	sw	$31,20($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L197
	li	$2,-1			# 0xffffffff
	.set	macro
	.set	reorder

$L194:
	jal	SpuGetReverbVoice
	li	$3,1			# 0x00000001
	sll	$3,$3,$16
	and	$2,$2,$3
	sltu	$2,$0,$2
$L197:
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	sfxGetChannelReverb
	.text
	.ent	sfxSetChannelPitch
sfxSetChannelPitch:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sltu	$2,$4,24
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L198
	sw	$31,16($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$5,$0,$L200
	li	$2,797769728			# 0x2f8d0000
	.set	macro
	.set	reorder

	ori	$2,$2,0xf18f
	sll	$3,$5,12
	mult	$3,$2
	sra	$3,$3,31
	mfhi	$2
	sra	$2,$2,13
	.set	noreorder
	.set	nomacro
	j	$L201
	subu	$2,$2,$3
	.set	macro
	.set	reorder

$L200:
	move	$2,$0
$L201:
	.set	noreorder
	.set	nomacro
	jal	SpuSetVoicePitch
	andi	$5,$2,0xffff
	.set	macro
	.set	reorder

$L198:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	sfxSetChannelPitch
	.text
	.ent	sfxSetChannelVolume
sfxSetChannelVolume:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sltu	$2,$4,24
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L202
	sw	$31,16($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$5,$0,$L204
	lui	$2,%hi(sfx2Data+872) # high
	.set	macro
	.set	reorder

	lw	$3,%lo(sfx2Data+872)($2)
	#nop
	mult	$5,$3
	mflo	$3
	#nop
	#nop
	bgez	$3,$L205
	addu	$3,$3,255
$L205:
	sra	$3,$3,8
	sll	$2,$3,14
	subu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	bgez	$2,$L207
	sra	$5,$2,8
	.set	macro
	.set	reorder

	addu	$2,$2,255
	.set	noreorder
	.set	nomacro
	j	$L207
	sra	$5,$2,8
	.set	macro
	.set	reorder

$L204:
	move	$5,$0
$L207:
	.set	noreorder
	.set	nomacro
	beq	$6,$0,$L208
	lui	$2,%hi(sfx2Data+872) # high
	.set	macro
	.set	reorder

	lw	$3,%lo(sfx2Data+872)($2)
	#nop
	mult	$6,$3
	mflo	$3
	#nop
	#nop
	bgez	$3,$L209
	addu	$3,$3,255
$L209:
	sra	$3,$3,8
	sll	$2,$3,14
	subu	$2,$2,$3
	bgez	$2,$L210
	addu	$2,$2,255
$L210:
	.set	noreorder
	.set	nomacro
	j	$L211
	sra	$2,$2,8
	.set	macro
	.set	reorder

$L208:
	move	$2,$0
$L211:
	sll	$5,$5,16
	sll	$6,$2,16
	sra	$5,$5,16
	.set	noreorder
	.set	nomacro
	jal	SpuSetVoiceVolume
	sra	$6,$6,16
	.set	macro
	.set	reorder

$L202:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	sfxSetChannelVolume
	.text
	.ent	sfxSetSampleVolume
sfxSetSampleVolume:
	.frame	$sp,48,$31		# vars= 0, regs= 7/0, args= 16, extra= 0
	.mask	0x803f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,48
	sw	$19,28($sp)
	move	$19,$4
	sw	$18,24($sp)
	move	$18,$5
	sw	$20,32($sp)
	move	$20,$6
	sw	$21,36($sp)
	move	$21,$7
	sltu	$2,$18,24
	sw	$31,40($sp)
	sw	$17,20($sp)
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L213
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	lui	$2,%hi(sfx2Data) # high
	addiu	$2,$2,%lo(sfx2Data) # low
	sll	$3,$18,2
	addu	$3,$3,$2
	lw	$2,880($3)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$19,$L223
	move	$2,$0
	.set	macro
	.set	reorder

	move	$4,$18
	move	$5,$20
	.set	noreorder
	.set	nomacro
	jal	sfxSetChannelVolume
	move	$6,$21
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L223
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

$L213:
	li	$2,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	bne	$18,$2,$L215
	move	$2,$0
	.set	macro
	.set	reorder

	move	$3,$0
	move	$17,$3
	lui	$2,%hi(sfx2Data) # high
	addiu	$16,$2,%lo(sfx2Data) # low
$L220:
	lw	$2,880($16)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$19,$L219
	move	$4,$18
	.set	macro
	.set	reorder

	move	$5,$20
	.set	noreorder
	.set	nomacro
	jal	sfxSetChannelVolume
	move	$6,$21
	.set	macro
	.set	reorder

	li	$3,1			# 0x00000001
$L219:
	addu	$17,$17,1
	slt	$2,$17,24
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L220
	addu	$16,$16,4
	.set	macro
	.set	reorder

	move	$2,$3
$L215:
$L223:
	lw	$31,40($sp)
	lw	$21,36($sp)
	lw	$20,32($sp)
	lw	$19,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,48
	.set	macro
	.set	reorder

	.end	sfxSetSampleVolume
	.text
	.ent	sfxSetSamplePitch
sfxSetSamplePitch:
	.frame	$sp,40,$31		# vars= 0, regs= 6/0, args= 16, extra= 0
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$19,28($sp)
	move	$19,$4
	sw	$18,24($sp)
	move	$18,$5
	sw	$20,32($sp)
	move	$20,$6
	sltu	$2,$18,24
	sw	$31,36($sp)
	sw	$17,20($sp)
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L225
	sw	$16,16($sp)
	.set	macro
	.set	reorder

	lui	$2,%hi(sfx2Data) # high
	addiu	$2,$2,%lo(sfx2Data) # low
	sll	$3,$18,2
	addu	$3,$3,$2
	lw	$2,880($3)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$19,$L235
	move	$2,$0
	.set	macro
	.set	reorder

	move	$4,$18
	.set	noreorder
	.set	nomacro
	jal	sfxSetChannelPitch
	move	$5,$20
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L235
	li	$2,1			# 0x00000001
	.set	macro
	.set	reorder

$L225:
	li	$2,-1			# 0xffffffff
	.set	noreorder
	.set	nomacro
	bne	$18,$2,$L227
	move	$2,$0
	.set	macro
	.set	reorder

	move	$3,$0
	move	$17,$3
	lui	$2,%hi(sfx2Data) # high
	addiu	$16,$2,%lo(sfx2Data) # low
$L232:
	lw	$2,880($16)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$19,$L231
	move	$4,$18
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	sfxSetChannelPitch
	move	$5,$20
	.set	macro
	.set	reorder

	li	$3,1			# 0x00000001
$L231:
	addu	$17,$17,1
	slt	$2,$17,24
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L232
	addu	$16,$16,4
	.set	macro
	.set	reorder

	move	$2,$3
$L227:
$L235:
	lw	$31,36($sp)
	lw	$20,32($sp)
	lw	$19,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,40
	.set	macro
	.set	reorder

	.end	sfxSetSamplePitch
	.text
	.ent	sfxGetFreeSoundMemory
sfxGetFreeSoundMemory:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$16,16($sp)
	lui	$16,%hi(sfx2Data) # high
	addiu	$2,$16,%lo(sfx2Data)($2)
	sw	$31,28($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	lw	$4,876($2)
	#nop
	sltu	$3,$4,10
	
	.set	noreorder
	.set	nomacro
	beq	$3,$0,$L237
	move	$18,$0
	.set	macro
	.set	reorder

	lui	$2,%hi($L248) # high
	addiu	$2,$2,%lo($L248) # low
	sll	$3,$4,2
	addu	$3,$3,$2
	lw	$4,0($3)
	#nop
	j	$4
	.rdata
	.align	3
$L248:
	.word	$L238
	.word	$L239
	.word	$L240
	.word	$L241
	.word	$L242
	.word	$L243
	.word	$L244
	.word	$L246
	.word	$L246
	.word	$L247
	.text
$L238:
	.set	noreorder
	.set	nomacro
	j	$L237
	move	$18,$0
	.set	macro
	.set	reorder

$L239:
	.set	noreorder
	.set	nomacro
	j	$L237
	li	$18,9920			# 0x000026c0
	.set	macro
	.set	reorder

$L240:
	.set	noreorder
	.set	nomacro
	j	$L237
	li	$18,8000			# 0x00001f40
	.set	macro
	.set	reorder

$L241:
	.set	noreorder
	.set	nomacro
	j	$L237
	li	$18,18496			# 0x00004840
	.set	macro
	.set	reorder

$L242:
	.set	noreorder
	.set	nomacro
	j	$L237
	li	$18,28640			# 0x00006fe0
	.set	macro
	.set	reorder

$L243:
	.set	noreorder
	.set	nomacro
	j	$L237
	li	$18,44512			# 0x0000ade0
	.set	macro
	.set	reorder

$L244:
	.set	noreorder
	.set	nomacro
	j	$L237
	li	$18,63168			# 0x0000f6c0
	.set	macro
	.set	reorder

$L246:
	li	$18,65536			# 0x00010000
	.set	noreorder
	.set	nomacro
	j	$L237
	ori	$18,$18,0x8040
	.set	macro
	.set	reorder

$L247:
	li	$18,15360			# 0x00003c00
$L237:
	lui	$4,%hi($LC3) # high
	addiu	$16,$16,%lo(sfx2Data) # low
	addiu	$4,$4,%lo($LC3) # low
	lw	$5,976($16)
	lui	$17,8
	.set	noreorder
	.set	nomacro
	jal	printf
	subu	$6,$17,$5
	.set	macro
	.set	reorder

	lui	$4,%hi($LC4) # high
	lw	$5,976($16)
	addiu	$4,$4,%lo($LC4) # low
	subu	$5,$5,$18
	.set	noreorder
	.set	nomacro
	jal	printf
	addu	$5,$5,-4112
	.set	macro
	.set	reorder

	lui	$4,%hi($LC5) # high
	addiu	$4,$4,%lo($LC5) # low
	.set	noreorder
	.set	nomacro
	jal	printf
	move	$5,$18
	.set	macro
	.set	reorder

	lw	$2,976($16)
	lw	$31,28($sp)
	lw	$18,24($sp)
	lw	$16,16($sp)
	subu	$2,$17,$2
	lw	$17,20($sp)

	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	sfxGetFreeSoundMemory
