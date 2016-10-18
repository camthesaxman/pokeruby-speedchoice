	.include "constants/gba_constants.s"
	.include "constants/species_constants.s"
	.include "asm/macros.s"

	.syntax unified

	.text

	thumb_func_start sub_8126098
sub_8126098: @ 8126098
	push {r4,lr}
	adds r4, r3, 0
	lsls r0, 16
	lsrs r0, 16
	lsls r2, 16
	lsrs r2, 16
	movs r3, 0x2
	ands r0, r3
	cmp r0, 0
	beq _081260C6
	ands r1, r3
	cmp r1, 0
	beq _081260C6
	movs r0, 0x4
	ands r2, r0
	cmp r2, 0
	beq _081260C6
	movs r0, 0x80
	.ifdef SAPPHIRE
	lsls r0, 1 @ unknown difference
	.endif
	ands r0, r4
	cmp r0, 0
	beq _081260C6
	movs r0, 0x1
	b _081260C8
_081260C6:
	movs r0, 0
_081260C8:
	pop {r4}
	pop {r1}
	bx r1
	thumb_func_end sub_8126098

	thumb_func_start sub_81260D0
sub_81260D0: @ 81260D0
	push {lr}
	ldr r0, _081260E4
	ldr r1, _081260E8
	bl StringExpandPlaceholders
	movs r0, 0x3
	bl sub_8126160
	pop {r0}
	bx r0
	.align 2, 0
_081260E4: .4byte gStringVar4
_081260E8: .4byte gOtherText_DataCannotUseVersion
	thumb_func_end sub_81260D0

	thumb_func_start sub_81260EC
sub_81260EC: @ 81260EC
	push {r4,r5,lr}
	adds r4, r0, 0
	adds r5, r1, 0
	ldr r1, _08126114
	ldr r2, _08126118
	bl InitScriptContext
	adds r0, r4, 0
	adds r1, r5, 0
	bl SetupBytecodeScript
	str r5, [r4, 0x64]
	movs r0, 0
	str r0, [r4, 0x68]
	str r0, [r4, 0x6C]
	str r0, [r4, 0x70]
	pop {r4,r5}
	pop {r0}
	bx r0
	.align 2, 0
_08126114: .4byte gScriptFuncs
_08126118: .4byte gScriptFuncs_End
	thumb_func_end sub_81260EC

	thumb_func_start sub_812611C
sub_812611C: @ 812611C
	push {r4,lr}
	adds r4, r0, 0
	bl RunScript
	lsls r0, 24
	cmp r0, 0
	beq _08126134
	ldr r0, [r4, 0x70]
	cmp r0, 0
	beq _08126134
	movs r0, 0x1
	b _08126136
_08126134:
	movs r0, 0
_08126136:
	pop {r4}
	pop {r1}
	bx r1
	thumb_func_end sub_812611C

	thumb_func_start sub_812613C
sub_812613C: @ 812613C
	push {r4,lr}
	adds r1, r0, 0
	ldr r4, _0812615C
	adds r0, r4, 0
	bl sub_81260EC
_08126148:
	adds r0, r4, 0
	bl sub_812611C
	cmp r0, 0
	bne _08126148
	ldr r0, [r4, 0x6C]
	pop {r4}
	pop {r1}
	bx r1
	.align 2, 0
_0812615C: .4byte gUnknown_02039288
	thumb_func_end sub_812613C

	thumb_func_start sub_8126160
sub_8126160: @ 8126160
	ldr r1, _08126168
	str r0, [r1, 0x6C]
	bx lr
	.align 2, 0
_08126168: .4byte gUnknown_02039288
	thumb_func_end sub_8126160

	thumb_func_start sub_812616C
sub_812616C: @ 812616C
	push {r4,lr}
	adds r4, r0, 0
	movs r3, 0
	movs r2, 0
	cmp r3, r1
	bcs _08126184
_08126178:
	adds r0, r4, r2
	ldrb r0, [r0]
	adds r3, r0
	adds r2, 0x1
	cmp r2, r1
	bcc _08126178
