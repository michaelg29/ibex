	.file	"hello_test.c"
	.option nopic
	.attribute arch, "rv32i2p0_m2p0_c2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
.Ltext0:
	.cfi_sections	.debug_frame
	.align	1
	.globl	mul1
	.hidden	mul1
	.type	mul1, @function
mul1:
.LFB3:
	.file 1 "hello_test.c"
	.loc 1 14 29
	.cfi_startproc
.LVL0:
	.loc 1 15 5
	.loc 1 15 25 is_stmt 0
	li	t0,7
	.loc 1 15 14
	slli	a5,a1,2
	.loc 1 15 25
	mul	a1,a1,t0
.LVL1:
	.loc 1 15 14
	add	a0,a0,a5
.LVL2:
	.loc 1 15 18
	addi	t1,a1,1
	.loc 1 15 14
	sw	t1,0(a0)
	.loc 1 16 1
	ret
	.cfi_endproc
.LFE3:
	.size	mul1, .-mul1
	.align	1
	.globl	mul2
	.hidden	mul2
	.type	mul2, @function
mul2:
.LFB4:
	.loc 1 17 29 is_stmt 1
	.cfi_startproc
.LVL3:
	.loc 1 18 5
	.loc 1 18 25 is_stmt 0
	li	t0,3
	.loc 1 18 14
	slli	a5,a1,2
	.loc 1 18 25
	mul	a1,a1,t0
.LVL4:
	.loc 1 18 14
	add	a0,a0,a5
.LVL5:
	.loc 1 18 18
	addi	t1,a1,1
	.loc 1 18 14
	sw	t1,0(a0)
	.loc 1 19 1
	ret
	.cfi_endproc
.LFE4:
	.size	mul2, .-mul2
	.align	1
	.globl	printLog
	.hidden	printLog
	.type	printLog, @function
printLog:
.LFB5:
	.loc 1 21 25 is_stmt 1
	.cfi_startproc
.LVL6:
	.loc 1 22 3
	.loc 1 23 3
	.loc 1 24 3
	.loc 1 25 3
	.loc 1 26 3
	.loc 1 27 3
	.loc 1 21 25 is_stmt 0
	addi	sp,sp,-48
	.cfi_def_cfa_offset 48
	.loc 1 25 9
	li	a5,4096
	.loc 1 21 25
	sw	ra,44(sp)
	.cfi_offset 1, -4
	.loc 1 25 9
	addi	ra,a5,-1467
	sh	ra,0(sp)
	.loc 1 27 9
	sb	zero,2(sp)
	.loc 1 28 3 is_stmt 1
	.loc 1 28 6 is_stmt 0
	beq	a0,zero,.L4
	mv	a5,sp
	.loc 1 24 5
	li	a7,0
	.loc 1 30 21
	li	t4,10
.LVL7:
.L5:
	.loc 1 29 11 is_stmt 1
	.loc 1 32 8 is_stmt 0
	addi	a6,a7,1
	.loc 1 29 11
	bgt	a0,zero,.L6
	add	a2,sp,a7
.LBB13:
	.loc 1 35 14
	li	t3,0
.LVL8:
.L7:
	.loc 1 35 21 is_stmt 1 discriminator 1
	.loc 1 35 5 is_stmt 0 discriminator 1
	addi	a2,a2,-1
	bne	a7,t3,.L8
.LBE13:
	.loc 1 39 5 is_stmt 1
	.loc 1 39 11 is_stmt 0
	addi	a3,sp,32
	add	t0,a3,a7
	li	t1,10
	.loc 1 41 11
	addi	t2,sp,32
	.loc 1 39 11
	sb	t1,-32(t0)
	.loc 1 40 5 is_stmt 1
	.loc 1 41 5
	.loc 1 41 11 is_stmt 0
	add	a4,t2,a6
	sb	zero,-32(a4)
.L4:
	.loc 1 43 3 is_stmt 1
	mv	a0,sp
	call	puts
.LVL9:
	.loc 1 44 1 is_stmt 0
	lw	ra,44(sp)
	.cfi_remember_state
	.cfi_restore 1
	addi	sp,sp,48
	.cfi_def_cfa_offset 0
	jr	ra
.LVL10:
.L6:
	.cfi_restore_state
	.loc 1 30 7 is_stmt 1
	.loc 1 30 21 is_stmt 0
	rem	t5,a0,t4
	addi	a5,a5,1
	.loc 1 32 8
	mv	a7,a6
	.loc 1 30 26
	addi	t6,t5,48
	.loc 1 30 13
	sb	t6,-1(a5)
	.loc 1 31 7 is_stmt 1
	.loc 1 31 13 is_stmt 0
	div	a0,a0,t4
.LVL11:
	.loc 1 32 7 is_stmt 1
	j	.L5
.LVL12:
.L8:
.LBB14:
	.loc 1 36 7 discriminator 3
	.loc 1 36 17 is_stmt 0 discriminator 3
	lbu	a0,0(a2)
	.loc 1 36 13 discriminator 3
	add	a1,sp,t3
	.loc 1 35 29 discriminator 3
	addi	t3,t3,1
	.loc 1 36 13 discriminator 3
	sb	a0,0(a1)
	.loc 1 35 28 is_stmt 1 discriminator 3
	j	.L7
.LBE14:
	.cfi_endproc
.LFE5:
	.size	printLog, .-printLog
	.section	.text.startup,"ax",@progbits
	.align	1
	.globl	main
	.hidden	main
	.type	main, @function
main:
.LFB6:
	.loc 1 46 33
	.cfi_startproc
.LVL13:
	.loc 1 47 3
	.loc 1 46 33 is_stmt 0
	addi	sp,sp,-48
	.cfi_def_cfa_offset 48
	li	t1,-8192
	sw	ra,44(sp)
	.cfi_offset 1, -4
	addi	ra,t1,208
	sw	s0,40(sp)
	sw	s1,36(sp)
	sw	s2,32(sp)
	sw	s3,28(sp)
	sw	s4,24(sp)
	sw	s5,20(sp)
	.loc 1 47 3
	li	a0,2000
