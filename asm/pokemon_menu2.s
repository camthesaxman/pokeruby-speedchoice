	.include "constants/gba_constants.inc"
	.include "constants/species_constants.inc"
	.include "asm/macros.inc"

	.syntax unified

	.text

	thumb_func_start sub_808AAF0
sub_808AAF0: @ 808AAF0
	push {r4,lr}
	lsls r0, 24
	lsrs r4, r0, 24
	ldr r0, _0808AB2C @ =gUnknown_0202E8F6
	ldrb r0, [r0]
	cmp r0, 0x1
	beq _0808AB24
	ldr r0, _0808AB30 @ =gMain
	ldrh r1, [r0, 0x2E]
	movs r0, 0x1
	ands r0, r1
	cmp r0, 0
	bne _0808AB12
	movs r0, 0x2
	ands r0, r1
	cmp r0, 0
	beq _0808AB24
_0808AB12:
	movs r0, 0
	movs r1, 0xE
	movs r2, 0x1D
	movs r3, 0x13
	bl MenuZeroFillWindowRect
	adds r0, r4, 0
	bl PokemonMenu_Cancel
_0808AB24:
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
_0808AB2C: .4byte gUnknown_0202E8F6
_0808AB30: .4byte gMain
	thumb_func_end sub_808AAF0

	thumb_func_start sub_808AB34
sub_808AB34: @ 808AB34
	push {r4,lr}
	lsls r0, 24
	lsrs r4, r0, 24
	ldr r0, _0808AB6C @ =gPaletteFade
	ldrb r1, [r0, 0x7]
	movs r0, 0x80
	ands r0, r1
	cmp r0, 0
	bne _0808AB84
	ldr r0, _0808AB70 @ =gTasks
	lsls r1, r4, 2
	adds r1, r4
	lsls r1, 3
	adds r1, r0
	movs r2, 0x1E
	ldrsh r0, [r1, r2]
	cmp r0, 0x5
	bne _0808AB62
	bl ShouldDoBrailleFlyEffect
	lsls r0, 24
	cmp r0, 0
	beq _0808AB78
_0808AB62:
	ldr r0, _0808AB74 @ =c2_exit_to_overworld_2_switch
	bl SetMainCallback2
	b _0808AB7E
	.align 2, 0
_0808AB6C: .4byte gPaletteFade
_0808AB70: .4byte gTasks
_0808AB74: .4byte c2_exit_to_overworld_2_switch
_0808AB78:
	ldr r0, _0808AB8C @ =sub_80FC074
	bl SetMainCallback2
_0808AB7E:
	adds r0, r4, 0
	bl DestroyTask
_0808AB84:
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
_0808AB8C: .4byte sub_80FC074
	thumb_func_end sub_808AB34

	thumb_func_start sub_808AB90
sub_808AB90: @ 808AB90
	push {lr}
	bl pal_fill_black
	ldr r0, _0808ABA4 @ =sub_808ABA8
	movs r1, 0x8
	bl CreateTask
	pop {r0}
	bx r0
	.align 2, 0
_0808ABA4: .4byte sub_808ABA8
	thumb_func_end sub_808AB90

	thumb_func_start sub_808ABA8
sub_808ABA8: @ 808ABA8
	push {r4,lr}
	lsls r0, 24
	lsrs r4, r0, 24
	bl sub_807D770
	lsls r0, 24
	lsrs r0, 24
	cmp r0, 0x1
	bne _0808ABDE
	ldr r0, _0808ABE4 @ =gLastFieldPokeMenuOpened
	ldrb r1, [r0]
	movs r0, 0x64
	muls r0, r1
	ldr r1, _0808ABE8 @ =gPlayerParty
	adds r0, r1
	movs r1, 0xB
	bl GetMonData
	ldr r1, _0808ABEC @ =gUnknown_0202FF84
	str r0, [r1]
	ldr r0, _0808ABF0 @ =gUnknown_03005CE4
	ldr r0, [r0]
	bl _call_via_r0
	adds r0, r4, 0
	bl DestroyTask
_0808ABDE:
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
_0808ABE4: .4byte gLastFieldPokeMenuOpened
_0808ABE8: .4byte gPlayerParty
_0808ABEC: .4byte gUnknown_0202FF84
_0808ABF0: .4byte gUnknown_03005CE4
	thumb_func_end sub_808ABA8

	thumb_func_start sub_808ABF4
sub_808ABF4: @ 808ABF4
	push {r4,lr}
	lsls r0, 24
	lsrs r4, r0, 24
	ldr r0, _0808AC28 @ =gMain
	ldrh r1, [r0, 0x2E]
	movs r0, 0x1
	ands r0, r1
	cmp r0, 0
	bne _0808AC0E
	movs r0, 0x2
	ands r0, r1
	cmp r0, 0
	beq _0808AC20
_0808AC0E:
	movs r0, 0x1
	movs r1, 0x11
	movs r2, 0x1C
	movs r3, 0x12
	bl MenuZeroFillWindowRect
	adds r0, r4, 0
	bl PokemonMenu_Cancel
_0808AC20:
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
_0808AC28: .4byte gMain
	thumb_func_end sub_808ABF4

	thumb_func_start sub_808AC2C
sub_808AC2C: @ 808AC2C
	push {lr}
	ldr r0, _0808AC40 @ =gUnknown_0202FF84
	ldr r1, _0808AC44 @ =gLastFieldPokeMenuOpened
	ldrb r1, [r1]
	str r1, [r0]
	movs r0, 0x9
	bl FieldEffectStart
	pop {r0}
	bx r0
	.align 2, 0
_0808AC40: .4byte gUnknown_0202FF84
_0808AC44: .4byte gLastFieldPokeMenuOpened
	thumb_func_end sub_808AC2C

	thumb_func_start SetUpFieldMove_Surf
