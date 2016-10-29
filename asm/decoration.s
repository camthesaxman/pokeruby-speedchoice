	.include "constants/gba_constants.inc"
	.include "constants/species_constants.inc"
	.include "asm/macros.inc"

	.syntax unified

	.text

	thumb_func_start sub_80FE1DC
sub_80FE1DC: @ 80FE1DC
	push {lr}
	sub sp, 0x8
	bl sub_80FE2B4
	movs r0, 0
	movs r1, 0
	movs r2, 0xA
	movs r3, 0x9
	bl MenuDrawTextWindow
	ldr r3, _080FE218 @ =gUnknown_083EC604
	movs r0, 0x1
	movs r1, 0x1
	movs r2, 0x4
	bl PrintMenuItems
	ldr r0, _080FE21C @ =gUnknown_020388D4
	ldrb r0, [r0]
	str r0, [sp]
	movs r0, 0x9
	str r0, [sp, 0x4]
	movs r0, 0
	movs r1, 0x1
	movs r2, 0x1
	movs r3, 0x4
	bl InitMenu
	add sp, 0x8
	pop {r0}
	bx r0
	.align 2, 0
_080FE218: .4byte gUnknown_083EC604
_080FE21C: .4byte gUnknown_020388D4
	thumb_func_end sub_80FE1DC

	thumb_func_start sub_80FE220
sub_80FE220: @ 80FE220
	push {lr}
	ldr r1, _080FE238 @ =gUnknown_020388D4
	movs r0, 0
	strb r0, [r1]
	bl ScriptContext2_Enable
	bl sub_80FE1DC
	bl sub_80FE394
	pop {r0}
	bx r0
	.align 2, 0
_080FE238: .4byte gUnknown_020388D4
	thumb_func_end sub_80FE220

	thumb_func_start DecorationPC
DecorationPC: @ 80FE23C
	push {r4,lr}
	adds r4, r0, 0
	lsls r4, 24
	lsrs r4, 24
	bl sub_80FE220
	ldr r1, _080FE25C @ =gTasks
	lsls r0, r4, 2
	adds r0, r4
	lsls r0, 3
	adds r0, r1
	ldr r1, _080FE260 @ =sub_80FE2EC
	str r1, [r0]
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
_080FE25C: .4byte gTasks
_080FE260: .4byte Task_DecorationPCProcessMenuInput
	thumb_func_end DecorationPC

	thumb_func_start Task_SecretBasePC_Decoration
Task_SecretBasePC_Decoration: @ 80FE264
	push {lr}
	lsls r0, 24
	lsrs r0, 24
	bl DecorationPC
	ldr r1, _080FE284 @ =0x0201f000
	ldr r0, _080FE288 @ =gSaveBlock1 + 0x1A1A
	str r0, [r1]
	adds r0, 0x10
	str r0, [r1, 0x4]
	movs r2, 0
	movs r0, 0x10
	strb r0, [r1, 0x8]
	strb r2, [r1, 0x9]
	pop {r0}
	bx r0
	.align 2, 0
_080FE284: .4byte 0x0201f000
_080FE288: .4byte gSaveBlock1 + 0x1A1A
	thumb_func_end Task_SecretBasePC_Decoration

	thumb_func_start DoPlayerPCDecoration
DoPlayerPCDecoration: @ 80FE28C
	push {lr}
	lsls r0, 24
	lsrs r0, 24
	bl DecorationPC
	ldr r1, _080FE2AC @ =0x0201f000
	ldr r0, _080FE2B0 @ =gSaveBlock1 + 0x2688
	str r0, [r1]
	adds r0, 0xC
	str r0, [r1, 0x4]
	movs r0, 0xC
	strb r0, [r1, 0x8]
	movs r0, 0x1
	strb r0, [r1, 0x9]
	pop {r0}
	bx r0
	.align 2, 0
_080FE2AC: .4byte 0x0201f000
_080FE2B0: .4byte gSaveBlock1 + 0x2688
	thumb_func_end DoPlayerPCDecoration

	thumb_func_start sub_80FE2B4
sub_80FE2B4: @ 80FE2B4
	push {lr}
	sub sp, 0x8
	ldr r1, _080FE2E8 @ =gUnknown_083EC654
	mov r0, sp
	movs r2, 0x6
	bl memcpy
	add r0, sp, 0x4
	movs r1, 0xDF
	movs r2, 0x2
	bl LoadPalette
	mov r0, sp
	adds r0, 0x2
	movs r1, 0xD1
	movs r2, 0x2
	bl LoadPalette
	mov r0, sp
	movs r1, 0xD8
	movs r2, 0x2
	bl LoadPalette
	add sp, 0x8
	pop {r0}
	bx r0
	.align 2, 0
_080FE2E8: .4byte gUnknown_083EC654
	thumb_func_end sub_80FE2B4

	thumb_func_start Task_DecorationPCProcessMenuInput
Task_DecorationPCProcessMenuInput: @ 80FE2EC
	push {r4-r7,lr}
	lsls r0, 24
	lsrs r6, r0, 24
	adds r7, r6, 0
	ldr r0, _080FE368 @ =gPaletteFade
	ldrb r1, [r0, 0x7]
	movs r5, 0x80
	adds r0, r5, 0
	ands r0, r1
	cmp r0, 0
	bne _080FE38C
	ldr r4, _080FE36C @ =gMain
	ldrh r1, [r4, 0x2E]
	movs r0, 0x40
	ands r0, r1
	cmp r0, 0
	beq _080FE324
	movs r0, 0x5
	bl PlaySE
	movs r0, 0x1
	negs r0, r0
	bl MoveMenuCursor
	ldr r1, _080FE370 @ =gUnknown_020388D4
	strb r0, [r1]
	bl sub_80FE394
_080FE324:
	ldrh r1, [r4, 0x2E]
	adds r0, r5, 0
	ands r0, r1
	cmp r0, 0
	beq _080FE342
	movs r0, 0x5
	bl PlaySE
	movs r0, 0x1
	bl MoveMenuCursor
	ldr r1, _080FE370 @ =gUnknown_020388D4
	strb r0, [r1]
	bl sub_80FE394
_080FE342:
	ldrh r1, [r4, 0x2E]
	movs r0, 0x1
	ands r0, r1
	cmp r0, 0
	beq _080FE378
	movs r0, 0x5
	bl PlaySE
	ldr r1, _080FE374 @ =gUnknown_083EC604
	ldr r0, _080FE370 @ =gUnknown_020388D4
	ldrb r0, [r0]
	lsls r0, 3
	adds r1, 0x4
	adds r0, r1
	ldr r1, [r0]
	adds r0, r6, 0
	bl _call_via_r1
	b _080FE38C
	.align 2, 0
_080FE368: .4byte gPaletteFade
_080FE36C: .4byte gMain
_080FE370: .4byte gUnknown_020388D4
_080FE374: .4byte gUnknown_083EC604
_080FE378:
	movs r0, 0x2
	ands r0, r1
	cmp r0, 0
	beq _080FE38C
	movs r0, 0x5
	bl PlaySE
	adds r0, r7, 0
	bl gpu_pal_decompress_alloc_tag_and_upload
_080FE38C:
	pop {r4-r7}
	pop {r0}
	bx r0
	thumb_func_end Task_DecorationPCProcessMenuInput

	thumb_func_start sub_80FE394
sub_80FE394: @ 80FE394
	push {lr}
	movs r0, 0x2
	movs r1, 0xF
	movs r2, 0x1B
	movs r3, 0x12
	bl MenuFillWindowRectWithBlankTile
	ldr r1, _080FE3BC @ =gUnknown_083EC624
	ldr r0, _080FE3C0 @ =gUnknown_020388D4
	ldrb r0, [r0]
	lsls r0, 2
	adds r0, r1
	ldr r0, [r0]
	movs r1, 0x2
	movs r2, 0xF
	bl MenuPrint
	pop {r0}
	bx r0
	.align 2, 0
_080FE3BC: .4byte gUnknown_083EC624
_080FE3C0: .4byte gUnknown_020388D4
	thumb_func_end sub_80FE394

	thumb_func_start gpu_pal_decompress_alloc_tag_and_upload
gpu_pal_decompress_alloc_tag_and_upload: @ 80FE3C4
	push {r4,lr}
	lsls r0, 24
	lsrs r4, r0, 24
	bl sub_8072DEC
	movs r0, 0
	movs r1, 0
	movs r2, 0xA
	movs r3, 0x9
	bl MenuZeroFillWindowRect
	movs r0, 0x2
	movs r1, 0xF
	movs r2, 0x1B
	movs r3, 0x12
	bl MenuFillWindowRectWithBlankTile
	movs r0, 0x6
	bl FreeSpritePaletteByTag
	ldr r0, _080FE404 @ =0x0201f000
	ldrb r0, [r0, 0x9]
	cmp r0, 0
	bne _080FE40C
	ldr r0, _080FE408 @ =gUnknown_0815F399
	bl ScriptContext1_SetupScript
	adds r0, r4, 0
	bl DestroyTask
	b _080FE412
	.align 2, 0
_080FE404: .4byte 0x0201f000
_080FE408: .4byte gUnknown_0815F399
_080FE40C:
	adds r0, r4, 0
	bl ReshowPlayerPC
_080FE412:
	pop {r4}
	pop {r0}
	bx r0
	thumb_func_end gpu_pal_decompress_alloc_tag_and_upload

	thumb_func_start sub_80FE418
sub_80FE418: @ 80FE418
	push {lr}
	lsls r0, 24
	lsrs r0, 24
	bl sub_80FE5AC
	pop {r0}
	bx r0
	thumb_func_end sub_80FE418

	thumb_func_start sub_80FE428
sub_80FE428: @ 80FE428
	push {r4,lr}
	sub sp, 0x8
	adds r4, r0, 0
	lsls r4, 24
	lsrs r4, 24
	ldr r0, _080FE464 @ =gUnknown_020388D4
	ldrb r0, [r0]
	str r0, [sp]
	movs r0, 0x9
	str r0, [sp, 0x4]
	movs r0, 0
	movs r1, 0x1
	movs r2, 0x1
	movs r3, 0x4
	bl InitMenu
	bl sub_80FE394
	ldr r1, _080FE468 @ =gTasks
	lsls r0, r4, 2
	adds r0, r4
	lsls r0, 3
	adds r0, r1
	ldr r1, _080FE46C @ =sub_80FE2EC
	str r1, [r0]
	add sp, 0x8
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
_080FE464: .4byte gUnknown_020388D4
_080FE468: .4byte gTasks
_080FE46C: .4byte Task_DecorationPCProcessMenuInput
	thumb_func_end sub_80FE428

	thumb_func_start sub_80FE470
sub_80FE470: @ 80FE470
	push {r4-r7,lr}
	mov r7, r10
	mov r6, r9
	mov r5, r8
	push {r5-r7}
	adds r4, r0, 0
	mov r8, r1
	mov r9, r2
	adds r5, r3, 0
	lsls r4, 24
	lsrs r4, 24
	mov r0, r8
	lsls r0, 24
	lsrs r0, 24
	mov r8, r0
	mov r0, r9
	lsls r0, 24
	lsrs r0, 24
	mov r9, r0
	lsls r5, 24
	lsrs r5, 24
	bl sub_8072CBC
	adds r6, r0, 0
	lsls r6, 24
	lsrs r6, 24
	ldr r7, _080FE51C @ =gStringVar4
	movs r0, 0xFC
	strb r0, [r7]
	movs r0, 0x5
	mov r10, r0
	strb r0, [r7, 0x1]
	strb r5, [r7, 0x2]
	adds r7, 0x3
	ldr r1, _080FE520 @ =gUnknown_083EC5E4
	lsls r0, r4, 2
	adds r0, r1
	ldr r1, [r0]
	adds r0, r7, 0
	bl StringCopy
	adds r7, r0, 0
	adds r0, r4, 0
	bl sub_8134194
	adds r1, r0, 0
	lsls r1, 24
	lsrs r1, 24
	adds r0, r7, 0
	movs r2, 0x56
	movs r3, 0x1
	bl sub_8072C14
	adds r7, r0, 0
	movs r0, 0xBA
	strb r0, [r7]
	adds r7, 0x1
	ldr r0, _080FE524 @ =gDecorationInventories
	lsls r4, 3
	adds r4, r0
	ldrb r1, [r4, 0x4]
	adds r0, r7, 0
	movs r2, 0x68
	movs r3, 0x1
	bl sub_8072C14
	adds r7, r0, 0
	movs r0, 0xFC
	strb r0, [r7]
	mov r0, r10
	strb r0, [r7, 0x1]
	strb r6, [r7, 0x2]
	movs r0, 0xFF
	strb r0, [r7, 0x3]
	ldr r0, _080FE51C @ =gStringVar4
	mov r1, r8
	mov r2, r9
	bl MenuPrint
	pop {r3-r5}
	mov r8, r3
	mov r9, r4
	mov r10, r5
	pop {r4-r7}
	pop {r0}
	bx r0
	.align 2, 0
_080FE51C: .4byte gStringVar4
_080FE520: .4byte gUnknown_083EC5E4
_080FE524: .4byte gDecorationInventories
	thumb_func_end sub_80FE470

	thumb_func_start sub_80FE528
sub_80FE528: @ 80FE528
	push {r4,r5,lr}
	adds r4, r0, 0
	lsls r4, 24
	lsrs r4, 24
	movs r0, 0
	movs r1, 0
	movs r2, 0xE
	movs r3, 0x13
	bl MenuDrawTextWindow
	movs r5, 0
	ldr r1, _080FE574 @ =gTasks
	lsls r0, r4, 2
	adds r0, r4
	lsls r0, 3
	adds r4, r0, r1
_080FE548:
	ldr r0, _080FE578 @ =0x0201f000
	ldrb r0, [r0, 0x9]
	cmp r0, 0x1
	bne _080FE57C
	movs r1, 0x1E
	ldrsh r0, [r4, r1]
	cmp r0, 0
	bne _080FE57C
	cmp r5, 0x6
	beq _080FE57C
	cmp r5, 0x7
	beq _080FE57C
	lsls r2, r5, 1
	adds r2, 0x1
	lsls r2, 24
	lsrs r2, 24
	adds r0, r5, 0
	movs r1, 0x1
	movs r3, 0xD
	bl sub_80FE470
	b _080FE58E
	.align 2, 0
_080FE574: .4byte gTasks
_080FE578: .4byte 0x0201f000
_080FE57C:
	lsls r2, r5, 1
	adds r2, 0x1
	lsls r2, 24
	lsrs r2, 24
	adds r0, r5, 0
	movs r1, 0x1
	movs r3, 0xFF
	bl sub_80FE470
_080FE58E:
	adds r0, r5, 0x1
	lsls r0, 24
	lsrs r5, r0, 24
	cmp r5, 0x7
	bls _080FE548
	ldr r0, _080FE5A8 @ =gUnknownText_Exit
	movs r1, 0x1
	movs r2, 0x11
	bl MenuPrint
	pop {r4,r5}
	pop {r0}
	bx r0
	.align 2, 0
_080FE5A8: .4byte gUnknownText_Exit
	thumb_func_end sub_80FE528

	thumb_func_start sub_80FE5AC
sub_80FE5AC: @ 80FE5AC
	push {r4,lr}
	sub sp, 0x8
	adds r4, r0, 0
	lsls r4, 24
	lsrs r4, 24
	bl sub_8072DEC
	movs r0, 0
	movs r1, 0
	movs r2, 0x1D
	movs r3, 0x13
	bl MenuZeroFillWindowRect
	adds r0, r4, 0
	bl sub_80FE528
	ldr r0, _080FE5F8 @ =gUnknown_020388F6
	ldrb r0, [r0]
	str r0, [sp]
	movs r0, 0xD
	str r0, [sp, 0x4]
	movs r0, 0
	movs r1, 0x1
	movs r2, 0x1
	movs r3, 0x9
	bl InitMenu
	ldr r1, _080FE5FC @ =gTasks
	lsls r0, r4, 2
	adds r0, r4
	lsls r0, 3
	adds r0, r1
	ldr r1, _080FE600 @ =sub_80FE604
	str r1, [r0]
	add sp, 0x8
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
_080FE5F8: .4byte gUnknown_020388F6
_080FE5FC: .4byte gTasks
_080FE600: .4byte sub_80FE604
	thumb_func_end sub_80FE5AC

	thumb_func_start sub_80FE604
sub_80FE604: @ 80FE604
	push {r4,r5,lr}
	lsls r0, 24
	lsrs r5, r0, 24
	adds r4, r5, 0
	ldr r0, _080FE638 @ =gPaletteFade
	ldrb r1, [r0, 0x7]
	movs r3, 0x80
	adds r0, r3, 0
	ands r0, r1
	cmp r0, 0
	beq _080FE61C
	b _080FE720
_080FE61C:
	ldr r2, _080FE63C @ =gMain
	ldrh r1, [r2, 0x30]
	movs r0, 0x40
	ands r0, r1
	cmp r0, 0
	beq _080FE640
	movs r0, 0x5
	bl PlaySE
	movs r0, 0x1
	negs r0, r0
	bl MoveMenuCursor
	b _080FE720
	.align 2, 0
_080FE638: .4byte gPaletteFade
_080FE63C: .4byte gMain
_080FE640:
	adds r0, r3, 0
	ands r0, r1
	cmp r0, 0
	beq _080FE656
	movs r0, 0x5
	bl PlaySE
	movs r0, 0x1
	bl MoveMenuCursor
	b _080FE720
_080FE656:
	ldrh r1, [r2, 0x2E]
	movs r0, 0x1
	ands r0, r1
	cmp r0, 0
	beq _080FE70C
	movs r0, 0x5
	bl PlaySE
	bl GetMenuCursorPos
	ldr r4, _080FE6C0 @ =gUnknown_020388F6
	strb r0, [r4]
	lsls r0, 24
	lsrs r0, 24
	cmp r0, 0x8
	beq _080FE704
	ldrb r0, [r4]
	bl sub_8134194
	ldr r1, _080FE6C4 @ =gUnknown_020388D5
	strb r0, [r1]
	lsls r0, 24
	cmp r0, 0
	beq _080FE6DC
	ldrb r0, [r4]
	bl sub_8134104
	ldr r2, _080FE6C8 @ =gUnknown_020388D0
	ldr r1, _080FE6CC @ =gDecorationInventories
	ldrb r0, [r4]
	lsls r0, 3
	adds r0, r1
	ldr r0, [r0]
	str r0, [r2]
	adds r0, r5, 0
	bl sub_80FEF50
	bl sub_80F944C
	ldr r0, _080FE6D0 @ =gUnknown_020388F7
	movs r1, 0x8
	bl sub_80F9480
	bl LoadScrollIndicatorPalette
	ldr r1, _080FE6D4 @ =gTasks
	lsls r0, r5, 2
	adds r0, r5
	lsls r0, 3
	adds r0, r1
	ldr r1, _080FE6D8 @ =sub_80FE868
	str r1, [r0]
	b _080FE720
	.align 2, 0
_080FE6C0: .4byte gUnknown_020388F6
_080FE6C4: .4byte gUnknown_020388D5
_080FE6C8: .4byte gUnknown_020388D0
_080FE6CC: .4byte gDecorationInventories
_080FE6D0: .4byte gUnknown_020388F7
_080FE6D4: .4byte gTasks
_080FE6D8: .4byte sub_80FE868
_080FE6DC:
	bl sub_8072DEC
	movs r0, 0
	movs r1, 0
	movs r2, 0xE
	movs r3, 0x13
	bl MenuZeroFillWindowRect
	ldr r1, _080FE6FC @ =gSecretBaseText_NoDecors
	ldr r2, _080FE700 @ =sub_80FE418
	adds r0, r5, 0
	movs r3, 0
	bl DisplayItemMessageOnField
	b _080FE720
	.align 2, 0
_080FE6FC: .4byte gSecretBaseText_NoDecors
_080FE700: .4byte sub_80FE418
_080FE704:
	adds r0, r5, 0
	bl sub_80FE728
	b _080FE720
_080FE70C:
	movs r0, 0x2
	ands r0, r1
	cmp r0, 0
	beq _080FE720
	movs r0, 0x5
	bl PlaySE
	adds r0, r4, 0
	bl sub_80FE728
_080FE720:
	pop {r4,r5}
	pop {r0}
	bx r0
	thumb_func_end sub_80FE604

	thumb_func_start sub_80FE728
sub_80FE728: @ 80FE728
	push {lr}
	lsls r0, 24
	lsrs r2, r0, 24
	ldr r1, _080FE748 @ =gTasks
	lsls r0, r2, 2
	adds r0, r2
	lsls r0, 3
	adds r0, r1
	movs r1, 0x1E
	ldrsh r0, [r0, r1]
	cmp r0, 0x3
	beq _080FE74C
	adds r0, r2, 0
	bl sub_80FE758
	b _080FE752
	.align 2, 0
_080FE748: .4byte gTasks
_080FE74C:
	adds r0, r2, 0
	bl sub_8109DAC
_080FE752:
	pop {r0}
	bx r0
	thumb_func_end sub_80FE728

	thumb_func_start sub_80FE758
sub_80FE758: @ 80FE758
	push {r4,r5,lr}
	lsls r0, 24
	lsrs r4, r0, 24
	bl sub_8072DEC
	movs r0, 0
	movs r1, 0
	movs r2, 0xE
	movs r3, 0x13
	bl MenuZeroFillWindowRect
	ldr r1, _080FE794 @ =gTasks
	lsls r0, r4, 2
	adds r0, r4
	lsls r0, 3
	adds r5, r0, r1
	movs r1, 0x1E
	ldrsh r0, [r5, r1]
	cmp r0, 0x2
	beq _080FE79C
	bl sub_80FE1DC
	bl MenuDisplayMessageBox
	bl sub_80FE394
	ldr r0, _080FE798 @ =sub_80FE2EC
	str r0, [r5]
	b _080FE7A2
	.align 2, 0
_080FE794: .4byte gTasks
_080FE798: .4byte Task_DecorationPCProcessMenuInput
_080FE79C:
	adds r0, r4, 0
	bl sub_80B3068
_080FE7A2:
	pop {r4,r5}
	pop {r0}
	bx r0
	thumb_func_end sub_80FE758

	thumb_func_start sub_80FE7A8
sub_80FE7A8: @ 80FE7A8
	push {lr}
	lsls r0, 24
	lsrs r0, 24
	ldr r2, _080FE7CC @ =gTasks
	lsls r1, r0, 2
	adds r1, r0
	lsls r1, 3
	adds r1, r2
	movs r3, 0
	movs r2, 0x3
	strh r2, [r1, 0x1E]
	ldr r1, _080FE7D0 @ =gUnknown_020388F6
	strb r3, [r1]
	bl sub_80FE5AC
	pop {r0}
	bx r0
	.align 2, 0
_080FE7CC: .4byte gTasks
_080FE7D0: .4byte gUnknown_020388F6
	thumb_func_end sub_80FE7A8

	thumb_func_start sub_80FE7D4
sub_80FE7D4: @ 80FE7D4
	push {lr}
	lsls r1, 24
	ldr r2, _080FE7E8 @ =gUnknown_083EC5E4
	lsrs r1, 22
	adds r1, r2
	ldr r1, [r1]
	bl StringCopy
	pop {r0}
	bx r0
	.align 2, 0
_080FE7E8: .4byte gUnknown_083EC5E4
	thumb_func_end sub_80FE7D4

	thumb_func_start sub_80FE7EC
sub_80FE7EC: @ 80FE7EC
	push {r4,lr}
	sub sp, 0x8
	adds r4, r0, 0
	lsls r4, 24
	lsrs r4, 24
	bl sub_8072DEC
	movs r0, 0
	movs r1, 0
	movs r2, 0x1D
	movs r3, 0x13
	bl MenuZeroFillWindowRect
	adds r0, r4, 0
	bl sub_80FEC94
	ldr r0, _080FE858 @ =gUnknown_020388F6
	ldrb r0, [r0]
	bl sub_80FECB8
	movs r0, 0xF
	movs r1, 0xC
	movs r2, 0x1D
	movs r3, 0x13
	bl MenuDrawTextWindow
	ldr r4, _080FE85C @ =gUnknown_020388F2
	ldr r0, _080FE860 @ =gUnknown_020388F4
	ldrb r0, [r0]
	ldrb r1, [r4]
	adds r0, r1
	lsls r0, 24
	lsrs r0, 24
	bl sub_80FECE0
	ldr r0, _080FE864 @ =gUnknown_020388F3
	ldrb r3, [r0]
	adds r3, 0x1
	lsls r3, 24
	lsrs r3, 24
	ldrb r0, [r4]
	str r0, [sp]
	movs r0, 0xD
	str r0, [sp, 0x4]
	movs r0, 0
	movs r1, 0x1
	movs r2, 0x2
	bl InitMenu
	add sp, 0x8
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
_080FE858: .4byte gUnknown_020388F6
_080FE85C: .4byte gUnknown_020388F2
_080FE860: .4byte gUnknown_020388F4
_080FE864: .4byte gUnknown_020388F3
	thumb_func_end sub_80FE7EC

	thumb_func_start sub_80FE868
sub_80FE868: @ 80FE868
	push {r4,lr}
	adds r4, r0, 0
	lsls r4, 24
	lsrs r4, 24
	adds r0, r4, 0
	bl sub_80FE7EC
	ldr r1, _080FE88C @ =gTasks
	lsls r0, r4, 2
	adds r0, r4
	lsls r0, 3
	adds r0, r1
	ldr r1, _080FE890 @ =sub_80FE948
	str r1, [r0]
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
_080FE88C: .4byte gTasks
_080FE890: .4byte sub_80FE948
	thumb_func_end sub_80FE868

	thumb_func_start sub_80FE894
sub_80FE894: @ 80FE894
	push {r4-r7,lr}
	mov r7, r10
	mov r6, r9
	mov r5, r8
	push {r5-r7}
	lsls r0, 24
	lsrs r0, 24
	mov r8, r0
	lsls r1, 24
	lsrs r5, r1, 24
	lsls r2, 24
	lsrs r7, r2, 24
	movs r0, 0
	mov r10, r0
	ldr r6, _080FE920 @ =gUnknown_020388F2
	ldrb r1, [r6]
	ldr r4, _080FE924 @ =gUnknown_020388F4
	ldrb r0, [r4]
	adds r1, r0
	ldr r2, _080FE928 @ =gUnknown_020388D5
	mov r9, r2
	ldrb r0, [r2]
	cmp r1, r0
	bne _080FE8C8
	movs r1, 0x1
	mov r10, r1
_080FE8C8:
	movs r0, 0x5
	bl PlaySE
	lsls r0, r5, 24
	asrs r0, 24
	cmp r0, 0
	beq _080FE8DC
	bl MoveMenuCursor
	strb r0, [r6]