.LVL14:
	.loc 1 46 33
	add	sp,sp,ra
	.cfi_def_cfa_offset 8032
	.cfi_offset 8, -8
	.cfi_offset 9, -12
	.cfi_offset 18, -16
	.cfi_offset 19, -20
	.cfi_offset 20, -24
	.cfi_offset 21, -28
	.loc 1 47 3
	li	a1,0
.LVL15:
	call	timer_enable
.LVL16:
	.loc 1 50 3 is_stmt 1
	.loc 1 50 32 is_stmt 0
	call	get_elapsed_time
.LVL17:
	.loc 1 52 3 is_stmt 1
.LBB15:
.LBB16:
	.file 2 "/home/prpate/ibex/ibex/examples/sw/simple_system/common/simple_system_common.h"
	.loc 2 53 3
	.loc 2 60 3
	li	a5,-1
 #APP
# 60 "/home/prpate/ibex/ibex/examples/sw/simple_system/common/simple_system_common.h" 1
	csrw  0x320, a5

# 0 "" 2
.LVL18:
 #NO_APP
.LBE16:
.LBE15:
	.loc 1 53 3
	call	pcount_reset
.LVL19:
	.loc 1 54 3
.LBB17:
.LBB18:
	.loc 2 53 3
	.loc 2 60 3
	li	t0,0
 #APP
# 60 "/home/prpate/ibex/ibex/examples/sw/simple_system/common/simple_system_common.h" 1
	csrw  0x320, t0

# 0 "" 2
.LVL20:
 #NO_APP
.LBE18:
.LBE17:
	.loc 1 55 3
	.loc 1 56 3
	.loc 1 57 3
	.loc 1 58 3
	.loc 1 59 3
	.loc 1 63 3
	.loc 1 65 3
.LBB21:
	.loc 1 65 8
	.loc 1 65 19
	.loc 1 71 7 is_stmt 0
	li	a4,8192
	li	s1,-4096
	.loc 1 67 7
	li	s2,-8192
	.loc 1 71 7
	addi	a0,a4,-192
	.loc 1 67 7
	addi	a3,a4,-192
	.loc 1 71 7
	addi	t2,s1,96
	add	a1,a0,sp
	.loc 1 67 7
	addi	a2,s2,192
	add	a6,a3,sp
	.loc 1 65 12
	li	s0,0
.LBE21:
	.loc 1 63 7
	li	s3,0
.LBB22:
.LBB19:
	.loc 2 60 3
	li	s5,3
.LBE19:
.LBE22:
.LBB23:
	.loc 1 71 7
	add	s1,a1,t2
	.loc 1 67 7
	add	s2,a6,a2
	.loc 1 65 3
	li	s4,1000
.LVL21:
.L16:
	.loc 1 66 5 is_stmt 1
.LBE23:
.LBB24:
.LBB20:
	.loc 2 60 3 is_stmt 0
	rem	a7,s0,s5
.LBE20:
.LBE24:
.LBB25:
	.loc 1 67 7
	mv	a1,s0
	.loc 1 66 7
	beq	a7,zero,.L14
	.loc 1 66 12 discriminator 1
	beq	s3,zero,.L14
	.loc 1 67 7 is_stmt 1
	mv	a0,s2
	call	mul1
.LVL22:
.L15:
	.loc 1 74 5 discriminator 2
	.loc 1 65 36 is_stmt 0 discriminator 2
	addi	s0,s0,1
.LVL23:
	.loc 1 74 9 discriminator 2
	xori	s3,s3,1
.LVL24:
	.loc 1 65 36 is_stmt 1 discriminator 2
	.loc 1 65 19 discriminator 2
	.loc 1 65 3 is_stmt 0 discriminator 2
	bne	s0,s4,.L16
.LBE25:
.LBB26:
.LBB27:
.LBB28:
.LBB29:
	.loc 1 127 25
	li	t5,8192
	li	t3,-8192
	addi	t6,t5,-192
	.loc 1 127 35
	li	ra,-4096
	addi	a5,t5,-192
	.loc 1 127 25
	addi	t4,t3,192
	add	t1,t6,sp
	.loc 1 127 35
	addi	t0,ra,96
	add	t2,a5,sp
.LBE29:
	.loc 1 126 7
	li	a4,4096
.LBE28:
.LBE27:
.LBE26:
.LBB40:
	li	s4,0
.LBE40:
.LBB41:
.LBB38:
.LBB36:
.LBB30:
	.loc 1 127 25
	add	s5,t1,t4
	.loc 1 127 35
	add	s1,t2,t0
.LBE30:
	.loc 1 126 7
	addi	s2,a4,-96
.L18:
.LBB31:
	.loc 1 127 9 is_stmt 1
	.loc 1 127 25 is_stmt 0
	add	a0,s5,s4
	.loc 1 127 35
	add	a1,s1,s4
	.loc 1 127 29
	lw	a2,0(a0)
	lw	a3,0(a1)
	mul	a0,a2,a3
	.loc 1 128 9 is_stmt 1
.LVL25:
	.loc 1 129 9
	.loc 1 133 9
	.loc 1 133 12 is_stmt 0
	bne	a0,zero,.L17
.LVL26:
.L20:
.LBE31:
	.loc 1 126 40 is_stmt 1
	.loc 1 126 23
	.loc 1 126 7 is_stmt 0
	addi	s4,s4,4
	bne	s4,s2,.L18
.LBB32:
	.loc 1 127 25
	li	s3,8192
.LVL27:
	li	a6,-8192
	addi	t3,s3,-192
	.loc 1 127 35
	li	t5,-4096
	addi	t1,s3,-192
	.loc 1 127 25
	addi	a7,a6,192
	add	t4,t3,sp
	.loc 1 127 35
	addi	t6,t5,96
	add	ra,t1,sp