SetUpFieldMove_Surf: @ 808AC48
	push {lr}
	bl PartyHasMonWithSurf
	lsls r0, 24
	lsrs r0, 24
	cmp r0, 0x1
	bne _0808AC84
	bl IsPlayerFacingSurfableFishableWater
	lsls r0, 24
	lsrs r0, 24
	cmp r0, 0x1
	bne _0808AC84
	ldr r1, _0808AC74 @ =gUnknown_0300485C
	ldr r0, _0808AC78 @ =sub_808AB90
	str r0, [r1]
	ldr r1, _0808AC7C @ =gUnknown_03005CE4
	ldr r0, _0808AC80 @ =sub_808AC2C
	str r0, [r1]
	movs r0, 0x1
	b _0808AC86
	.align 2, 0
_0808AC74: .4byte gUnknown_0300485C
_0808AC78: .4byte sub_808AB90
_0808AC7C: .4byte gUnknown_03005CE4
_0808AC80: .4byte sub_808AC2C
_0808AC84:
	movs r0, 0
_0808AC86:
	pop {r1}
	bx r1
	thumb_func_end SetUpFieldMove_Surf

	thumb_func_start sub_808AC8C
sub_808AC8C: @ 808AC8C
	push {lr}
	ldr r0, _0808ACA0 @ =gUnknown_0202FF84
	ldr r1, _0808ACA4 @ =gLastFieldPokeMenuOpened
	ldrb r1, [r1]
	str r1, [r0]
	movs r0, 0x1F
	bl FieldEffectStart
	pop {r0}
	bx r0
	.align 2, 0
_0808ACA0: .4byte gUnknown_0202FF84
_0808ACA4: .4byte gLastFieldPokeMenuOpened
	thumb_func_end sub_808AC8C

	thumb_func_start SetUpFieldMove_Fly
SetUpFieldMove_Fly: @ 808ACA8
	push {lr}
	bl ShouldDoBrailleFlyEffect
	lsls r0, 24
	cmp r0, 0
	beq _0808ACD0
	ldr r1, _0808ACC0 @ =gUnknown_0300485C
	ldr r0, _0808ACC4 @ =sub_808AB90
	str r0, [r1]
	ldr r1, _0808ACC8 @ =gUnknown_03005CE4
	ldr r0, _0808ACCC @ =DoBrailleFlyEffect
	b _0808ACF2
	.align 2, 0
_0808ACC0: .4byte gUnknown_0300485C
_0808ACC4: .4byte sub_808AB90
_0808ACC8: .4byte gUnknown_03005CE4
_0808ACCC: .4byte DoBrailleFlyEffect
_0808ACD0:
	ldr r0, _0808ACE4 @ =gMapHeader
	ldrb r0, [r0, 0x17]
	bl is_light_level_1_2_3_or_6
	lsls r0, 24
	lsrs r0, 24
	cmp r0, 0x1
	beq _0808ACE8
	movs r0, 0
	b _0808ACF6
	.align 2, 0
_0808ACE4: .4byte gMapHeader
_0808ACE8:
	ldr r1, _0808ACFC @ =gUnknown_0300485C
	ldr r0, _0808AD00 @ =sub_808AB90
	str r0, [r1]
	ldr r1, _0808AD04 @ =gUnknown_03005CE4
	ldr r0, _0808AD08 @ =sub_808AC8C
_0808ACF2:
	str r0, [r1]
	movs r0, 0x1
_0808ACF6:
	pop {r1}
	bx r1
	.align 2, 0
_0808ACFC: .4byte gUnknown_0300485C
_0808AD00: .4byte sub_808AB90
_0808AD04: .4byte gUnknown_03005CE4
_0808AD08: .4byte sub_808AC8C
	thumb_func_end SetUpFieldMove_Fly

	thumb_func_start sub_808AD0C
sub_808AD0C: @ 808AD0C
	push {r4,lr}
	ldr r4, _0808AD14 @ =0x0201b260
	b _0808AD24
	.align 2, 0
_0808AD14: .4byte 0x0201b260
_0808AD18:
	bl sub_80F9344
	lsls r0, 24
	lsrs r0, 24
	cmp r0, 0x1
	beq _0808AD48
_0808AD24:
	bl sub_806B124
	lsls r0, 24
	lsrs r0, 24
	cmp r0, 0x1
	bne _0808AD18
	ldrb r0, [r4]
	ldr r1, _0808AD50 @ =gLastFieldPokeMenuOpened
	ldrb r1, [r1]
	bl sub_806C994
	ldrb r0, [r4]
	movs r1, 0
	bl sub_806BF74
	ldr r0, _0808AD54 @ =sub_806AEDC
	bl SetMainCallback2
_0808AD48:
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
_0808AD50: .4byte gLastFieldPokeMenuOpened
_0808AD54: .4byte sub_806AEDC
	thumb_func_end sub_808AD0C

	thumb_func_start sub_808AD58
sub_808AD58: @ 808AD58
	push {lr}
	ldr r2, _0808AD7C @ =gPaletteFade
	ldrb r0, [r2, 0x8]
	movs r1, 0x80
	orrs r0, r1
	strb r0, [r2, 0x8]
	ldr r2, _0808AD80 @ =sub_8089CD4
	movs r0, 0
	movs r1, 0xFF
	movs r3, 0
	bl sub_806AF4C
	ldr r0, _0808AD84 @ =sub_808AD0C
	bl SetMainCallback2
	pop {r0}
	bx r0
	.align 2, 0
_0808AD7C: .4byte gPaletteFade
_0808AD80: .4byte sub_8089CD4
_0808AD84: .4byte sub_808AD0C
	thumb_func_end sub_808AD58

	thumb_func_start unref_sub_808AD88