_080FE8DC:
	cmp r7, 0
	beq _080FE8EE
	ldrb r0, [r4]
	adds r0, r7
	strb r0, [r4]
	mov r0, r8
	movs r1, 0x1
	bl sub_80FEABC
_080FE8EE:
	ldrb r0, [r6]
	ldrb r1, [r4]
	adds r0, r1
	mov r2, r9
	ldrb r2, [r2]
	cmp r0, r2
	beq _080FE92C
	mov r0, r10
	cmp r0, 0
	beq _080FE90E
	movs r0, 0xF
	movs r1, 0xC
	movs r2, 0x1D
	movs r3, 0x13
	bl MenuDrawTextWindow
_080FE90E:
	ldrb r0, [r4]
	ldrb r6, [r6]
	adds r0, r6
	lsls r0, 24
	lsrs r0, 24
	bl sub_80FECE0
	b _080FE938
	.align 2, 0
_080FE920: .4byte gUnknown_020388F2
_080FE924: .4byte gUnknown_020388F4
_080FE928: .4byte gUnknown_020388D5
_080FE92C:
	movs r0, 0xF
	movs r1, 0xC
	movs r2, 0x1D
	movs r3, 0x13
	bl MenuZeroFillWindowRect
_080FE938:
	pop {r3-r5}
	mov r8, r3
	mov r9, r4
	mov r10, r5
	pop {r4-r7}
	pop {r0}
	bx r0
	thumb_func_end sub_80FE894

	thumb_func_start sub_80FE948
sub_80FE948: @ 80FE948
	push {r4,lr}
	lsls r0, 24
	lsrs r4, r0, 24
	ldr r0, _080FE980 @ =gPaletteFade
	ldrb r1, [r0, 0x7]
	movs r0, 0x80
	ands r0, r1
	cmp r0, 0
	beq _080FE95C
	b _080FEAAC
_080FE95C:
	ldr r0, _080FE984 @ =gMain
	ldrh r1, [r0, 0x30]
	movs r0, 0xF0
	ands r0, r1
	cmp r0, 0x40
	bne _080FE9A0
	ldr r0, _080FE988 @ =gUnknown_020388F2
	ldrb r0, [r0]
	cmp r0, 0
	beq _080FE98C
	movs r1, 0x1
	negs r1, r1
	adds r0, r4, 0
	movs r2, 0
	bl sub_80FE894
	b _080FE9A0
	.align 2, 0
_080FE980: .4byte gPaletteFade
_080FE984: .4byte gMain
_080FE988: .4byte gUnknown_020388F2
_080FE98C:
	ldr r0, _080FE9C4 @ =gUnknown_020388F4
	ldrb r0, [r0]
	cmp r0, 0
	beq _080FE9A0
	movs r2, 0x1
	negs r2, r2
	adds r0, r4, 0
	movs r1, 0
	bl sub_80FE894
_080FE9A0:
	ldr r0, _080FE9C8 @ =gMain
	ldrh r1, [r0, 0x30]
	movs r0, 0xF0
	ands r0, r1
	cmp r0, 0x80
	bne _080FE9EE
	ldr r2, _080FE9CC @ =gUnknown_020388F2
	ldr r1, _080FE9D0 @ =gUnknown_020388F3
	ldrb r0, [r2]
	ldrb r1, [r1]
	cmp r0, r1
	beq _080FE9D4
	adds r0, r4, 0
	movs r1, 0x1
	movs r2, 0
	bl sub_80FE894
	b _080FE9EE
	.align 2, 0
_080FE9C4: .4byte gUnknown_020388F4
_080FE9C8: .4byte gMain
_080FE9CC: .4byte gUnknown_020388F2
_080FE9D0: .4byte gUnknown_020388F3
_080FE9D4:
	ldr r0, _080FEA38 @ =gUnknown_020388F4
	ldrb r0, [r0]
	ldrb r1, [r2]
	adds r0, r1
	ldr r1, _080FEA3C @ =gUnknown_020388D5
	ldrb r1, [r1]
	cmp r0, r1
	beq _080FE9EE
	adds r0, r4, 0
	movs r1, 0
	movs r2, 0x1
	bl sub_80FE894
_080FE9EE:
	ldr r0, _080FEA40 @ =gMain
	ldrh r1, [r0, 0x2E]
	movs r0, 0x1
	ands r0, r1
	cmp r0, 0
	beq _080FEA7C
	bl sub_8072DEC
	movs r0, 0x5
	bl PlaySE
	ldr r2, _080FEA44 @ =gUnknown_020388F5
	ldr r1, _080FEA48 @ =gUnknown_020388F2
	ldr r0, _080FEA38 @ =gUnknown_020388F4
	ldrb r0, [r0]
	ldrb r1, [r1]
	adds r0, r1
	strb r0, [r2]
	ldr r1, _080FEA3C @ =gUnknown_020388D5
	lsls r0, 24
	lsrs r0, 24
	ldrb r1, [r1]
	cmp r0, r1
	bne _080FEA54
	ldr r1, _080FEA4C @ =gUnknown_083EC634
	ldr r2, _080FEA50 @ =gTasks
	lsls r0, r4, 2
	adds r0, r4
	lsls r0, 3
	adds r0, r2
	movs r2, 0x1E
	ldrsh r0, [r0, r2]
	lsls r0, 3
	adds r1, 0x4
	adds r0, r1
	b _080FEA68
	.align 2, 0
_080FEA38: .4byte gUnknown_020388F4
_080FEA3C: .4byte gUnknown_020388D5
_080FEA40: .4byte gMain
_080FEA44: .4byte gUnknown_020388F5
_080FEA48: .4byte gUnknown_020388F2
_080FEA4C: .4byte gUnknown_083EC634
_080FEA50: .4byte gTasks
_080FEA54:
	ldr r2, _080FEA74 @ =gUnknown_083EC634
	ldr r1, _080FEA78 @ =gTasks
	lsls r0, r4, 2
	adds r0, r4
	lsls r0, 3
	adds r0, r1
	movs r1, 0x1E
	ldrsh r0, [r0, r1]
	lsls r0, 3
	adds r0, r2
_080FEA68:
	ldr r1, [r0]
	adds r0, r4, 0
	bl _call_via_r1
	b _080FEAAC
	.align 2, 0
_080FEA74: .4byte gUnknown_083EC634
_080FEA78: .4byte gTasks
_080FEA7C:
	movs r0, 0x2
	ands r0, r1
	cmp r0, 0
	beq _080FEAAC
	bl sub_8072DEC
	movs r0, 0x5
	bl PlaySE
	ldr r1, _080FEAB4 @ =gUnknown_083EC634
	ldr r2, _080FEAB8 @ =gTasks
	lsls r0, r4, 2
	adds r0, r4
	lsls r0, 3
	adds r0, r2
	movs r2, 0x1E
	ldrsh r0, [r0, r2]
	lsls r0, 3
	adds r1, 0x4
	adds r0, r1
	ldr r1, [r0]
	adds r0, r4, 0
	bl _call_via_r1
_080FEAAC:
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
_080FEAB4: .4byte gUnknown_083EC634
_080FEAB8: .4byte gTasks
	thumb_func_end sub_80FE948

	thumb_func_start sub_80FEABC
sub_80FEABC: @ 80FEABC
	push {r4-r7,lr}
	mov r7, r8
	push {r7}
	sub sp, 0x4
	lsls r0, 24
	lsrs r0, 24
	mov r8, r0
	ldr r4, _080FEB58 @ =gUnknown_020388F4
	ldrb r0, [r4]
	cmp r0, 0
	bne _080FEADE
	movs r0, 0
	bl DestroyVerticalScrollIndicator
	ldrb r0, [r4]
	cmp r0, 0
	beq _080FEAE8
_080FEADE:
	movs r0, 0
	movs r1, 0x3C
	movs r2, 0x8
	bl CreateVerticalScrollIndicators
_080FEAE8:
	ldr r5, _080FEB58 @ =gUnknown_020388F4
	ldrb r0, [r5]
	adds r0, 0x7
	ldr r4, _080FEB5C @ =gUnknown_020388D5
	ldrb r1, [r4]
	cmp r0, r1
	bne _080FEAFC
	movs r0, 0x1
	bl DestroyVerticalScrollIndicator
_080FEAFC:
	ldrb r0, [r5]
	adds r0, 0x7
	ldrb r4, [r4]
	cmp r0, r4
	bge _080FEB10
	movs r0, 0x1
	movs r1, 0x3C
	movs r2, 0x98
	bl CreateVerticalScrollIndicators
_080FEB10:
	ldrb r4, [r5]
	adds r0, r4, 0
	adds r0, 0x8
	cmp r4, r0
	blt _080FEB1C
	b _080FEC7E
_080FEB1C:
	adds r7, r5, 0
_080FEB1E:
	ldrb r1, [r7]
	subs r1, r4, r1
	lsls r0, r1, 25
	movs r2, 0x80
	lsls r2, 18
	adds r0, r2
	lsrs r6, r0, 24
	ldr r0, _080FEB60 @ =gUnknown_020388F7
	adds r1, r0
	ldrb r0, [r1]
	cmp r0, 0
	beq _080FEB3C
	adds r0, r1, 0
	bl sub_80F94F8
_080FEB3C:
	ldr r0, _080FEB5C @ =gUnknown_020388D5
	ldrb r0, [r0]
	cmp r4, r0
	bne _080FEB68
	lsls r2, r6, 3
	movs r0, 0x1
	str r0, [sp]
	ldr r0, _080FEB64 @ =gUnknownText_Exit
	movs r1, 0x8
	movs r3, 0x68
	bl sub_8072A18
	b _080FEC7E
	.align 2, 0
_080FEB58: .4byte gUnknown_020388F4
_080FEB5C: .4byte gUnknown_020388D5
_080FEB60: .4byte gUnknown_020388F7
_080FEB64: .4byte gUnknownText_Exit
_080FEB68:
	ldr r0, _080FEBC0 @ =gUnknown_020388D0
	ldr r1, [r0]
	adds r2, r1, r4
	ldrb r1, [r2]
	mov r12, r0
	adds r5, r4, 0x1
	cmp r1, 0
	bne _080FEB7A
	b _080FEC70
_080FEB7A:
	ldr r0, _080FEBC4 @ =0x0201f000
	ldrb r5, [r0, 0x9]
	cmp r5, 0x1
	bne _080FEBDC
	ldr r0, _080FEBC8 @ =gUnknown_020388F6
	ldrb r0, [r0]
	cmp r0, 0x6
	beq _080FEBDC
	cmp r0, 0x7
	beq _080FEBDC
	ldr r0, _080FEBCC @ =gTasks
	mov r3, r8
	lsls r1, r3, 2
	add r1, r8
	lsls r1, 3
	adds r1, r0
	movs r3, 0x1E
	ldrsh r0, [r1, r3]
	cmp r0, 0
	bne _080FEBDC
	ldrb r1, [r2]
	lsls r1, 5
	ldr r0, _080FEBD0 @ =gDecorations + 0x1
	adds r1, r0
	ldr r0, _080FEBD4 @ =gStringVar1
	bl StringCopy
	lsls r2, r6, 3
	str r5, [sp]
	ldr r0, _080FEBD8 @ =gUnknown_083EC65A
	movs r1, 0x8
	movs r3, 0x68
	bl sub_8072A18
	b _080FEBF8
	.align 2, 0
_080FEBC0: .4byte gUnknown_020388D0
_080FEBC4: .4byte 0x0201f000
_080FEBC8: .4byte gUnknown_020388F6
_080FEBCC: .4byte gTasks
_080FEBD0: .4byte gDecorations + 0x1
_080FEBD4: .4byte gStringVar1
_080FEBD8: .4byte gUnknown_083EC65A
_080FEBDC:
	mov r1, r12
	ldr r0, [r1]
	adds r0, r4
	ldrb r0, [r0]
	lsls r0, 5
	ldr r1, _080FEC00 @ =gDecorations + 0x1
	adds r0, r1
	lsls r2, r6, 3
	movs r1, 0x1
	str r1, [sp]
	movs r1, 0x8
	movs r3, 0x68
	bl sub_8072A18
_080FEBF8:
	movs r1, 0
	adds r5, r4, 0x1
	b _080FEC0A
	.align 2, 0
_080FEC00: .4byte gDecorations + 0x1
_080FEC04:
	adds r0, r1, 0x1
	lsls r0, 16
	lsrs r1, r0, 16
_080FEC0A:
	cmp r1, 0xF
	bhi _080FEC34
	ldr r0, _080FEC38 @ =gUnknown_020388D6
	adds r0, r1, r0
	ldrb r0, [r0]
	subs r0, 0x1
	cmp r0, r4
	bne _080FEC04
	ldrb r3, [r7]
	subs r3, r4, r3
	ldr r1, _080FEC3C @ =gUnknown_020388F7
	adds r1, r3, r1
	lsls r3, 20
	movs r2, 0xC0
	lsls r2, 13
	adds r3, r2
	asrs r3, 16
	movs r0, 0x4
	movs r2, 0x6C
	bl sub_80F94A4
_080FEC34:
	movs r1, 0
	b _080FEC46
	.align 2, 0
_080FEC38: .4byte gUnknown_020388D6
_080FEC3C: .4byte gUnknown_020388F7
_080FEC40:
	adds r0, r1, 0x1
	lsls r0, 16
	lsrs r1, r0, 16
_080FEC46:
	cmp r1, 0xB
	bhi _080FEC70
	ldr r0, _080FEC8C @ =gUnknown_020388E6
	adds r0, r1, r0
	ldrb r0, [r0]
	subs r0, 0x1
	cmp r0, r4
	bne _080FEC40
	ldrb r3, [r7]
	subs r3, r4, r3
	ldr r1, _080FEC90 @ =gUnknown_020388F7
	adds r1, r3, r1
	lsls r3, 20
	movs r0, 0xC0
	lsls r0, 13
	adds r3, r0
	asrs r3, 16
	movs r0, 0x5
	movs r2, 0x6C
	bl sub_80F94A4
_080FEC70:
	lsls r0, r5, 16
	lsrs r4, r0, 16
	ldrb r0, [r7]
	adds r0, 0x8
	cmp r4, r0
	bge _080FEC7E
	b _080FEB1E
_080FEC7E:
	add sp, 0x4
	pop {r3}
	mov r8, r3
	pop {r4-r7}
	pop {r0}
	bx r0
	.align 2, 0
_080FEC8C: .4byte gUnknown_020388E6
_080FEC90: .4byte gUnknown_020388F7
	thumb_func_end sub_80FEABC

	thumb_func_start sub_80FEC94
sub_80FEC94: @ 80FEC94
	push {r4,lr}
	adds r4, r0, 0
	lsls r4, 24
	lsrs r4, 24
	movs r0, 0
	movs r1, 0
	movs r2, 0xE
	movs r3, 0x13
	bl MenuDrawTextWindow
	adds r0, r4, 0
	movs r1, 0
	bl sub_80FEABC
	pop {r4}
	pop {r0}
	bx r0
	thumb_func_end sub_80FEC94

	thumb_func_start sub_80FECB8
sub_80FECB8: @ 80FECB8
	push {r4,lr}
	adds r4, r0, 0
	lsls r4, 24
	lsrs r4, 24
	movs r0, 0xF
	movs r1, 0
	movs r2, 0x1D
	movs r3, 0x3
	bl MenuDrawTextWindow
	adds r0, r4, 0
	movs r1, 0x10
	movs r2, 0x1
	movs r3, 0xFF
	bl sub_80FE470
	pop {r4}
	pop {r0}
	bx r0
	thumb_func_end sub_80FECB8

	thumb_func_start sub_80FECE0
sub_80FECE0: @ 80FECE0
	push {lr}
	sub sp, 0x8
	lsls r0, 24
	lsrs r0, 24
	ldr r2, _080FED14 @ =gDecorations
	ldr r1, _080FED18 @ =gUnknown_020388D0
	ldr r1, [r1]
	adds r1, r0
	ldrb r0, [r1]
	lsls r0, 5
	adds r2, 0x18
	adds r0, r2
	ldr r0, [r0]
	movs r1, 0x30
	str r1, [sp]
	movs r1, 0x1
	str r1, [sp, 0x4]
	movs r1, 0x80
	movs r2, 0x68
	movs r3, 0x68
	bl sub_8072AB0
	add sp, 0x8
	pop {r0}
	bx r0
	.align 2, 0
_080FED14: .4byte gDecorations
_080FED18: .4byte gUnknown_020388D0
	thumb_func_end sub_80FECE0

	thumb_func_start sub_80FED1C
sub_80FED1C: @ 80FED1C
	push {lr}
	movs r0, 0xF
	movs r1, 0
	movs r2, 0x1D
	movs r3, 0x3
	bl MenuZeroFillWindowRect
	movs r0, 0xF
	movs r1, 0xC
	movs r2, 0x1D
	movs r3, 0x13
	bl MenuZeroFillWindowRect
	pop {r0}
	bx r0
	thumb_func_end sub_80FED1C

	thumb_func_start sub_80FED3C
sub_80FED3C: @ 80FED3C
	push {r4,lr}
	adds r4, r0, 0
	lsls r4, 24
	lsrs r4, 24
	bl LoadScrollIndicatorPalette
	ldr r1, _080FED5C @ =gTasks
	lsls r0, r4, 2
	adds r0, r4
	lsls r0, 3
	adds r0, r1
	ldr r1, _080FED60 @ =sub_80FE868
	str r1, [r0]
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
_080FED5C: .4byte gTasks
_080FED60: .4byte sub_80FE868
	thumb_func_end sub_80FED3C

	thumb_func_start sub_80FED64
sub_80FED64: @ 80FED64
	push {lr}
	lsls r0, 24
	lsrs r2, r0, 24
	movs r1, 0
	ldr r3, _080FED7C @ =gUnknown_020388D6
_080FED6E:
	adds r0, r1, r3
	ldrb r0, [r0]
	cmp r0, r2
	bne _080FED80
	movs r0, 0x1
	b _080FED8C
	.align 2, 0
_080FED7C: .4byte gUnknown_020388D6
_080FED80:
	adds r0, r1, 0x1
	lsls r0, 24
	lsrs r1, r0, 24
	cmp r1, 0xF
	bls _080FED6E
	movs r0, 0
_080FED8C:
	pop {r1}
	bx r1
	thumb_func_end sub_80FED64

	thumb_func_start sub_80FED90
sub_80FED90: @ 80FED90
	push {r4-r7,lr}
	mov r7, r10
	mov r6, r9
	mov r5, r8
	push {r5-r7}
	movs r6, 0
	movs r3, 0
	ldr r4, _080FEE30 @ =gUnknown_020388D6
	movs r1, 0
	ldr r2, _080FEE34 @ =gUnknown_020388E6
_080FEDA4:
	adds r0, r3, r4
	strb r1, [r0]
	cmp r3, 0xB
	bhi _080FEDB0
	adds r0, r3, r2
	strb r1, [r0]
_080FEDB0:
	adds r0, r3, 0x1
	lsls r0, 16
	lsrs r3, r0, 16
	cmp r3, 0xF
	bls _080FEDA4
	movs r3, 0
	ldr r0, _080FEE38 @ =gSaveBlock1 + 0x1A1A
	mov r10, r0
	ldr r1, _080FEE3C @ =gDecorationInventories
	mov r9, r1
	ldr r2, _080FEE40 @ =gUnknown_020388F6
	mov r8, r2
_080FEDC8:
	mov r1, r10
	adds r0, r3, r1
	ldrb r0, [r0]
	cmp r0, 0
	beq _080FEE5A
	movs r1, 0
	mov r2, r8
	ldrb r0, [r2]
	lsls r0, 3
	add r0, r9
	ldrb r0, [r0, 0x4]
	cmp r1, r0
	bcs _080FEE5A
	ldr r0, _080FEE38 @ =gSaveBlock1 + 0x1A1A
	adds r0, r3
	mov r12, r0
	ldr r7, _080FEE30 @ =gUnknown_020388D6
_080FEDEA:
	ldr r0, _080FEE44 @ =gUnknown_020388D0
	ldr r0, [r0]
	adds r0, r1
	ldrb r0, [r0]
	adds r4, r1, 0x1
	mov r1, r12
	ldrb r1, [r1]
	cmp r0, r1
	bne _080FEE48
	movs r1, 0
	cmp r1, r6
	bcs _080FEE1E
	ldrb r0, [r7]
	cmp r0, r4
	beq _080FEE1E
	ldr r5, _080FEE30 @ =gUnknown_020388D6
	adds r2, r4, 0
_080FEE0C:
	adds r0, r1, 0x1
	lsls r0, 16
	lsrs r1, r0, 16
	cmp r1, r6
	bcs _080FEE1E
	adds r0, r1, r5
	ldrb r0, [r0]
	cmp r0, r2
	bne _080FEE0C
_080FEE1E:
	cmp r1, r6
	bne _080FEE48
	adds r0, r6, r7
	strb r4, [r0]
	adds r0, r6, 0x1
	lsls r0, 16
	lsrs r6, r0, 16
	b _080FEE5A
	.align 2, 0
_080FEE30: .4byte gUnknown_020388D6
_080FEE34: .4byte gUnknown_020388E6
_080FEE38: .4byte gSaveBlock1 + 0x1A1A
_080FEE3C: .4byte gDecorationInventories
_080FEE40: .4byte gUnknown_020388F6
_080FEE44: .4byte gUnknown_020388D0
_080FEE48:
	lsls r0, r4, 16
	lsrs r1, r0, 16
	mov r2, r8
	ldrb r0, [r2]
	lsls r0, 3
	add r0, r9
	ldrb r0, [r0, 0x4]
	cmp r1, r0
	bcc _080FEDEA
_080FEE5A:
	adds r0, r3, 0x1
	lsls r0, 16
	lsrs r3, r0, 16
	cmp r3, 0xF
	bls _080FEDC8
	movs r6, 0
	movs r3, 0
	ldr r0, _080FEEE4 @ =gDecorationInventories
	mov r8, r0
_080FEE6C:
	ldr r0, _080FEEE8 @ =gSaveBlock1
	ldr r1, _080FEEEC @ =0x00002688
	adds r0, r1
	adds r2, r3, r0
	ldrb r0, [r2]
	adds r7, r3, 0x1
	cmp r0, 0
	beq _080FEF0E
	movs r1, 0
	ldr r0, _080FEEF0 @ =gUnknown_020388F6
	ldrb r0, [r0]
	lsls r0, 3
	add r0, r8
	ldrb r0, [r0, 0x4]
	cmp r1, r0
	bcs _080FEF0E
	adds r5, r2, 0
_080FEE8E:
	ldr r0, _080FEEF4 @ =gUnknown_020388D0
	ldr r0, [r0]
	adds r0, r1
	ldrb r0, [r0]
	adds r4, r1, 0x1
	ldrb r2, [r5]
	cmp r0, r2
	bne _080FEEFC
	lsls r0, r4, 24
	lsrs r0, 24
	bl sub_80FED64
	lsls r0, 24
	cmp r0, 0
	bne _080FEEFC
	movs r1, 0
	cmp r1, r6
	bcs _080FEED0
	ldr r2, _080FEEF8 @ =gUnknown_020388E6
	ldrb r0, [r2]
	cmp r0, r4
	beq _080FEED0
	adds r3, r2, 0
	adds r2, r4, 0
_080FEEBE:
	adds r0, r1, 0x1
	lsls r0, 16
	lsrs r1, r0, 16
	cmp r1, r6
	bcs _080FEED0
	adds r0, r1, r3
	ldrb r0, [r0]
	cmp r0, r2
	bne _080FEEBE
_080FEED0:
	cmp r1, r6
	bne _080FEEFC
	ldr r0, _080FEEF8 @ =gUnknown_020388E6
	adds r0, r6, r0
	strb r4, [r0]
	adds r0, r6, 0x1
	lsls r0, 16
	lsrs r6, r0, 16
	b _080FEF0E
	.align 2, 0
_080FEEE4: .4byte gDecorationInventories
_080FEEE8: .4byte gSaveBlock1
_080FEEEC: .4byte 0x00002688
_080FEEF0: .4byte gUnknown_020388F6
_080FEEF4: .4byte gUnknown_020388D0
_080FEEF8: .4byte gUnknown_020388E6
_080FEEFC:
	lsls r0, r4, 16
	lsrs r1, r0, 16
	ldr r0, _080FEF24 @ =gUnknown_020388F6
	ldrb r0, [r0]
	lsls r0, 3
	add r0, r8
	ldrb r0, [r0, 0x4]
	cmp r1, r0
	bcc _080FEE8E
_080FEF0E:
	lsls r0, r7, 16
	lsrs r3, r0, 16
	cmp r3, 0xB
	bls _080FEE6C
	pop {r3-r5}
	mov r8, r3
	mov r9, r4
	mov r10, r5
	pop {r4-r7}
	pop {r0}
	bx r0
	.align 2, 0
_080FEF24: .4byte gUnknown_020388F6
	thumb_func_end sub_80FED90

	thumb_func_start sub_80FEF28
sub_80FEF28: @ 80FEF28
	push {lr}
	ldr r0, _080FEF38 @ =gUnknown_020388D5
	ldrb r1, [r0]
	cmp r1, 0x7
	bhi _080FEF40
	ldr r0, _080FEF3C @ =gUnknown_020388F3
	strb r1, [r0]
	b _080FEF46
	.align 2, 0
_080FEF38: .4byte gUnknown_020388D5
_080FEF3C: .4byte gUnknown_020388F3
_080FEF40:
	ldr r1, _080FEF4C @ =gUnknown_020388F3
	movs r0, 0x7
	strb r0, [r1]
_080FEF46:
	pop {r0}
	bx r0
	.align 2, 0
_080FEF4C: .4byte gUnknown_020388F3
	thumb_func_end sub_80FEF28

	thumb_func_start sub_80FEF50
sub_80FEF50: @ 80FEF50
	push {lr}
	lsls r0, 24
	lsrs r0, 24
	bl sub_80FED90
	bl sub_80FEF28
	ldr r0, _080FEF6C @ =gUnknown_020388F2
	movs r1, 0
	strb r1, [r0]
	ldr r0, _080FEF70 @ =gUnknown_020388F4
	strb r1, [r0]
	pop {r0}
	bx r0
	.align 2, 0
_080FEF6C: .4byte gUnknown_020388F2
_080FEF70: .4byte gUnknown_020388F4
	thumb_func_end sub_80FEF50

	thumb_func_start sub_80FEF74
sub_80FEF74: @ 80FEF74
	push {lr}
	ldr r0, _080FEFA0 @ =gUnknown_020388F7
	movs r1, 0x8
	bl sub_80F9520
	movs r0, 0
	bl DestroyVerticalScrollIndicator
	movs r0, 0x1
	bl DestroyVerticalScrollIndicator
	bl sub_8072DEC
	movs r0, 0
	movs r1, 0
	movs r2, 0xE
	movs r3, 0x13
	bl MenuZeroFillWindowRect
	pop {r0}
	bx r0
	.align 2, 0