.LBE32:
	.loc 1 126 7
	li	t0,4096
	li	s0,0
.LVL28:
.LBB33:
	.loc 1 127 25
	add	s5,t4,a7
	.loc 1 127 35
	add	s1,ra,t6
.LBE33:
	.loc 1 126 7
	addi	s2,t0,-96
.L19:
.LBB34:
	.loc 1 127 9 is_stmt 1
	.loc 1 127 25 is_stmt 0
	add	t2,s5,s0
	.loc 1 127 35
	add	a5,s1,s0
	.loc 1 127 29
	lw	a4,0(t2)
	lw	a0,0(a5)
	mul	a0,a4,a0
	.loc 1 128 9 is_stmt 1
.LVL29:
	.loc 1 129 9
	.loc 1 133 9
	.loc 1 133 12 is_stmt 0
	bne	a0,zero,.L21
.LVL30:
.L23:
.LBE34:
	.loc 1 126 40 is_stmt 1
	.loc 1 126 23
	.loc 1 126 7 is_stmt 0
	addi	s0,s0,4
	bne	s0,s2,.L19
.LBE36:
.LBE38:
	.loc 1 104 30 is_stmt 1
.LVL31:
	.loc 1 104 19
.LBE41:
	.loc 1 197 3
.LBB42:
.LBB43:
	.loc 2 53 3
	.loc 2 60 3
	li	a1,-1
 #APP
# 60 "/home/prpate/ibex/ibex/examples/sw/simple_system/common/simple_system_common.h" 1
	csrw  0x320, a1

# 0 "" 2
.LVL32:
 #NO_APP
.LBE43:
.LBE42:
	.loc 1 198 3
 #APP
# 198 "hello_test.c" 1
	wfi
# 0 "" 2
	.loc 1 199 3
	.loc 1 200 1 is_stmt 0
 #NO_APP
	li	a2,8192
	addi	a3,a2,-208
	add	sp,sp,a3
	.cfi_remember_state
	.cfi_def_cfa_offset 48
	lw	ra,44(sp)
	.cfi_restore 1
	lw	s0,40(sp)
	.cfi_restore 8
	lw	s1,36(sp)
	.cfi_restore 9
	lw	s2,32(sp)
	.cfi_restore 18
	lw	s3,28(sp)
	.cfi_restore 19
	lw	s4,24(sp)
	.cfi_restore 20
	lw	s5,20(sp)
	.cfi_restore 21
	li	a0,0
	addi	sp,sp,48
	.cfi_def_cfa_offset 0
	jr	ra
.LVL33:
.L14:
	.cfi_restore_state
.LBB44:
	.loc 1 71 7 is_stmt 1
	mv	a0,s1
	call	mul2
.LVL34:
	j	.L15
.LVL35:
.L17:
.LBE44:
.LBB45:
.LBB39:
.LBB37:
.LBB35:
	.loc 1 134 11
	call	printLog
.LVL36:
	j	.L20
.LVL37:
.L21:
	.loc 1 134 11
	call	printLog
.LVL38:
	j	.L23
.LBE35:
.LBE37:
.LBE39:
.LBE45:
	.cfi_endproc
.LFE6:
	.size	main, .-main
	.text
.Letext0:
	.file 3 "/home/prpate/.local/lib/gcc/riscv32-unknown-elf/10.2.0/include/stdint-gcc.h"
	.section	.debug_info,"",@progbits