unref_sub_808AD88: @ 808AD88
	push {lr}
	ldr r0, _0808ADA4 @ =gLastFieldPokeMenuOpened
	ldrb r1, [r0]
	movs r0, 0x64
	muls r0, r1
	ldr r1, _0808ADA8 @ =gPlayerParty
	adds r0, r1
	movs r1, 0xB
	bl GetMonData
	lsls r0, 16
	lsrs r0, 16
	pop {r1}
	bx r1
	.align 2, 0
_0808ADA4: .4byte gLastFieldPokeMenuOpened
_0808ADA8: .4byte gPlayerParty
	thumb_func_end unref_sub_808AD88

	thumb_func_start sub_808ADAC
sub_808ADAC: @ 808ADAC
	push {lr}
	ldr r0, _0808ADC0 @ =gUnknown_0202FF84
	ldr r1, _0808ADC4 @ =gLastFieldPokeMenuOpened
	ldrb r1, [r1]
	str r1, [r0]
	movs r0, 0x2C
	bl FieldEffectStart
	pop {r0}
	bx r0
	.align 2, 0
_0808ADC0: .4byte gUnknown_0202FF84
_0808ADC4: .4byte gLastFieldPokeMenuOpened
	thumb_func_end sub_808ADAC

	thumb_func_start SetUpFieldMove_Dive
SetUpFieldMove_Dive: @ 808ADC8
	push {lr}
	bl sub_8068F18
	ldr r1, _0808ADE0 @ =gUnknown_0202FF84
	lsls r0, 24
	lsrs r0, 24
	str r0, [r1, 0x4]
	cmp r0, 0
	bne _0808ADE4
	movs r0, 0
	b _0808ADF2
	.align 2, 0
_0808ADE0: .4byte gUnknown_0202FF84
_0808ADE4:
	ldr r1, _0808ADF8 @ =gUnknown_0300485C
	ldr r0, _0808ADFC @ =sub_808AB90
	str r0, [r1]
	ldr r1, _0808AE00 @ =gUnknown_03005CE4
	ldr r0, _0808AE04 @ =sub_808ADAC
	str r0, [r1]
	movs r0, 0x1
_0808ADF2:
	pop {r1}
	bx r1
	.align 2, 0
_0808ADF8: .4byte gUnknown_0300485C
_0808ADFC: .4byte sub_808AB90
_0808AE00: .4byte gUnknown_03005CE4
_0808AE04: .4byte sub_808ADAC
	thumb_func_end SetUpFieldMove_Dive

	thumb_func_start sub_808AE08
sub_808AE08: @ 808AE08
	push {lr}
	ldr r0, _0808AE1C @ =gUnknown_0202FF84
	ldr r1, _0808AE20 @ =gLastFieldPokeMenuOpened
	ldrb r1, [r1]
	str r1, [r0]
	movs r0, 0x2B
	bl FieldEffectStart
	pop {r0}
	bx r0
	.align 2, 0
_0808AE1C: .4byte gUnknown_0202FF84
_0808AE20: .4byte gLastFieldPokeMenuOpened
	thumb_func_end sub_808AE08

	thumb_func_start SetUpFieldMove_Waterfall
SetUpFieldMove_Waterfall: @ 808AE24
	push {r4,lr}
	sub sp, 0x4
	mov r4, sp
	adds r4, 0x2
	mov r0, sp
	adds r1, r4, 0
	bl GetXYCoordsOneStepInFrontOfPlayer
	mov r0, sp
	movs r1, 0
	ldrsh r0, [r0, r1]
	movs r2, 0
	ldrsh r1, [r4, r2]
	bl MapGridGetMetatileBehaviorAt
	lsls r0, 24
	lsrs r0, 24
	bl MetatileBehavior_IsWaterfall
	lsls r0, 24
	lsrs r0, 24
	cmp r0, 0x1
	bne _0808AE80
	bl IsPlayerSurfingNorth
	lsls r0, 24
	lsrs r0, 24
	cmp r0, 0x1
	bne _0808AE80
	ldr r1, _0808AE70 @ =gUnknown_0300485C
	ldr r0, _0808AE74 @ =sub_808AB90
	str r0, [r1]
	ldr r1, _0808AE78 @ =gUnknown_03005CE4
	ldr r0, _0808AE7C @ =sub_808AE08
	str r0, [r1]
	movs r0, 0x1
	b _0808AE82
	.align 2, 0
_0808AE70: .4byte gUnknown_0300485C
_0808AE74: .4byte sub_808AB90
_0808AE78: .4byte gUnknown_03005CE4
_0808AE7C: .4byte sub_808AE08
_0808AE80:
	movs r0, 0
_0808AE82:
	add sp, 0x4
	pop {r4}
	pop {r1}
	bx r1
	thumb_func_end SetUpFieldMove_Waterfall

	thumb_func_start sub_808AE8C
sub_808AE8C: @ 808AE8C
	push {r4-r6,lr}
	ldr r0, _0808AED8 @ =gScriptItemId
	ldrb r0, [r0]
	subs r0, 0x21
	lsls r0, 24
	lsrs r6, r0, 24
	movs r5, 0
_0808AE9A:
	movs r0, 0x64
	adds r1, r5, 0
	muls r1, r0
	ldr r0, _0808AEDC @ =gPlayerParty
	adds r4, r1, r0
	adds r0, r4, 0
	movs r1, 0xB
	bl GetMonData
	cmp r0, 0
	beq _0808AF10
	adds r0, r5, 0
	bl sub_806D668
	adds r0, r4, 0
	movs r1, 0x2D
	bl GetMonData
	cmp r0, 0
	bne _0808AECE
	adds r0, r4, 0
	adds r1, r6, 0
	bl CanMonLearnTMHM
	cmp r0, 0
	bne _0808AEE0