_08126184:
	adds r0, r3, 0
	pop {r4}
	pop {r1}
	bx r1
	thumb_func_end sub_812616C

	thumb_func_start sub_812618C
sub_812618C: @ 812618C
	adds r2, r0, 0
	ldrb r0, [r2]
	ldrb r1, [r2, 0x1]
	lsls r1, 8
	orrs r0, r1
	ldrb r1, [r2, 0x2]
	lsls r1, 16
	orrs r0, r1
	ldrb r1, [r2, 0x3]
	lsls r1, 24
	orrs r0, r1
	bx lr
	thumb_func_end sub_812618C

	thumb_func_start sub_81261A4
sub_81261A4: @ 81261A4
	strb r1, [r0]
	lsrs r2, r1, 8
	strb r2, [r0, 0x1]
	lsrs r2, r1, 16
	strb r2, [r0, 0x2]
	lsrs r1, 24
	strb r1, [r0, 0x3]
	bx lr
	thumb_func_end sub_81261A4

	thumb_func_start unref_sub_81261B4
unref_sub_81261B4: @ 81261B4
	push {r4-r7,lr}
	adds r5, r0, 0
	adds r7, r1, 0
	ldrb r0, [r5]
	cmp r0, 0x1
	bne _08126204
	ldrb r0, [r5, 0x11]
	cmp r0, 0xF
	bne _08126204
	adds r6, r5, 0
	adds r6, 0x12
	adds r0, r6, 0
	bl sub_812618C
	cmp r0, 0
	bne _08126204
	adds r0, r5, 0
	adds r0, 0x16
	bl sub_812618C
	adds r4, r0, 0
	subs r4, r7
	adds r4, r5
	adds r0, r5, 0
	adds r0, 0x1A
	bl sub_812618C
	adds r1, r0, 0
	subs r1, r7
	adds r1, r5
	subs r1, r4
	adds r0, r4, 0
	bl sub_812616C
	adds r1, r0, 0
	adds r0, r6, 0
	bl sub_81261A4
	movs r0, 0x1
	b _08126206
_08126204:
	movs r0, 0
_08126206:
	pop {r4-r7}
	pop {r1}
	bx r1
	thumb_func_end unref_sub_81261B4

	thumb_func_start unref_sub_812620C
unref_sub_812620C: @ 812620C
	push {r4-r7,lr}
	adds r5, r0, 0
	adds r7, r1, 0
	ldrb r0, [r5]
	cmp r0, 0x1
	bne _08126260
	ldrb r0, [r5, 0x11]
	cmp r0, 0x10
	bne _08126260
	adds r6, r5, 0
	adds r6, 0x12
	adds r0, r6, 0
	bl sub_812618C
	cmp r0, 0
	bne _08126260
	adds r0, r5, 0
	adds r0, 0x16
	bl sub_812618C
	adds r4, r0, 0
	subs r4, r7
	adds r4, r5
	adds r0, r5, 0
	adds r0, 0x1A
	bl sub_812618C
	adds r1, r0, 0
	subs r1, r7
	adds r1, r5
	subs r1, r4
	adds r0, r4, 0
	bl sub_8041174
	adds r1, r0, 0
	lsls r1, 16
	lsrs r1, 16
	adds r0, r6, 0
	bl sub_81261A4
	movs r0, 0x1
	b _08126262
_08126260:
	movs r0, 0
_08126262:
	pop {r4-r7}
	pop {r1}
	bx r1
	thumb_func_end unref_sub_812620C

	thumb_func_start sub_8126268
sub_8126268: @ 8126268
	push {lr}
	movs r2, 0
	ldr r3, _08126284
	movs r1, 0
_08126270:
	adds r0, r3, r1
	ldrb r0, [r0]
	adds r2, r0
	adds r1, 0x1
	cmp r1, 0xB
	bls _08126270
	adds r0, r2, 0
	pop {r1}
	bx r1
	.align 2, 0
_08126284: .4byte gSaveBlock1 + 0x3A80
	thumb_func_end sub_8126268

	thumb_func_start sub_8126288