_080FEFA0: .4byte gUnknown_020388F7
	thumb_func_end sub_80FEF74

	thumb_func_start sub_80FEFA4
sub_80FEFA4: @ 80FEFA4
	push {r4,lr}
	movs r2, 0
	ldr r0, _080FEFD0 @ =gUnknown_020388F4
	ldrb r0, [r0]
	ldr r1, _080FEFD4 @ =gUnknown_020388F2
	ldrb r1, [r1]
	adds r0, r1
	adds r1, r0, 0x1
	ldr r4, _080FEFD8 @ =gUnknown_020388D6
	ldr r3, _080FEFDC @ =gUnknown_020388E6
_080FEFB8:
	adds r0, r2, r4
	ldrb r0, [r0]
	cmp r0, r1
	beq _080FEFCC
	cmp r2, 0xB
	bhi _080FEFE0
	adds r0, r2, r3
	ldrb r0, [r0]
	cmp r0, r1
	bne _080FEFE0
_080FEFCC:
	movs r0, 0
	b _080FEFEC
	.align 2, 0
_080FEFD0: .4byte gUnknown_020388F4
_080FEFD4: .4byte gUnknown_020388F2
_080FEFD8: .4byte gUnknown_020388D6
_080FEFDC: .4byte gUnknown_020388E6
_080FEFE0:
	adds r0, r2, 0x1
	lsls r0, 16
	lsrs r2, r0, 16
	cmp r2, 0xF
	bls _080FEFB8
	movs r0, 0x1
_080FEFEC:
	pop {r4}
	pop {r1}
	bx r1
	thumb_func_end sub_80FEFA4

	thumb_func_start sub_80FEFF4
sub_80FEFF4: @ 80FEFF4
	push {r4,lr}
	lsls r0, 24
	lsrs r4, r0, 24
	ldr r0, _080FF028 @ =gMain
	ldrh r1, [r0, 0x2E]
	movs r0, 0x1
	ands r0, r1
	cmp r0, 0
	bne _080FF00E
	movs r0, 0x2
	ands r0, r1
	cmp r0, 0
	beq _080FF020
_080FF00E:
	bl LoadScrollIndicatorPalette
	ldr r0, _080FF02C @ =gTasks
	lsls r1, r4, 2
	adds r1, r4
	lsls r1, 3
	adds r1, r0
	ldr r0, _080FF030 @ =sub_80FE868
	str r0, [r1]
_080FF020:
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
_080FF028: .4byte gMain
_080FF02C: .4byte gTasks
_080FF030: .4byte sub_80FE868
	thumb_func_end sub_80FEFF4

	thumb_func_start sub_80FF034
sub_80FF034: @ 80FF034
	push {r4,lr}
	adds r4, r0, 0
	lsls r4, 24
	lsrs r4, 24
	bl sub_8072DEC
	movs r0, 0
	movs r1, 0
	movs r2, 0xE
	movs r3, 0x13
	bl MenuZeroFillWindowRect
	adds r0, r4, 0
	bl sub_80FE5AC
	pop {r4}
	pop {r0}
	bx r0
	thumb_func_end sub_80FF034

	thumb_func_start sub_80FF058
sub_80FF058: @ 80FF058
	push {r4,lr}
	adds r4, r0, 0
	lsls r4, 24
	lsrs r4, 24
	ldr r0, _080FF08C @ =gUnknown_020388F7
	movs r1, 0x8
	bl sub_80F9520
	movs r0, 0
	bl DestroyVerticalScrollIndicator
	movs r0, 0x1
	bl DestroyVerticalScrollIndicator
	bl BuyMenuFreeMemory
	ldr r1, _080FF090 @ =gTasks
	lsls r0, r4, 2
	adds r0, r4
	lsls r0, 3
	adds r0, r1
	ldr r1, _080FF094 @ =sub_80FF034
	str r1, [r0]
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
_080FF08C: .4byte gUnknown_020388F7
_080FF090: .4byte gTasks
_080FF094: .4byte sub_80FF034
	thumb_func_end sub_80FF058

	thumb_func_start sub_80FF098
sub_80FF098: @ 80FF098
	push {r4,lr}
	lsls r0, 24
	lsrs r4, r0, 24
	ldr r1, _080FF0D4 @ =gUnknown_020388D5
	ldrb r0, [r1]
	subs r0, 0x1
	strb r0, [r1]
	ldr r3, _080FF0D8 @ =gUnknown_020388F4
	ldrb r2, [r3]
	adds r0, r2, 0x7
	ldrb r1, [r1]
	cmp r0, r1
	ble _080FF0BA
	cmp r2, 0
	beq _080FF0BA
	subs r0, r2, 0x1
	strb r0, [r3]
_080FF0BA:
	ldr r0, _080FF0DC @ =gUnknown_020388F6
	ldrb r0, [r0]
	bl sub_8134104
	adds r0, r4, 0
	bl sub_80FED90
	bl sub_80FEF28
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
_080FF0D4: .4byte gUnknown_020388D5
_080FF0D8: .4byte gUnknown_020388F4
_080FF0DC: .4byte gUnknown_020388F6
	thumb_func_end sub_80FF098

	thumb_func_start sub_80FF0E0
sub_80FF0E0: @ 80FF0E0
	push {r4,lr}
	lsls r0, 24
	lsrs r0, 24
	ldr r3, _080FF10C @ =gTasks
	lsls r2, r0, 2
	adds r2, r0
	lsls r2, 3
	adds r4, r2, r3
	ldr r1, _080FF110 @ =gSaveBlock1
	ldrh r0, [r1]
	strh r0, [r4, 0xE]
	ldrh r0, [r1, 0x2]
	strh r0, [r4, 0x10]
	adds r3, 0x8
	adds r2, r3
	adds r1, r2, 0x2
	adds r0, r2, 0
	bl PlayerGetDestCoords
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
_080FF10C: .4byte gTasks
_080FF110: .4byte gSaveBlock1
	thumb_func_end sub_80FF0E0

	thumb_func_start sub_80FF114
sub_80FF114: @ 80FF114
	push {r4,r5,lr}
	sub sp, 0x4
	adds r5, r0, 0
	lsls r5, 24
	lsrs r5, 24
	bl DrawWholeMapView
	ldr r1, _080FF158 @ =gSaveBlock1
	movs r0, 0x4
	ldrsb r0, [r1, r0]
	ldrb r1, [r1, 0x5]
	lsls r1, 24
	asrs r1, 24
	movs r2, 0x1
	negs r2, r2
	ldr r3, _080FF15C @ =gTasks
	lsls r4, r5, 2
	adds r4, r5
	lsls r4, 3
	adds r4, r3
	movs r3, 0xE
	ldrsb r3, [r4, r3]
	ldrb r4, [r4, 0x10]
	lsls r4, 24
	asrs r4, 24
	str r4, [sp]
	bl warp1_set
	bl warp_in
	add sp, 0x4
	pop {r4,r5}
	pop {r0}
	bx r0
	.align 2, 0
_080FF158: .4byte gSaveBlock1
_080FF15C: .4byte gTasks
	thumb_func_end sub_80FF114

	thumb_func_start sub_80FF160
sub_80FF160: @ 80FF160
	push {r4,lr}
	lsls r0, 24
	lsrs r4, r0, 24
	bl sub_81341D4
	lsls r0, 24
	cmp r0, 0
	bne _080FF188
	ldr r1, _080FF180 @ =gSecretBaseText_NoDecors
	ldr r2, _080FF184 @ =sub_80FE428
	adds r0, r4, 0
	movs r3, 0
	bl DisplayItemMessageOnField
	b _080FF1A2
	.align 2, 0
_080FF180: .4byte gSecretBaseText_NoDecors
_080FF184: .4byte sub_80FE428
_080FF188:
	ldr r1, _080FF1A8 @ =gTasks
	lsls r0, r4, 2
	adds r0, r4
	lsls r0, 3
	adds r0, r1
	movs r2, 0
	movs r1, 0
	strh r1, [r0, 0x1E]
	ldr r0, _080FF1AC @ =gUnknown_020388F6
	strb r2, [r0]
	adds r0, r4, 0
	bl sub_80FE5AC
_080FF1A2:
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
_080FF1A8: .4byte gTasks
_080FF1AC: .4byte gUnknown_020388F6
	thumb_func_end sub_80FF160

	thumb_func_start sub_80FF1B0
sub_80FF1B0: @ 80FF1B0
	push {lr}
	lsls r0, 24
	lsrs r2, r0, 24
	lsls r1, 24
	lsrs r1, 24
	ldr r0, _080FF1D0 @ =0x0000ffff
	cmp r2, 0x22
	beq _080FF1D8
	cmp r2, 0x26
	bne _080FF1E2
	ldr r0, _080FF1D4 @ =gUnknown_083EC97C
	adds r0, r1, r0
	ldrb r0, [r0]
	lsls r0, 28
	lsrs r0, 16
	b _080FF1E2
	.align 2, 0
_080FF1D0: .4byte 0x0000ffff
_080FF1D4: .4byte gUnknown_083EC97C
_080FF1D8:
	ldr r0, _080FF1E8 @ =gUnknown_083EC984
	adds r0, r1, r0
	ldrb r0, [r0]
	lsls r0, 28
	lsrs r0, 16
_080FF1E2:
	pop {r1}
	bx r1
	.align 2, 0
_080FF1E8: .4byte gUnknown_083EC984
	thumb_func_end sub_80FF1B0

	thumb_func_start sub_80FF1EC
sub_80FF1EC: @ 80FF1EC
	push {r4-r7,lr}
	mov r7, r10
	mov r6, r9
	mov r5, r8
	push {r5-r7}
	sub sp, 0x34
	ldr r4, [sp, 0x54]
	lsls r0, 16
	lsrs r0, 16
	str r0, [sp]
	lsls r1, 16
	lsrs r1, 16
	str r1, [sp, 0x4]
	lsls r2, 24
	lsrs r2, 24
	str r2, [sp, 0x8]
	lsls r3, 24
	lsrs r3, 24
	str r3, [sp, 0xC]
	lsls r4, 16
	lsrs r4, 16
	str r4, [sp, 0x10]
	movs r2, 0
	lsls r0, r3, 16
	cmp r2, r3
	bcc _080FF222
	b _080FF384
_080FF222:
	ldr r1, [sp, 0x8]
	str r1, [sp, 0x28]
	str r0, [sp, 0x2C]
_080FF228:
	ldr r3, [sp, 0x4]
	ldr r4, [sp, 0xC]
	subs r1, r3, r4
	lsls r0, r2, 16
	asrs r0, 16
	adds r0, 0x1
	adds r1, r0
	lsls r1, 16
	lsrs r1, 16
	str r1, [sp, 0x14]
	movs r0, 0
	mov r10, r0
	adds r1, r2, 0x1
	str r1, [sp, 0x30]
	ldr r3, [sp, 0x28]
	cmp r10, r3
	bcc _080FF24C
	b _080FF374
_080FF24C:
	ldr r4, [sp, 0x10]
	lsls r4, 5
	str r4, [sp, 0x18]
	ldr r0, _080FF2B4 @ =gDecorations + 0x1C
	adds r0, r4, r0
	str r0, [sp, 0x1C]
	ldr r0, _080FF2B8 @ =gDecorations
	adds r0, r4, r0
	str r0, [sp, 0x24]
	ldr r3, [sp, 0x8]
	adds r1, r2, 0
	muls r1, r3
	str r1, [sp, 0x20]
_080FF266:
	ldr r0, [sp]
	add r0, r10
	lsls r0, 16
	lsrs r5, r0, 16
	ldr r1, [sp, 0x20]
	add r1, r10
	ldr r4, [sp, 0x1C]
	ldr r0, [r4]
	lsls r1, 1
	adds r1, r0
	movs r2, 0x80
	lsls r2, 2
	adds r0, r2, 0
	ldrh r1, [r1]
	adds r0, r1
	lsls r0, 16
	lsrs r0, 16
	bl GetBehaviorByMetatileId
	lsls r4, r0, 16
	lsls r0, r4, 8
	lsrs r0, 24
	bl sub_8057288
	lsls r0, 24
	lsrs r0, 24
	cmp r0, 0x1
	beq _080FF2AC
	ldr r3, [sp, 0x24]
	ldrb r0, [r3, 0x11]
	cmp r0, 0x1
	beq _080FF2BC
	lsrs r0, r4, 28
	cmp r0, 0
	beq _080FF2BC
_080FF2AC:
	movs r4, 0xC0
	lsls r4, 4
	mov r8, r4
	b _080FF2C0
	.align 2, 0
_080FF2B4: .4byte gDecorations + 0x1C
_080FF2B8: .4byte gDecorations
_080FF2BC:
	movs r0, 0
	mov r8, r0
_080FF2C0:
	ldr r1, [sp, 0x24]
	ldrb r0, [r1, 0x11]
	lsls r7, r5, 16
	ldr r2, [sp, 0x14]
	lsls r2, 16
	mov r9, r2
	cmp r0, 0x3
	beq _080FF2EA
	asrs r0, r7, 16
	asrs r1, r2, 16
	bl MapGridGetMetatileBehaviorAt
	lsls r0, 24
	lsrs r0, 24
	bl sub_80572B0
	lsls r0, 24
	lsrs r0, 24
	movs r6, 0x1
	cmp r0, 0x1
	beq _080FF2EC
_080FF2EA:
	movs r6, 0
_080FF2EC:
	ldr r3, [sp, 0x18]
	ldr r4, _080FF334 @ =gDecorations
	adds r0, r3, r4
	ldrb r0, [r0]
	ldr r4, [sp, 0x20]
	add r4, r10
	lsls r1, r4, 24
	lsrs r1, 24
	bl sub_80FF1B0
	lsls r0, 16
	lsrs r5, r0, 16
	ldr r0, _080FF338 @ =0x0000ffff
	cmp r5, r0
	beq _080FF33C
	asrs r0, r7, 16
	mov r2, r9
	asrs r1, r2, 16
	ldr r3, [sp, 0x1C]
	ldr r2, [r3]
	lsls r3, r4, 1
	adds r3, r2
	movs r4, 0x80
	lsls r4, 2
	adds r2, r4, 0
	orrs r6, r2
	ldrh r3, [r3]
	adds r2, r6, r3
	mov r3, r8
	orrs r3, r2
	orrs r3, r5
	lsls r2, r3, 16
	lsrs r2, 16
	bl MapGridSetMetatileEntryAt
	b _080FF362
	.align 2, 0
_080FF334: .4byte gDecorations
_080FF338: .4byte 0x0000ffff
_080FF33C:
	asrs r0, r7, 16
	mov r2, r9
	asrs r1, r2, 16
	ldr r3, [sp, 0x1C]
	ldr r2, [r3]
	lsls r3, r4, 1
	adds r3, r2
	movs r4, 0x80
	lsls r4, 2
	adds r2, r4, 0
	orrs r6, r2
	ldrh r3, [r3]
	adds r2, r6, r3
	mov r3, r8
	orrs r3, r2
	lsls r2, r3, 16
	lsrs r2, 16
	bl MapGridSetMetatileIdAt
_080FF362:
	mov r0, r10
	adds r0, 0x1
	lsls r0, 16
	lsrs r0, 16
	mov r10, r0
	ldr r4, [sp, 0x28]
	cmp r10, r4
	bcs _080FF374
	b _080FF266
_080FF374:
	ldr r1, [sp, 0x30]
	lsls r0, r1, 16
	lsrs r2, r0, 16
	ldr r3, [sp, 0x2C]
	lsrs r0, r3, 16
	cmp r2, r0
	bcs _080FF384
	b _080FF228
_080FF384:
	add sp, 0x34
	pop {r3-r5}
	mov r8, r3
	mov r9, r4
	mov r10, r5
	pop {r4-r7}
	pop {r0}
	bx r0
	thumb_func_end sub_80FF1EC

	thumb_func_start sub_80FF394
sub_80FF394: @ 80FF394
	push {r4,lr}
	sub sp, 0x4
	lsls r0, 16
	lsrs r3, r0, 16
	lsls r1, 16
	lsrs r4, r1, 16
	lsls r2, 16
	lsrs r2, 16
	ldr r1, _080FF3BC @ =gDecorations
	lsls r0, r2, 5
	adds r0, r1
	ldrb r0, [r0, 0x12]
	cmp r0, 0x9
	bhi _080FF46C
	lsls r0, 2
	ldr r1, _080FF3C0 @ =_080FF3C4
	adds r0, r1
	ldr r0, [r0]
	mov pc, r0
	.align 2, 0
_080FF3BC: .4byte gDecorations
_080FF3C0: .4byte _080FF3C4
	.align 2, 0
_080FF3C4:
	.4byte _080FF3EC
	.4byte _080FF3F6
	.4byte _080FF400
	.4byte _080FF410
	.4byte _080FF41A
	.4byte _080FF424
	.4byte _080FF434
	.4byte _080FF43E
	.4byte _080FF44E
	.4byte _080FF45E
_080FF3EC:
	str r2, [sp]
	adds r0, r3, 0
	adds r1, r4, 0
	movs r2, 0x1
	b _080FF408
_080FF3F6:
	str r2, [sp]
	adds r0, r3, 0
	adds r1, r4, 0
	movs r2, 0x2
	b _080FF408
_080FF400:
	str r2, [sp]
	adds r0, r3, 0
	adds r1, r4, 0
	movs r2, 0x3
_080FF408:
	movs r3, 0x1
	bl sub_80FF1EC
	b _080FF46C
_080FF410:
	str r2, [sp]
	adds r0, r3, 0
	adds r1, r4, 0
	movs r2, 0x4
	b _080FF42C
_080FF41A:
	str r2, [sp]
	adds r0, r3, 0
	adds r1, r4, 0
	movs r2, 0x2
	b _080FF42C
_080FF424:
	str r2, [sp]
	adds r0, r3, 0
	adds r1, r4, 0
	movs r2, 0x1
_080FF42C:
	movs r3, 0x2
	bl sub_80FF1EC
	b _080FF46C
_080FF434:
	str r2, [sp]
	adds r0, r3, 0
	adds r1, r4, 0
	movs r2, 0x1
	b _080FF456
_080FF43E:
	str r2, [sp]
	adds r0, r3, 0
	adds r1, r4, 0
	movs r2, 0x2
	movs r3, 0x4
	bl sub_80FF1EC
	b _080FF46C
_080FF44E:
	str r2, [sp]
	adds r0, r3, 0
	adds r1, r4, 0
	movs r2, 0x3
_080FF456:
	movs r3, 0x3
	bl sub_80FF1EC
	b _080FF46C
_080FF45E:
	str r2, [sp]
	adds r0, r3, 0
	adds r1, r4, 0
	movs r2, 0x3
	movs r3, 0x2
	bl sub_80FF1EC
_080FF46C:
	add sp, 0x4
	pop {r4}
	pop {r0}
	bx r0
	thumb_func_end sub_80FF394

	thumb_func_start sub_80FF474
sub_80FF474: @ 80FF474
	push {r4-r7,lr}
	mov r7, r10
	mov r6, r9
	mov r5, r8
	push {r5-r7}
	sub sp, 0x4
	movs r6, 0
	ldr r0, _080FF54C @ =gMapHeader
	mov r8, r0
	ldr r1, _080FF550 @ =gUnknown_0202E8CE
	mov r9, r1
	ldr r2, _080FF554 @ =gUnknown_0202E8D0
	mov r10, r2
	ldr r7, _080FF558 @ =gSaveBlock1
_080FF490:
	adds r5, r6, 0
	adds r5, 0xAE
	adds r4, r5, 0
	adds r0, r4, 0
	bl FlagGet
	lsls r0, 24
	lsrs r0, 24
	cmp r0, 0x1
	bne _080FF570
	adds r0, r4, 0
	bl FlagReset
	movs r2, 0
	mov r4, r8
	ldr r0, [r4, 0x4]
	ldrb r6, [r0]
	cmp r2, r6
	bcs _080FF4E0
	ldr r0, [r0, 0x4]
	ldrh r0, [r0, 0x14]
	cmp r0, r5
	beq _080FF4E0
	ldr r0, _080FF54C @ =gMapHeader
	ldr r3, [r0, 0x4]
	ldrb r6, [r3]
	adds r4, r5, 0
_080FF4C6:
	adds r0, r2, 0x1
	lsls r0, 24
	lsrs r2, r0, 24
	cmp r2, r6
	bcs _080FF4E0
	ldr r0, [r3, 0x4]
	lsls r1, r2, 1
	adds r1, r2
	lsls r1, 3
	adds r1, r0
	ldrh r0, [r1, 0x14]
	cmp r0, r4
	bne _080FF4C6
_080FF4E0:
	mov r1, r8
	ldr r0, [r1, 0x4]
	ldr r1, [r0, 0x4]
	lsls r4, r2, 1
	adds r4, r2
	lsls r4, 3
	adds r1, r4, r1
	ldr r2, _080FF55C @ =0x00003f20
	adds r0, r2, 0
	ldrb r1, [r1, 0x1]
	adds r0, r1
	ldr r1, _080FF560 @ =gUnknown_02038900
	ldr r1, [r1]
	ldr r1, [r1, 0x1C]
	ldrh r1, [r1]
	bl VarSet
	mov r5, r8
	ldr r0, [r5, 0x4]
	ldr r0, [r0, 0x4]
	adds r4, r0
	ldrb r0, [r4]
	mov r6, r9
	strh r0, [r6]
	ldr r1, _080FF564 @ =gUnknown_020391A4
	ldrh r1, [r1]
	mov r2, r10
	strh r1, [r2]
	ldr r1, _080FF568 @ =gUnknown_020391A6
	ldrh r1, [r1]
	ldr r4, _080FF56C @ =gUnknown_0202E8D2
	strh r1, [r4]
	ldrb r1, [r7, 0x5]
	ldrb r2, [r7, 0x4]
	bl show_sprite
	ldrb r0, [r6]
	ldrb r1, [r7, 0x5]
	ldrb r2, [r7, 0x4]
	mov r5, r10
	movs r6, 0
	ldrsh r3, [r5, r6]
	movs r5, 0
	ldrsh r4, [r4, r5]
	str r4, [sp]
	bl sub_805C0F8
	mov r6, r9
	ldrb r0, [r6]
	ldrb r1, [r7, 0x5]
	ldrb r2, [r7, 0x4]
	bl sub_805C78C
	b _080FF57A
	.align 2, 0
_080FF54C: .4byte gMapHeader
_080FF550: .4byte gUnknown_0202E8CE
_080FF554: .4byte gUnknown_0202E8D0
_080FF558: .4byte gSaveBlock1
_080FF55C: .4byte 0x00003f20
_080FF560: .4byte gUnknown_02038900
_080FF564: .4byte gUnknown_020391A4
_080FF568: .4byte gUnknown_020391A6
_080FF56C: .4byte gUnknown_0202E8D2
_080FF570:
	adds r0, r6, 0x1
	lsls r0, 24
	lsrs r6, r0, 24
	cmp r6, 0xD
	bls _080FF490
_080FF57A:
	add sp, 0x4
	pop {r3-r5}
	mov r8, r3
	mov r9, r4
	mov r10, r5
	pop {r4-r7}
	pop {r0}
	bx r0
	thumb_func_end sub_80FF474

	thumb_func_start sub_80FF58C
sub_80FF58C: @ 80FF58C
	push {lr}
	movs r1, 0
	ldr r0, _080FF5A8 @ =0x0201f000
	ldrb r2, [r0, 0x8]
	cmp r1, r2
	bcs _080FF5B6
	ldr r3, [r0]
_080FF59A:
	adds r0, r3, r1
	ldrb r0, [r0]
	cmp r0, 0
	bne _080FF5AC
	movs r0, 0x1
	b _080FF5B8
	.align 2, 0
_080FF5A8: .4byte 0x0201f000
_080FF5AC:
	adds r0, r1, 0x1
	lsls r0, 16
	lsrs r1, r0, 16
	cmp r1, r2
	bcc _080FF59A
_080FF5B6:
	movs r0, 0
_080FF5B8:
	pop {r1}
	bx r1
	thumb_func_end sub_80FF58C

	thumb_func_start sub_80FF5BC
sub_80FF5BC: @ 80FF5BC
	push {r4,r5,lr}
	lsls r0, 24
	lsrs r5, r0, 24
	ldr r0, _080FF5E4 @ =0x0201f000
	ldrb r0, [r0, 0x9]
	cmp r0, 0x1
	bne _080FF5F0
	ldr r0, _080FF5E8 @ =gUnknown_020388F6
	ldrb r0, [r0]
	cmp r0, 0x6
	beq _080FF5F0
	cmp r0, 0x7
	beq _080FF5F0
	bl sub_80FEF74
	bl sub_80FED1C
	ldr r1, _080FF5EC @ =gSecretBaseText_DecorCantPlace
	b _080FF66E
	.align 2, 0
_080FF5E4: .4byte 0x0201f000
_080FF5E8: .4byte gUnknown_020388F6
_080FF5EC: .4byte gSecretBaseText_DecorCantPlace
_080FF5F0:
	bl sub_80FEFA4
	lsls r0, 24
	lsrs r0, 24
	cmp r0, 0x1
	bne _080FF688
	bl sub_80FF58C
	lsls r0, 24
	lsrs r0, 24
	cmp r0, 0x1
	bne _080FF62C
	movs r0, 0x1
	movs r1, 0
	bl fade_screen
	ldr r1, _080FF624 @ =gTasks
	lsls r0, r5, 2
	adds r0, r5
	lsls r0, 3
	adds r0, r1
	movs r1, 0
	strh r1, [r0, 0xC]
	ldr r1, _080FF628 @ =sub_80FF6AC
	str r1, [r0]
	b _080FF69C
	.align 2, 0
_080FF624: .4byte gTasks
_080FF628: .4byte sub_80FF6AC
_080FF62C:
	bl sub_80FEF74
	bl sub_80FED1C
	ldr r0, _080FF654 @ =gStringVar1
	ldr r4, _080FF658 @ =0x0201f000
	ldrb r1, [r4, 0x8]
	movs r2, 0x1
	movs r3, 0x2
	bl ConvertIntToDecimalStringN
	ldrb r0, [r4, 0x9]
	cmp r0, 0
	bne _080FF664
	ldr r0, _080FF65C @ =gStringVar4
	ldr r1, _080FF660 @ =gSecretBaseText_NoMoreDecor
	bl StringExpandPlaceholders
	b _080FF66C
	.align 2, 0
_080FF654: .4byte gStringVar1
_080FF658: .4byte 0x0201f000
_080FF65C: .4byte gStringVar4
_080FF660: .4byte gSecretBaseText_NoMoreDecor
_080FF664:
	ldr r0, _080FF67C @ =gStringVar4
	ldr r1, _080FF680 @ =gSecretBaseText_NoMoreDecor2
	bl StringExpandPlaceholders