.Ldebug_info0:
	.4byte	0x3ca
	.2byte	0x4
	.4byte	.Ldebug_abbrev0
	.byte	0x4
	.byte	0x1
	.4byte	.LASF26
	.byte	0xc
	.4byte	.LASF27
	.4byte	.LASF28
	.4byte	.Ldebug_ranges0+0xc8
	.4byte	0
	.4byte	.Ldebug_line0
	.byte	0x2
	.byte	0x4
	.byte	0x7
	.4byte	.LASF0
	.byte	0x3
	.byte	0x4
	.byte	0x5
	.string	"int"
	.byte	0x2
	.byte	0x8
	.byte	0x5
	.4byte	.LASF1
	.byte	0x2
	.byte	0x10
	.byte	0x4
	.4byte	.LASF2
	.byte	0x2
	.byte	0x1
	.byte	0x6
	.4byte	.LASF3
	.byte	0x2
	.byte	0x1
	.byte	0x8
	.4byte	.LASF4
	.byte	0x2
	.byte	0x2
	.byte	0x5
	.4byte	.LASF5
	.byte	0x2
	.byte	0x2
	.byte	0x7
	.4byte	.LASF6
	.byte	0x2
	.byte	0x4
	.byte	0x5
	.4byte	.LASF7
	.byte	0x2
	.byte	0x4
	.byte	0x7
	.4byte	.LASF8
	.byte	0x2
	.byte	0x8
	.byte	0x7
	.4byte	.LASF9
	.byte	0x4
	.byte	0x4
	.4byte	0x78
	.byte	0x2
	.byte	0x1
	.byte	0x8
	.4byte	.LASF10
	.byte	0x5
	.4byte	.LASF29
	.byte	0x3
	.byte	0x37
	.byte	0x19
	.4byte	0x6b
	.byte	0x6
	.4byte	.LASF30
	.byte	0x1
	.byte	0x2e
	.byte	0x5
	.4byte	0x2c
	.4byte	.LFB6
	.4byte	.LFE6-.LFB6
	.byte	0x1
	.byte	0x9c
	.4byte	0x265
	.byte	0x7
	.4byte	.LASF11
	.byte	0x1
	.byte	0x2e
	.byte	0xe
	.4byte	0x2c
	.4byte	.LLST6
	.byte	0x7
	.4byte	.LASF12
	.byte	0x1
	.byte	0x2e
	.byte	0x1b
	.4byte	0x265
	.4byte	.LLST7
	.byte	0x8
	.4byte	.LASF15
	.byte	0x1
	.byte	0x32
	.byte	0xc
	.4byte	0x7f
	.byte	0x9
	.4byte	.LASF13
	.byte	0x1
	.byte	0x37
	.byte	0x7
	.4byte	0x26b
	.byte	0x3
	.byte	0x91
	.byte	0xa0,0x41
	.byte	0x9
	.4byte	.LASF14
	.byte	0x1
	.byte	0x38
	.byte	0x7
	.4byte	0x26b
	.byte	0x3
	.byte	0x91
	.byte	0xc0,0x60
	.byte	0x8
	.4byte	.LASF16
	.byte	0x1
	.byte	0x39
	.byte	0x7
	.4byte	0x26b
	.byte	0xa
	.string	"m1"
	.byte	0x1
	.byte	0x3a
	.byte	0x8
	.4byte	0x27c
	.byte	0xa
	.string	"m2"
	.byte	0x1
	.byte	0x3b
	.byte	0x8
	.4byte	0x27c
	.byte	0xb
	.string	"rem"
	.byte	0x1
	.byte	0x3f
	.byte	0x7
	.4byte	0x2c
	.4byte	.LLST8
	.byte	0xc
	.4byte	.Ldebug_ranges0+0x38
	.4byte	0x165
	.byte	0xb
	.string	"i"
	.byte	0x1
	.byte	0x41
	.byte	0xc
	.4byte	0x2c
	.4byte	.LLST11
	.byte	0xd
	.4byte	.LVL22
	.4byte	0x340
	.4byte	0x154
	.byte	0xe
	.byte	0x1
	.byte	0x5a
	.byte	0x2
	.byte	0x82
	.byte	0
	.byte	0xe
	.byte	0x1
	.byte	0x5b
	.byte	0x2
	.byte	0x78
	.byte	0
	.byte	0
	.byte	0xf
	.4byte	.LVL34
	.4byte	0x303
	.byte	0xe
	.byte	0x1
	.byte	0x5a
	.byte	0x2
	.byte	0x79
	.byte	0
	.byte	0
	.byte	0
	.byte	0xc
	.4byte	.Ldebug_ranges0+0x68
	.4byte	0x1d4
	.byte	0xb
	.string	"a"
	.byte	0x1
	.byte	0x68
	.byte	0xc
	.4byte	0x2c
	.4byte	.LLST12
	.byte	0x10
	.4byte	.Ldebug_ranges0+0x68
	.byte	0xb
	.string	"i"
	.byte	0x1
	.byte	0x7c
	.byte	0x9
	.4byte	0x2c
	.4byte	.LLST13
	.byte	0xa
	.string	"st"
	.byte	0x1
	.byte	0x7d
	.byte	0xa
	.4byte	0x28c
	.byte	0x10
	.4byte	.Ldebug_ranges0+0x68
	.byte	0xa
	.string	"j"
	.byte	0x1
	.byte	0x7e
	.byte	0x10
	.4byte	0x2c
	.byte	0x10
	.4byte	.Ldebug_ranges0+0x88
	.byte	0x11
	.4byte	.LASF17
	.byte	0x1
	.byte	0x80
	.byte	0xd
	.4byte	0x2c
	.4byte	.LLST14
	.byte	0x12
	.4byte	.LVL36
	.4byte	0x29c
	.byte	0x12
	.4byte	.LVL38
	.4byte	0x29c
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0x13
	.4byte	0x377
	.4byte	.LBB15
	.4byte	.LBE15-.LBB15
	.byte	0x1
	.byte	0x34
	.byte	0x3
	.4byte	0x1f8
	.byte	0x14
	.4byte	0x384
	.4byte	.LLST9
	.byte	0x15
	.4byte	0x390
	.byte	0x7f
	.byte	0
	.byte	0x16
	.4byte	0x377
	.4byte	.LBB17
	.4byte	.Ldebug_ranges0+0x18
	.byte	0x1
	.byte	0x36
	.byte	0x3
	.4byte	0x222
	.byte	0x14
	.4byte	0x384
	.4byte	.LLST10
	.byte	0x10
	.4byte	.Ldebug_ranges0+0x18
	.byte	0x17
	.4byte	0x390
	.byte	0
	.byte	0
	.byte	0
	.byte	0x13
	.4byte	0x377
	.4byte	.LBB42
	.4byte	.LBE42-.LBB42
	.byte	0x1
	.byte	0xc5
	.byte	0x3
	.4byte	0x249
	.byte	0x14
	.4byte	0x384
	.4byte	.LLST15
	.byte	0x18
	.4byte	0x390
	.4byte	.LLST16
	.byte	0
	.byte	0x12
	.4byte	.LVL16
	.4byte	0x39d
	.byte	0x12
	.4byte	.LVL17
	.4byte	0x3a9
	.byte	0x12
	.4byte	.LVL19
	.4byte	0x3b5
	.byte	0
	.byte	0x4
	.byte	0x4
	.4byte	0x72
	.byte	0x19
	.4byte	0x2c
	.4byte	0x27c
	.byte	0x1a
	.4byte	0x25
	.2byte	0x3e7
	.byte	0
	.byte	0x19
	.4byte	0x78
	.4byte	0x28c
	.byte	0x1b
	.4byte	0x25
	.byte	0x5
	.byte	0
	.byte	0x19
	.4byte	0x78
	.4byte	0x29c
	.byte	0x1b
	.4byte	0x25
	.byte	0x1d
	.byte	0
	.byte	0x1c
	.4byte	.LASF18
	.byte	0x1
	.byte	0x15
	.byte	0x6
	.4byte	.LFB5
	.4byte	.LFE5-.LFB5
	.byte	0x1
	.byte	0x9c
	.4byte	0x303
	.byte	0x7
	.4byte	.LASF17
	.byte	0x1
	.byte	0x15
	.byte	0x13
	.4byte	0x2c
	.4byte	.LLST4
	.byte	0xb
	.string	"i"
	.byte	0x1
	.byte	0x16
	.byte	0x7
	.4byte	0x2c
	.4byte	.LLST5
	.byte	0x1d
	.string	"st"
	.byte	0x1
	.byte	0x17
	.byte	0x8
	.4byte	0x28c
	.byte	0x2
	.byte	0x91
	.byte	0x50
	.byte	0xc
	.4byte	.Ldebug_ranges0+0
	.4byte	0x2f2
	.byte	0xa
	.string	"k"
	.byte	0x1
	.byte	0x23
	.byte	0xe
	.4byte	0x2c
	.byte	0
	.byte	0xf
	.4byte	.LVL9
	.4byte	0x3c1
	.byte	0xe
	.byte	0x1
	.byte	0x5a
	.byte	0x2
	.byte	0x72
	.byte	0
	.byte	0
	.byte	0
	.byte	0x1c
	.4byte	.LASF19
	.byte	0x1
	.byte	0x11
	.byte	0x6
	.4byte	.LFB4
	.4byte	.LFE4-.LFB4
	.byte	0x1
	.byte	0x9c
	.4byte	0x33a
	.byte	0x1e
	.string	"arr"
	.byte	0x1
	.byte	0x11
	.byte	0x10
	.4byte	0x33a
	.4byte	.LLST2
	.byte	0x1e
	.string	"ind"
	.byte	0x1
	.byte	0x11
	.byte	0x19
	.4byte	0x2c
	.4byte	.LLST3
	.byte	0
	.byte	0x4
	.byte	0x4
	.4byte	0x2c
	.byte	0x1c
	.4byte	.LASF20
	.byte	0x1
	.byte	0xe
	.byte	0x6
	.4byte	.LFB3
	.4byte	.LFE3-.LFB3
	.byte	0x1
	.byte	0x9c
	.4byte	0x377
	.byte	0x1e
	.string	"arr"
	.byte	0x1
	.byte	0xe
	.byte	0x10
	.4byte	0x33a
	.4byte	.LLST0
	.byte	0x1e
	.string	"ind"
	.byte	0x1
	.byte	0xe
	.byte	0x19
	.4byte	0x2c
	.4byte	.LLST1
	.byte	0
	.byte	0x1f
	.4byte	.LASF31
	.byte	0x2
	.byte	0x33
	.byte	0x14
	.byte	0x3
	.4byte	0x39d
	.byte	0x20
	.4byte	.LASF32
	.byte	0x2
	.byte	0x33
	.byte	0x26
	.4byte	0x2c
	.byte	0x8
	.4byte	.LASF21
	.byte	0x2
	.byte	0x35
	.byte	0x10
	.4byte	0x25
	.byte	0
	.byte	0x21
	.4byte	.LASF22
	.4byte	.LASF22
	.byte	0x2
	.byte	0x50
	.byte	0x6
	.byte	0x21
	.4byte	.LASF23
	.4byte	.LASF23
	.byte	0x2
	.byte	0x66
	.byte	0xa
	.byte	0x21
	.4byte	.LASF24
	.4byte	.LASF24
	.byte	0x2
	.byte	0x49
	.byte	0x6
	.byte	0x21
	.4byte	.LASF25
	.4byte	.LASF25
	.byte	0x2
	.byte	0x1f
	.byte	0x5
	.byte	0
	.section	.debug_abbrev,"",@progbits