_0808AECE:
	adds r0, r5, 0
	movs r1, 0x9A
	bl sub_806BC3C
	b _0808AF10
	.align 2, 0
_0808AED8: .4byte gScriptItemId
_0808AEDC: .4byte gPlayerParty
_0808AEE0:
	ldr r0, _0808AF04 @ =gScriptItemId
	ldrh r0, [r0]
	bl ItemIdToBattleMoveId
	adds r1, r0, 0
	lsls r1, 16
	lsrs r1, 16
	adds r0, r4, 0
	bl pokemon_has_move
	lsls r0, 24
	cmp r0, 0
	beq _0808AF08
	adds r0, r5, 0
	movs r1, 0xA8
	bl sub_806BC3C
	b _0808AF10
	.align 2, 0
_0808AF04: .4byte gScriptItemId
_0808AF08:
	adds r0, r5, 0
	movs r1, 0x8C
	bl sub_806BC3C
_0808AF10:
	adds r0, r5, 0x1
	lsls r0, 24
	lsrs r5, r0, 24
	cmp r5, 0x5
	bls _0808AE9A
	pop {r4-r6}
	pop {r0}
	bx r0
	thumb_func_end sub_808AE8C

	thumb_func_start sub_808AF20
sub_808AF20: @ 808AF20
	push {r4,r5,lr}
	movs r5, 0
_0808AF24:
	movs r0, 0x64
	adds r1, r5, 0
	muls r1, r0
	ldr r0, _0808AF78 @ =gPlayerParty
	adds r4, r1, r0
	adds r0, r4, 0
	movs r1, 0xB
	bl GetMonData
	cmp r0, 0
	beq _0808AF66
	adds r0, r4, 0
	movs r1, 0x2D
	bl GetMonData
	cmp r0, 0
	bne _0808AF58
	ldr r0, _0808AF7C @ =gScriptItemId
	ldrh r2, [r0]
	adds r0, r4, 0
	movs r1, 0x3
	bl GetEvolutionTargetSpecies
	lsls r0, 16
	cmp r0, 0
	bne _0808AF66
_0808AF58:
	adds r0, r5, 0
	bl sub_806D668
	adds r0, r5, 0
	movs r1, 0
	bl sub_806BC3C
_0808AF66:
	adds r0, r5, 0x1
	lsls r0, 24
	lsrs r5, r0, 24
	cmp r5, 0x5
	bls _0808AF24
	pop {r4,r5}
	pop {r0}
	bx r0
	.align 2, 0
_0808AF78: .4byte gPlayerParty
_0808AF7C: .4byte gScriptItemId
	thumb_func_end sub_808AF20

	thumb_func_start sub_808AF80
sub_808AF80: @ 808AF80
	push {r4,r5,lr}
	ldr r5, _0808AFB0 @ =0x0201b260
_0808AF84:
	bl sub_806B124
	lsls r0, 24
	lsrs r0, 24
	cmp r0, 0x1
	bne _0808B00C
	ldr r0, _0808AFB4 @ =gUnknown_02038561
	ldrb r0, [r0]
	cmp r0, 0
	bne _0808AFC6
	ldr r0, _0808AFB8 @ =gScriptItemId
	ldrh r0, [r0]
	bl CheckIfItemIsTMHMOrEvolutionStone
	lsls r0, 24
	lsrs r0, 24
	cmp r0, 0x1
	beq _0808AFBC
	cmp r0, 0x2
	beq _0808AFC2
	b _0808AFC6
	.align 2, 0
_0808AFB0: .4byte 0x0201b260
_0808AFB4: .4byte gUnknown_02038561
_0808AFB8: .4byte gScriptItemId
_0808AFBC:
	bl sub_808AE8C
	b _0808AFC6
_0808AFC2:
	bl sub_808AF20
_0808AFC6:
	ldr r4, _0808B000 @ =gLastFieldPokeMenuOpened
	ldrb r0, [r4]
	cmp r0, 0x5
	bhi _0808AFE2
	adds r1, r0, 0
	movs r0, 0x64
	muls r0, r1
	ldr r1, _0808B004 @ =gPlayerParty
	adds r0, r1
	movs r1, 0xB
	bl GetMonData
	cmp r0, 0
	bne _0808AFE6
_0808AFE2:
	movs r0, 0
	strb r0, [r4]
_0808AFE6:
	ldrb r0, [r5]
	ldr r1, _0808B000 @ =gLastFieldPokeMenuOpened
	ldrb r1, [r1]
	bl sub_806C994
	ldrb r0, [r5]
	movs r1, 0
	bl sub_806BF74
	ldr r0, _0808B008 @ =sub_806AEDC
	bl SetMainCallback2
	b _0808B018
	.align 2, 0
_0808B000: .4byte gLastFieldPokeMenuOpened
_0808B004: .4byte gPlayerParty
_0808B008: .4byte sub_806AEDC
_0808B00C:
	bl sub_80F9344
	lsls r0, 24
	lsrs r0, 24
	cmp r0, 0x1
	bne _0808AF84
_0808B018:
	pop {r4,r5}
	pop {r0}
	bx r0
	thumb_func_end sub_808AF80

	thumb_func_start sub_808B020
sub_808B020: @ 808B020
	push {lr}
	ldr r2, _0808B040 @ =gPaletteFade
	ldrb r0, [r2, 0x8]
	movs r1, 0x80
	orrs r0, r1
	strb r0, [r2, 0x8]
	ldr r0, _0808B044 @ =gUnknown_02038561
	ldrb r0, [r0]
	cmp r0, 0x1
	beq _0808B0A0
	cmp r0, 0x1
	bgt _0808B048
	cmp r0, 0
	beq _0808B052
	b _0808B0AC
	.align 2, 0