sub_8126288: @ 8126288
	push {r4,lr}
	ldr r4, _081262B4
	bl sub_8126268
	adds r1, r0, 0
	ldrb r0, [r4]
	cmp r0, 0
	beq _081262B0
	ldrb r0, [r4, 0x1]
	cmp r0, 0
	beq _081262B0
	ldrh r0, [r4, 0x2]
	cmp r0, 0
	beq _081262B0
	cmp r1, 0
	beq _081262B0
	subs r0, r4, 0x4
	ldr r0, [r0]
	cmp r1, r0
	beq _081262B8
_081262B0:
	movs r0, 0
	b _081262BA
	.align 2, 0
_081262B4: .4byte gSaveBlock1 + 0x3A80
_081262B8:
	movs r0, 0x1
_081262BA:
	pop {r4}
	pop {r1}
	bx r1
	thumb_func_end sub_8126288

	thumb_func_start sub_81262C0
sub_81262C0: @ 81262C0
	push {lr}
	sub sp, 0x4
	mov r1, sp
	movs r0, 0
	strh r0, [r1]
	ldr r1, _081262DC
	ldr r2, _081262E0
	mov r0, sp
	bl CpuSet
	add sp, 0x4
	pop {r0}
	bx r0
	.align 2, 0
_081262DC: .4byte gSaveBlock1 + 0x3A7C
_081262E0: .4byte 0x01000008
	thumb_func_end sub_81262C0

	thumb_func_start sub_81262E4
sub_81262E4: @ 81262E4
	push {r4-r6,lr}
	lsls r0, 24
	lsrs r0, 24
	adds r3, r0, 0
	lsls r1, 24
	lsrs r1, 24
	adds r5, r1, 0
	lsls r2, 16
	lsrs r2, 16
	adds r6, r2, 0
	cmp r3, 0
	beq _08126304
	cmp r1, 0
	beq _08126304
	cmp r2, 0
	bne _0812630A
_08126304:
	bl sub_81262C0
	b _0812632A
_0812630A:
	ldr r4, _08126330
	movs r1, 0xEA
	lsls r1, 6
	adds r0, r4, r1
	strb r3, [r0]
	adds r1, 0x1
	adds r0, r4, r1
	strb r5, [r0]
	adds r1, 0x1
	adds r0, r4, r1
	strh r6, [r0]
	bl sub_8126268
	ldr r1, _08126334
	adds r4, r1
	str r0, [r4]
_0812632A:
	pop {r4-r6}
	pop {r0}
	bx r0
	.align 2, 0
_08126330: .4byte gSaveBlock1
_08126334: .4byte 0x00003a7c
	thumb_func_end sub_81262E4

	thumb_func_start sub_8126338
sub_8126338: @ 8126338
	push {r4,r5,lr}
	ldr r4, _0812634C
	bl sub_8126288
	cmp r0, 0
	bne _08126350
	bl sub_81262C0
	movs r0, 0
	b _0812636E
	.align 2, 0
_0812634C: .4byte gSaveBlock1 + 0x3A80
_08126350:
	ldrh r5, [r4, 0x2]
	ldrb r0, [r4, 0x1]
	subs r0, 0x1
	strb r0, [r4, 0x1]
	lsls r0, 24
	cmp r0, 0
	bne _08126364
	bl sub_81262C0
	b _0812636C
_08126364:
	bl sub_8126268
	subs r1, r4, 0x4
	str r0, [r1]
_0812636C:
	adds r0, r5, 0
_0812636E:
	pop {r4,r5}
	pop {r1}
	bx r1
	thumb_func_end sub_8126338

	thumb_func_start script_status_stop_and_ret_1
script_status_stop_and_ret_1: @ 8126374
	push {lr}
	bl StopScript
	movs r0, 0x1
	pop {r1}
	bx r1
	thumb_func_end script_status_stop_and_ret_1

	thumb_func_start sub_8126380