.Ldebug_abbrev0:
	.byte	0x1
	.byte	0x11
	.byte	0x1
	.byte	0x25
	.byte	0xe
	.byte	0x13
	.byte	0xb
	.byte	0x3
	.byte	0xe
	.byte	0x1b
	.byte	0xe
	.byte	0x55
	.byte	0x17
	.byte	0x11
	.byte	0x1
	.byte	0x10
	.byte	0x17
	.byte	0
	.byte	0
	.byte	0x2
	.byte	0x24
	.byte	0
	.byte	0xb
	.byte	0xb
	.byte	0x3e
	.byte	0xb
	.byte	0x3
	.byte	0xe
	.byte	0
	.byte	0
	.byte	0x3
	.byte	0x24
	.byte	0
	.byte	0xb
	.byte	0xb
	.byte	0x3e
	.byte	0xb
	.byte	0x3
	.byte	0x8
	.byte	0
	.byte	0
	.byte	0x4
	.byte	0xf
	.byte	0
	.byte	0xb
	.byte	0xb
	.byte	0x49
	.byte	0x13
	.byte	0
	.byte	0
	.byte	0x5
	.byte	0x16
	.byte	0
	.byte	0x3
	.byte	0xe
	.byte	0x3a
	.byte	0xb
	.byte	0x3b
	.byte	0xb
	.byte	0x39
	.byte	0xb
	.byte	0x49
	.byte	0x13
	.byte	0
	.byte	0
	.byte	0x6
	.byte	0x2e
	.byte	0x1
	.byte	0x3f
	.byte	0x19
	.byte	0x3
	.byte	0xe
	.byte	0x3a
	.byte	0xb
	.byte	0x3b
	.byte	0xb
	.byte	0x39
	.byte	0xb
	.byte	0x27
	.byte	0x19
	.byte	0x49
	.byte	0x13
	.byte	0x11
	.byte	0x1
	.byte	0x12
	.byte	0x6
	.byte	0x40
	.byte	0x18
	.byte	0x97,0x42
	.byte	0x19
	.byte	0x1
	.byte	0x13
	.byte	0
	.byte	0
	.byte	0x7
	.byte	0x5
	.byte	0
	.byte	0x3
	.byte	0xe
	.byte	0x3a
	.byte	0xb
	.byte	0x3b
	.byte	0xb
	.byte	0x39
	.byte	0xb
	.byte	0x49
	.byte	0x13
	.byte	0x2
	.byte	0x17
	.byte	0
	.byte	0
	.byte	0x8
	.byte	0x34
	.byte	0
	.byte	0x3
	.byte	0xe
	.byte	0x3a
	.byte	0xb
	.byte	0x3b
	.byte	0xb
	.byte	0x39
	.byte	0xb
	.byte	0x49
	.byte	0x13
	.byte	0
	.byte	0
	.byte	0x9
	.byte	0x34
	.byte	0
	.byte	0x3
	.byte	0xe
	.byte	0x3a
	.byte	0xb
	.byte	0x3b
	.byte	0xb
	.byte	0x39
	.byte	0xb
	.byte	0x49
	.byte	0x13
	.byte	0x2
	.byte	0x18
	.byte	0
	.byte	0
	.byte	0xa
	.byte	0x34
	.byte	0
	.byte	0x3
	.byte	0x8
	.byte	0x3a
	.byte	0xb
	.byte	0x3b
	.byte	0xb
	.byte	0x39
	.byte	0xb
	.byte	0x49
	.byte	0x13
	.byte	0
	.byte	0
	.byte	0xb
	.byte	0x34
	.byte	0
	.byte	0x3
	.byte	0x8
	.byte	0x3a
	.byte	0xb
	.byte	0x3b
	.byte	0xb
	.byte	0x39
	.byte	0xb
	.byte	0x49
	.byte	0x13
	.byte	0x2
	.byte	0x17
	.byte	0
	.byte	0
	.byte	0xc
	.byte	0xb
	.byte	0x1
	.byte	0x55
	.byte	0x17
	.byte	0x1
	.byte	0x13
	.byte	0
	.byte	0
	.byte	0xd
	.byte	0x89,0x82,0x1
	.byte	0x1
	.byte	0x11
	.byte	0x1
	.byte	0x31
	.byte	0x13
	.byte	0x1
	.byte	0x13
	.byte	0
	.byte	0
	.byte	0xe
	.byte	0x8a,0x82,0x1
	.byte	0
	.byte	0x2
	.byte	0x18
	.byte	0x91,0x42
	.byte	0x18
	.byte	0
	.byte	0
	.byte	0xf
	.byte	0x89,0x82,0x1
	.byte	0x1
	.byte	0x11
	.byte	0x1
	.byte	0x31
	.byte	0x13
	.byte	0
	.byte	0
	.byte	0x10
	.byte	0xb
	.byte	0x1
	.byte	0x55
	.byte	0x17
	.byte	0
	.byte	0
	.byte	0x11
	.byte	0x34
	.byte	0
	.byte	0x3
	.byte	0xe
	.byte	0x3a
	.byte	0xb
	.byte	0x3b
	.byte	0xb
	.byte	0x39
	.byte	0xb
	.byte	0x49
	.byte	0x13
	.byte	0x2
	.byte	0x17
	.byte	0
	.byte	0
	.byte	0x12
	.byte	0x89,0x82,0x1
	.byte	0
	.byte	0x11
	.byte	0x1
	.byte	0x31
	.byte	0x13
	.byte	0
	.byte	0
	.byte	0x13
	.byte	0x1d
	.byte	0x1
	.byte	0x31
	.byte	0x13
	.byte	0x11
	.byte	0x1
	.byte	0x12
	.byte	0x6
	.byte	0x58
	.byte	0xb
	.byte	0x59
	.byte	0xb
	.byte	0x57
	.byte	0xb
	.byte	0x1
	.byte	0x13
	.byte	0
	.byte	0
	.byte	0x14
	.byte	0x5
	.byte	0
	.byte	0x31
	.byte	0x13
	.byte	0x2
	.byte	0x17
	.byte	0
	.byte	0
	.byte	0x15
	.byte	0x34
	.byte	0
	.byte	0x31
	.byte	0x13
	.byte	0x1c
	.byte	0xd
	.byte	0
	.byte	0
	.byte	0x16
	.byte	0x1d
	.byte	0x1
	.byte	0x31
	.byte	0x13
	.byte	0x52
	.byte	0x1
	.byte	0x55
	.byte	0x17
	.byte	0x58
	.byte	0xb
	.byte	0x59
	.byte	0xb
	.byte	0x57
	.byte	0xb
	.byte	0x1
	.byte	0x13
	.byte	0
	.byte	0
	.byte	0x17
	.byte	0x34
	.byte	0
	.byte	0x31
	.byte	0x13
	.byte	0x1c
	.byte	0xb
	.byte	0
	.byte	0
	.byte	0x18
	.byte	0x34
	.byte	0
	.byte	0x31
	.byte	0x13
	.byte	0x2
	.byte	0x17
	.byte	0
	.byte	0
	.byte	0x19
	.byte	0x1
	.byte	0x1
	.byte	0x49
	.byte	0x13
	.byte	0x1
	.byte	0x13
	.byte	0
	.byte	0
	.byte	0x1a
	.byte	0x21
	.byte	0
	.byte	0x49
	.byte	0x13
	.byte	0x2f
	.byte	0x5
	.byte	0
	.byte	0
	.byte	0x1b
	.byte	0x21
	.byte	0
	.byte	0x49
	.byte	0x13
	.byte	0x2f
	.byte	0xb
	.byte	0
	.byte	0
	.byte	0x1c
	.byte	0x2e
	.byte	0x1
	.byte	0x3f
	.byte	0x19
	.byte	0x3
	.byte	0xe
	.byte	0x3a
	.byte	0xb
	.byte	0x3b
	.byte	0xb
	.byte	0x39
	.byte	0xb
	.byte	0x27
	.byte	0x19
	.byte	0x11
	.byte	0x1
	.byte	0x12
	.byte	0x6
	.byte	0x40
	.byte	0x18
	.byte	0x97,0x42
	.byte	0x19
	.byte	0x1
	.byte	0x13
	.byte	0
	.byte	0
	.byte	0x1d
	.byte	0x34
	.byte	0
	.byte	0x3
	.byte	0x8
	.byte	0x3a
	.byte	0xb
	.byte	0x3b
	.byte	0xb
	.byte	0x39
	.byte	0xb
	.byte	0x49
	.byte	0x13
	.byte	0x2
	.byte	0x18
	.byte	0
	.byte	0
	.byte	0x1e
	.byte	0x5
	.byte	0
	.byte	0x3
	.byte	0x8
	.byte	0x3a
	.byte	0xb
	.byte	0x3b
	.byte	0xb
	.byte	0x39
	.byte	0xb
	.byte	0x49
	.byte	0x13
	.byte	0x2
	.byte	0x17
	.byte	0
	.byte	0
	.byte	0x1f
	.byte	0x2e
	.byte	0x1
	.byte	0x3
	.byte	0xe
	.byte	0x3a
	.byte	0xb
	.byte	0x3b
	.byte	0xb
	.byte	0x39
	.byte	0xb
	.byte	0x27
	.byte	0x19
	.byte	0x20
	.byte	0xb
	.byte	0x1
	.byte	0x13
	.byte	0
	.byte	0
	.byte	0x20
	.byte	0x5
	.byte	0
	.byte	0x3
	.byte	0xe
	.byte	0x3a
	.byte	0xb
	.byte	0x3b
	.byte	0xb
	.byte	0x39
	.byte	0xb
	.byte	0x49
	.byte	0x13
	.byte	0
	.byte	0
	.byte	0x21
	.byte	0x2e
	.byte	0
	.byte	0x3f
	.byte	0x19
	.byte	0x3c
	.byte	0x19
	.byte	0x6e
	.byte	0xe
	.byte	0x3
	.byte	0xe
	.byte	0x3a
	.byte	0xb
	.byte	0x3b
	.byte	0xb
	.byte	0x39
	.byte	0xb
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_loc,"",@progbits
.Ldebug_loc0:
.LLST6:
	.4byte	.LVL13
	.4byte	.LVL14
	.2byte	0x1
	.byte	0x5a
	.4byte	.LVL14
	.4byte	.LFE6
	.2byte	0x4
	.byte	0xf3
	.byte	0x1
	.byte	0x5a
	.byte	0x9f
	.4byte	0
	.4byte	0