_0808B040: .4byte gPaletteFade
_0808B044: .4byte gUnknown_02038561
_0808B048:
	cmp r0, 0x3
	beq _0808B0A0
	cmp r0, 0x4
	beq _0808B08C
	b _0808B0AC
_0808B052:
	ldr r0, _0808B070 @ =gScriptItemId
	ldrh r0, [r0]
	bl CheckIfItemIsTMHMOrEvolutionStone
	lsls r0, 24
	lsrs r0, 24
	cmp r0, 0x1
	bne _0808B078
	ldr r2, _0808B074 @ =sub_808B0C0
	movs r0, 0
	movs r1, 0
	movs r3, 0x14
	bl sub_806AF4C
	b _0808B0AC
	.align 2, 0
_0808B070: .4byte gScriptItemId
_0808B074: .4byte sub_808B0C0
_0808B078:
	ldr r2, _0808B088 @ =sub_808B0C0
	movs r0, 0
	movs r1, 0
	movs r3, 0x3
	bl sub_806AF4C
	b _0808B0AC
	.align 2, 0
_0808B088: .4byte sub_808B0C0
_0808B08C:
	ldr r2, _0808B09C @ =sub_808B1EC
	movs r0, 0
	movs r1, 0
	movs r3, 0xFF
	bl sub_806AF4C
	b _0808B0AC
	.align 2, 0
_0808B09C: .4byte sub_808B1EC
_0808B0A0:
	ldr r2, _0808B0B8 @ =sub_808B0C0
	movs r0, 0
	movs r1, 0
	movs r3, 0x4
	bl sub_806AF4C
_0808B0AC:
	ldr r0, _0808B0BC @ =sub_808AF80
	bl SetMainCallback2
	pop {r0}
	bx r0
	.align 2, 0
_0808B0B8: .4byte sub_808B0C0
_0808B0BC: .4byte sub_808AF80
	thumb_func_end sub_808B020

	thumb_func_start sub_808B0C0
sub_808B0C0: @ 808B0C0
	push {r4,r5,lr}
	sub sp, 0x4
	lsls r0, 24
	lsrs r4, r0, 24
	ldr r0, _0808B0EC @ =gPaletteFade
	ldrb r1, [r0, 0x7]
	movs r0, 0x80
	ands r0, r1
	lsls r0, 24
	lsrs r5, r0, 24
	cmp r5, 0
	bne _0808B1CE
	adds r0, r4, 0
	bl sub_806BD80
	lsls r0, 16
	lsrs r0, 16
	cmp r0, 0x1
	beq _0808B0F0
	cmp r0, 0x2
	beq _0808B184
	b _0808B1CE
	.align 2, 0
_0808B0EC: .4byte gPaletteFade
_0808B0F0:
	adds r0, r4, 0
	bl sub_806CA38
	ldr r1, _0808B118 @ =gLastFieldPokeMenuOpened
	strb r0, [r1]
	ldrb r1, [r1]
	movs r0, 0x64
	muls r0, r1
	ldr r1, _0808B11C @ =gPlayerParty
	adds r0, r1
	movs r1, 0x2D
	bl GetMonData
	cmp r0, 0
	beq _0808B120
	movs r0, 0x20
	bl PlaySE
	b _0808B1CE
	.align 2, 0
_0808B118: .4byte gLastFieldPokeMenuOpened
_0808B11C: .4byte gPlayerParty
_0808B120:
	bl sub_806D5A4
	ldr r5, _0808B16C @ =gUnknown_02038561
	ldrb r0, [r5]
	cmp r0, 0
	bne _0808B13C
	ldr r3, _0808B170 @ =gUnknown_03004AE4
	ldr r0, _0808B174 @ =gScriptItemId
	ldrh r1, [r0]
	ldr r2, _0808B178 @ =sub_808B224
	ldr r3, [r3]
	adds r0, r4, 0
	bl _call_via_r3
_0808B13C:
	ldrb r0, [r5]
	cmp r0, 0x1
	bne _0808B154
	movs r0, 0x5
	bl PlaySE
	ldr r0, _0808B174 @ =gScriptItemId
	ldrh r1, [r0]
	ldr r2, _0808B17C @ =sub_808B2EC
	adds r0, r4, 0
	bl PartyMenuTryGiveMonHeldItem
_0808B154:
	ldrb r0, [r5]
	cmp r0, 0x3
	bne _0808B1CE
	movs r0, 0x5
	bl PlaySE
	ldr r1, _0808B180 @ =sub_808B2B4
	adds r0, r4, 0
	bl PartyMenuTryGiveMonMail
	b _0808B1CE
	.align 2, 0
_0808B16C: .4byte gUnknown_02038561
_0808B170: .4byte gUnknown_03004AE4
_0808B174: .4byte gScriptItemId
_0808B178: .4byte sub_808B224
_0808B17C: .4byte sub_808B2EC
_0808B180: .4byte sub_808B2B4
_0808B184:
	adds r0, r4, 0
	bl sub_806CA38
	ldr r1, _0808B1D8 @ =gLastFieldPokeMenuOpened
	strb r0, [r1]
	movs r0, 0x5
	bl PlaySE
	movs r0, 0x1
	negs r0, r0
	str r5, [sp]
	movs r1, 0
	movs r2, 0
	movs r3, 0x10
	bl BeginNormalPaletteFade
	ldr r2, _0808B1DC @ =gUnknown_02038561
	ldrb r0, [r2]
	cmp r0, 0x1
	bhi _0808B1BA
	ldr r0, _0808B1E0 @ =gTasks
	lsls r1, r4, 2
	adds r1, r4
	lsls r1, 3
	adds r1, r0
	ldr r0, _0808B1E4 @ =sub_808B25C
	str r0, [r1]