sub_8126380: @ 8126380
	push {r4-r7,lr}
	adds r7, r0, 0
	bl ScriptReadWord
	str r0, [r7, 0x68]
	adds r0, r7, 0
	bl ScriptReadHalfword
	adds r5, r0, 0
	lsls r5, 16
	lsrs r5, 16
	adds r0, r7, 0
	bl ScriptReadWord
	adds r6, r0, 0
	adds r0, r7, 0
	bl ScriptReadHalfword
	adds r4, r0, 0
	lsls r4, 16
	lsrs r4, 16
	adds r0, r7, 0
	bl ScriptReadWord
	adds r3, r0, 0
	adds r0, r5, 0
	adds r1, r6, 0
	adds r2, r4, 0
	bl sub_8126098
	cmp r0, 0x1
	bne _081263C4
	str r0, [r7, 0x70]
	b _081263C8
_081263C4:
	bl sub_81260D0
_081263C8:
	movs r0, 0x1
	pop {r4-r7}
	pop {r1}
	bx r1
	thumb_func_end sub_8126380

	thumb_func_start sub_81263D0
sub_81263D0: @ 81263D0
	movs r0, 0
	bx lr
	thumb_func_end sub_81263D0

	thumb_func_start sub_81263D4
sub_81263D4: @ 81263D4
	ldr r1, [r0, 0x8]
	ldrb r2, [r1]
	adds r1, 0x1
	str r1, [r0, 0x8]
	str r2, [r0, 0x6C]
	movs r0, 0
	bx lr
	thumb_func_end sub_81263D4

	thumb_func_start sub_81263E4
sub_81263E4: @ 81263E4
	push {r4,r5,lr}
	adds r4, r0, 0
	ldr r0, [r4, 0x8]
	ldrb r5, [r0]
	adds r0, 0x1
	str r0, [r4, 0x8]
	adds r0, r4, 0
	bl ScriptReadWord
	ldr r1, [r4, 0x68]
	subs r0, r1
	ldr r1, [r4, 0x64]
	adds r1, r0, r1
	cmp r5, 0xFF
	beq _08126408
	ldr r0, [r4, 0x6C]
	cmp r5, r0
	bne _0812640E
_08126408:
	ldr r0, _08126418
	bl StringExpandPlaceholders
_0812640E:
	movs r0, 0
	pop {r4,r5}
	pop {r1}
	bx r1
	.align 2, 0
_08126418: .4byte gStringVar4
	thumb_func_end sub_81263E4

	thumb_func_start sub_812641C
sub_812641C: @ 812641C
	push {r4,lr}
	adds r4, r0, 0
	bl ScriptReadWord
	ldr r1, [r4, 0x68]
	subs r0, r1
	ldr r1, [r4, 0x64]
	adds r0, r1
	bl ScriptContext2_RunNewScript
	movs r0, 0
	pop {r4}
	pop {r1}
	bx r1
	thumb_func_end sub_812641C

	thumb_func_start sub_8126438
sub_8126438: @ 8126438
	push {r4-r7,lr}
	mov r7, r8
	push {r7}
	adds r7, r0, 0
	bl sub_80B4940
	mov r8, r0
	adds r0, r7, 0
	bl ScriptReadWord
	adds r4, r0, 0
	ldr r0, [r7, 0x68]
	subs r4, r0
	ldr r0, [r7, 0x64]
	adds r4, r0
	ldr r6, _08126484
	ldr r5, _08126488
	adds r0, r6, 0
	adds r1, r5, 0
	movs r2, 0x7
	bl StringCopyN
	adds r0, r4, 0
	bl sub_80B48A8
	ldr r4, _0812648C
	adds r0, r4, 0
	adds r1, r5, 0
	movs r2, 0x7
	bl StringCopyN
	mov r0, r8
	cmp r0, 0
	bne _08126498
	ldr r0, _08126490
	ldr r1, _08126494
	b _081264B8
	.align 2, 0
_08126484: .4byte gStringVar1
_08126488: .4byte gSaveBlock1 + 0x3160
_0812648C: .4byte gStringVar2
_08126490: .4byte gStringVar4
_08126494: .4byte gOtherText_BerryObtainedDadHasIt
_08126498:
	adds r0, r6, 0
	adds r1, r4, 0
	bl StringCompare
	cmp r0, 0
	beq _081264B4
	ldr r0, _081264AC
	ldr r1, _081264B0
	b _081264B8
	.align 2, 0