.LLST7:
	.4byte	.LVL13
	.4byte	.LVL15
	.2byte	0x1
	.byte	0x5b
	.4byte	.LVL15
	.4byte	.LFE6
	.2byte	0x4
	.byte	0xf3
	.byte	0x1
	.byte	0x5b
	.byte	0x9f
	.4byte	0
	.4byte	0
.LLST8:
	.4byte	.LVL20
	.4byte	.LVL21
	.2byte	0x2
	.byte	0x30
	.byte	0x9f
	.4byte	.LVL21
	.4byte	.LVL27
	.2byte	0x1
	.byte	0x63
	.4byte	.LVL33
	.4byte	.LVL37
	.2byte	0x1
	.byte	0x63
	.4byte	0
	.4byte	0
.LLST11:
	.4byte	.LVL20
	.4byte	.LVL21
	.2byte	0x2
	.byte	0x30
	.byte	0x9f
	.4byte	.LVL21
	.4byte	.LVL23
	.2byte	0x1
	.byte	0x58
	.4byte	.LVL23
	.4byte	.LVL24
	.2byte	0x3
	.byte	0x78
	.byte	0x7f
	.byte	0x9f
	.4byte	.LVL24
	.4byte	.LVL28
	.2byte	0x1
	.byte	0x58
	.4byte	.LVL33
	.4byte	.LVL37
	.2byte	0x1
	.byte	0x58
	.4byte	0
	.4byte	0