_0808B1BA:
	ldrb r0, [r2]
	cmp r0, 0x3
	bne _0808B1CE
	ldr r0, _0808B1E0 @ =gTasks
	lsls r1, r4, 2
	adds r1, r4
	lsls r1, 3
	adds r1, r0
	ldr r0, _0808B1E8 @ =sub_808B2B4
	str r0, [r1]
_0808B1CE:
	add sp, 0x4
	pop {r4,r5}
	pop {r0}
	bx r0
	.align 2, 0
_0808B1D8: .4byte gLastFieldPokeMenuOpened
_0808B1DC: .4byte gUnknown_02038561
_0808B1E0: .4byte gTasks
_0808B1E4: .4byte sub_808B25C
_0808B1E8: .4byte sub_808B2B4
	thumb_func_end sub_808B0C0

	thumb_func_start sub_808B1EC
sub_808B1EC: @ 808B1EC
	push {r4,lr}
	lsls r0, 24
	lsrs r4, r0, 24
	ldr r0, _0808B214 @ =gPaletteFade
	ldrb r1, [r0, 0x7]
	movs r0, 0x80
	ands r0, r1
	cmp r0, 0
	bne _0808B20E
	ldr r3, _0808B218 @ =gUnknown_03004AE4
	ldr r0, _0808B21C @ =gScriptItemId
	ldrh r1, [r0]
	ldr r2, _0808B220 @ =sub_808B224
	ldr r3, [r3]
	adds r0, r4, 0
	bl _call_via_r3
_0808B20E:
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
_0808B214: .4byte gPaletteFade
_0808B218: .4byte gUnknown_03004AE4
_0808B21C: .4byte gScriptItemId
_0808B220: .4byte sub_808B224
	thumb_func_end sub_808B1EC

	thumb_func_start sub_808B224
sub_808B224: @ 808B224
	push {r4,lr}
	sub sp, 0x4
	adds r4, r0, 0
	lsls r4, 24
	lsrs r4, 24
	movs r0, 0x1
	negs r0, r0
	movs r1, 0
	str r1, [sp]
	movs r2, 0
	movs r3, 0x10
	bl BeginNormalPaletteFade
	ldr r1, _0808B254 @ =gTasks
	lsls r0, r4, 2
	adds r0, r4
	lsls r0, 3
	adds r0, r1
	ldr r1, _0808B258 @ =sub_808B25C
	str r1, [r0]
	add sp, 0x4
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
_0808B254: .4byte gTasks
_0808B258: .4byte sub_808B25C
	thumb_func_end sub_808B224

	thumb_func_start sub_808B25C
sub_808B25C: @ 808B25C
	push {r4,lr}
	lsls r0, 24
	lsrs r4, r0, 24
	ldr r0, _0808B280 @ =gPaletteFade
	ldrb r1, [r0, 0x7]
	movs r0, 0x80
	ands r0, r1
	cmp r0, 0
	bne _0808B27A
	ldr r0, _0808B284 @ =sub_80A5B40
	bl SetMainCallback2
	adds r0, r4, 0
	bl DestroyTask
_0808B27A:
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
_0808B280: .4byte gPaletteFade
_0808B284: .4byte sub_80A5B40
	thumb_func_end sub_808B25C

	thumb_func_start sub_808B288
sub_808B288: @ 808B288
	push {r4,lr}
	lsls r0, 24
	lsrs r4, r0, 24
	ldr r0, _0808B2AC @ =gPaletteFade
	ldrb r1, [r0, 0x7]
	movs r0, 0x80
	ands r0, r1
	cmp r0, 0
	bne _0808B2A6
	ldr r0, _0808B2B0 @ =sub_813B6F8
	bl SetMainCallback2
	adds r0, r4, 0
	bl DestroyTask
_0808B2A6:
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
_0808B2AC: .4byte gPaletteFade
_0808B2B0: .4byte sub_813B6F8
	thumb_func_end sub_808B288

	thumb_func_start sub_808B2B4
sub_808B2B4: @ 808B2B4
	push {r4,lr}
	sub sp, 0x4
	adds r4, r0, 0
	lsls r4, 24
	lsrs r4, 24
	movs r0, 0x1
	negs r0, r0
	movs r1, 0
	str r1, [sp]
	movs r2, 0
	movs r3, 0x10
	bl BeginNormalPaletteFade
	ldr r1, _0808B2E4 @ =gTasks
	lsls r0, r4, 2
	adds r0, r4
	lsls r0, 3
	adds r0, r1
	ldr r1, _0808B2E8 @ =sub_808B288
	str r1, [r0]
	add sp, 0x4
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
_0808B2E4: .4byte gTasks
_0808B2E8: .4byte sub_808B288
	thumb_func_end sub_808B2B4

	thumb_func_start sub_808B2EC
sub_808B2EC: @ 808B2EC
	push {r4,lr}
	sub sp, 0x4
	lsls r0, 24
	lsrs r4, r0, 24
	ldr r0, _0808B31C @ =gUnknown_0202E8F4
	ldrb r0, [r0]
	cmp r0, 0x2
	bne _0808B328
	movs r0, 0x1
	negs r0, r0
	movs r1, 0
	str r1, [sp]
	movs r2, 0
	movs r3, 0x10
	bl BeginNormalPaletteFade
	ldr r1, _0808B320 @ =gTasks
	lsls r0, r4, 2
	adds r0, r4
	lsls r0, 3
	adds r0, r1
	ldr r1, _0808B324 @ =sub_808B338
	str r1, [r0]
	b _0808B32E
	.align 2, 0
_0808B31C: .4byte gUnknown_0202E8F4
_0808B320: .4byte gTasks
_0808B324: .4byte sub_808B338
_0808B328:
	adds r0, r4, 0
	bl sub_808B224