_080FF66C:
	ldr r1, _080FF67C @ =gStringVar4
_080FF66E:
	ldr r2, _080FF684 @ =sub_80FEFF4
	adds r0, r5, 0
	movs r3, 0
	bl DisplayItemMessageOnField
	b _080FF69C
	.align 2, 0
_080FF67C: .4byte gStringVar4
_080FF680: .4byte gSecretBaseText_NoMoreDecor2
_080FF684: .4byte sub_80FEFF4
_080FF688:
	bl sub_80FEF74
	bl sub_80FED1C
	ldr r1, _080FF6A4 @ =gSecretBaseText_InUseAlready
	ldr r2, _080FF6A8 @ =sub_80FEFF4
	adds r0, r5, 0
	movs r3, 0
	bl DisplayItemMessageOnField
_080FF69C:
	pop {r4,r5}
	pop {r0}
	bx r0
	.align 2, 0
_080FF6A4: .4byte gSecretBaseText_InUseAlready
_080FF6A8: .4byte sub_80FEFF4
	thumb_func_end sub_80FF5BC

	thumb_func_start sub_80FF6AC
sub_80FF6AC: @ 80FF6AC
	push {r4-r7,lr}
	lsls r0, 24
	lsrs r6, r0, 24
	ldr r1, _080FF6D0 @ =gTasks
	lsls r0, r6, 2
	adds r0, r6
	lsls r0, 3
	adds r7, r0, r1
	movs r1, 0xC
	ldrsh r0, [r7, r1]
	cmp r0, 0x1
	beq _080FF714
	cmp r0, 0x1
	bgt _080FF6D4
	cmp r0, 0
	beq _080FF6DA
	b _080FF77A
	.align 2, 0
_080FF6D0: .4byte gTasks
_080FF6D4:
	cmp r0, 0x2
	beq _080FF764
	b _080FF77A
_080FF6DA:
	ldr r0, _080FF70C @ =gPaletteFade
	ldrb r1, [r0, 0x7]
	movs r0, 0x80
	ands r0, r1
	cmp r0, 0
	bne _080FF77A
	adds r0, r6, 0
	bl sub_80FF0E0
	movs r0, 0
	bl DestroyVerticalScrollIndicator
	movs r0, 0x1
	bl DestroyVerticalScrollIndicator
	ldr r0, _080FF710 @ =gUnknown_020388F7
	movs r1, 0x8
	bl sub_80F9520
	bl BuyMenuFreeMemory
	movs r0, 0x1
	strh r0, [r7, 0xC]
	b _080FF77A
	.align 2, 0
_080FF70C: .4byte gPaletteFade
_080FF710: .4byte gUnknown_020388F7
_080FF714:
	ldr r4, _080FF754 @ =gPaletteFade
	ldrb r0, [r4, 0x8]
	movs r1, 0x80
	orrs r0, r1
	strb r0, [r4, 0x8]
	ldr r5, _080FF758 @ =gUnknown_02038900
	ldr r0, _080FF75C @ =gUnknown_020388F5
	ldrb r1, [r0]
	ldr r0, _080FF760 @ =gUnknown_020388D0
	ldr r0, [r0]
	adds r0, r1
	ldrb r1, [r0]
	adds r0, r5, 0
	bl AddDecorationIconObjectFromFieldObject
	adds r0, r6, 0
	bl sub_80FF960
	adds r0, r6, 0
	adds r1, r5, 0
	bl SetUpPlacingDecorationPlayerAvatar
	bl pal_fill_black
	ldrb r1, [r4, 0x8]
	movs r0, 0x7F
	ands r0, r1
	strb r0, [r4, 0x8]
	movs r0, 0x2
	strh r0, [r7, 0xC]
	b _080FF77A
	.align 2, 0
_080FF754: .4byte gPaletteFade
_080FF758: .4byte gUnknown_02038900
_080FF75C: .4byte gUnknown_020388F5
_080FF760: .4byte gUnknown_020388D0
_080FF764:
	bl sub_807D770
	lsls r0, 24
	lsrs r0, 24
	cmp r0, 0x1
	bne _080FF77A
	movs r0, 0
	strh r0, [r7, 0x20]
	adds r0, r6, 0
	bl sub_810065C
_080FF77A:
	pop {r4-r7}
	pop {r0}
	bx r0
	thumb_func_end sub_80FF6AC

	thumb_func_start AddDecorationIconObjectFromFieldObject
AddDecorationIconObjectFromFieldObject: @ 80FF780
	push {r4-r6,lr}
	sub sp, 0x4
	adds r5, r0, 0
	lsls r4, r1, 24
	lsrs r4, 24
	bl sub_80FEF74
	bl sub_80FED1C
	adds r0, r5, 0
	bl sub_81006D0
	lsls r4, 5
	ldr r0, _080FF810 @ =gDecorations
	adds r4, r0
	str r4, [r5]
	ldrb r0, [r4, 0x11]
	cmp r0, 0x4
	beq _080FF834
	adds r0, r5, 0
	bl sub_81008BC
	ldr r0, [r5]
	ldrb r0, [r0, 0x12]
	bl sub_8100930
	adds r0, r5, 0
	bl sub_8100874
	ldr r1, _080FF814 @ =0x00000884
	adds r0, r5, r1
	ldr r1, _080FF818 @ =gMapHeader
	ldr r1, [r1]
	ldr r2, [r1, 0x14]
	ldr r1, [r5]
	ldr r1, [r1, 0x1C]
	ldrh r1, [r1]
	ldr r2, [r2, 0xC]
	lsls r1, 4
	adds r1, r2
	ldrh r1, [r1, 0xE]
	lsrs r1, 12
	bl sub_810070C
	ldr r0, _080FF81C @ =gUnknown_083EC954
	bl LoadSpritePalette
	ldr r3, _080FF820 @ =gUnknown_020391A8
	ldr r2, _080FF824 @ =gSprites
	ldr r4, _080FF828 @ =gUnknown_03004880
	ldr r1, [r4, 0x4]
	lsls r0, r1, 4
	adds r0, r1
	lsls r0, 2
	adds r0, r2
	ldrh r0, [r0, 0x2E]
	strb r0, [r3]
	ldr r0, _080FF82C @ =gSpriteTemplate_83EC93C
	ldr r3, _080FF830 @ =gUnknown_083EC900
	ldr r1, [r5]
	ldrb r2, [r1, 0x12]
	lsls r2, 2
	adds r2, r3
	ldrb r1, [r2, 0x2]
	ldrb r2, [r2, 0x3]
	movs r3, 0
	bl CreateSprite
	lsls r0, 24
	lsrs r0, 24
	str r0, [r4, 0x4]
	b _080FF87E
	.align 2, 0
_080FF810: .4byte gDecorations
_080FF814: .4byte 0x00000884
_080FF818: .4byte gMapHeader
_080FF81C: .4byte gUnknown_083EC954
_080FF820: .4byte gUnknown_020391A8
_080FF824: .4byte gSprites
_080FF828: .4byte gUnknown_03004880
_080FF82C: .4byte gSpriteTemplate_83EC93C
_080FF830: .4byte gUnknown_083EC900
_080FF834:
	ldr r2, _080FF888 @ =gUnknown_020391A8
	ldr r6, _080FF88C @ =gSprites
	ldr r5, _080FF890 @ =gUnknown_03004880
	ldr r1, [r5, 0x4]
	lsls r0, r1, 4
	adds r0, r1
	lsls r0, 2
	adds r0, r6
	ldrh r0, [r0, 0x2E]
	strb r0, [r2]
	ldr r0, [r4, 0x1C]
	ldrh r0, [r0]
	ldr r1, _080FF894 @ =sub_81009A8
	ldr r2, _080FF898 @ =gUnknown_083EC900
	ldrb r3, [r4, 0x12]
	lsls r3, 2
	adds r3, r2
	ldrb r2, [r3, 0x2]
	ldrb r3, [r3, 0x3]
	movs r4, 0x1
	str r4, [sp]
	bl AddPseudoFieldObject
	lsls r0, 24
	lsrs r0, 24
	str r0, [r5, 0x4]
	lsls r1, r0, 4
	adds r1, r0
	lsls r1, 2
	adds r1, r6
	ldrb r2, [r1, 0x5]
	movs r0, 0xD
	negs r0, r0
	ands r0, r2
	movs r2, 0x4
	orrs r0, r2
	strb r0, [r1, 0x5]
_080FF87E:
	add sp, 0x4
	pop {r4-r6}
	pop {r0}
	bx r0
	.align 2, 0
_080FF888: .4byte gUnknown_020391A8
_080FF88C: .4byte gSprites
_080FF890: .4byte gUnknown_03004880
_080FF894: .4byte sub_81009A8
_080FF898: .4byte gUnknown_083EC900
	thumb_func_end AddDecorationIconObjectFromFieldObject

	thumb_func_start SetUpPlacingDecorationPlayerAvatar
SetUpPlacingDecorationPlayerAvatar: @ 80FF89C
	push {r4,lr}
	sub sp, 0x4
	lsls r0, 24
	lsrs r0, 24
	ldr r3, _080FF8F0 @ =gTasks
	lsls r2, r0, 2
	adds r2, r0
	lsls r2, 3
	adds r2, r3
	ldrb r2, [r2, 0x12]
	ldr r3, _080FF8F4 @ =gUnknown_083EC900
	ldr r0, [r1]
	ldrb r4, [r0, 0x12]
	lsls r1, r4, 2
	adds r1, r3
	lsls r0, r2, 4
	ldrb r1, [r1, 0x2]
	adds r0, r1
	subs r2, 0x1
	lsls r2, 3
	subs r0, r2
	lsls r0, 24
	lsrs r2, r0, 24
	cmp r4, 0x2
	beq _080FF8D6
	cmp r4, 0x8
	beq _080FF8D6
	cmp r4, 0x9
	bne _080FF8DE
_080FF8D6:
	adds r0, r2, 0
	subs r0, 0x8
	lsls r0, 24
	lsrs r2, r0, 24
_080FF8DE:
	ldr r0, _080FF8F8 @ =gSaveBlock2
	ldrb r0, [r0, 0x8]
	cmp r0, 0
	bne _080FF900
	ldr r1, _080FF8FC @ =SpriteCallbackDummy
	str r0, [sp]
	movs r0, 0xC1
	b _080FF908
	.align 2, 0
_080FF8F0: .4byte gTasks
_080FF8F4: .4byte gUnknown_083EC900
_080FF8F8: .4byte gSaveBlock2
_080FF8FC: .4byte SpriteCallbackDummy
_080FF900:
	ldr r1, _080FF94C @ =SpriteCallbackDummy
	movs r0, 0
	str r0, [sp]
	movs r0, 0xC2
_080FF908:
	movs r3, 0x48
	bl AddPseudoFieldObject
	ldr r1, _080FF950 @ =gUnknown_020391A9
	strb r0, [r1]
	ldr r3, _080FF954 @ =gSprites
	ldr r0, _080FF950 @ =gUnknown_020391A9
	ldrb r1, [r0]
	lsls r0, r1, 4
	adds r0, r1
	lsls r0, 2
	adds r0, r3
	ldrb r2, [r0, 0x5]
	movs r1, 0xD
	negs r1, r1
	ands r1, r2
	movs r2, 0x4
	orrs r1, r2
	strb r1, [r0, 0x5]
	ldr r4, _080FF958 @ =gUnknown_020391A8
	ldrb r1, [r4]
	lsls r0, r1, 4
	adds r0, r1
	lsls r0, 2
	adds r0, r3
	bl DestroySprite
	ldr r0, _080FF95C @ =gUnknown_03004880
	ldr r0, [r0, 0x4]
	strb r0, [r4]
	add sp, 0x4
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
_080FF94C: .4byte SpriteCallbackDummy
_080FF950: .4byte gUnknown_020391A9
_080FF954: .4byte gSprites
_080FF958: .4byte gUnknown_020391A8
_080FF95C: .4byte gUnknown_03004880
	thumb_func_end SetUpPlacingDecorationPlayerAvatar

	thumb_func_start sub_80FF960
sub_80FF960: @ 80FF960
	push {lr}
	lsls r0, 24
	lsrs r3, r0, 24
	ldr r2, _080FF98C @ =gDecorations
	ldr r0, _080FF990 @ =gUnknown_020388F5
	ldrb r1, [r0]
	ldr r0, _080FF994 @ =gUnknown_020388D0
	ldr r0, [r0]
	adds r0, r1
	ldrb r0, [r0]
	lsls r0, 5
	adds r0, r2
	ldrb r0, [r0, 0x12]
	cmp r0, 0x9
	bls _080FF980
	b _080FFAA6
_080FF980:
	lsls r0, 2
	ldr r1, _080FF998 @ =_080FF99C
	adds r0, r1
	ldr r0, [r0]
	mov pc, r0
	.align 2, 0
_080FF98C: .4byte gDecorations
_080FF990: .4byte gUnknown_020388F5
_080FF994: .4byte gUnknown_020388D0
_080FF998: .4byte _080FF99C
	.align 2, 0
_080FF99C:
	.4byte _080FF9C4
	.4byte _080FF9D8
	.4byte _080FF9F0
	.4byte _080FFA08
	.4byte _080FFA1C
	.4byte _080FFA30
	.4byte _080FFA44
	.4byte _080FFA64
	.4byte _080FFA7C
	.4byte _080FFA94
_080FF9C4:
	ldr r0, _080FF9D4 @ =gTasks
	lsls r1, r3, 2
	adds r1, r3
	lsls r1, 3
	adds r1, r0
	movs r0, 0x1
	b _080FFA88
	.align 2, 0
_080FF9D4: .4byte gTasks
_080FF9D8:
	ldr r1, _080FF9EC @ =gTasks
	lsls r0, r3, 2
	adds r0, r3
	lsls r0, 3
	adds r0, r1
	movs r1, 0x2
	strh r1, [r0, 0x12]
	movs r1, 0x1
	b _080FFAA4
	.align 2, 0
_080FF9EC: .4byte gTasks
_080FF9F0:
	ldr r1, _080FFA04 @ =gTasks
	lsls r0, r3, 2
	adds r0, r3
	lsls r0, 3
	adds r0, r1
	movs r1, 0x3
	strh r1, [r0, 0x12]
	movs r1, 0x1
	b _080FFAA4
	.align 2, 0
_080FFA04: .4byte gTasks
_080FFA08:
	ldr r1, _080FFA18 @ =gTasks
	lsls r0, r3, 2
	adds r0, r3
	lsls r0, 3
	adds r0, r1
	movs r1, 0x4
	b _080FFAA0
	.align 2, 0
_080FFA18: .4byte gTasks
_080FFA1C:
	ldr r0, _080FFA2C @ =gTasks
	lsls r1, r3, 2
	adds r1, r3
	lsls r1, 3
	adds r1, r0
	movs r0, 0x2
	b _080FFA88
	.align 2, 0
_080FFA2C: .4byte gTasks
_080FFA30:
	ldr r1, _080FFA40 @ =gTasks
	lsls r0, r3, 2
	adds r0, r3
	lsls r0, 3
	adds r0, r1
	movs r1, 0x1
	b _080FFAA0
	.align 2, 0
_080FFA40: .4byte gTasks
_080FFA44:
	ldr r0, _080FFA60 @ =gTasks
	lsls r1, r3, 2
	adds r1, r3
	lsls r1, 3
	adds r1, r0
	movs r0, 0x1
	strh r0, [r1, 0x12]
	movs r0, 0x3
	strh r0, [r1, 0x14]
	ldrh r0, [r1, 0xA]
	adds r0, 0x1
	strh r0, [r1, 0xA]
	b _080FFAA6
	.align 2, 0
_080FFA60: .4byte gTasks
_080FFA64:
	ldr r1, _080FFA78 @ =gTasks
	lsls r0, r3, 2
	adds r0, r3
	lsls r0, 3
	adds r0, r1
	movs r1, 0x2
	strh r1, [r0, 0x12]
	movs r1, 0x4
	b _080FFAA4
	.align 2, 0
_080FFA78: .4byte gTasks
_080FFA7C:
	ldr r0, _080FFA90 @ =gTasks
	lsls r1, r3, 2
	adds r1, r3
	lsls r1, 3
	adds r1, r0
	movs r0, 0x3
_080FFA88:
	strh r0, [r1, 0x12]
	strh r0, [r1, 0x14]
	b _080FFAA6
	.align 2, 0
_080FFA90: .4byte gTasks
_080FFA94:
	ldr r1, _080FFAAC @ =gTasks
	lsls r0, r3, 2
	adds r0, r3
	lsls r0, 3
	adds r0, r1
	movs r1, 0x3
_080FFAA0:
	strh r1, [r0, 0x12]
	movs r1, 0x2
_080FFAA4:
	strh r1, [r0, 0x14]
_080FFAA6:
	pop {r0}
	bx r0
	.align 2, 0
_080FFAAC: .4byte gTasks
	thumb_func_end sub_80FF960

	thumb_func_start sub_80FFAB0
sub_80FFAB0: @ 80FFAB0
	push {r4,lr}
	adds r4, r0, 0
	lsls r4, 24
	lsrs r4, 24
	ldr r1, _080FFAF8 @ =gTasks
	lsls r0, r4, 2
	adds r0, r4
	lsls r0, 3
	adds r0, r1
	movs r1, 0
	strh r1, [r0, 0x1C]
	ldr r3, _080FFAFC @ =gSprites
	ldr r0, _080FFB00 @ =gUnknown_020391A8
	ldrb r1, [r0]
	lsls r0, r1, 4
	adds r0, r1
	lsls r0, 2
	adds r0, r3
	movs r2, 0x1
	strh r2, [r0, 0x3C]
	ldr r0, _080FFB04 @ =gUnknown_020391A9
	ldrb r1, [r0]
	lsls r0, r1, 4
	adds r0, r1
	lsls r0, 2
	adds r0, r3
	strh r2, [r0, 0x3C]
	bl sub_810045C
	adds r0, r4, 0
	bl sub_8100038
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
_080FFAF8: .4byte gTasks
_080FFAFC: .4byte gSprites
_080FFB00: .4byte gUnknown_020391A8
_080FFB04: .4byte gUnknown_020391A9
	thumb_func_end sub_80FFAB0

	thumb_func_start sub_80FFB08
sub_80FFB08: @ 80FFB08
	push {r4,lr}
	adds r4, r0, 0
	lsls r4, 24
	lsrs r4, 24
	ldr r1, _080FFB54 @ =gTasks
	lsls r0, r4, 2
	adds r0, r4
	lsls r0, 3
	adds r0, r1
	movs r1, 0
	strh r1, [r0, 0x1C]
	ldr r3, _080FFB58 @ =gSprites
	ldr r0, _080FFB5C @ =gUnknown_020391A8
	ldrb r1, [r0]
	lsls r0, r1, 4
	adds r0, r1
	lsls r0, 2
	adds r0, r3
	movs r2, 0x1
	strh r2, [r0, 0x3C]
	ldr r0, _080FFB60 @ =gUnknown_020391A9
	ldrb r1, [r0]
	lsls r0, r1, 4
	adds r0, r1
	lsls r0, 2
	adds r0, r3
	strh r2, [r0, 0x3C]
	bl sub_810045C
	ldr r1, _080FFB64 @ =gSecretBaseText_CancelDecorating
	ldr r2, _080FFB68 @ =sub_8100248
	adds r0, r4, 0
	movs r3, 0
	bl DisplayItemMessageOnField
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
_080FFB54: .4byte gTasks
_080FFB58: .4byte gSprites
_080FFB5C: .4byte gUnknown_020391A8
_080FFB60: .4byte gUnknown_020391A9
_080FFB64: .4byte gSecretBaseText_CancelDecorating
_080FFB68: .4byte sub_8100248
	thumb_func_end sub_80FFB08

	thumb_func_start sub_80FFB6C
sub_80FFB6C: @ 80FFB6C
	push {r4,lr}
	lsls r0, 24
	lsrs r0, 24
	lsls r1, 16
	lsrs r4, r1, 16
	bl sub_8057274
	lsls r0, 24
	lsrs r0, 24
	cmp r0, 0x1
	bne _080FFB86
	cmp r4, 0
	beq _080FFB8A
_080FFB86:
	movs r0, 0
	b _080FFB8C
_080FFB8A:
	movs r0, 0x1
_080FFB8C:
	pop {r4}
	pop {r1}
	bx r1
	thumb_func_end sub_80FFB6C

	thumb_func_start sub_80FFB94
sub_80FFB94: @ 80FFB94
	push {r4,r5,lr}
	lsls r0, 24
	lsrs r0, 24
	lsls r2, 16
	lsrs r4, r2, 16
	lsls r3, 16
	lsrs r5, r3, 16
	lsls r1, 16
	asrs r1, 16
	ldr r3, _080FFBD0 @ =gTasks
	lsls r2, r0, 2
	adds r2, r0
	lsls r2, 3
	adds r2, r3
	movs r3, 0xE
	ldrsh r0, [r2, r3]
	adds r0, 0x7
	cmp r1, r0
	bne _080FFBD4
	lsls r1, r4, 16
	asrs r1, 16
	movs r3, 0x10
	ldrsh r0, [r2, r3]
	adds r0, 0x7
	cmp r1, r0
	bne _080FFBD4
	cmp r5, 0
	beq _080FFBD4
	movs r0, 0
	b _080FFBD6
	.align 2, 0
_080FFBD0: .4byte gTasks
_080FFBD4:
	movs r0, 0x1
_080FFBD6:
	pop {r4,r5}
	pop {r1}
	bx r1
	thumb_func_end sub_80FFB94

	thumb_func_start sub_80FFBDC
sub_80FFBDC: @ 80FFBDC
	push {r4-r6,lr}
	adds r5, r1, 0
	lsls r0, 16
	lsrs r6, r0, 16
	lsls r0, r6, 24
	lsrs r4, r0, 24
	adds r0, r4, 0
	bl sub_8057274
	lsls r0, 24
	lsrs r0, 24
	cmp r0, 0x1
	beq _080FFC1C
	ldrb r0, [r5]
	cmp r0, 0x21
	bne _080FFC0A
	adds r0, r4, 0
	bl sub_8057300
	lsls r0, 24
	lsrs r0, 24
	cmp r0, 0x1
	beq _080FFC18
_080FFC0A:
	lsls r0, r6, 24
	lsrs r0, 24
	bl sub_805729C
	lsls r0, 24
	cmp r0, 0
	beq _080FFC1C
_080FFC18:
	movs r0, 0x1
	b _080FFC1E
_080FFC1C:
	movs r0, 0
_080FFC1E:
	pop {r4-r6}
	pop {r1}
	bx r1
	thumb_func_end sub_80FFBDC

	thumb_func_start sub_80FFC24
sub_80FFC24: @ 80FFC24
	push {r4-r7,lr}
	mov r7, r10
	mov r6, r9
	mov r5, r8
	push {r5-r7}
	sub sp, 0x24
	str r1, [sp]
	lsls r0, 24
	lsrs r0, 24
	mov r10, r0
	ldr r1, _080FFC60 @ =gTasks
	lsls r0, 2
	add r0, r10
	lsls r0, 3
	adds r0, r1
	ldrb r2, [r0, 0x14]
	str r2, [sp, 0x4]
	ldrb r0, [r0, 0x12]
	str r0, [sp, 0x8]
	ldr r3, [sp]
	ldrb r0, [r3, 0x11]
	adds r2, r1, 0
	cmp r0, 0x4
	bls _080FFC56
	b _08100024
_080FFC56:
	lsls r0, 2
	ldr r1, _080FFC64 @ =_080FFC68
	adds r0, r1
	ldr r0, [r0]
	mov pc, r0
	.align 2, 0
_080FFC60: .4byte gTasks
_080FFC64: .4byte _080FFC68
	.align 2, 0
_080FFC68:
	.4byte _080FFC7C
	.4byte _080FFC7C
	.4byte _080FFD68
	.4byte _080FFF1C
	.4byte _080FFFA0
_080FFC7C:
	movs r6, 0
	ldr r0, [sp, 0x4]
	cmp r6, r0
	bcc _080FFC86
	b _08100024
_080FFC86:
	mov r1, r10
	lsls r1, 2
	str r1, [sp, 0x1C]
_080FFC8C:
	mov r2, r10
	lsls r0, r2, 2
	add r0, r10
	lsls r0, 3
	ldr r3, _080FFD64 @ =gTasks
	adds r0, r3
	ldrh r0, [r0, 0xA]
	subs r0, r6
	lsls r0, 16
	lsrs r0, 16
	mov r9, r0
	movs r7, 0
	adds r6, 0x1
	str r6, [sp, 0x14]
	ldr r0, [sp, 0x8]
	cmp r7, r0
	bcs _080FFD56
	mov r1, r9
	lsls r1, 16
	str r1, [sp, 0xC]
	asrs r1, 16
	mov r9, r1
_080FFCB8:
	ldr r0, [sp, 0x1C]
	add r0, r10
	lsls r0, 3
	ldr r2, _080FFD64 @ =gTasks
	adds r0, r2
	ldrh r0, [r0, 0x8]
	adds r0, r7
	lsls r0, 16
	mov r8, r0
	asrs r6, r0, 16
	adds r0, r6, 0
	mov r1, r9
	bl MapGridGetMetatileBehaviorAt
	lsls r0, 24
	lsrs r4, r0, 24
	ldr r3, [sp, 0x4]
	ldr r1, [sp, 0x14]
	subs r0, r3, r1
	ldr r2, [sp, 0x8]
	adds r1, r0, 0
	muls r1, r2
	adds r1, r7
	ldr r3, [sp]
	ldr r0, [r3, 0x1C]
	lsls r1, 1
	adds r1, r0
	movs r2, 0x80
	lsls r2, 2
	adds r0, r2, 0
	ldrh r1, [r1]
	adds r0, r1
	lsls r0, 16
	lsrs r0, 16
	bl GetBehaviorByMetatileId
	movs r3, 0xF0
	lsls r3, 8
	adds r1, r3, 0
	adds r5, r1, 0
	ands r5, r0
	adds r0, r4, 0
	ldr r1, [sp]
	bl sub_80FFBDC
	lsls r0, 24
	cmp r0, 0
	bne _080FFD1A
	b _080FFFF4
_080FFD1A:
	mov r0, r10
	adds r1, r6, 0
	mov r2, r9
	adds r3, r5, 0
	bl sub_80FFB94
	lsls r0, 24
	cmp r0, 0
	bne _080FFD2E
	b _080FFFF4