_081264AC: .4byte gStringVar4
_081264B0: .4byte gOtherText_BerryTransformed
_081264B4:
	ldr r0, _081264D4
	ldr r1, _081264D8
_081264B8:
	bl StringExpandPlaceholders
	movs r0, 0x2
	str r0, [r7, 0x6C]
	bl sub_80B4940
	cmp r0, 0x1
	bne _081264E0
	ldr r0, _081264DC
	movs r1, 0x1
	bl VarSet
	b _081264E4
	.align 2, 0
_081264D4: .4byte gStringVar4
_081264D8: .4byte gOtherText_BerryAlreadyObtained
_081264DC: .4byte 0x0000402d
_081264E0:
	movs r0, 0x1
	str r0, [r7, 0x6C]
_081264E4:
	movs r0, 0
	pop {r3}
	mov r8, r3
	pop {r4-r7}
	pop {r1}
	bx r1
	thumb_func_end sub_8126438

	thumb_func_start sub_81264F0
sub_81264F0: @ 81264F0
	push {r4,lr}
	adds r4, r0, 0
	ldr r2, [r4, 0x8]
	ldrb r0, [r2]
	adds r2, 0x1
	str r2, [r4, 0x8]
	ldrb r1, [r2]
	adds r2, 0x1
	str r2, [r4, 0x8]
	bl sub_80C5C38
	ldr r0, _0812651C
	ldr r1, _08126520
	bl StringExpandPlaceholders
	movs r0, 0x2
	str r0, [r4, 0x6C]
	movs r0, 0
	pop {r4}
	pop {r1}
	bx r1
	.align 2, 0
_0812651C: .4byte gStringVar4
_08126520: .4byte gOtherText_SpecialRibbonReceived
	thumb_func_end sub_81264F0

	thumb_func_start sub_8126524
sub_8126524: @ 8126524
	push {r4-r6,lr}
	mov r6, r9
	mov r5, r8
	push {r5,r6}
	sub sp, 0x4
	adds r4, r0, 0
	ldr r0, [r4, 0x8]
	ldrb r1, [r0]
	mov r9, r1
	adds r0, 0x1
	str r0, [r4, 0x8]
	ldrb r1, [r0]
	mov r8, r1
	adds r1, r0, 0x1
	str r1, [r4, 0x8]
	ldrb r6, [r0, 0x1]
	adds r1, 0x1
	str r1, [r4, 0x8]
	adds r0, r4, 0
	bl ScriptReadWord
	adds r5, r0, 0
	ldr r0, [r4, 0x68]
	subs r5, r0
	ldr r0, [r4, 0x64]
	adds r5, r0
	adds r0, r4, 0
	bl ScriptReadWord
	adds r1, r0, 0
	ldr r0, [r4, 0x68]
	subs r1, r0
	ldr r0, [r4, 0x64]
	adds r1, r0
	subs r1, r5
	lsls r1, 16
	lsrs r1, 16
	str r6, [sp]
	adds r0, r5, 0
	mov r2, r9
	mov r3, r8
	bl InitRamScript
	movs r0, 0
	add sp, 0x4
	pop {r3,r4}
	mov r8, r3
	mov r9, r4
	pop {r4-r6}
	pop {r1}
	bx r1
	thumb_func_end sub_8126524

	thumb_func_start sub_812658C
sub_812658C: @ 812658C
	push {r4,lr}
	adds r4, r0, 0
	bl sub_80690F0
	ldr r0, _081265A8
	ldr r1, _081265AC
	bl StringExpandPlaceholders
	movs r0, 0x2
	str r0, [r4, 0x6C]
	movs r0, 0
	pop {r4}
	pop {r1}
	bx r1
	.align 2, 0
_081265A8: .4byte gStringVar4
_081265AC: .4byte gOtherText_DexUpgraded
	thumb_func_end sub_812658C

	thumb_func_start sub_81265B0