.LLST12:
	.4byte	.LVL31
	.4byte	.LVL33
	.2byte	0x2
	.byte	0x32
	.byte	0x9f
	.4byte	0
	.4byte	0
.LLST13:
	.4byte	.LVL25
	.4byte	.LVL26
	.2byte	0x2
	.byte	0x30
	.byte	0x9f
	.4byte	.LVL29
	.4byte	.LVL30
	.2byte	0x2
	.byte	0x30
	.byte	0x9f
	.4byte	.LVL35
	.4byte	.LFE6
	.2byte	0x2
	.byte	0x30
	.byte	0x9f
	.4byte	0
	.4byte	0
.LLST14:
	.4byte	.LVL25
	.4byte	.LVL26
	.2byte	0x1
	.byte	0x5a
	.4byte	.LVL29
	.4byte	.LVL30
	.2byte	0x1
	.byte	0x5a
	.4byte	.LVL35
	.4byte	.LVL36-1
	.2byte	0x1
	.byte	0x5a
	.4byte	.LVL37
	.4byte	.LVL38-1
	.2byte	0x1
	.byte	0x5a
	.4byte	0
	.4byte	0
.LLST9:
	.4byte	.LVL17
	.4byte	.LVL18
	.2byte	0x2
	.byte	0x30
	.byte	0x9f
	.4byte	0
	.4byte	0
.LLST10:
	.4byte	.LVL19
	.4byte	.LVL20
	.2byte	0x2
	.byte	0x31
	.byte	0x9f
	.4byte	0
	.4byte	0
.LLST15:
	.4byte	.LVL31
	.4byte	.LVL32
	.2byte	0x2
	.byte	0x30
	.byte	0x9f
	.4byte	0
	.4byte	0
.LLST16:
	.4byte	.LVL31
	.4byte	.LVL33
	.2byte	0x3
	.byte	0x9
	.byte	0xff
	.byte	0x9f
	.4byte	0
	.4byte	0
.LLST4:
	.4byte	.LVL6
	.4byte	.LVL8
	.2byte	0x1
	.byte	0x5a
	.4byte	.LVL10
	.4byte	.LVL12
	.2byte	0x1
	.byte	0x5a
	.4byte	0
	.4byte	0