_080FFD2E:
	mov r1, r8
	lsrs r0, r1, 16
	ldr r2, [sp, 0xC]
	lsrs r1, r2, 16
	movs r2, 0
	bl GetFieldObjectIdByXYZ
	lsls r0, 24
	lsrs r4, r0, 24
	cmp r4, 0
	beq _080FFD4A
	cmp r4, 0x10
	beq _080FFD4A
	b _080FFFF4
_080FFD4A:
	adds r0, r7, 0x1
	lsls r0, 24
	lsrs r7, r0, 24
	ldr r3, [sp, 0x8]
	cmp r7, r3
	bcc _080FFCB8
_080FFD56:
	ldr r1, [sp, 0x14]
	lsls r0, r1, 24
	lsrs r6, r0, 24
	ldr r2, [sp, 0x4]
	cmp r6, r2
	bcc _080FFC8C
	b _08100024
	.align 2, 0
_080FFD64: .4byte gTasks
_080FFD68:
	movs r6, 0
	mov r3, r10
	lsls r3, 2
	str r3, [sp, 0x1C]
	ldr r0, [sp, 0x4]
	subs r0, 0x1
	str r0, [sp, 0x18]
	cmp r6, r0
	bge _080FFE54
	adds r0, r3, 0
	add r0, r10
	lsls r0, 3
	str r0, [sp, 0x10]
_080FFD82:
	ldr r1, [sp, 0x10]
	adds r0, r1, r2
	ldrh r0, [r0, 0xA]
	subs r0, r6
	lsls r0, 16
	lsrs r0, 16
	mov r9, r0
	movs r7, 0
	adds r6, 0x1
	str r6, [sp, 0x14]
	ldr r3, [sp, 0x8]
	cmp r7, r3
	bcs _080FFE48
	lsls r0, 16
	str r0, [sp, 0x20]
_080FFDA0:
	ldr r1, [sp, 0x10]
	adds r0, r1, r2
	ldrh r0, [r0, 0x8]
	adds r0, r7
	lsls r0, 16
	mov r8, r0
	asrs r6, r0, 16
	mov r2, r9
	lsls r1, r2, 16
	adds r0, r6, 0
	asrs r1, 16
	bl MapGridGetMetatileBehaviorAt
	lsls r0, 24
	lsrs r4, r0, 24
	ldr r3, [sp, 0x4]
	ldr r1, [sp, 0x14]
	subs r0, r3, r1
	ldr r2, [sp, 0x8]
	adds r1, r0, 0
	muls r1, r2
	adds r1, r7
	ldr r3, [sp]
	ldr r0, [r3, 0x1C]
	lsls r1, 1
	adds r1, r0
	movs r2, 0x80
	lsls r2, 2
	adds r0, r2, 0
	ldrh r1, [r1]
	adds r0, r1
	lsls r0, 16
	lsrs r0, 16
	bl GetBehaviorByMetatileId
	movs r3, 0xF0
	lsls r3, 8
	adds r1, r3, 0
	adds r5, r1, 0
	ands r5, r0
	adds r0, r4, 0
	bl sub_805729C
	lsls r0, 24
	cmp r0, 0
	bne _080FFE0C
	adds r0, r4, 0
	adds r1, r5, 0
	bl sub_80FFB6C
	lsls r0, 24
	cmp r0, 0
	bne _080FFE0C
	b _080FFFF4
_080FFE0C:
	mov r0, r10
	adds r1, r6, 0
	ldr r3, [sp, 0x20]
	asrs r2, r3, 16
	adds r3, r5, 0
	bl sub_80FFB94
	lsls r0, 24
	cmp r0, 0
	bne _080FFE22
	b _080FFFF4
_080FFE22:
	mov r1, r8
	lsrs r0, r1, 16
	ldr r2, [sp, 0x20]
	lsrs r1, r2, 16
	movs r2, 0
	bl GetFieldObjectIdByXYZ
	lsls r0, 24
	lsrs r0, 24
	cmp r0, 0x10
	beq _080FFE3A
	b _080FFFF4
_080FFE3A:
	adds r0, r7, 0x1
	lsls r0, 24
	lsrs r7, r0, 24
	ldr r2, _080FFF18 @ =gTasks
	ldr r3, [sp, 0x8]
	cmp r7, r3
	bcc _080FFDA0
_080FFE48:
	ldr r1, [sp, 0x14]
	lsls r0, r1, 24
	lsrs r6, r0, 24
	ldr r3, [sp, 0x18]
	cmp r6, r3
	blt _080FFD82
_080FFE54:
	ldr r0, [sp, 0x1C]
	add r0, r10
	lsls r0, 3
	adds r0, r2
	ldrh r0, [r0, 0xA]
	ldr r1, [sp, 0x4]
	subs r0, r1
	adds r0, 0x1
	lsls r0, 16
	lsrs r0, 16
	mov r9, r0
	movs r7, 0
	ldr r3, [sp, 0x8]
	cmp r7, r3
	bcc _080FFE74
	b _08100024
_080FFE74:
	lsls r0, 16
	str r0, [sp, 0x20]
_080FFE78:
	ldr r0, [sp, 0x1C]
	add r0, r10
	lsls r0, 3
	ldr r1, _080FFF18 @ =gTasks
	adds r0, r1
	ldrh r0, [r0, 0x8]
	adds r0, r7
	lsls r0, 16
	mov r8, r0
	asrs r6, r0, 16
	mov r2, r9
	lsls r1, r2, 16
	adds r0, r6, 0
	asrs r1, 16
	bl MapGridGetMetatileBehaviorAt
	lsls r0, 24
	lsrs r4, r0, 24
	ldr r3, [sp]
	ldr r0, [r3, 0x1C]
	lsls r1, r7, 1
	adds r1, r0
	movs r2, 0x80
	lsls r2, 2
	adds r0, r2, 0
	ldrh r1, [r1]
	adds r0, r1
	lsls r0, 16
	lsrs r0, 16
	bl GetBehaviorByMetatileId
	movs r3, 0xF0
	lsls r3, 8
	adds r1, r3, 0
	adds r5, r1, 0
	ands r5, r0
	adds r0, r4, 0
	bl sub_805729C
	lsls r0, 24
	cmp r0, 0
	bne _080FFEDA
	adds r0, r4, 0
	bl sub_80572B0
	lsls r0, 24
	cmp r0, 0
	bne _080FFEDA
	b _080FFFF4
_080FFEDA:
	mov r0, r10
	adds r1, r6, 0
	ldr r3, [sp, 0x20]
	asrs r2, r3, 16
	adds r3, r5, 0
	bl sub_80FFB94
	lsls r0, 24
	cmp r0, 0
	bne _080FFEF0
	b _080FFFF4
_080FFEF0:
	mov r1, r8
	lsrs r0, r1, 16
	ldr r2, [sp, 0x20]
	lsrs r1, r2, 16
	movs r2, 0
	bl GetFieldObjectIdByXYZ
	lsls r0, 24
	lsrs r4, r0, 24
	cmp r4, 0
	beq _080FFF0A
	cmp r4, 0x10
	bne _080FFFF4
_080FFF0A:
	adds r0, r7, 0x1
	lsls r0, 24
	lsrs r7, r0, 24
	ldr r3, [sp, 0x8]
	cmp r7, r3
	bcc _080FFE78
	b _08100024
	.align 2, 0
_080FFF18: .4byte gTasks
_080FFF1C:
	movs r6, 0
	ldr r0, [sp, 0x4]
	cmp r6, r0
	bcc _080FFF26
	b _08100024
_080FFF26:
	mov r1, r10
	lsls r0, r1, 2
	add r0, r10
	lsls r1, r0, 3
	ldr r2, _080FFF9C @ =gTasks
	adds r0, r1, r2
	ldrh r0, [r0, 0xA]
	subs r0, r6
	lsls r0, 16
	lsrs r0, 16
	mov r9, r0
	movs r7, 0
	ldr r3, [sp, 0x8]
	cmp r7, r3
	bcs _080FFF8C
	adds r0, r2, 0
	adds r1, r0
	mov r8, r1
	mov r1, r9
	lsls r0, r1, 16
	asrs r5, r0, 16
_080FFF50:
	mov r2, r8
	ldrh r0, [r2, 0x8]
	adds r0, r7
	lsls r0, 16
	asrs r4, r0, 16
	adds r0, r4, 0
	adds r1, r5, 0
	bl MapGridGetMetatileBehaviorAt
	lsls r0, 24
	lsrs r0, 24
	bl sub_80572B0
	lsls r0, 24
	cmp r0, 0
	beq _080FFFF4
	adds r0, r4, 0
	adds r1, r5, 0x1
	bl MapGridGetMetatileIdAt
	movs r1, 0xA3
	lsls r1, 2
	cmp r0, r1
	beq _080FFFF4
	adds r0, r7, 0x1
	lsls r0, 24
	lsrs r7, r0, 24
	ldr r3, [sp, 0x8]
	cmp r7, r3
	bcc _080FFF50
_080FFF8C:
	adds r0, r6, 0x1
	lsls r0, 24
	lsrs r6, r0, 24
	ldr r0, [sp, 0x4]
	cmp r6, r0
	bcc _080FFF26
	b _08100024
	.align 2, 0
_080FFF9C: .4byte gTasks
_080FFFA0:
	mov r3, r10
	lsls r1, r3, 2
	adds r0, r1, r3
	lsls r0, 3
	adds r0, r2
	ldrh r0, [r0, 0xA]
	mov r9, r0
	movs r7, 0
	str r1, [sp, 0x1C]
	ldr r0, [sp, 0x8]
	cmp r7, r0
	bcs _08100024
	adds r6, r2, 0
	mov r1, r9
	lsls r1, 16
	str r1, [sp, 0x20]
_080FFFC0:
	ldr r0, [sp, 0x1C]
	add r0, r10
	lsls r0, 3
	adds r0, r6
	ldrh r0, [r0, 0x8]
	adds r0, r7
	lsls r0, 16
	lsrs r5, r0, 16
	asrs r0, 16
	mov r2, r9
	lsls r1, r2, 16
	asrs r1, 16
	bl MapGridGetMetatileBehaviorAt
	lsls r0, 24
	lsrs r4, r0, 24
	ldr r3, [sp]
	ldrb r0, [r3, 0x12]
	cmp r0, 0x5
	bne _080FFFF8
_080FFFE8:
	adds r0, r4, 0
	bl sub_80572EC
	lsls r0, 24
	cmp r0, 0
	bne _08100004
_080FFFF4:
	movs r0, 0
	b _08100026
_080FFFF8:
	adds r0, r4, 0
	bl sub_80572D8
	lsls r0, 24
	cmp r0, 0
	beq _080FFFE8
_08100004:
	adds r0, r5, 0
	ldr r2, [sp, 0x20]
	lsrs r1, r2, 16
	movs r2, 0
	bl GetFieldObjectIdByXYZ
	lsls r0, 24
	lsrs r0, 24
	cmp r0, 0x10
	bne _080FFFF4
	adds r0, r7, 0x1
	lsls r0, 24
	lsrs r7, r0, 24
	ldr r3, [sp, 0x8]
	cmp r7, r3
	bcc _080FFFC0
_08100024:
	movs r0, 0x1
_08100026:
	add sp, 0x24
	pop {r3-r5}
	mov r8, r3
	mov r9, r4
	mov r10, r5
	pop {r4-r7}
	pop {r1}
	bx r1
	thumb_func_end sub_80FFC24

	thumb_func_start sub_8100038
sub_8100038: @ 8100038
	push {r4,lr}
	lsls r0, 24
	lsrs r4, r0, 24
	ldr r0, _0810006C @ =gUnknown_020388F5
	ldrb r1, [r0]
	ldr r0, _08100070 @ =gUnknown_020388D0
	ldr r0, [r0]
	adds r0, r1
	ldrb r1, [r0]
	lsls r1, 5
	ldr r0, _08100074 @ =gDecorations
	adds r1, r0
	adds r0, r4, 0
	bl sub_80FFC24
	lsls r0, 24
	lsrs r0, 24
	cmp r0, 0x1
	bne _08100080
	ldr r1, _08100078 @ =gSecretBaseText_PlaceItHere
	ldr r2, _0810007C @ =sub_81000A0
	adds r0, r4, 0
	movs r3, 0
	bl DisplayItemMessageOnField
	b _08100092
	.align 2, 0
_0810006C: .4byte gUnknown_020388F5
_08100070: .4byte gUnknown_020388D0
_08100074: .4byte gDecorations
_08100078: .4byte gSecretBaseText_PlaceItHere
_0810007C: .4byte sub_81000A0
_08100080:
	movs r0, 0x20
	bl PlaySE
	ldr r1, _08100098 @ =gSecretBaseText_CantBePlacedHere
	ldr r2, _0810009C @ =sub_81006A8
	adds r0, r4, 0
	movs r3, 0
	bl DisplayItemMessageOnField
_08100092:
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
_08100098: .4byte gSecretBaseText_CantBePlacedHere
_0810009C: .4byte sub_81006A8
	thumb_func_end sub_8100038

	thumb_func_start sub_81000A0
sub_81000A0: @ 81000A0
	push {r4,lr}
	adds r4, r0, 0
	lsls r4, 24
	lsrs r4, 24
	movs r0, 0x14
	movs r1, 0x8
	movs r2, 0x1
	bl DisplayYesNoMenu
	ldr r1, _081000C0 @ =gUnknown_083EC95C
	adds r0, r4, 0
	bl sub_80F914C
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
_081000C0: .4byte gUnknown_083EC95C
	thumb_func_end sub_81000A0

	thumb_func_start sub_81000C4
sub_81000C4: @ 81000C4
	push {r4,lr}
	lsls r0, 24
	lsrs r4, r0, 24
	movs r0, 0
	movs r1, 0
	movs r2, 0x1D
	movs r3, 0x13
	bl MenuZeroFillWindowRect
	adds r0, r4, 0
	bl sub_8100174
	ldr r2, _0810010C @ =gDecorations
	ldr r0, _08100110 @ =gUnknown_020388F5
	ldrb r1, [r0]
	ldr r0, _08100114 @ =gUnknown_020388D0
	ldr r0, [r0]
	adds r0, r1
	ldrb r3, [r0]
	lsls r0, r3, 5
	adds r0, r2
	ldrb r0, [r0, 0x11]
	cmp r0, 0x4
	beq _0810011C
	ldr r0, _08100118 @ =gTasks
	lsls r1, r4, 2
	adds r1, r4
	lsls r1, 3
	adds r1, r0
	ldrh r0, [r1, 0x8]
	ldrh r1, [r1, 0xA]
	adds r2, r3, 0
	bl sub_80FF394
	b _0810013C
	.align 2, 0
_0810010C: .4byte gDecorations
_08100110: .4byte gUnknown_020388F5
_08100114: .4byte gUnknown_020388D0
_08100118: .4byte gTasks
_0810011C:
	ldr r2, _0810015C @ =gUnknown_020391A4
	ldr r0, _08100160 @ =gTasks
	lsls r1, r4, 2
	adds r1, r4
	lsls r1, 3
	adds r1, r0
	ldrh r0, [r1, 0x8]
	subs r0, 0x7
	strh r0, [r2]
	ldr r2, _08100164 @ =gUnknown_020391A6
	ldrh r0, [r1, 0xA]
	subs r0, 0x7
	strh r0, [r2]
	ldr r0, _08100168 @ =gUnknown_081A2F7B
	bl ScriptContext1_SetupScript
_0810013C:
	ldr r2, _0810016C @ =gSprites
	ldr r0, _08100170 @ =gUnknown_020391A8
	ldrb r1, [r0]
	lsls r0, r1, 4
	adds r0, r1
	lsls r0, 2
	adds r0, r2
	ldrh r1, [r0, 0x22]
	adds r1, 0x2
	strh r1, [r0, 0x22]
	adds r0, r4, 0
	bl sub_810028C
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
_0810015C: .4byte gUnknown_020391A4
_08100160: .4byte gTasks
_08100164: .4byte gUnknown_020391A6
_08100168: .4byte gUnknown_081A2F7B
_0810016C: .4byte gSprites
_08100170: .4byte gUnknown_020391A8
	thumb_func_end sub_81000C4

	thumb_func_start sub_8100174
sub_8100174: @ 8100174
	push {r4-r6,lr}
	lsls r0, 24
	lsrs r6, r0, 24
	movs r3, 0
	ldr r0, _081001B0 @ =0x0201f000
	ldrb r1, [r0, 0x8]
	adds r5, r0, 0
	cmp r3, r1
	bcs _0810019A
	ldr r4, [r5]
_08100188:
	adds r2, r4, r3
	ldrb r0, [r2]
	cmp r0, 0
	beq _081001B8
	adds r0, r3, 0x1
	lsls r0, 16
	lsrs r3, r0, 16
	cmp r3, r1
	bcc _08100188
_0810019A:
	ldrb r0, [r5, 0x9]
	cmp r0, 0
	bne _08100204
	movs r3, 0
	ldr r0, _081001B4 @ =gUnknown_020388D6
	ldrb r1, [r0]
	adds r2, r0, 0
	cmp r1, 0
	bne _081001F0
	b _08100210
	.align 2, 0
_081001B0: .4byte 0x0201f000
_081001B4: .4byte gUnknown_020388D6
_081001B8:
	ldr r0, _081001E4 @ =gUnknown_020388F5
	ldrb r1, [r0]
	ldr r0, _081001E8 @ =gUnknown_020388D0
	ldr r0, [r0]
	adds r0, r1
	ldrb r0, [r0]
	strb r0, [r2]
	ldr r2, [r5, 0x4]
	adds r2, r3
	ldr r0, _081001EC @ =gTasks
	lsls r1, r6, 2
	adds r1, r6
	lsls r1, 3
	adds r1, r0
	ldrb r0, [r1, 0x8]
	subs r0, 0x7
	lsls r0, 4
	ldrb r1, [r1, 0xA]
	subs r1, 0x7
	adds r0, r1
	strb r0, [r2]
	b _0810019A
	.align 2, 0
_081001E4: .4byte gUnknown_020388F5
_081001E8: .4byte gUnknown_020388D0
_081001EC: .4byte gTasks
_081001F0:
	adds r0, r3, 0x1
	lsls r0, 16
	lsrs r3, r0, 16
	cmp r3, 0xF
	bhi _0810023E
	adds r1, r3, r2
	ldrb r0, [r1]
	cmp r0, 0
	bne _081001F0
	b _08100236
_08100204:
	movs r3, 0
	ldr r0, _0810021C @ =gUnknown_020388E6
	ldrb r1, [r0]
	adds r2, r0, 0
	cmp r1, 0
	bne _08100224
_08100210:
	ldr r0, _08100220 @ =gUnknown_020388F5
	ldrb r0, [r0]
	adds r0, 0x1
	strb r0, [r2]
	b _0810023E
	.align 2, 0
_0810021C: .4byte gUnknown_020388E6
_08100220: .4byte gUnknown_020388F5
_08100224:
	adds r0, r3, 0x1
	lsls r0, 16
	lsrs r3, r0, 16
	cmp r3, 0xB
	bhi _0810023E
	adds r1, r3, r2
	ldrb r0, [r1]
	cmp r0, 0
	bne _08100224
_08100236:
	ldr r0, _08100244 @ =gUnknown_020388F5
	ldrb r0, [r0]
	adds r0, 0x1
	strb r0, [r1]
_0810023E:
	pop {r4-r6}
	pop {r0}
	bx r0
	.align 2, 0
_08100244: .4byte gUnknown_020388F5
	thumb_func_end sub_8100174

	thumb_func_start sub_8100248
sub_8100248: @ 8100248
	push {r4,lr}
	adds r4, r0, 0
	lsls r4, 24
	lsrs r4, 24
	movs r0, 0x14
	movs r1, 0x8
	movs r2, 0x1
	bl DisplayYesNoMenu
	ldr r1, _08100268 @ =gUnknown_083EC964
	adds r0, r4, 0
	bl sub_80F914C
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
_08100268: .4byte gUnknown_083EC964
	thumb_func_end sub_8100248

	thumb_func_start sub_810026C
sub_810026C: @ 810026C
	push {r4,lr}
	adds r4, r0, 0
	lsls r4, 24
	lsrs r4, 24
	movs r0, 0
	movs r1, 0
	movs r2, 0x1D
	movs r3, 0x13
	bl MenuZeroFillWindowRect
	adds r0, r4, 0
	bl sub_810028C
	pop {r4}
	pop {r0}
	bx r0
	thumb_func_end sub_810026C

	thumb_func_start sub_810028C
sub_810028C: @ 810028C
	push {r4,lr}
	adds r4, r0, 0
	lsls r4, 24
	lsrs r4, 24
	movs r0, 0x1
	movs r1, 0
	bl fade_screen
	ldr r1, _081002B4 @ =gTasks
	lsls r0, r4, 2
	adds r0, r4
	lsls r0, 3
	adds r0, r1
	movs r1, 0
	strh r1, [r0, 0xC]
	ldr r1, _081002B8 @ =c1_overworld_prev_quest
	str r1, [r0]
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
_081002B4: .4byte gTasks
_081002B8: .4byte c1_overworld_prev_quest
	thumb_func_end sub_810028C

	thumb_func_start c1_overworld_prev_quest
c1_overworld_prev_quest: @ 81002BC
	push {r4,r5,lr}
	lsls r0, 24
	lsrs r4, r0, 24
	ldr r1, _081002DC @ =gTasks
	lsls r0, r4, 2
	adds r0, r4
	lsls r0, 3
	adds r5, r0, r1
	movs r1, 0xC
	ldrsh r0, [r5, r1]
	cmp r0, 0
	beq _081002E0
	cmp r0, 0x1
	beq _08100300
	b _0810031C
	.align 2, 0
_081002DC: .4byte gTasks
_081002E0:
	bl ScriptContext2_Enable
	ldr r0, _081002FC @ =gPaletteFade
	ldrb r1, [r0, 0x7]
	movs r0, 0x80
	ands r0, r1
	cmp r0, 0
	bne _0810031C
	adds r0, r4, 0
	bl sub_80FF114
	movs r0, 0x1
	strh r0, [r5, 0xC]
	b _0810031C
	.align 2, 0
_081002FC: .4byte gPaletteFade
_08100300:
	bl sub_81016F4
	ldr r0, _08100324 @ =0x00000bb8
	bl FreeSpritePaletteByTag
	ldr r1, _08100328 @ =gUnknown_0300485C
	ldr r0, _0810032C @ =sub_8100364
	str r0, [r1]
	ldr r0, _08100330 @ =c2_exit_to_overworld_2_switch
	bl SetMainCallback2
	adds r0, r4, 0
	bl DestroyTask
_0810031C:
	pop {r4,r5}
	pop {r0}
	bx r0
	.align 2, 0
_08100324: .4byte 0x00000bb8
_08100328: .4byte gUnknown_0300485C
_0810032C: .4byte sub_8100364
_08100330: .4byte c2_exit_to_overworld_2_switch
	thumb_func_end c1_overworld_prev_quest

	thumb_func_start sub_8100334
sub_8100334: @ 8100334
	push {r4,lr}
	lsls r0, 24
	lsrs r4, r0, 24
	bl sub_807D770
	lsls r0, 24
	lsrs r0, 24
	cmp r0, 0x1
	bne _08100354
	ldr r0, _0810035C @ =gTasks
	lsls r1, r4, 2
	adds r1, r4
	lsls r1, 3
	adds r1, r0
	ldr r0, _08100360 @ =sub_80FE948
	str r0, [r1]
_08100354:
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
_0810035C: .4byte gTasks
_08100360: .4byte sub_80FE948
	thumb_func_end sub_8100334

	thumb_func_start sub_8100364
sub_8100364: @ 8100364
	push {lr}
	bl ScriptContext2_Enable
	bl LoadScrollIndicatorPalette
	bl pal_fill_black
	ldr r0, _08100388 @ =sub_8100334
	movs r1, 0x8
	bl CreateTask
	lsls r0, 24
	lsrs r0, 24
	bl sub_80FE7EC
	pop {r0}
	bx r0
	.align 2, 0
_08100388: .4byte sub_8100334
	thumb_func_end sub_8100364

	thumb_func_start sub_810038C
sub_810038C: @ 810038C
	push {r4,lr}
	lsls r0, 24
	lsrs r0, 24
	lsls r1, r0, 2
	adds r1, r0
	lsls r1, 3
	ldr r0, _081003BC @ =gTasks + 0x8
	adds r2, r1, r0
	ldr r0, _081003C0 @ =gUnknown_020391AA
	ldrb r1, [r0]
	adds r3, r0, 0
	cmp r1, 0x1
	bne _081003C4
	movs r1, 0x2
	ldrsh r0, [r2, r1]
	movs r4, 0xC
	ldrsh r1, [r2, r4]
	subs r0, r1
	subs r0, 0x6
	cmp r0, 0
	bge _081003C4
	ldrh r0, [r2, 0x2]
	adds r0, 0x1
	b _081003DE
	.align 2, 0
_081003BC: .4byte gTasks + 0x8
_081003C0: .4byte gUnknown_020391AA
_081003C4:
	ldrb r0, [r3]
	cmp r0, 0x2
	bne _081003E8
	movs r0, 0x2
	ldrsh r1, [r2, r0]
	subs r1, 0x7
	ldr r0, _081003E4 @ =gMapHeader
	ldr r0, [r0]
	ldr r0, [r0, 0x4]
	cmp r1, r0
	blt _081003E8
	ldrh r0, [r2, 0x2]
	subs r0, 0x1
_081003DE:
	strh r0, [r2, 0x2]
	movs r0, 0
	b _0810042A
	.align 2, 0
_081003E4: .4byte gMapHeader
_081003E8:
	ldrb r0, [r3]
	cmp r0, 0x3
	bne _081003FE
	movs r1, 0
	ldrsh r0, [r2, r1]
	subs r0, 0x7
	cmp r0, 0
	bge _081003FE
	ldrh r0, [r2]
	adds r0, 0x1
	b _0810041E
_081003FE:
	ldrb r0, [r3]
	cmp r0, 0x4
	bne _08100428
	movs r3, 0
	ldrsh r1, [r2, r3]
	movs r4, 0xA
	ldrsh r0, [r2, r4]
	adds r1, r0
	subs r1, 0x8
	ldr r0, _08100424 @ =gMapHeader
	ldr r0, [r0]
	ldr r0, [r0]
	cmp r1, r0
	blt _08100428
	ldrh r0, [r2]
	subs r0, 0x1
_0810041E:
	strh r0, [r2]
	movs r0, 0
	b _0810042A
	.align 2, 0
_08100424: .4byte gMapHeader
_08100428:
	movs r0, 0x1
_0810042A:
	pop {r4}
	pop {r1}
	bx r1
	thumb_func_end sub_810038C

	thumb_func_start sub_8100430