sub_81265B0: @ 81265B0
	push {r4,lr}
	adds r4, r0, 0
	ldr r1, [r4, 0x8]
	ldrb r0, [r1]
	adds r1, 0x1
	str r1, [r4, 0x8]
	bl sub_80EB890
	ldr r0, _081265D4
	ldr r1, _081265D8
	bl StringExpandPlaceholders
	movs r0, 0x2
	str r0, [r4, 0x6C]
	movs r0, 0
	pop {r4}
	pop {r1}
	bx r1
	.align 2, 0
_081265D4: .4byte gStringVar4
_081265D8: .4byte gOtherText_RareWordAdded
	thumb_func_end sub_81265B0

	thumb_func_start sub_81265DC
sub_81265DC: @ 81265DC
	push {r4,r5,lr}
	ldr r1, [r0, 0x8]
	ldrb r5, [r1]
	adds r1, 0x1
	str r1, [r0, 0x8]
	ldrb r4, [r1]
	adds r1, 0x1
	str r1, [r0, 0x8]
	bl ScriptReadHalfword
	adds r2, r0, 0
	lsls r2, 16
	lsrs r2, 16
	adds r0, r5, 0
	adds r1, r4, 0
	bl sub_81262E4
	movs r0, 0
	pop {r4,r5}
	pop {r1}
	bx r1
	thumb_func_end sub_81265DC

	thumb_func_start sub_8126608
sub_8126608: @ 8126608
	push {r4-r7,lr}
	mov r7, r8
	push {r7}
	sub sp, 0x88
	adds r6, r0, 0
	bl ScriptReadWord
	ldr r1, [r6, 0x68]
	subs r0, r1
	ldr r1, [r6, 0x64]
	adds r5, r0, r1
	movs r0, 0x64
	adds r0, r5
	mov r8, r0
	add r4, sp, 0x24
	adds r0, r4, 0
	adds r1, r5, 0
	movs r2, 0x64
	bl memcpy
	adds r0, r4, 0
	movs r1, 0x41
	bl GetMonData
	lsls r0, 16
	lsrs r4, r0, 16
	movs r0, 0xCE
	lsls r0, 1
	cmp r4, r0
	bne _08126658
	ldr r0, _08126650
	ldr r1, _08126654
	movs r2, 0xB
	bl StringCopyN
	b _08126662
	.align 2, 0
_08126650: .4byte gStringVar1
_08126654: .4byte gSystemText_Egg
_08126658:
	ldr r0, _08126678
	ldr r1, _0812667C
	movs r2, 0xB
	bl StringCopyN
_08126662:
	ldr r0, _08126680
	ldrb r0, [r0]
	cmp r0, 0x6
	bne _0812668C
	ldr r0, _08126684
	ldr r1, _08126688
	bl StringExpandPlaceholders
	movs r0, 0x3
	b _081266F6
	.align 2, 0
_08126678: .4byte gStringVar1
_0812667C: .4byte gSystemText_Pokemon2
_08126680: .4byte gPlayerPartyCount
_08126684: .4byte gStringVar4
_08126688: .4byte gOtherText_PartyIsFull
_0812668C:
	ldr r7, _08126708
	adds r0, r7, 0
	adds r1, r5, 0
	movs r2, 0x64
	bl memcpy
	mov r0, sp
	mov r1, r8
	movs r2, 0x24
	bl memcpy
	movs r0, 0xCE
	lsls r0, 1
	cmp r4, r0
	beq _081266C6
	adds r0, r4, 0
	bl SpeciesToNationalPokedexNum
	adds r4, r0, 0
	lsls r4, 16
	lsrs r4, 16
	adds r0, r4, 0
	movs r1, 0x2
	bl sub_8090D90
	adds r0, r4, 0
	movs r1, 0x3
	bl sub_8090D90
_081266C6:
	adds r0, r7, 0
	movs r1, 0xC
	bl GetMonData
	lsls r0, 16
	lsrs r0, 16
	bl itemid_is_mail
	lsls r0, 24
	cmp r0, 0
	beq _081266E4
	adds r0, r7, 0
	mov r1, sp
	bl sub_80A2D88
_081266E4:
	bl party_compaction
	bl CalculatePlayerPartyCount
	ldr r0, _0812670C
	ldr r1, _08126710
	bl StringExpandPlaceholders
	movs r0, 0x2