.LLST5:
	.4byte	.LVL6
	.4byte	.LVL7
	.2byte	0x2
	.byte	0x30
	.byte	0x9f
	.4byte	.LVL11
	.4byte	.LVL12
	.2byte	0x3
	.byte	0x81
	.byte	0x1
	.byte	0x9f
	.4byte	0
	.4byte	0
.LLST2:
	.4byte	.LVL3
	.4byte	.LVL5
	.2byte	0x1
	.byte	0x5a
	.4byte	.LVL5
	.4byte	.LFE4
	.2byte	0x4
	.byte	0xf3
	.byte	0x1
	.byte	0x5a
	.byte	0x9f
	.4byte	0
	.4byte	0
.LLST3:
	.4byte	.LVL3
	.4byte	.LVL4
	.2byte	0x1
	.byte	0x5b
	.4byte	.LVL4
	.4byte	.LFE4
	.2byte	0x4
	.byte	0xf3
	.byte	0x1
	.byte	0x5b
	.byte	0x9f
	.4byte	0
	.4byte	0
.LLST0:
	.4byte	.LVL0
	.4byte	.LVL2
	.2byte	0x1
	.byte	0x5a
	.4byte	.LVL2
	.4byte	.LFE3
	.2byte	0x4
	.byte	0xf3
	.byte	0x1
	.byte	0x5a
	.byte	0x9f
	.4byte	0
	.4byte	0
.LLST1:
	.4byte	.LVL0
	.4byte	.LVL1
	.2byte	0x1
	.byte	0x5b
	.4byte	.LVL1
	.4byte	.LFE3
	.2byte	0x4
	.byte	0xf3
	.byte	0x1
	.byte	0x5b
	.byte	0x9f
	.4byte	0
	.4byte	0
	.section	.debug_aranges,"",@progbits
	.4byte	0x24
	.2byte	0x2
	.4byte	.Ldebug_info0
	.byte	0x4
	.byte	0
	.2byte	0
	.2byte	0
	.4byte	.Ltext0
	.4byte	.Letext0-.Ltext0
	.4byte	.LFB6
	.4byte	.LFE6-.LFB6
	.4byte	0
	.4byte	0
	.section	.debug_ranges,"",@progbits
.Ldebug_ranges0:
	.4byte	.LBB13
	.4byte	.LBE13
	.4byte	.LBB14
	.4byte	.LBE14
	.4byte	0
	.4byte	0
	.4byte	.LBB17
	.4byte	.LBE17
	.4byte	.LBB22
	.4byte	.LBE22
	.4byte	.LBB24
	.4byte	.LBE24
	.4byte	0
	.4byte	0
	.4byte	.LBB21
	.4byte	.LBE21
	.4byte	.LBB23
	.4byte	.LBE23
	.4byte	.LBB25
	.4byte	.LBE25
	.4byte	.LBB40
	.4byte	.LBE40
	.4byte	.LBB44
	.4byte	.LBE44
	.4byte	0
	.4byte	0
	.4byte	.LBB26
	.4byte	.LBE26
	.4byte	.LBB41
	.4byte	.LBE41
	.4byte	.LBB45
	.4byte	.LBE45
	.4byte	0
	.4byte	0
	.4byte	.LBB29
	.4byte	.LBE29
	.4byte	.LBB30
	.4byte	.LBE30
	.4byte	.LBB31
	.4byte	.LBE31
	.4byte	.LBB32
	.4byte	.LBE32
	.4byte	.LBB33
	.4byte	.LBE33
	.4byte	.LBB34
	.4byte	.LBE34
	.4byte	.LBB35
	.4byte	.LBE35
	.4byte	0
	.4byte	0
	.4byte	.Ltext0
	.4byte	.Letext0
	.4byte	.LFB6
	.4byte	.LFE6
	.4byte	0
	.4byte	0
	.section	.debug_line,"",@progbits
.Ldebug_line0:
	.section	.debug_str,"MS",@progbits,1
.LASF13:
	.string	"vec1"
.LASF14:
	.string	"vec2"
.LASF31:
	.string	"pcount_enable"
.LASF17:
	.string	"count"
.LASF12:
	.string	"argv"
.LASF22:
	.string	"timer_enable"
.LASF32:
	.string	"enable"
.LASF29:
	.string	"uint64_t"
.LASF15:
	.string	"last_elapsed_time"
.LASF21:
	.string	"inhibit_val"
.LASF4:
	.string	"unsigned char"
.LASF27:
	.string	"hello_test.c"
.LASF8:
	.string	"long unsigned int"
.LASF6:
	.string	"short unsigned int"
.LASF26:
	.string	"GNU C17 10.2.0 -march=rv32imc -mabi=ilp32 -mcmodel=medany -march=rv32imc -g -Ofast -Os -fvisibility=hidden -funroll-loops -finline-functions -fno-if-conversion -ffreestanding"
.LASF11:
	.string	"argc"
.LASF30:
	.string	"main"
.LASF28:
	.string	"/home/prpate/ibex/ibex/examples/sw/simple_system/hello_test"
.LASF19:
	.string	"mul2"
.LASF0:
	.string	"unsigned int"
.LASF9:
	.string	"long long unsigned int"
.LASF16:
	.string	"result"
.LASF2:
	.string	"long double"
.LASF1:
	.string	"long long int"
.LASF10:
	.string	"char"
.LASF18:
	.string	"printLog"
.LASF5:
	.string	"short int"
.LASF23:
	.string	"get_elapsed_time"
.LASF7:
	.string	"long int"
.LASF25:
	.string	"puts"
.LASF3:
	.string	"signed char"
.LASF20:
	.string	"mul1"
.LASF24:
	.string	"pcount_reset"
	.ident	"GCC: (crosstool-NG 1.26.0_rc1) 10.2.0"