sub_8100430: @ 8100430
	push {lr}
	ldr r0, _08100450 @ =gMain
	ldrh r0, [r0, 0x2C]
	movs r1, 0xF0
	ands r1, r0
	cmp r1, 0x40
	beq _08100454
	cmp r1, 0x80
	beq _08100454
	cmp r1, 0x20
	beq _08100454
	cmp r1, 0x10
	beq _08100454
	movs r0, 0
	b _08100456
	.align 2, 0
_08100450: .4byte gMain
_08100454:
	movs r0, 0x1
_08100456:
	pop {r1}
	bx r1
	thumb_func_end sub_8100430

	thumb_func_start sub_810045C
sub_810045C: @ 810045C
	push {r4,lr}
	ldr r1, _08100488 @ =gUnknown_020391AA
	movs r0, 0
	strb r0, [r1]
	ldr r4, _0810048C @ =gSprites
	ldr r3, _08100490 @ =gUnknown_020391A8
	ldrb r1, [r3]
	lsls r0, r1, 4
	adds r0, r1
	lsls r0, 2
	adds r0, r4
	movs r2, 0
	strh r2, [r0, 0x32]
	ldrb r1, [r3]
	lsls r0, r1, 4
	adds r0, r1
	lsls r0, 2
	adds r0, r4
	strh r2, [r0, 0x34]
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
_08100488: .4byte gUnknown_020391AA
_0810048C: .4byte gSprites
_08100490: .4byte gUnknown_020391A8
	thumb_func_end sub_810045C

	thumb_func_start sub_8100494
sub_8100494: @ 8100494
	push {r4-r7,lr}
	lsls r0, 24
	lsrs r4, r0, 24
	ldr r5, _081004D0 @ =gSprites
	ldr r3, _081004D4 @ =gUnknown_020391A8
	ldrb r1, [r3]
	lsls r0, r1, 4
	adds r0, r1
	lsls r0, 2
	adds r0, r5
	movs r1, 0x36
	ldrsh r6, [r0, r1]
	cmp r6, 0
	beq _081004B2
	b _081005DE
_081004B2:
	ldr r1, _081004D8 @ =gTasks
	lsls r0, r4, 2
	adds r0, r4
	lsls r0, 3
	adds r2, r0, r1
	movs r1, 0x1C
	ldrsh r0, [r2, r1]
	cmp r0, 0x1
	bne _081004E0
	ldr r0, _081004DC @ =gUnknown_083EC96C
	movs r3, 0x20
	ldrsh r1, [r2, r3]
	lsls r1, 3
	b _081004EE
	.align 2, 0
_081004D0: .4byte gSprites
_081004D4: .4byte gUnknown_020391A8
_081004D8: .4byte gTasks
_081004DC: .4byte gUnknown_083EC96C
_081004E0:
	cmp r0, 0x2
	bne _08100500
	ldr r0, _081004FC @ =gUnknown_083EC96C
	movs r3, 0x20
	ldrsh r1, [r2, r3]
	lsls r1, 3
	adds r0, 0x4
_081004EE:
	adds r1, r0
	ldr r1, [r1]
	adds r0, r4, 0
	bl _call_via_r1
	b _0810063C
	.align 2, 0
_081004FC: .4byte gUnknown_083EC96C
_08100500:
	ldr r7, _08100644 @ =gMain
	ldrh r1, [r7, 0x2C]
	movs r0, 0xF0
	mov r12, r0
	ands r0, r1
	cmp r0, 0x40
	bne _08100534
	ldr r1, _08100648 @ =gUnknown_020391AA
	movs r0, 0x1
	strb r0, [r1]
	ldrb r1, [r3]
	lsls r0, r1, 4
	adds r0, r1
	lsls r0, 2
	adds r0, r5
	strh r6, [r0, 0x32]
	ldrb r1, [r3]
	lsls r0, r1, 4
	adds r0, r1
	lsls r0, 2
	adds r0, r5
	ldr r1, _0810064C @ =0x0000fffe
	strh r1, [r0, 0x34]
	ldrh r0, [r2, 0xA]
	subs r0, 0x1
	strh r0, [r2, 0xA]
_08100534:
	ldrh r1, [r7, 0x2C]
	mov r0, r12
	ands r0, r1
	cmp r0, 0x80
	bne _08100564
	ldr r1, _08100648 @ =gUnknown_020391AA
	movs r0, 0x2
	strb r0, [r1]
	ldrb r1, [r3]
	lsls r0, r1, 4
	adds r0, r1
	lsls r0, 2
	adds r0, r5
	strh r6, [r0, 0x32]
	ldrb r1, [r3]
	lsls r0, r1, 4
	adds r0, r1
	lsls r0, 2
	adds r0, r5
	movs r1, 0x2
	strh r1, [r0, 0x34]
	ldrh r0, [r2, 0xA]
	adds r0, 0x1
	strh r0, [r2, 0xA]
_08100564:
	ldrh r1, [r7, 0x2C]
	mov r0, r12
	ands r0, r1
	cmp r0, 0x20
	bne _08100594
	ldr r1, _08100648 @ =gUnknown_020391AA
	movs r0, 0x3
	strb r0, [r1]
	ldrb r1, [r3]
	lsls r0, r1, 4
	adds r0, r1
	lsls r0, 2
	adds r0, r5
	ldr r1, _0810064C @ =0x0000fffe
	strh r1, [r0, 0x32]
	ldrb r1, [r3]
	lsls r0, r1, 4
	adds r0, r1
	lsls r0, 2
	adds r0, r5
	strh r6, [r0, 0x34]
	ldrh r0, [r2, 0x8]
	subs r0, 0x1
	strh r0, [r2, 0x8]
_08100594:
	ldrh r1, [r7, 0x2C]
	mov r0, r12
	ands r0, r1
	cmp r0, 0x10
	bne _081005C4
	ldr r1, _08100648 @ =gUnknown_020391AA
	movs r0, 0x4
	strb r0, [r1]
	ldrb r1, [r3]
	lsls r0, r1, 4
	adds r0, r1
	lsls r0, 2
	adds r0, r5
	movs r1, 0x2
	strh r1, [r0, 0x32]
	ldrb r1, [r3]
	lsls r0, r1, 4
	adds r0, r1
	lsls r0, 2
	adds r0, r5
	strh r6, [r0, 0x34]
	ldrh r0, [r2, 0x8]
	adds r0, 0x1
	strh r0, [r2, 0x8]
_081005C4:
	bl sub_8100430
	lsls r0, 24
	cmp r0, 0
	beq _081005DA
	adds r0, r4, 0
	bl sub_810038C
	lsls r0, 24
	cmp r0, 0
	bne _081005DE
_081005DA:
	bl sub_810045C
_081005DE:
	ldr r0, _08100648 @ =gUnknown_020391AA
	ldrb r0, [r0]
	cmp r0, 0
	beq _0810060C
	ldr r3, _08100650 @ =gSprites
	ldr r2, _08100654 @ =gUnknown_020391A8
	ldrb r1, [r2]
	lsls r0, r1, 4
	adds r0, r1
	lsls r0, 2
	adds r0, r3
	ldrh r1, [r0, 0x36]
	adds r1, 0x1
	strh r1, [r0, 0x36]
	ldrb r0, [r2]
	lsls r1, r0, 4
	adds r1, r0
	lsls r1, 2
	adds r1, r3
	ldrh r2, [r1, 0x36]
	movs r0, 0x7
	ands r0, r2
	strh r0, [r1, 0x36]
_0810060C:
	ldr r0, _08100658 @ =gTasks
	lsls r1, r4, 2
	adds r1, r4
	lsls r1, 3
	adds r2, r1, r0
	movs r1, 0x1C
	ldrsh r0, [r2, r1]
	cmp r0, 0
	bne _0810063C
	ldr r4, _08100644 @ =gMain
	ldrh r1, [r4, 0x2E]
	movs r3, 0x1
	adds r0, r3, 0
	ands r0, r1
	cmp r0, 0
	beq _0810062E
	strh r3, [r2, 0x1C]
_0810062E:
	ldrh r1, [r4, 0x2E]
	movs r3, 0x2
	adds r0, r3, 0
	ands r0, r1
	cmp r0, 0
	beq _0810063C
	strh r3, [r2, 0x1C]
_0810063C:
	pop {r4-r7}
	pop {r0}
	bx r0
	.align 2, 0
_08100644: .4byte gMain
_08100648: .4byte gUnknown_020391AA
_0810064C: .4byte 0x0000fffe
_08100650: .4byte gSprites
_08100654: .4byte gUnknown_020391A8
_08100658: .4byte gTasks
	thumb_func_end sub_8100494

	thumb_func_start sub_810065C
sub_810065C: @ 810065C
	push {r4,lr}
	adds r4, r0, 0
	lsls r4, 24
	lsrs r4, 24
	movs r0, 0
	movs r1, 0
	movs r2, 0x1D
	movs r3, 0x13
	bl MenuZeroFillWindowRect
	ldr r2, _08100698 @ =gSprites
	ldr r0, _0810069C @ =gUnknown_020391A8
	ldrb r1, [r0]
	lsls r0, r1, 4
	adds r0, r1
	lsls r0, 2
	adds r0, r2
	movs r2, 0
	strh r2, [r0, 0x3C]
	ldr r1, _081006A0 @ =gTasks
	lsls r0, r4, 2
	adds r0, r4
	lsls r0, 3
	adds r0, r1
	strh r2, [r0, 0x1C]
	ldr r1, _081006A4 @ =sub_8100494
	str r1, [r0]
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
_08100698: .4byte gSprites
_0810069C: .4byte gUnknown_020391A8
_081006A0: .4byte gTasks
_081006A4: .4byte sub_8100494
	thumb_func_end sub_810065C

	thumb_func_start sub_81006A8
sub_81006A8: @ 81006A8
	push {lr}
	lsls r0, 24
	lsrs r2, r0, 24
	ldr r0, _081006CC @ =gMain
	ldrh r1, [r0, 0x2E]
	movs r0, 0x1
	ands r0, r1
	cmp r0, 0
	bne _081006C2
	movs r0, 0x2
	ands r0, r1
	cmp r0, 0
	beq _081006C8
_081006C2:
	adds r0, r2, 0
	bl sub_810065C
_081006C8:
	pop {r0}
	bx r0
	.align 2, 0
_081006CC: .4byte gMain
	thumb_func_end sub_81006A8

	thumb_func_start sub_81006D0
sub_81006D0: @ 81006D0
	push {r4,r5,lr}
	adds r3, r0, 0
	movs r1, 0
	adds r2, r3, 0
	adds r2, 0x84
	movs r5, 0
	ldr r4, _08100708 @ =0x000007ff
_081006DE:
	adds r0, r2, r1
	strb r5, [r0]
	adds r0, r1, 0x1
	lsls r0, 16
	lsrs r1, r0, 16
	cmp r1, r4
	bls _081006DE
	movs r1, 0
	adds r2, r3, 0x4
	movs r3, 0
_081006F2:
	lsls r0, r1, 1
	adds r0, r2, r0
	strh r3, [r0]
	adds r0, r1, 0x1
	lsls r0, 16
	lsrs r1, r0, 16
	cmp r1, 0x3F
	bls _081006F2
	pop {r4,r5}
	pop {r0}
	bx r0
	.align 2, 0
_08100708: .4byte 0x000007ff
	thumb_func_end sub_81006D0

	thumb_func_start sub_810070C
sub_810070C: @ 810070C
	push {r4,r5,lr}
	adds r5, r0, 0
	lsls r1, 16
	movs r2, 0
	ldr r0, _0810073C @ =gMapHeader
	ldr r0, [r0]
	ldr r0, [r0, 0x10]
	lsrs r4, r1, 12
	ldr r3, [r0, 0x8]
_0810071E:
	lsls r1, r2, 1
	adds r1, r5
	adds r0, r4, r2
	lsls r0, 1
	adds r0, r3
	ldrh r0, [r0]
	strh r0, [r1]
	adds r0, r2, 0x1
	lsls r0, 16
	lsrs r2, r0, 16
	cmp r2, 0xF
	bls _0810071E
	pop {r4,r5}
	pop {r0}
	bx r0
	.align 2, 0
_0810073C: .4byte gMapHeader
	thumb_func_end sub_810070C

	thumb_func_start sub_8100740
sub_8100740: @ 8100740
	push {r4-r7,lr}
	sub sp, 0x20
	adds r7, r0, 0
	lsls r1, 16
	lsrs r2, r1, 16
	lsrs r3, r1, 26
	cmp r2, 0
	beq _08100754
	ldr r0, _08100784 @ =0x000003ff
	ands r2, r0
_08100754:
	movs r5, 0
	ldr r0, _08100788 @ =gMapHeader
	ldr r6, [r0]
	lsls r4, r2, 5
_0810075C:
	mov r0, sp
	adds r2, r0, r5
	ldr r0, [r6, 0x10]
	ldr r0, [r0, 0x4]
	adds r1, r4, r5
	adds r0, r1
	ldrb r0, [r0]
	strb r0, [r2]
	adds r0, r5, 0x1
	lsls r0, 16
	lsrs r5, r0, 16
	cmp r5, 0x1F
	bls _0810075C
	cmp r3, 0x1
	beq _081007AE
	cmp r3, 0x1
	bgt _0810078C
	cmp r3, 0
	beq _08100796
	b _0810086A
	.align 2, 0
_08100784: .4byte 0x000003ff
_08100788: .4byte gMapHeader
_0810078C:
	cmp r3, 0x2
	beq _0810080E
	cmp r3, 0x3
	beq _08100846
	b _0810086A
_08100796:
	movs r5, 0
_08100798:
	adds r1, r7, r5
	mov r2, sp
	adds r0, r2, r5
	ldrb r0, [r0]
	strb r0, [r1]
	adds r0, r5, 0x1
	lsls r0, 16
	lsrs r5, r0, 16
	cmp r5, 0x1F
	bls _08100798
	b _0810086A
_081007AE:
	movs r5, 0
	movs r6, 0xF
_081007B2:
	lsls r4, r5, 2
	adds r4, r7
	adds r5, 0x1
	lsls r3, r5, 2
	subs r0, r3, 0x1
	add r0, sp
	ldrb r2, [r0]
	lsrs r1, r2, 4
	adds r0, r6, 0
	ands r0, r2
	lsls r0, 4
	adds r1, r0
	strb r1, [r4]
	subs r0, r3, 0x2
	add r0, sp
	ldrb r2, [r0]
	lsrs r1, r2, 4
	adds r0, r6, 0
	ands r0, r2
	lsls r0, 4
	adds r1, r0
	strb r1, [r4, 0x1]
	subs r0, r3, 0x3
	add r0, sp
	ldrb r2, [r0]
	lsrs r1, r2, 4
	adds r0, r6, 0
	ands r0, r2
	lsls r0, 4
	adds r1, r0
	strb r1, [r4, 0x2]
	subs r3, 0x4
	mov r1, sp
	adds r0, r1, r3
	ldrb r2, [r0]
	lsrs r1, r2, 4
	adds r0, r6, 0
	ands r0, r2
	lsls r0, 4
	adds r1, r0
	strb r1, [r4, 0x3]
	lsls r5, 16
	lsrs r5, 16
	cmp r5, 0x7
	bls _081007B2
	b _0810086A
_0810080E:
	movs r5, 0
	movs r3, 0x7
_08100812:
	lsls r2, r5, 2
	adds r2, r7
	subs r1, r3, r5
	lsls r1, 2
	mov r4, sp
	adds r0, r4, r1
	ldrb r0, [r0]
	strb r0, [r2]
	adds r0, r1, 0x1
	add r0, sp
	ldrb r0, [r0]
	strb r0, [r2, 0x1]
	adds r0, r1, 0x2
	add r0, sp
	ldrb r0, [r0]
	strb r0, [r2, 0x2]
	adds r1, 0x3
	adds r0, r4, r1
	ldrb r0, [r0]
	strb r0, [r2, 0x3]
	adds r0, r5, 0x1
	lsls r0, 16
	lsrs r5, r0, 16
	cmp r5, 0x7
	bls _08100812
	b _0810086A
_08100846:
	movs r5, 0
	movs r4, 0x1F
	movs r6, 0xF
_0810084C:
	adds r3, r7, r5
	subs r0, r4, r5
	add r0, sp
	ldrb r2, [r0]
	lsrs r1, r2, 4
	adds r0, r6, 0
	ands r0, r2
	lsls r0, 4
	adds r1, r0
	strb r1, [r3]
	adds r0, r5, 0x1
	lsls r0, 16
	lsrs r5, r0, 16
	cmp r5, 0x1F
	bls _0810084C
_0810086A:
	add sp, 0x20
	pop {r4-r7}
	pop {r0}
	bx r0
	thumb_func_end sub_8100740

	thumb_func_start sub_8100874
sub_8100874: @ 8100874
	push {r4,r5,lr}
	adds r5, r0, 0
	movs r4, 0
_0810087A:
	lsls r0, r4, 5
	adds r0, 0x84
	adds r0, r5, r0
	lsls r2, r4, 1
	adds r1, r5, 0x4
	adds r1, r2
	ldrh r1, [r1]
	bl sub_8100740
	adds r0, r4, 0x1
	lsls r0, 16
	lsrs r4, r0, 16
	cmp r4, 0x3F
	bls _0810087A
	pop {r4,r5}
	pop {r0}
	bx r0
	thumb_func_end sub_8100874

	thumb_func_start sub_810089C
sub_810089C: @ 810089C
	lsls r0, 16
	ldr r1, _081008B4 @ =gMapHeader
	ldr r1, [r1]
	ldr r1, [r1, 0x14]
	ldr r1, [r1, 0xC]
	lsrs r0, 15
	adds r0, r1
	ldrh r1, [r0]
	ldr r0, _081008B8 @ =0x00000fff
	ands r0, r1
	bx lr
	.align 2, 0
_081008B4: .4byte gMapHeader
_081008B8: .4byte 0x00000fff
	thumb_func_end sub_810089C

	thumb_func_start sub_81008BC
sub_81008BC: @ 81008BC
	push {r4-r7,lr}
	mov r7, r8
	push {r7}
	mov r8, r0
	ldr r0, [r0]
	ldrb r0, [r0, 0x12]
	movs r6, 0
	ldr r1, _0810092C @ =gUnknown_083EC860
	lsls r5, r0, 4
	adds r0, r5, r1
	ldrb r0, [r0, 0xC]
	cmp r6, r0
	bcs _08100920
	adds r7, r1, 0
_081008D8:
	mov r4, r8
	ldm r4!, {r1}
	adds r0, r7, 0x4
	adds r0, r5, r0
	ldr r0, [r0]
	adds r0, r6
	ldrb r0, [r0]
	ldr r1, [r1, 0x1C]
	lsls r0, 1
	adds r0, r1
	ldrh r0, [r0]
	adds r1, r7, 0
	adds r1, 0x8
	adds r1, r5, r1
	ldr r1, [r1]
	adds r1, r6
	lsls r0, 3
	ldrb r1, [r1]
	adds r0, r1
	lsls r0, 16
	lsrs r0, 16
	bl sub_810089C
	adds r2, r5, r7
	ldr r1, [r2]
	adds r1, r6
	ldrb r1, [r1]
	lsls r1, 1
	adds r4, r1
	strh r0, [r4]
	adds r0, r6, 0x1
	lsls r0, 24
	lsrs r6, r0, 24
	ldrb r2, [r2, 0xC]
	cmp r6, r2
	bcc _081008D8
_08100920:
	pop {r3}
	mov r8, r3
	pop {r4-r7}
	pop {r0}
	bx r0
	.align 2, 0
_0810092C: .4byte gUnknown_083EC860
	thumb_func_end sub_81008BC

	thumb_func_start sub_8100930
sub_8100930: @ 8100930
	push {r4,r5,lr}
	lsls r0, 24
	ldr r3, _08100998 @ =gUnknown_020391AC
	movs r1, 0
	strb r1, [r3]
	ldrb r2, [r3, 0x1]
	subs r1, 0x4
	ands r1, r2
	movs r4, 0xD
	negs r4, r4
	ands r1, r4
	movs r2, 0x11
	negs r2, r2
	ands r1, r2
	subs r2, 0x10
	ands r1, r2
	strb r1, [r3, 0x1]
	ldr r1, _0810099C @ =gUnknown_083EC900
	lsrs r0, 22
	adds r0, r1
	ldrb r1, [r0]
	movs r5, 0x3F
	lsls r1, 6
	strb r1, [r3, 0x1]
	ldrh r2, [r3, 0x2]
	ldr r1, _081009A0 @ =0xfffffe00
	ands r1, r2
	strh r1, [r3, 0x2]
	ldrb r2, [r3, 0x3]
	movs r1, 0x3F
	negs r1, r1
	ands r1, r2
	strb r1, [r3, 0x3]
	ldrb r0, [r0, 0x1]
	lsls r0, 6
	ands r5, r1
	orrs r5, r0
	strb r5, [r3, 0x3]
	ldrh r1, [r3, 0x4]
	ldr r0, _081009A4 @ =0xfffffc00
	ands r0, r1
	strh r0, [r3, 0x4]
	ldrb r0, [r3, 0x5]
	ands r4, r0
	movs r0, 0x4
	orrs r4, r0
	movs r0, 0xF
	ands r4, r0
	strb r4, [r3, 0x5]
	pop {r4,r5}
	pop {r0}
	bx r0
	.align 2, 0
_08100998: .4byte gUnknown_020391AC
_0810099C: .4byte gUnknown_083EC900
_081009A0: .4byte 0xfffffe00
_081009A4: .4byte 0xfffffc00
	thumb_func_end sub_8100930

	thumb_func_start sub_81009A8
sub_81009A8: @ 81009A8
	movs r1, 0
	strh r1, [r0, 0x32]
	strh r1, [r0, 0x34]
	strh r1, [r0, 0x36]
	strh r1, [r0, 0x38]
	strh r1, [r0, 0x3A]
	strh r1, [r0, 0x3C]
	ldr r1, _081009BC @ =sub_81009C0
	str r1, [r0, 0x1C]
	bx lr
	.align 2, 0
_081009BC: .4byte sub_81009C0
	thumb_func_end sub_81009A8

	thumb_func_start sub_81009C0
sub_81009C0: @ 81009C0
	push {lr}
	adds r2, r0, 0
	movs r1, 0x3C
	ldrsh r0, [r2, r1]
	cmp r0, 0
	bne _081009FA
	movs r1, 0x3A
	ldrsh r0, [r2, r1]
	cmp r0, 0xE
	bgt _081009E2
	adds r3, r2, 0
	adds r3, 0x3E
	ldrb r1, [r3]
	movs r0, 0x5
	negs r0, r0
	ands r0, r1
	b _081009EC
_081009E2:
	adds r3, r2, 0
	adds r3, 0x3E
	ldrb r0, [r3]
	movs r1, 0x4
	orrs r0, r1
_081009EC:
	strb r0, [r3]
	ldrh r0, [r2, 0x3A]
	adds r0, 0x1
	movs r1, 0x1F
	ands r0, r1
	strh r0, [r2, 0x3A]
	b _08100A06
_081009FA:
	adds r2, 0x3E
	ldrb r1, [r2]
	movs r0, 0x5
	negs r0, r0
	ands r0, r1
	strb r0, [r2]
_08100A06:
	pop {r0}
	bx r0
	thumb_func_end sub_81009C0

	thumb_func_start sub_8100A0C
sub_8100A0C: @ 8100A0C
	push {r4,lr}
	lsls r0, 24
	lsrs r4, r0, 24
	adds r0, r4, 0
	bl sub_8100D38
	lsls r0, 24
	lsrs r0, 24
	cmp r0, 0x1
	bne _08100A44
	movs r0, 0x1
	movs r1, 0
	bl fade_screen
	ldr r1, _08100A3C @ =gTasks
	lsls r0, r4, 2
	adds r0, r4
	lsls r0, 3
	adds r0, r1
	movs r1, 0
	strh r1, [r0, 0xC]
	ldr r1, _08100A40 @ =sub_8100E70
	str r1, [r0]
	b _08100A50
	.align 2, 0
_08100A3C: .4byte gTasks
_08100A40: .4byte sub_8100E70
_08100A44:
	ldr r1, _08100A58 @ =gSecretBaseText_NoDecorInUse
	ldr r2, _08100A5C @ =sub_80FE428
	adds r0, r4, 0
	movs r3, 0
	bl DisplayItemMessageOnField
_08100A50:
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
_08100A58: .4byte gSecretBaseText_NoDecorInUse
_08100A5C: .4byte sub_80FE428
	thumb_func_end sub_8100A0C

	thumb_func_start sub_8100A60
sub_8100A60: @ 8100A60
	lsls r0, 24
	lsrs r0, 24
	ldr r3, _08100A78 @ =0x0201f000
	ldr r1, [r3]
	adds r1, r0
	movs r2, 0
	strb r2, [r1]
	ldr r1, [r3, 0x4]
	adds r1, r0
	strb r2, [r1]
	bx lr
	.align 2, 0
_08100A78: .4byte 0x0201f000
	thumb_func_end sub_8100A60

	thumb_func_start sub_8100A7C
sub_8100A7C: @ 8100A7C
	push {r4-r6,lr}
	ldr r6, _08100A9C @ =gUnknown_0202E8CE
	movs r0, 0
	strh r0, [r6]
	ldr r2, _08100AA0 @ =gScriptResult
	strh r0, [r2]
	ldr r4, _08100AA4 @ =gUnknown_0202E8CC
	ldr r1, _08100AA8 @ =gUnknown_02039234
	ldrh r0, [r4]
	ldrb r1, [r1]
	cmp r0, r1
	bne _08100AB8
	movs r0, 0x1
	strh r0, [r2]
	b _08100B0A
	.align 2, 0
_08100A9C: .4byte gUnknown_0202E8CE
_08100AA0: .4byte gScriptResult
_08100AA4: .4byte gUnknown_0202E8CC
_08100AA8: .4byte gUnknown_02039234
_08100AAC:
	ldr r1, _08100AB4 @ =gUnknown_0202E8D0
	ldrb r0, [r2]
	strh r0, [r1]
	b _08100B0A
	.align 2, 0
_08100AB4: .4byte gUnknown_0202E8D0
_08100AB8:
	ldr r3, _08100B10 @ =gDecorations
	ldr r2, _08100B14 @ =0x0201f000
	ldr r1, _08100B18 @ =gUnknown_020391B4
	ldrh r0, [r4]
	lsls r0, 3
	adds r4, r0, r1
	ldrb r1, [r4]
	ldr r0, [r2]
	adds r0, r1
	ldrb r0, [r0]
	lsls r0, 5
	adds r0, r3
	ldrb r0, [r0, 0x11]
	cmp r0, 0x4
	bne _08100B0A
	ldrh r0, [r4, 0x4]
	strh r0, [r6]
	ldrb r0, [r4]
	bl sub_8100A60
	movs r1, 0
	ldr r0, _08100B1C @ =gMapHeader
	ldr r0, [r0, 0x4]
	ldrb r2, [r0]
	cmp r1, r2
	bcs _08100B0A
	ldr r5, [r0, 0x4]
	ldrh r4, [r6]
	adds r3, r2, 0