_0808B32E:
	add sp, 0x4
	pop {r4}
	pop {r0}
	bx r0
	thumb_func_end sub_808B2EC

	thumb_func_start sub_808B338
sub_808B338: @ 808B338
	push {r4,r5,lr}
	lsls r0, 24
	lsrs r5, r0, 24
	ldr r0, _0808B38C @ =gPaletteFade
	ldrb r1, [r0, 0x7]
	movs r0, 0x80
	ands r0, r1
	cmp r0, 0
	bne _0808B384
	adds r0, r5, 0
	bl sub_806CA38
	ldr r1, _0808B390 @ =gLastFieldPokeMenuOpened
	strb r0, [r1]
	ldrb r1, [r1]
	movs r0, 0x64
	muls r0, r1
	ldr r1, _0808B394 @ =gPlayerParty
	adds r0, r1
	movs r1, 0x40
	bl GetMonData
	adds r4, r0, 0
	lsls r4, 24
	lsrs r4, 24
	adds r0, r5, 0
	bl DestroyTask
	lsls r1, r4, 3
	adds r1, r4
	lsls r1, 2
	ldr r0, _0808B398 @ =gSaveBlock1 + 0x2B4C
	adds r1, r0
	ldr r2, _0808B39C @ =sub_808B3EC
	movs r0, 0x4
	movs r3, 0x3
	bl sub_80E62A0
_0808B384:
	pop {r4,r5}
	pop {r0}
	bx r0
	.align 2, 0
_0808B38C: .4byte gPaletteFade
_0808B390: .4byte gLastFieldPokeMenuOpened
_0808B394: .4byte gPlayerParty
_0808B398: .4byte gSaveBlock1 + 0x2B4C
_0808B39C: .4byte sub_808B3EC
	thumb_func_end sub_808B338

	thumb_func_start sub_808B3A0
sub_808B3A0: @ 808B3A0
	push {r4,lr}
	ldr r4, _0808B3A8 @ =0x0201b260
	b _0808B3B8
	.align 2, 0
_0808B3A8: .4byte 0x0201b260
_0808B3AC:
	bl sub_80F9344
	lsls r0, 24
	lsrs r0, 24
	cmp r0, 0x1
	beq _0808B3DC
_0808B3B8:
	bl sub_806B124
	lsls r0, 24
	lsrs r0, 24
	cmp r0, 0x1
	bne _0808B3AC
	ldrb r0, [r4]
	ldr r1, _0808B3E4 @ =gLastFieldPokeMenuOpened
	ldrb r1, [r1]
	bl sub_806C994
	ldrb r0, [r4]
	movs r1, 0
	bl sub_806BF74
	ldr r0, _0808B3E8 @ =sub_806AEDC
	bl SetMainCallback2
_0808B3DC:
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
_0808B3E4: .4byte gLastFieldPokeMenuOpened
_0808B3E8: .4byte sub_806AEDC
	thumb_func_end sub_808B3A0

	thumb_func_start sub_808B3EC
sub_808B3EC: @ 808B3EC
	push {r4-r7,lr}
	mov r7, r8
	push {r7}
	ldr r0, _0808B464 @ =gPaletteFade
	mov r8, r0
	ldrb r0, [r0, 0x8]
	movs r1, 0x80
	orrs r0, r1
	mov r1, r8
	strb r0, [r1, 0x8]
	ldr r0, _0808B468 @ =gScriptResult
	ldrh r0, [r0]
	cmp r0, 0
	bne _0808B480
	ldr r7, _0808B46C @ =gUnknown_0202E8F8
	ldrh r0, [r7]
	cmp r0, 0
	beq _0808B416
	movs r1, 0x1
	bl RemoveBagItem
_0808B416:
	ldr r6, _0808B470 @ =gLastFieldPokeMenuOpened
	ldrb r0, [r6]
	movs r5, 0x64
	muls r0, r5
	ldr r4, _0808B474 @ =gPlayerParty
	adds r0, r4
	movs r1, 0xC
	bl GetMonData
	lsls r0, 16
	lsrs r0, 16
	movs r1, 0x1
	bl AddBagItem
	ldrb r0, [r6]
	muls r0, r5
	adds r0, r4
	bl sub_80A2DF8
	ldrb r0, [r6]
	muls r0, r5
	adds r0, r4
	movs r1, 0xC
	adds r2, r7, 0
	bl SetMonData
	ldr r0, _0808B478 @ =sub_808B25C
	movs r1, 0x5
	bl CreateTask
	mov r0, r8
	ldrb r1, [r0, 0x8]
	movs r0, 0x7F
	ands r0, r1
	mov r1, r8
	strb r0, [r1, 0x8]
	ldr r0, _0808B47C @ =sub_806AEDC
	b _0808B48E
	.align 2, 0
_0808B464: .4byte gPaletteFade
_0808B468: .4byte gScriptResult
_0808B46C: .4byte gUnknown_0202E8F8
_0808B470: .4byte gLastFieldPokeMenuOpened
_0808B474: .4byte gPlayerParty
_0808B478: .4byte sub_808B25C
_0808B47C: .4byte sub_806AEDC
_0808B480:
	ldr r2, _0808B49C @ =sub_808B4A4
	movs r0, 0
	movs r1, 0
	movs r3, 0xFF
	bl sub_806AF4C
	ldr r0, _0808B4A0 @ =sub_808B3A0
_0808B48E:
	bl SetMainCallback2
	pop {r3}
	mov r8, r3
	pop {r4-r7}
	pop {r0}
	bx r0
	.align 2, 0
_0808B49C: .4byte sub_808B4A4
_0808B4A0: .4byte sub_808B3A0
	thumb_func_end sub_808B3EC

	thumb_func_start sub_808B4A4