_081266F6:
	str r0, [r6, 0x6C]
	movs r0, 0
	add sp, 0x88
	pop {r3}
	mov r8, r3
	pop {r4-r7}
	pop {r1}
	bx r1
	.align 2, 0
_08126708: .4byte gUnknown_03004554
_0812670C: .4byte gStringVar4
_08126710: .4byte gOtherText_PokeWasSentOver
	thumb_func_end sub_8126608

	thumb_func_start sub_8126714
sub_8126714: @ 8126714
	push {r4,lr}
	adds r4, r0, 0
	bl ScriptReadWord
	adds r1, r0, 0
	ldr r0, [r4, 0x68]
	subs r1, r0
	ldr r0, [r4, 0x64]
	adds r1, r0
	ldr r0, _08126748
	movs r2, 0xBC
	bl memcpy
	bl sub_813601C
	ldr r0, _0812674C
	ldr r1, _08126750
	bl StringExpandPlaceholders
	movs r0, 0x2
	str r0, [r4, 0x6C]
	movs r0, 0
	pop {r4}
	pop {r1}
	bx r1
	.align 2, 0
_08126748: .4byte gSaveBlock2 + 0x498
_0812674C: .4byte gStringVar4
_08126750: .4byte gOtherText_NewTrainerInHoenn
	thumb_func_end sub_8126714

	thumb_func_start sub_8126754
sub_8126754: @ 8126754
	push {r4,lr}
	adds r4, r0, 0
	bl sub_80691BC
	ldr r0, _08126770
	ldr r1, _08126774
	bl StringExpandPlaceholders
	movs r0, 0x2
	str r0, [r4, 0x6C]
	movs r0, 0
	pop {r4}
	pop {r1}
	bx r1
	.align 2, 0
_08126770: .4byte gStringVar4
_08126774: .4byte gSystemText_ClockAdjustmentUsable
	thumb_func_end sub_8126754

	thumb_func_start sub_8126778
sub_8126778: @ 8126778
	push {r4-r6,lr}
	adds r6, r0, 0
	bl ScriptReadWord
	adds r5, r0, 0
	adds r0, r6, 0
	bl ScriptReadWord
	adds r4, r0, 0
	ldr r0, [r6, 0x68]
	subs r4, r0
	ldr r0, [r6, 0x64]
	adds r4, r0
	adds r0, r6, 0
	bl ScriptReadWord
	adds r1, r0, 0
	ldr r0, [r6, 0x68]
	subs r1, r0
	ldr r0, [r6, 0x64]
	adds r1, r0
	subs r1, r4
	adds r0, r4, 0
	bl sub_812616C
	cmp r5, r0
	beq _081267B6
	movs r0, 0
	str r0, [r6, 0x70]
	movs r0, 0x1
	str r0, [r6, 0x6C]
_081267B6:
	movs r0, 0x1
	pop {r4-r6}
	pop {r1}
	bx r1
	thumb_func_end sub_8126778

	thumb_func_start sub_81267C0
sub_81267C0: @ 81267C0
	push {r4-r6,lr}
	adds r6, r0, 0
	bl ScriptReadWord
	adds r5, r0, 0
	adds r0, r6, 0
	bl ScriptReadWord
	adds r4, r0, 0
	ldr r0, [r6, 0x68]
	subs r4, r0
	ldr r0, [r6, 0x64]
	adds r4, r0
	adds r0, r6, 0
	bl ScriptReadWord
	adds r1, r0, 0
	ldr r0, [r6, 0x68]
	subs r1, r0
	ldr r0, [r6, 0x64]
	adds r1, r0
	subs r1, r4
	adds r0, r4, 0
	bl sub_8041174
	lsls r0, 16
	lsrs r0, 16
	cmp r5, r0
	beq _08126802
	movs r0, 0
	str r0, [r6, 0x70]
	movs r0, 0x1
	str r0, [r6, 0x6C]
_08126802:
	movs r0, 0x1
	pop {r4-r6}
	pop {r1}
	bx r1
	thumb_func_end sub_81267C0

	.align 2, 0 @ Don't pad with nop.