_08100AF2:
	lsls r0, r1, 1
	adds r0, r1
	lsls r0, 3
	adds r2, r0, r5
	ldrh r0, [r2, 0x14]
	cmp r0, r4
	beq _08100AAC
	adds r0, r1, 0x1
	lsls r0, 16
	lsrs r1, r0, 16
	cmp r1, r3
	bcc _08100AF2
_08100B0A:
	pop {r4-r6}
	pop {r0}
	bx r0
	.align 2, 0
_08100B10: .4byte gDecorations
_08100B14: .4byte 0x0201f000
_08100B18: .4byte gUnknown_020391B4
_08100B1C: .4byte gMapHeader
	thumb_func_end sub_8100A7C

	thumb_func_start sub_8100B20
sub_8100B20: @ 8100B20
	push {r4-r6,lr}
	movs r2, 0
	ldr r0, _08100B4C @ =gMapHeader
	ldr r0, [r0, 0x4]
	ldrb r1, [r0]
	cmp r2, r1
	bcs _08100B64
	adds r3, r0, 0
	ldr r5, [r3, 0x4]
	ldr r0, _08100B50 @ =gUnknown_0202E8CC
	ldrh r4, [r0]
	ldr r6, _08100B54 @ =gUnknown_0202E8CE
_08100B38:
	lsls r0, r2, 1
	adds r0, r2
	lsls r0, 3
	adds r1, r0, r5
	ldrh r0, [r1, 0x14]
	cmp r0, r4
	bne _08100B58
	ldrb r0, [r1]
	strh r0, [r6]
	b _08100B64
	.align 2, 0
_08100B4C: .4byte gMapHeader
_08100B50: .4byte gUnknown_0202E8CC
_08100B54: .4byte gUnknown_0202E8CE
_08100B58:
	adds r0, r2, 0x1
	lsls r0, 24
	lsrs r2, r0, 24
	ldrb r0, [r3]
	cmp r2, r0
	bcc _08100B38
_08100B64:
	pop {r4-r6}
	pop {r0}
	bx r0
	thumb_func_end sub_8100B20

	thumb_func_start sub_8100B6C
sub_8100B6C: @ 8100B6C
	push {r4-r7,lr}
	mov r7, r10
	mov r6, r9
	mov r5, r8
	push {r5-r7}
	sub sp, 0xC
	movs r7, 0
	b _08100C64
_08100B7C:
	lsls r3, r7, 3
	ldr r0, _08100BE0 @ =gUnknown_020391B4
	adds r4, r3, r0
	ldrb r1, [r4]
	ldr r2, _08100BE4 @ =0x0201f000
	ldr r0, [r2]
	adds r0, r1
	ldrb r6, [r0]
	lsls r0, r6, 5
	ldr r5, _08100BE8 @ =gDecorations
	adds r0, r5
	ldrb r2, [r0, 0x11]
	ldr r5, _08100BE4 @ =0x0201f000
	ldr r0, [r5, 0x4]
	adds r0, r1
	ldrb r0, [r0]
	lsrs r1, r0, 4
	mov r9, r1
	movs r5, 0xF
	mov r10, r5
	mov r1, r10
	ands r1, r0
	mov r10, r1
	adds r5, r3, 0
	adds r3, r7, 0x1
	str r3, [sp]
	cmp r2, 0x4
	beq _08100C5E
	cmp r6, 0x29
	bne _08100BD0
	mov r0, r9
	adds r0, 0x7
	adds r1, 0x7
	bl MapGridGetMetatileIdAt
	movs r1, 0xA3
	lsls r1, 2
	cmp r0, r1
	bne _08100BD0
	ldrb r0, [r4, 0x2]
	adds r0, 0x1
	strb r0, [r4, 0x2]
_08100BD0:
	movs r6, 0
	ldr r1, _08100BE0 @ =gUnknown_020391B4
	adds r2, r5, 0
	adds r0, r5, r1
	adds r3, r7, 0x1
	str r3, [sp]
	b _08100C4E
	.align 2, 0
_08100BE0: .4byte gUnknown_020391B4
_08100BE4: .4byte 0x0201f000
_08100BE8: .4byte gDecorations
_08100BEC:
	movs r4, 0
	adds r0, r2, r1
	adds r7, r6, 0x1
	str r7, [sp, 0x4]
	ldrb r0, [r0, 0x1]
	cmp r4, r0
	bcs _08100C42
	ldr r0, _08100C7C @ =gUnknown_020391B4
	adds r0, r5
	mov r8, r0
	subs r1, r6, 0x7
	str r1, [sp, 0x8]
_08100C04:
	adds r0, r4, 0x7
	add r0, r9
	ldr r1, _08100C80 @ =gMapHeader
	ldr r3, [r1]
	mov r7, r10
	subs r2, r7, r6
	ldr r1, [r3]
	muls r2, r1
	mov r7, r9
	adds r1, r7, r4
	adds r1, r2
	ldr r2, [r3, 0xC]
	lsls r1, 1
	adds r1, r2
	ldrh r1, [r1]
	movs r3, 0xC0
	lsls r3, 6
	adds r2, r3, 0
	orrs r2, r1
	mov r7, r10
	ldr r3, [sp, 0x8]
	subs r1, r7, r3
	bl MapGridSetMetatileEntryAt
	adds r0, r4, 0x1
	lsls r0, 24
	lsrs r4, r0, 24
	mov r7, r8
	ldrb r7, [r7, 0x1]
	cmp r4, r7
	bcc _08100C04
_08100C42:
	ldr r1, [sp, 0x4]
	lsls r0, r1, 24
	lsrs r6, r0, 24
	ldr r1, _08100C7C @ =gUnknown_020391B4
	adds r2, r5, 0
	adds r0, r5, r1
_08100C4E:
	ldrb r0, [r0, 0x2]
	cmp r6, r0
	bcc _08100BEC
	ldr r2, _08100C7C @ =gUnknown_020391B4
	adds r0, r5, r2
	ldrb r0, [r0]
	bl sub_8100A60
_08100C5E:
	ldr r3, [sp]
	lsls r0, r3, 24
	lsrs r7, r0, 24
_08100C64:
	ldr r0, _08100C84 @ =gUnknown_02039234
	ldrb r0, [r0]
	cmp r7, r0
	bcc _08100B7C
	add sp, 0xC
	pop {r3-r5}
	mov r8, r3
	mov r9, r4
	mov r10, r5
	pop {r4-r7}
	pop {r0}
	bx r0
	.align 2, 0
_08100C7C: .4byte gUnknown_020391B4
_08100C80: .4byte gMapHeader
_08100C84: .4byte gUnknown_02039234
	thumb_func_end sub_8100B6C

	thumb_func_start sub_8100C88
sub_8100C88: @ 8100C88
	push {r4,r5,lr}
	lsls r0, 24
	lsrs r4, r0, 24
	ldr r1, _08100CAC @ =gTasks
	lsls r0, r4, 2
	adds r0, r4
	lsls r0, 3
	adds r5, r0, r1
	movs r1, 0xC
	ldrsh r0, [r5, r1]
	cmp r0, 0x1
	beq _08100CC4
	cmp r0, 0x1
	bgt _08100CB0
	cmp r0, 0
	beq _08100CBA
	b _08100D24
	.align 2, 0
_08100CAC: .4byte gTasks
_08100CB0:
	cmp r0, 0x2
	beq _08100CF4
	cmp r0, 0x3
	beq _08100D08
	b _08100D24
_08100CBA:
	bl sub_8100B6C
	movs r0, 0x1
	strh r0, [r5, 0xC]
	b _08100D24
_08100CC4:
	ldr r0, _08100CEC @ =gPaletteFade
	ldrb r1, [r0, 0x7]
	movs r0, 0x80
	ands r0, r1
	cmp r0, 0
	bne _08100D24
	bl DrawWholeMapView
	ldr r0, _08100CF0 @ =gUnknown_081A2F8A
	bl ScriptContext1_SetupScript
	movs r0, 0
	movs r1, 0
	movs r2, 0x1D
	movs r3, 0x13
	bl MenuZeroFillWindowRect
	movs r0, 0x2
	strh r0, [r5, 0xC]
	b _08100D24
	.align 2, 0
_08100CEC: .4byte gPaletteFade
_08100CF0: .4byte gUnknown_081A2F8A
_08100CF4:
	bl ScriptContext2_Enable
	adds r0, r4, 0
	bl sub_80FED90
	bl pal_fill_black
	movs r0, 0x3
	strh r0, [r5, 0xC]
	b _08100D24
_08100D08:
	bl sub_807D770
	lsls r0, 24
	lsrs r0, 24
	cmp r0, 0x1
	bne _08100D24
	ldr r0, _08100D2C @ =0x0000ffff
	strh r0, [r5, 0x22]
	ldr r1, _08100D30 @ =gSecretBaseText_DecorReturned
	ldr r2, _08100D34 @ =sub_81010F0
	adds r0, r4, 0
	movs r3, 0
	bl DisplayItemMessageOnField
_08100D24:
	pop {r4,r5}
	pop {r0}
	bx r0
	.align 2, 0
_08100D2C: .4byte 0x0000ffff
_08100D30: .4byte gSecretBaseText_DecorReturned
_08100D34: .4byte sub_81010F0
	thumb_func_end sub_8100C88

	thumb_func_start sub_8100D38
sub_8100D38: @ 8100D38
	push {r4,r5,lr}
	lsls r0, 24
	lsrs r3, r0, 24
	movs r2, 0
	ldr r0, _08100D68 @ =0x0201f000
	adds r4, r0, 0
	ldrb r0, [r4, 0x8]
	cmp r2, r0
	bcs _08100D7C
	adds r5, r4, 0
	ldr r1, _08100D6C @ =gTasks
	lsls r0, r3, 2
	adds r0, r3
	lsls r0, 3
	adds r1, r0, r1
_08100D56:
	ldr r0, [r5]
	adds r0, r2
	ldrb r0, [r0]
	cmp r0, 0
	beq _08100D70
	strh r2, [r1, 0x22]
	movs r0, 0x1
	b _08100D7E
	.align 2, 0
_08100D68: .4byte 0x0201f000
_08100D6C: .4byte gTasks
_08100D70:
	adds r0, r2, 0x1
	lsls r0, 16
	lsrs r2, r0, 16
	ldrb r0, [r4, 0x8]
	cmp r2, r0
	bcc _08100D56
_08100D7C:
	movs r0, 0
_08100D7E:
	pop {r4,r5}
	pop {r1}
	bx r1
	thumb_func_end sub_8100D38

	thumb_func_start SetUpPuttingAwayDecorationPlayerAvatar
SetUpPuttingAwayDecorationPlayerAvatar: @ 8100D84
	push {r4-r6,lr}
	mov r6, r8
	push {r6}
	sub sp, 0x4
	bl player_get_direction_lower_nybble
	movs r0, 0
	movs r1, 0
	movs r2, 0x1D
	movs r3, 0x13
	bl MenuZeroFillWindowRect
	ldr r3, _08100DD8 @ =gUnknown_020391A8
	ldr r2, _08100DDC @ =gSprites
	ldr r4, _08100DE0 @ =gUnknown_03004880
	ldr r1, [r4, 0x4]
	lsls r0, r1, 4
	adds r0, r1
	lsls r0, 2
	adds r0, r2
	ldrh r0, [r0, 0x2E]
	strb r0, [r3]
	bl sub_81016C8
	ldr r0, _08100DE4 @ =gSpriteTemplate_83ECA88
	movs r1, 0x78
	movs r2, 0x50
	movs r3, 0
	bl CreateSprite
	lsls r0, 24
	lsrs r0, 24
	str r0, [r4, 0x4]
	ldr r0, _08100DE8 @ =gSaveBlock2
	ldrb r0, [r0, 0x8]
	cmp r0, 0
	bne _08100DF0
	ldr r1, _08100DEC @ =SpriteCallbackDummy
	str r0, [sp]
	movs r0, 0xC1
	b _08100DF8
	.align 2, 0
_08100DD8: .4byte gUnknown_020391A8
_08100DDC: .4byte gSprites
_08100DE0: .4byte gUnknown_03004880
_08100DE4: .4byte gSpriteTemplate_83ECA88
_08100DE8: .4byte gSaveBlock2
_08100DEC: .4byte SpriteCallbackDummy
_08100DF0:
	ldr r1, _08100E5C @ =SpriteCallbackDummy
	movs r0, 0
	str r0, [sp]
	movs r0, 0xC2
_08100DF8:
	movs r2, 0x88
	movs r3, 0x48
	bl AddPseudoFieldObject
	ldr r1, _08100E60 @ =gUnknown_020391A9
	strb r0, [r1]
	ldr r6, _08100E64 @ =gSprites
	ldr r0, _08100E60 @ =gUnknown_020391A9
	ldrb r0, [r0]
	lsls r1, r0, 4
	adds r1, r0
	lsls r1, 2
	adds r1, r6
	ldrb r2, [r1, 0x5]
	movs r4, 0xD
	negs r4, r4
	adds r0, r4, 0
	ands r0, r2
	movs r2, 0x4
	mov r8, r2
	mov r2, r8
	orrs r0, r2
	strb r0, [r1, 0x5]
	ldr r5, _08100E68 @ =gUnknown_020391A8
	ldrb r1, [r5]
	lsls r0, r1, 4
	adds r0, r1
	lsls r0, 2
	adds r0, r6
	bl DestroySprite
	ldr r0, _08100E6C @ =gUnknown_03004880
	ldr r0, [r0, 0x4]
	strb r0, [r5]
	ldrb r1, [r5]
	lsls r0, r1, 4
	adds r0, r1
	lsls r0, 2
	adds r0, r6
	ldrb r1, [r0, 0x5]
	ands r4, r1
	mov r1, r8
	orrs r4, r1
	strb r4, [r0, 0x5]
	add sp, 0x4
	pop {r3}
	mov r8, r3
	pop {r4-r6}
	pop {r0}
	bx r0
	.align 2, 0
_08100E5C: .4byte SpriteCallbackDummy
_08100E60: .4byte gUnknown_020391A9
_08100E64: .4byte gSprites
_08100E68: .4byte gUnknown_020391A8
_08100E6C: .4byte gUnknown_03004880
	thumb_func_end SetUpPuttingAwayDecorationPlayerAvatar

	thumb_func_start sub_8100E70
sub_8100E70: @ 8100E70
	push {r4,r5,lr}
	lsls r0, 24
	lsrs r5, r0, 24
	lsls r0, r5, 2
	adds r0, r5
	lsls r0, 3
	ldr r1, _08100E94 @ =gTasks + 0x8
	adds r4, r0, r1
	movs r1, 0x4
	ldrsh r0, [r4, r1]
	cmp r0, 0x1
	beq _08100EC4
	cmp r0, 0x1
	bgt _08100E98
	cmp r0, 0
	beq _08100E9E
	b _08100EE6
	.align 2, 0
_08100E94: .4byte gTasks + 0x8
_08100E98:
	cmp r0, 0x2
	beq _08100ED2
	b _08100EE6
_08100E9E:
	ldr r0, _08100EC0 @ =gPaletteFade
	ldrb r1, [r0, 0x7]
	movs r0, 0x80
	ands r0, r1
	cmp r0, 0
	bne _08100EE6
	adds r0, r5, 0
	bl sub_80FF0E0
	movs r0, 0x1
	strh r0, [r4, 0x4]
	strh r0, [r4, 0xC]
	strh r0, [r4, 0xA]
	bl sub_8072DEC
	b _08100EE6
	.align 2, 0
_08100EC0: .4byte gPaletteFade
_08100EC4:
	bl SetUpPuttingAwayDecorationPlayerAvatar
	bl pal_fill_black
	movs r0, 0x2
	strh r0, [r4, 0x4]
	b _08100EE6
_08100ED2:
	bl sub_807D770
	lsls r0, 24
	lsrs r0, 24
	cmp r0, 0x1
	bne _08100EE6
	strh r0, [r4, 0x18]
	adds r0, r5, 0
	bl sub_8100EEC
_08100EE6:
	pop {r4,r5}
	pop {r0}
	bx r0
	thumb_func_end sub_8100E70

	thumb_func_start sub_8100EEC
sub_8100EEC: @ 8100EEC
	push {r4-r6,lr}
	adds r5, r0, 0
	lsls r5, 24
	lsrs r5, 24
	movs r0, 0
	movs r1, 0
	movs r2, 0x1D
	movs r3, 0x13
	bl MenuZeroFillWindowRect
	ldr r4, _08100F70 @ =gSprites
	ldr r3, _08100F74 @ =gUnknown_020391A8
	ldrb r1, [r3]
	lsls r0, r1, 4
	adds r0, r1
	lsls r0, 2
	adds r0, r4
	movs r6, 0
	strh r6, [r0, 0x3C]
	ldrb r1, [r3]
	lsls r0, r1, 4
	adds r0, r1
	lsls r0, 2
	adds r0, r4
	adds r0, 0x3E
	ldrb r2, [r0]
	movs r1, 0x5
	negs r1, r1
	ands r1, r2
	strb r1, [r0]
	ldrb r1, [r3]
	lsls r0, r1, 4
	adds r0, r1
	lsls r0, 2
	adds r1, r4, 0
	adds r1, 0x1C
	adds r0, r1
	ldr r1, _08100F78 @ =sub_8101698
	str r1, [r0]
	ldr r2, _08100F7C @ =gUnknown_020391A9
	ldrb r1, [r2]
	lsls r0, r1, 4
	adds r0, r1
	lsls r0, 2
	adds r0, r4
	movs r1, 0x88
	strh r1, [r0, 0x20]
	ldrb r1, [r2]
	lsls r0, r1, 4
	adds r0, r1
	lsls r0, 2
	adds r0, r4
	movs r1, 0x48
	strh r1, [r0, 0x22]
	ldr r1, _08100F80 @ =gTasks
	lsls r0, r5, 2
	adds r0, r5
	lsls r0, 3
	adds r0, r1
	strh r6, [r0, 0x1C]
	ldr r1, _08100F84 @ =sub_8100494
	str r1, [r0]
	pop {r4-r6}
	pop {r0}
	bx r0
	.align 2, 0
_08100F70: .4byte gSprites
_08100F74: .4byte gUnknown_020391A8
_08100F78: .4byte sub_8101698
_08100F7C: .4byte gUnknown_020391A9
_08100F80: .4byte gTasks
_08100F84: .4byte sub_8100494
	thumb_func_end sub_8100EEC

	thumb_func_start sub_8100F88
sub_8100F88: @ 8100F88
	push {r4,lr}
	adds r4, r0, 0
	lsls r4, 24
	lsrs r4, 24
	ldr r1, _08100FB0 @ =gTasks
	lsls r0, r4, 2
	adds r0, r4
	lsls r0, 3
	adds r0, r1
	movs r1, 0
	strh r1, [r0, 0x1C]
	bl sub_810045C
	adds r0, r4, 0
	bl sub_8101024
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
_08100FB0: .4byte gTasks
	thumb_func_end sub_8100F88

	thumb_func_start sub_8100FB4
sub_8100FB4: @ 8100FB4
	push {r4,r5,lr}
	adds r4, r0, 0
	lsls r4, 24
	lsrs r4, 24
	ldr r1, _0810100C @ =gTasks
	lsls r0, r4, 2
	adds r0, r4
	lsls r0, 3
	adds r0, r1
	movs r1, 0
	strh r1, [r0, 0x1C]
	bl sub_810045C
	ldr r3, _08101010 @ =gSprites
	ldr r5, _08101014 @ =gUnknown_020391A8
	ldrb r1, [r5]
	lsls r0, r1, 4
	adds r0, r1
	lsls r0, 2
	adds r0, r3
	adds r0, 0x3E
	ldrb r2, [r0]
	movs r1, 0x5
	negs r1, r1
	ands r1, r2
	strb r1, [r0]
	ldrb r1, [r5]
	lsls r0, r1, 4
	adds r0, r1
	lsls r0, 2
	adds r3, 0x1C
	adds r0, r3
	ldr r1, _08101018 @ =SpriteCallbackDummy
	str r1, [r0]
	ldr r1, _0810101C @ =gSecretBaseText_StopPuttingAwayDecor
	ldr r2, _08101020 @ =sub_810156C
	adds r0, r4, 0
	movs r3, 0
	bl DisplayItemMessageOnField
	pop {r4,r5}
	pop {r0}
	bx r0
	.align 2, 0
_0810100C: .4byte gTasks
_08101010: .4byte gSprites
_08101014: .4byte gUnknown_020391A8
_08101018: .4byte SpriteCallbackDummy
_0810101C: .4byte gSecretBaseText_StopPuttingAwayDecor
_08101020: .4byte sub_810156C
	thumb_func_end sub_8100FB4

	thumb_func_start sub_8101024
sub_8101024: @ 8101024
	push {r4,r5,lr}
	lsls r0, 24
	lsrs r5, r0, 24
	adds r0, r5, 0
	bl sub_8101460
	ldr r0, _08101040 @ =gUnknown_02039234
	ldrb r0, [r0]
	cmp r0, 0
	beq _0810104C
	ldr r1, _08101044 @ =gSecretBaseText_ReturnDecor
	ldr r2, _08101048 @ =sub_8101518
	b _081010B0
	.align 2, 0
_08101040: .4byte gUnknown_02039234
_08101044: .4byte gSecretBaseText_ReturnDecor
_08101048: .4byte sub_8101518
_0810104C:
	lsls r1, r5, 2
	adds r1, r5
	lsls r1, 3
	ldr r0, _081010BC @ =gTasks + 0x8
	adds r1, r0
	movs r2, 0
	ldrsh r0, [r1, r2]
	movs r2, 0x2
	ldrsh r1, [r1, r2]
	bl MapGridGetMetatileBehaviorAt
	lsls r0, 24
	lsrs r4, r0, 24
	adds r0, r4, 0
	bl sub_8057238
	lsls r0, 24
	lsrs r0, 24
	cmp r0, 0x1
	beq _08101082
	adds r0, r4, 0
	bl sub_805738C
	lsls r0, 24
	lsrs r0, 24
	cmp r0, 0x1
	bne _081010D4
_08101082:
	ldr r3, _081010C0 @ =gSprites
	ldr r4, _081010C4 @ =gUnknown_020391A8
	ldrb r1, [r4]
	lsls r0, r1, 4
	adds r0, r1
	lsls r0, 2
	adds r0, r3
	adds r0, 0x3E
	ldrb r2, [r0]
	movs r1, 0x5
	negs r1, r1
	ands r1, r2
	strb r1, [r0]
	ldrb r1, [r4]
	lsls r0, r1, 4
	adds r0, r1
	lsls r0, 2
	adds r3, 0x1C
	adds r0, r3
	ldr r1, _081010C8 @ =SpriteCallbackDummy
	str r1, [r0]
	ldr r1, _081010CC @ =gSecretBaseText_StopPuttingAwayDecor
	ldr r2, _081010D0 @ =sub_810156C
_081010B0:
	adds r0, r5, 0
	movs r3, 0
	bl DisplayItemMessageOnField
	b _081010E0
	.align 2, 0
_081010BC: .4byte gTasks + 0x8
_081010C0: .4byte gSprites
_081010C4: .4byte gUnknown_020391A8
_081010C8: .4byte SpriteCallbackDummy
_081010CC: .4byte gSecretBaseText_StopPuttingAwayDecor
_081010D0: .4byte sub_810156C
_081010D4:
	ldr r1, _081010E8 @ =gSecretBaseText_NoDecor
	ldr r2, _081010EC @ =sub_81010F0
	adds r0, r5, 0
	movs r3, 0
	bl DisplayItemMessageOnField
_081010E0:
	pop {r4,r5}
	pop {r0}
	bx r0
	.align 2, 0
_081010E8: .4byte gSecretBaseText_NoDecor
_081010EC: .4byte sub_81010F0
	thumb_func_end sub_8101024

	thumb_func_start sub_81010F0
sub_81010F0: @ 81010F0
	push {lr}
	lsls r0, 24
	lsrs r2, r0, 24
	ldr r0, _08101114 @ =gMain
	ldrh r1, [r0, 0x2E]
	movs r0, 0x1
	ands r0, r1
	cmp r0, 0
	bne _0810110A
	movs r0, 0x2
	ands r0, r1
	cmp r0, 0
	beq _08101110
_0810110A:
	adds r0, r2, 0
	bl sub_8100EEC
_08101110:
	pop {r0}
	bx r0
	.align 2, 0
_08101114: .4byte gMain
	thumb_func_end sub_81010F0

	thumb_func_start sub_8101118
sub_8101118: @ 8101118
	push {lr}
	adds r2, r1, 0
	lsls r0, 24
	ldr r1, _08101130 @ =gDecorations
	lsrs r0, 19
	adds r0, r1
	ldrb r1, [r0, 0x12]
	cmp r1, 0
	bne _08101134
	movs r0, 0x1
	strb r0, [r2, 0x1]
	b _08101192
	.align 2, 0
_08101130: .4byte gDecorations
_08101134:
	cmp r1, 0x1
	bne _08101140
	movs r0, 0x2
	strb r0, [r2, 0x1]
	strb r1, [r2, 0x2]
	b _08101194
_08101140:
	cmp r1, 0x2
	bne _0810114C
	movs r0, 0x3
	strb r0, [r2, 0x1]
	movs r0, 0x1
	b _08101192
_0810114C:
	cmp r1, 0x3
	bne _08101154
	movs r0, 0x4
	b _0810118E
_08101154:
	cmp r1, 0x4
	bne _0810115E
	movs r0, 0x2
	strb r0, [r2, 0x1]
	b _08101192
_0810115E:
	cmp r1, 0x5
	bne _08101166
	movs r0, 0x1
	b _0810118E
_08101166:
	cmp r1, 0x6
	bne _08101172
	movs r0, 0x1
	strb r0, [r2, 0x1]
	movs r0, 0x3
	b _08101192
_08101172:
	cmp r1, 0x7
	bne _0810117E
	movs r0, 0x2
	strb r0, [r2, 0x1]
	movs r0, 0x4
	b _08101192
_0810117E:
	cmp r1, 0x8
	bne _08101188
	movs r0, 0x3
	strb r0, [r2, 0x1]
	b _08101192
_08101188:
	cmp r1, 0x9
	bne _08101194
	movs r0, 0x3
_0810118E:
	strb r0, [r2, 0x1]
	movs r0, 0x2
_08101192:
	strb r0, [r2, 0x2]
_08101194:
	pop {r0}
	bx r0
	thumb_func_end sub_8101118

	thumb_func_start sub_8101198