sub_808B4A4: @ 808B4A4
	push {r4,lr}
	lsls r0, 24
	lsrs r4, r0, 24
	ldr r0, _0808B4D8 @ =gPaletteFade
	ldrb r1, [r0, 0x7]
	movs r0, 0x80
	ands r0, r1
	cmp r0, 0
	bne _0808B4D2
	ldr r0, _0808B4DC @ =gLastFieldPokeMenuOpened
	ldrb r0, [r0]
	ldr r1, _0808B4E0 @ =gScriptItemId
	ldrh r1, [r1]
	movs r2, 0x1
	bl DisplayGiveHeldItemMessage
	ldr r1, _0808B4E4 @ =gTasks
	lsls r0, r4, 2
	adds r0, r4
	lsls r0, 3
	adds r0, r1
	ldr r1, _0808B4E8 @ =sub_808B4EC
	str r1, [r0]
_0808B4D2:
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
_0808B4D8: .4byte gPaletteFade
_0808B4DC: .4byte gLastFieldPokeMenuOpened
_0808B4E0: .4byte gScriptItemId
_0808B4E4: .4byte gTasks
_0808B4E8: .4byte sub_808B4EC
	thumb_func_end sub_808B4A4

	thumb_func_start sub_808B4EC
sub_808B4EC: @ 808B4EC
	push {lr}
	lsls r0, 24
	lsrs r1, r0, 24
	ldr r0, _0808B504 @ =gUnknown_0202E8F6
	ldrb r0, [r0]
	cmp r0, 0x1
	beq _0808B500
	adds r0, r1, 0
	bl sub_808B224
_0808B500:
	pop {r0}
	bx r0
	.align 2, 0
_0808B504: .4byte gUnknown_0202E8F6
	thumb_func_end sub_808B4EC

	thumb_func_start sub_808B508
sub_808B508: @ 808B508
	push {lr}
	lsls r0, 24
	lsrs r0, 24
	bl sub_808B224
	pop {r0}
	bx r0
	thumb_func_end sub_808B508

	thumb_func_start sub_808B518
sub_808B518: @ 808B518
	push {r4,lr}
	ldr r4, _0808B520 @ =0x0201b260
	b _0808B530
	.align 2, 0
_0808B520: .4byte 0x0201b260
_0808B524:
	bl sub_80F9344
	lsls r0, 24
	lsrs r0, 24
	cmp r0, 0x1
	beq _0808B554
_0808B530:
	bl sub_806B124
	lsls r0, 24
	lsrs r0, 24
	cmp r0, 0x1
	bne _0808B524
	ldrb r0, [r4]
	ldr r1, _0808B55C @ =gUnknown_020384F0
	ldrb r1, [r1]
	bl sub_806C994
	ldrb r0, [r4]
	movs r1, 0
	bl sub_806BF74
	ldr r0, _0808B560 @ =sub_806AEDC
	bl SetMainCallback2
_0808B554:
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
_0808B55C: .4byte gUnknown_020384F0
_0808B560: .4byte sub_806AEDC
	thumb_func_end sub_808B518

	thumb_func_start sub_808B564
sub_808B564: @ 808B564
	push {lr}
	ldr r2, _0808B58C @ =gPaletteFade
	ldrb r0, [r2, 0x8]
	movs r1, 0x80
	orrs r0, r1
	strb r0, [r2, 0x8]
	bl sub_809FA30
	lsls r0, 24
	lsrs r0, 24
	cmp r0, 0x4
	beq _0808B594
	ldr r2, _0808B590 @ =TaughtMove
	movs r0, 0
	movs r1, 0
	movs r3, 0xFF
	bl sub_806AF4C
	b _0808B5A0
	.align 2, 0
_0808B58C: .4byte gPaletteFade
_0808B590: .4byte TaughtMove
_0808B594:
	ldr r2, _0808B5AC @ =StopTryingToTeachMove_806F588
	movs r0, 0
	movs r1, 0
	movs r3, 0xFF
	bl sub_806AF4C
_0808B5A0:
	ldr r0, _0808B5B0 @ =sub_808B518
	bl SetMainCallback2
	pop {r0}
	bx r0
	.align 2, 0
_0808B5AC: .4byte StopTryingToTeachMove_806F588
_0808B5B0: .4byte sub_808B518
	thumb_func_end sub_808B564

	thumb_func_start sub_808B5B4
sub_808B5B4: @ 808B5B4
	push {lr}
	ldr r3, _0808B5D8 @ =gUnknown_03005CF0
	ldr r2, _0808B5DC @ =gTasks
	lsls r1, r0, 2
	adds r1, r0
	lsls r1, 3
	adds r1, r2
	ldr r2, [r1]
	str r2, [r3]
	ldr r2, _0808B5E0 @ =sub_808B5E4
	str r2, [r1]
	lsls r0, 24
	lsrs r0, 24
	bl _call_via_r2
	pop {r0}
	bx r0
	.align 2, 0
_0808B5D8: .4byte gUnknown_03005CF0
_0808B5DC: .4byte gTasks
_0808B5E0: .4byte sub_808B5E4
	thumb_func_end sub_808B5B4

	thumb_func_start sub_808B5E4
sub_808B5E4: @ 808B5E4
	push {r4,lr}
	lsls r0, 24
	lsrs r4, r0, 24
	bl sub_8055870
	cmp r0, 0x1
	beq _0808B602
	ldr r1, _0808B608 @ =gTasks
	lsls r0, r4, 2
	adds r0, r4
	lsls r0, 3
	adds r0, r1
	ldr r1, _0808B60C @ =gUnknown_03005CF0
	ldr r1, [r1]
	str r1, [r0]
_0808B602:
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
_0808B608: .4byte gTasks
_0808B60C: .4byte gUnknown_03005CF0
	thumb_func_end sub_808B5E4

	.align 2, 0 @ Don't pad with nop.