sub_8101198: @ 8101198
	push {r4-r6,lr}
	lsls r0, 24
	lsls r1, 24
	ldr r5, _081011F0 @ =gSprites
	ldr r6, _081011F4 @ =gUnknown_020391A8
	ldrb r3, [r6]
	lsls r2, r3, 4
	adds r2, r3
	lsls r2, 2
	adds r2, r5
	adds r2, 0x3E
	ldrb r3, [r2]
	movs r4, 0x4
	orrs r3, r4
	strb r3, [r2]
	ldrb r3, [r6]
	lsls r2, r3, 4
	adds r2, r3
	lsls r2, 2
	adds r3, r5, 0
	adds r3, 0x1C
	adds r2, r3
	ldr r3, _081011F8 @ =SpriteCallbackDummy
	str r3, [r2]
	ldr r4, _081011FC @ =gUnknown_020391A9
	ldrb r3, [r4]
	lsls r2, r3, 4
	adds r2, r3
	lsls r2, 2
	adds r2, r5
	lsrs r0, 20
	adds r0, 0x88
	strh r0, [r2, 0x20]
	ldrb r2, [r4]
	lsls r0, r2, 4
	adds r0, r2
	lsls r0, 2
	adds r0, r5
	lsrs r1, 20
	adds r1, 0x48
	strh r1, [r0, 0x22]
	pop {r4-r6}
	pop {r0}
	bx r0
	.align 2, 0
_081011F0: .4byte gSprites
_081011F4: .4byte gUnknown_020391A8
_081011F8: .4byte SpriteCallbackDummy
_081011FC: .4byte gUnknown_020391A9
	thumb_func_end sub_8101198

	thumb_func_start sub_8101200
sub_8101200: @ 8101200
	push {r4-r7,lr}
	mov r7, r8
	push {r7}
	adds r6, r2, 0
	lsls r0, 24
	lsrs r0, 24
	lsls r1, 24
	lsrs r1, 24
	ldr r3, _0810128C @ =gTasks
	lsls r2, r0, 2
	adds r2, r0
	lsls r2, 3
	adds r2, r3
	ldrb r0, [r2, 0x8]
	subs r0, 0x7
	lsls r0, 24
	lsrs r7, r0, 24
	ldrb r0, [r2, 0xA]
	subs r0, 0x7
	lsls r0, 24
	lsrs r0, 24
	mov r8, r0
	ldr r2, _08101290 @ =0x0201f000
	ldr r0, [r2, 0x4]
	adds r0, r1
	ldrb r0, [r0]
	lsrs r4, r0, 4
	movs r5, 0xF
	ands r5, r0
	ldr r0, [r2]
	adds r0, r1
	ldrb r0, [r0]
	cmp r0, 0x29
	bne _0810125A
	adds r0, r4, 0x7
	adds r1, r5, 0x7
	bl MapGridGetMetatileIdAt
	movs r1, 0xA3
	lsls r1, 2
	cmp r0, r1
	bne _0810125A
	ldrb r0, [r6, 0x2]
	subs r0, 0x1
	strb r0, [r6, 0x2]
_0810125A:
	cmp r7, r4
	bcc _08101294
	ldrb r1, [r6, 0x1]
	adds r0, r4, r1
	cmp r7, r0
	bge _08101294
	ldrb r0, [r6, 0x2]
	subs r0, r5, r0
	cmp r8, r0
	ble _08101294
	cmp r8, r5
	bhi _08101294
	subs r0, r7, r4
	adds r0, 0x1
	subs r0, r1, r0
	lsls r0, 24
	lsrs r0, 24
	mov r2, r8
	subs r1, r5, r2
	lsls r1, 24
	lsrs r1, 24
	bl sub_8101198
	movs r0, 0x1
	b _08101296
	.align 2, 0
_0810128C: .4byte gTasks
_08101290: .4byte 0x0201f000
_08101294:
	movs r0, 0
_08101296:
	pop {r3}
	mov r8, r3
	pop {r4-r7}
	pop {r1}
	bx r1
	thumb_func_end sub_8101200

	thumb_func_start sub_81012A0
sub_81012A0: @ 81012A0
	push {r4-r7,lr}
	mov r7, r9
	mov r6, r8
	push {r6,r7}
	ldr r2, _0810130C @ =0x0201f000
	ldr r3, _08101310 @ =gUnknown_020391B4
	ldr r0, _08101314 @ =gUnknown_02039234
	ldrb r0, [r0]
	lsls r0, 3
	adds r0, r3
	ldrb r1, [r0]
	ldr r0, [r2, 0x4]
	adds r0, r1
	ldrb r0, [r0]
	lsrs r7, r0, 4
	movs r6, 0xF
	ands r6, r0
	movs r5, 0
	ldr r0, _08101318 @ =gSaveBlock1
	mov r8, r0
	mov r9, r3
_081012CA:
	lsls r0, r5, 1
	adds r0, r5
	lsls r0, 3
	mov r2, r8
	adds r1, r0, r2
	ldr r2, _0810131C @ =0x00000c24
	adds r0, r1, r2
	movs r2, 0
	ldrsh r0, [r0, r2]
	cmp r0, r7
	bne _08101328
	ldr r2, _08101320 @ =0x00000c26
	adds r0, r1, r2
	movs r2, 0
	ldrsh r0, [r0, r2]
	cmp r0, r6
	bne _08101328
	ldr r0, _08101324 @ =0x00000c34
	adds r4, r1, r0
	ldrh r0, [r4]
	bl FlagGet
	lsls r0, 24
	cmp r0, 0
	bne _08101328
	ldr r0, _08101314 @ =gUnknown_02039234
	ldrb r0, [r0]
	lsls r0, 3
	add r0, r9
	ldrh r1, [r4]
	strh r1, [r0, 0x4]
	b _08101332
	.align 2, 0
_0810130C: .4byte 0x0201f000
_08101310: .4byte gUnknown_020391B4
_08101314: .4byte gUnknown_02039234
_08101318: .4byte gSaveBlock1
_0810131C: .4byte 0x00000c24
_08101320: .4byte 0x00000c26
_08101324: .4byte 0x00000c34
_08101328:
	adds r0, r5, 0x1
	lsls r0, 16
	lsrs r5, r0, 16
	cmp r5, 0x3F
	bls _081012CA
_08101332:
	pop {r3,r4}
	mov r8, r3
	mov r9, r4
	pop {r4-r7}
	pop {r0}
	bx r0
	thumb_func_end sub_81012A0

	thumb_func_start sub_8101340
sub_8101340: @ 8101340
	push {r4-r7,lr}
	lsls r0, 24
	lsrs r7, r0, 24
	movs r6, 0
	b _081013A2
_0810134A:
	ldr r0, [r0]
	adds r1, r0, r6
	ldrb r0, [r1]
	cmp r0, 0
	beq _0810139C
	ldr r0, _08101390 @ =gDecorations
	ldrb r2, [r1]
	lsls r1, r2, 5
	adds r1, r0
	ldrb r0, [r1, 0x11]
	cmp r0, 0x4
	bne _0810139C
	ldr r5, _08101394 @ =gUnknown_020391B4
	adds r0, r2, 0
	adds r1, r5, 0
	bl sub_8101118
	lsls r1, r6, 24
	lsrs r1, 24
	adds r0, r7, 0
	adds r2, r5, 0
	bl sub_8101200
	lsls r0, 24
	lsrs r4, r0, 24
	cmp r4, 0x1
	bne _0810139C
	strb r6, [r5]
	bl sub_81012A0
	ldr r0, _08101398 @ =gUnknown_02039234
	strb r4, [r0]
	movs r0, 0x1
	b _081013AC
	.align 2, 0
_08101390: .4byte gDecorations
_08101394: .4byte gUnknown_020391B4
_08101398: .4byte gUnknown_02039234
_0810139C:
	adds r0, r6, 0x1
	lsls r0, 16
	lsrs r6, r0, 16
_081013A2:
	ldr r0, _081013B4 @ =0x0201f000
	ldrb r1, [r0, 0x8]
	cmp r6, r1
	bcc _0810134A
	movs r0, 0
_081013AC:
	pop {r4-r7}
	pop {r1}
	bx r1
	.align 2, 0
_081013B4: .4byte 0x0201f000
	thumb_func_end sub_8101340

	thumb_func_start sub_81013B8
sub_81013B8: @ 81013B8
	push {r4-r7,lr}
	mov r7, r10
	mov r6, r9
	mov r5, r8
	push {r5-r7}
	sub sp, 0x4
	lsls r0, 24
	lsrs r0, 24
	str r0, [sp]
	lsls r1, 24
	lsrs r1, 24
	mov r10, r1
	lsls r2, 24
	lsrs r2, 24
	mov r9, r2
	lsls r3, 24
	lsrs r3, 24
	mov r8, r3
	movs r4, 0
	ldr r7, _08101450 @ =0x0201f000
	ldrb r0, [r7, 0x8]
	cmp r4, r0
	bcs _0810143E
	adds r6, r7, 0
	ldr r5, _08101454 @ =gUnknown_02039234
_081013EA:
	ldr r0, [r6]
	adds r0, r4
	ldrb r1, [r0]
	ldr r0, [r6, 0x4]
	adds r0, r4
	ldrb r0, [r0]
	lsrs r3, r0, 4
	movs r2, 0xF
	ands r2, r0
	cmp r1, 0
	beq _08101432
	ldr r0, _08101458 @ =gDecorations
	lsls r1, 5
	adds r1, r0
	ldrb r0, [r1, 0x11]
	cmp r0, 0x4
	bne _08101432
	ldr r0, [sp]
	cmp r0, r3
	bhi _08101432
	cmp r10, r2
	bhi _08101432
	cmp r9, r3
	bcc _08101432
	cmp r8, r2
	bcc _08101432
	ldr r0, _0810145C @ =gUnknown_020391B4
	ldrb r1, [r5]
	lsls r1, 3
	adds r1, r0
	strb r4, [r1]
	bl sub_81012A0
	ldrb r0, [r5]
	adds r0, 0x1
	strb r0, [r5]
_08101432:
	adds r0, r4, 0x1
	lsls r0, 24
	lsrs r4, r0, 24
	ldrb r0, [r7, 0x8]
	cmp r4, r0
	bcc _081013EA
_0810143E:
	add sp, 0x4
	pop {r3-r5}
	mov r8, r3
	mov r9, r4
	mov r10, r5
	pop {r4-r7}
	pop {r0}
	bx r0
	.align 2, 0
_08101450: .4byte 0x0201f000
_08101454: .4byte gUnknown_02039234
_08101458: .4byte gDecorations
_0810145C: .4byte gUnknown_020391B4
	thumb_func_end sub_81013B8

	thumb_func_start sub_8101460
sub_8101460: @ 8101460
	push {r4-r7,lr}
	lsls r0, 24
	lsrs r6, r0, 24
	ldr r4, _081014B8 @ =gUnknown_02039234
	movs r0, 0
	strb r0, [r4]
	adds r0, r6, 0
	bl sub_8101340
	lsls r0, 24
	lsrs r0, 24
	cmp r0, 0x1
	beq _08101504
	movs r5, 0
	ldr r0, _081014BC @ =0x0201f000
	ldrb r1, [r0, 0x8]
	cmp r5, r1
	bcs _081014D2
	adds r7, r4, 0
_08101486:
	ldr r0, [r0]
	adds r0, r5
	ldrb r1, [r0]
	cmp r1, 0
	beq _081014C4
	ldr r4, _081014C0 @ =gUnknown_020391B4
	adds r0, r1, 0
	adds r1, r4, 0
	bl sub_8101118
	adds r0, r6, 0
	adds r1, r5, 0
	adds r2, r4, 0
	bl sub_8101200
	lsls r0, 24
	lsrs r0, 24
	cmp r0, 0x1
	bne _081014C4
	strb r5, [r4]
	ldrb r0, [r7]
	adds r0, 0x1
	strb r0, [r7]
	b _081014D2
	.align 2, 0
_081014B8: .4byte gUnknown_02039234
_081014BC: .4byte 0x0201f000
_081014C0: .4byte gUnknown_020391B4
_081014C4:
	adds r0, r5, 0x1
	lsls r0, 24
	lsrs r5, r0, 24
	ldr r0, _0810150C @ =0x0201f000
	ldrb r1, [r0, 0x8]
	cmp r5, r1
	bcc _08101486
_081014D2:
	ldr r0, _08101510 @ =gUnknown_02039234
	ldrb r0, [r0]
	cmp r0, 0
	beq _08101504
	ldr r0, _0810150C @ =0x0201f000
	ldr r2, _08101514 @ =gUnknown_020391B4
	ldrb r1, [r2]
	ldr r0, [r0, 0x4]
	adds r0, r1
	ldrb r1, [r0]
	lsrs r0, r1, 4
	movs r3, 0xF
	ands r3, r1
	ldrb r1, [r2, 0x2]
	subs r1, r3, r1
	adds r1, 0x1
	lsls r1, 24
	lsrs r1, 24
	ldrb r2, [r2, 0x1]
	adds r2, r0
	subs r2, 0x1
	lsls r2, 24
	lsrs r2, 24
	bl sub_81013B8
_08101504:
	pop {r4-r7}
	pop {r0}
	bx r0
	.align 2, 0
_0810150C: .4byte 0x0201f000
_08101510: .4byte gUnknown_02039234
_08101514: .4byte gUnknown_020391B4
	thumb_func_end sub_8101460

	thumb_func_start sub_8101518
sub_8101518: @ 8101518
	push {r4,lr}
	adds r4, r0, 0
	lsls r4, 24
	lsrs r4, 24
	movs r0, 0x14
	movs r1, 0x8
	movs r2, 0x1
	bl DisplayYesNoMenu
	ldr r1, _08101538 @ =gUnknown_083EC9CC
	adds r0, r4, 0
	bl sub_80F914C
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
_08101538: .4byte gUnknown_083EC9CC
	thumb_func_end sub_8101518

	thumb_func_start sub_810153C
sub_810153C: @ 810153C
	push {r4,lr}
	adds r4, r0, 0
	lsls r4, 24
	lsrs r4, 24
	movs r0, 0x1
	movs r1, 0
	bl fade_screen
	ldr r1, _08101564 @ =gTasks
	lsls r0, r4, 2
	adds r0, r4
	lsls r0, 3
	adds r0, r1
	movs r1, 0
	strh r1, [r0, 0xC]
	ldr r1, _08101568 @ =sub_8100C88
	str r1, [r0]
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
_08101564: .4byte gTasks
_08101568: .4byte sub_8100C88
	thumb_func_end sub_810153C

	thumb_func_start sub_810156C
sub_810156C: @ 810156C
	push {r4,lr}
	adds r4, r0, 0
	lsls r4, 24
	lsrs r4, 24
	movs r0, 0x14
	movs r1, 0x8
	movs r2, 0x1
	bl DisplayYesNoMenu
	ldr r1, _0810158C @ =gUnknown_083EC9D4
	adds r0, r4, 0
	bl sub_80F914C
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
_0810158C: .4byte gUnknown_083EC9D4
	thumb_func_end sub_810156C

	thumb_func_start sub_8101590
sub_8101590: @ 8101590
	push {r4,lr}
	adds r4, r0, 0
	lsls r4, 24
	lsrs r4, 24
	movs r0, 0
	movs r1, 0
	movs r2, 0x1D
	movs r3, 0x13
	bl MenuZeroFillWindowRect
	adds r0, r4, 0
	bl sub_81015B0
	pop {r4}
	pop {r0}
	bx r0
	thumb_func_end sub_8101590

	thumb_func_start sub_81015B0
sub_81015B0: @ 81015B0
	push {r4,lr}
	adds r4, r0, 0
	lsls r4, 24
	lsrs r4, 24
	movs r0, 0x1
	movs r1, 0
	bl fade_screen
	ldr r1, _081015D8 @ =gTasks
	lsls r0, r4, 2
	adds r0, r4
	lsls r0, 3
	adds r0, r1
	movs r1, 0
	strh r1, [r0, 0xC]
	ldr r1, _081015DC @ =sub_81015E0
	str r1, [r0]
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
_081015D8: .4byte gTasks
_081015DC: .4byte sub_81015E0
	thumb_func_end sub_81015B0

	thumb_func_start sub_81015E0
sub_81015E0: @ 81015E0
	push {r4,r5,lr}
	lsls r0, 24
	lsrs r4, r0, 24
	ldr r1, _08101600 @ =gTasks
	lsls r0, r4, 2
	adds r0, r4
	lsls r0, 3
	adds r5, r0, r1
	movs r1, 0xC
	ldrsh r0, [r5, r1]
	cmp r0, 0
	beq _08101604
	cmp r0, 0x1
	beq _08101620
	b _08101636
	.align 2, 0
_08101600: .4byte gTasks
_08101604:
	ldr r0, _0810161C @ =gPaletteFade
	ldrb r1, [r0, 0x7]
	movs r0, 0x80
	ands r0, r1
	cmp r0, 0
	bne _08101636
	adds r0, r4, 0
	bl sub_80FF114
	movs r0, 0x1
	strh r0, [r5, 0xC]
	b _08101636
	.align 2, 0
_0810161C: .4byte gPaletteFade
_08101620:
	bl sub_81016F4
	ldr r0, _0810163C @ =gUnknown_0300485C
	ldr r1, _08101640 @ =sub_8101678
	str r1, [r0]
	ldr r0, _08101644 @ =c2_exit_to_overworld_2_switch
	bl SetMainCallback2
	adds r0, r4, 0
	bl DestroyTask
_08101636:
	pop {r4,r5}
	pop {r0}
	bx r0
	.align 2, 0
_0810163C: .4byte gUnknown_0300485C
_08101640: .4byte sub_8101678
_08101644: .4byte c2_exit_to_overworld_2_switch
	thumb_func_end sub_81015E0

	thumb_func_start sub_8101648
sub_8101648: @ 8101648
	push {r4,lr}
	lsls r0, 24
	lsrs r4, r0, 24
	bl sub_807D770
	lsls r0, 24
	lsrs r0, 24
	cmp r0, 0x1
	bne _08101668
	ldr r0, _08101670 @ =gTasks
	lsls r1, r4, 2
	adds r1, r4
	lsls r1, 3
	adds r1, r0
	ldr r0, _08101674 @ =sub_80FE2EC
	str r0, [r1]
_08101668:
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
_08101670: .4byte gTasks
_08101674: .4byte Task_DecorationPCProcessMenuInput
	thumb_func_end sub_8101648

	thumb_func_start sub_8101678
sub_8101678: @ 8101678
	push {lr}
	bl pal_fill_black
	bl MenuDisplayMessageBox
	bl sub_80FE220
	ldr r0, _08101694 @ =sub_8101648
	movs r1, 0x8
	bl CreateTask
	pop {r0}
	bx r0
	.align 2, 0
_08101694: .4byte sub_8101648
	thumb_func_end sub_8101678

	thumb_func_start sub_8101698
sub_8101698: @ 8101698
	push {lr}
	adds r2, r0, 0
	ldrh r0, [r2, 0x2E]
	adds r0, 0x1
	movs r1, 0x1F
	ands r0, r1
	strh r0, [r2, 0x2E]
	cmp r0, 0xF
	ble _081016B8
	adds r0, r2, 0
	adds r0, 0x3E
	ldrb r1, [r0]
	movs r2, 0x4
	orrs r1, r2
	strb r1, [r0]
	b _081016C4
_081016B8:
	adds r2, 0x3E
	ldrb r1, [r2]
	movs r0, 0x5
	negs r0, r0
	ands r0, r1
	strb r0, [r2]
_081016C4:
	pop {r0}
	bx r0
	thumb_func_end sub_8101698

	thumb_func_start sub_81016C8
sub_81016C8: @ 81016C8
	push {lr}
	ldr r0, _081016DC @ =gSaveBlock2
	ldrb r0, [r0, 0x8]
	cmp r0, 0
	bne _081016E4
	ldr r0, _081016E0 @ =gUnknown_083ECA5C
	bl LoadSpritePalette
	b _081016EA
	.align 2, 0
_081016DC: .4byte gSaveBlock2
_081016E0: .4byte gUnknown_083ECA5C
_081016E4:
	ldr r0, _081016F0 @ =gUnknown_083ECA64
	bl LoadSpritePalette
_081016EA:
	pop {r0}
	bx r0
	.align 2, 0
_081016F0: .4byte gUnknown_083ECA64
	thumb_func_end sub_81016C8

	thumb_func_start sub_81016F4
sub_81016F4: @ 81016F4
	push {lr}
	movs r0, 0x8
	bl FreeSpritePaletteByTag
	pop {r0}
	bx r0
	thumb_func_end sub_81016F4

	thumb_func_start sub_8101700
sub_8101700: @ 8101700
	push {r4,lr}
	lsls r0, 24
	lsrs r4, r0, 24
	bl sub_81341D4
	lsls r0, 24
	cmp r0, 0
	bne _08101728
	ldr r1, _08101720 @ =gSecretBaseText_NoDecors
	ldr r2, _08101724 @ =sub_80FE428
	adds r0, r4, 0
	movs r3, 0
	bl DisplayItemMessageOnField
	b _08101742
	.align 2, 0
_08101720: .4byte gSecretBaseText_NoDecors
_08101724: .4byte sub_80FE428
_08101728:
	ldr r1, _08101748 @ =gTasks
	lsls r0, r4, 2
	adds r0, r4
	lsls r0, 3
	adds r0, r1
	movs r2, 0
	movs r1, 0x1
	strh r1, [r0, 0x1E]
	ldr r0, _0810174C @ =gUnknown_020388F6
	strb r2, [r0]
	adds r0, r4, 0
	bl sub_80FE5AC
_08101742:
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
_08101748: .4byte gTasks
_0810174C: .4byte gUnknown_020388F6
	thumb_func_end sub_8101700

	thumb_func_start unref_sub_8101750
unref_sub_8101750: @ 8101750
	push {r4,lr}
	lsls r0, 24
	lsrs r4, r0, 24
	bl sub_81341D4
	lsls r0, 24
	cmp r0, 0
	bne _08101778
	ldr r1, _08101770 @ =gSecretBaseText_NoDecors
	ldr r2, _08101774 @ =sub_80FE428
	adds r0, r4, 0
	movs r3, 0
	bl DisplayItemMessageOnField
	b _08101792
	.align 2, 0
_08101770: .4byte gSecretBaseText_NoDecors
_08101774: .4byte sub_80FE428
_08101778:
	ldr r1, _08101798 @ =gTasks
	lsls r0, r4, 2
	adds r0, r4
	lsls r0, 3
	adds r0, r1
	movs r2, 0
	movs r1, 0x2
	strh r1, [r0, 0x1E]
	ldr r0, _0810179C @ =gUnknown_020388F6
	strb r2, [r0]
	adds r0, r4, 0
	bl sub_80FE5AC
_08101792:
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
_08101798: .4byte gTasks
_0810179C: .4byte gUnknown_020388F6
	thumb_func_end unref_sub_8101750

	thumb_func_start sub_81017A0
sub_81017A0: @ 81017A0
	push {r4,r5,lr}
	lsls r0, 24
	lsrs r5, r0, 24
	bl sub_80FEF74
	bl sub_80FED1C
	bl sub_80FEFA4
	lsls r0, 24
	lsrs r0, 24
	cmp r0, 0x1
	bne _08101808
	ldr r0, _081017EC @ =gStringVar1
	ldr r1, _081017F0 @ =gUnknown_020388F5
	ldrb r2, [r1]
	ldr r1, _081017F4 @ =gUnknown_020388D0
	ldr r1, [r1]
	adds r1, r2
	ldrb r1, [r1]
	lsls r1, 5
	ldr r2, _081017F8 @ =gDecorations + 0x1
	adds r1, r2
	bl StringCopy
	ldr r4, _081017FC @ =gStringVar4
	ldr r1, _08101800 @ =gSecretBaseText_WillBeDiscarded
	adds r0, r4, 0
	bl StringExpandPlaceholders
	ldr r2, _08101804 @ =sub_8101824
	adds r0, r5, 0
	adds r1, r4, 0
	movs r3, 0
	bl DisplayItemMessageOnField
	b _08101814
	.align 2, 0
_081017EC: .4byte gStringVar1
_081017F0: .4byte gUnknown_020388F5
_081017F4: .4byte gUnknown_020388D0
_081017F8: .4byte gDecorations + 0x1
_081017FC: .4byte gStringVar4
_08101800: .4byte gSecretBaseText_WillBeDiscarded
_08101804: .4byte sub_8101824
_08101808:
	ldr r1, _0810181C @ =gSecretBaseText_DecorInUse
	ldr r2, _08101820 @ =sub_80FEFF4
	adds r0, r5, 0
	movs r3, 0
	bl DisplayItemMessageOnField
_08101814:
	pop {r4,r5}
	pop {r0}
	bx r0
	.align 2, 0
_0810181C: .4byte gSecretBaseText_DecorInUse
_08101820: .4byte sub_80FEFF4
	thumb_func_end sub_81017A0

	thumb_func_start sub_8101824
sub_8101824: @ 8101824
	push {r4,lr}
	adds r4, r0, 0
	lsls r4, 24
	lsrs r4, 24
	movs r0, 0x14
	movs r1, 0x8
	movs r2, 0x1
	bl DisplayYesNoMenu
	ldr r1, _08101844 @ =gUnknown_083ECAA0
	adds r0, r4, 0
	bl sub_80F914C
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
_08101844: .4byte gUnknown_083ECAA0
	thumb_func_end sub_8101824

	thumb_func_start sub_8101848
sub_8101848: @ 8101848
	push {r4-r6,lr}
	adds r4, r0, 0
	lsls r4, 24
	lsrs r4, 24
	movs r0, 0x14
	movs r1, 0x8
	movs r2, 0x1A
	movs r3, 0xE
	bl MenuZeroFillWindowRect
	ldr r6, _08101890 @ =gUnknown_020388F5
	ldrb r1, [r6]
	ldr r5, _08101894 @ =gUnknown_020388D0
	ldr r0, [r5]
	adds r0, r1
	ldrb r0, [r0]
	bl sub_8109A30
	ldrb r1, [r6]
	ldr r0, [r5]
	adds r0, r1
	movs r1, 0
	strb r1, [r0]
	adds r0, r4, 0
	bl sub_80FF098
	ldr r1, _08101898 @ =gSecretBaseText_DecorThrownAway
	ldr r2, _0810189C @ =sub_80FEFF4
	adds r0, r4, 0
	movs r3, 0
	bl DisplayItemMessageOnField
	pop {r4-r6}
	pop {r0}
	bx r0
	.align 2, 0
_08101890: .4byte gUnknown_020388F5
_08101894: .4byte gUnknown_020388D0
_08101898: .4byte gSecretBaseText_DecorThrownAway
_0810189C: .4byte sub_80FEFF4
	thumb_func_end sub_8101848

	.align 2, 0 @ Don't pad with nop.
