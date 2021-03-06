Route110_TrickHouseEntrance_MapScripts:: @ 8160F2B
	map_script 3, Route110_TrickHouseEntrance_MapScript1_160F3B
	map_script 2, Route110_TrickHouseEntrance_MapScript2_1611CD
	map_script 4, Route110_TrickHouseEntrance_MapScript2_1610B2
	.byte 0

Route110_TrickHouseEntrance_MapScript1_160F3B:: @ 8160F3B
	setflag 2114
	compare 0x40b5, 1
	jumpeq Route110_TrickHouseEntrance_EventScript_160FCE
	compare 0x40c1, 1
	jumpeq Route110_TrickHouseEntrance_EventScript_160FB2
	compare 0x40a6, 1
	jumpeq Route110_TrickHouseEntrance_EventScript_16108E
	compare 0x40a7, 5
	callif 1, Route110_TrickHouseEntrance_EventScript_160FDE
	compare 0x40a7, 3
	callif 1, Route110_TrickHouseEntrance_EventScript_160FDE
	compare 0x40a7, 0
	callif 1, Route110_TrickHouseEntrance_EventScript_160FDE
	switch 0x40a7
	case 0, Route110_TrickHouseEntrance_EventScript_16109A
	case 1, Route110_TrickHouseEntrance_EventScript_1610A0
	case 3, Route110_TrickHouseEntrance_EventScript_1610A6
	case 4, Route110_TrickHouseEntrance_EventScript_1610AC
	end

Route110_TrickHouseEntrance_EventScript_160FB2:: @ 8160FB2
	setvar 0x40a5, 1
	compare 0x4044, 8
	jumpeq Route110_TrickHouseEntrance_EventScript_160FC8
	setvar 0x40a7, 2
	end

Route110_TrickHouseEntrance_EventScript_160FC8:: @ 8160FC8
	setvar 0x40a7, 6
	end

Route110_TrickHouseEntrance_EventScript_160FCE:: @ 8160FCE
	setvar 0x40b5, 0
	setvar 0x40a7, 5
	setvar 0x40a5, 1
	end

Route110_TrickHouseEntrance_EventScript_160FDE:: @ 8160FDE
	setvar 0x40a7, 0
	compare 0x4044, 1
	callif 1, Route110_TrickHouseEntrance_EventScript_16103C
	compare 0x4044, 2
	callif 1, Route110_TrickHouseEntrance_EventScript_161046
	compare 0x4044, 3
	callif 1, Route110_TrickHouseEntrance_EventScript_161050
	compare 0x4044, 4
	callif 1, Route110_TrickHouseEntrance_EventScript_16105A
	compare 0x4044, 5
	callif 1, Route110_TrickHouseEntrance_EventScript_161064
	compare 0x4044, 6
	callif 1, Route110_TrickHouseEntrance_EventScript_16106E
	compare 0x4044, 7
	callif 1, Route110_TrickHouseEntrance_EventScript_161078
	compare 0x4044, 8
	callif 1, Route110_TrickHouseEntrance_EventScript_161082
	return

Route110_TrickHouseEntrance_EventScript_16103C:: @ 816103C
	checkflag 2057
	callif 0, Route110_TrickHouseEntrance_EventScript_161088
	return

Route110_TrickHouseEntrance_EventScript_161046:: @ 8161046
	checkflag 2058
	callif 0, Route110_TrickHouseEntrance_EventScript_161088
	return

Route110_TrickHouseEntrance_EventScript_161050:: @ 8161050
	checkflag 2059
	callif 0, Route110_TrickHouseEntrance_EventScript_161088
	return

Route110_TrickHouseEntrance_EventScript_16105A:: @ 816105A
	checkflag 2060
	callif 0, Route110_TrickHouseEntrance_EventScript_161088
	return

Route110_TrickHouseEntrance_EventScript_161064:: @ 8161064
	checkflag 2061
	callif 0, Route110_TrickHouseEntrance_EventScript_161088
	return

Route110_TrickHouseEntrance_EventScript_16106E:: @ 816106E
	checkflag 2062
	callif 0, Route110_TrickHouseEntrance_EventScript_161088
	return

Route110_TrickHouseEntrance_EventScript_161078:: @ 8161078
	checkflag 2052
	callif 0, Route110_TrickHouseEntrance_EventScript_161088
	return

Route110_TrickHouseEntrance_EventScript_161082:: @ 8161082
	setvar 0x40a7, 4
	return

Route110_TrickHouseEntrance_EventScript_161088:: @ 8161088
	setvar 0x40a7, 3
	return

Route110_TrickHouseEntrance_EventScript_16108E:: @ 816108E
	movespriteperm 1, 5, 2
	spritebehave 1, 4
	end

Route110_TrickHouseEntrance_EventScript_16109A:: @ 816109A
	setvar 0x40a5, 0
	end

Route110_TrickHouseEntrance_EventScript_1610A0:: @ 81610A0
	setvar 0x40a5, 1
	end

Route110_TrickHouseEntrance_EventScript_1610A6:: @ 81610A6
	setvar 0x40a5, 1
	end

Route110_TrickHouseEntrance_EventScript_1610AC:: @ 81610AC
	setvar 0x40a5, 1
	end

Route110_TrickHouseEntrance_MapScript2_1610B2:: @ 81610B2
	map_script_2 0x40a6, 1, Route110_TrickHouseEntrance_EventScript_1610F4
	map_script_2 0x40a7, 0, Route110_TrickHouseEntrance_EventScript_161105
	map_script_2 0x40a7, 1, Route110_TrickHouseEntrance_EventScript_1611AB
	map_script_2 0x40a7, 2, Route110_TrickHouseEntrance_EventScript_1611AF
	map_script_2 0x40a7, 3, Route110_TrickHouseEntrance_EventScript_1611AF
	map_script_2 0x40a7, 4, Route110_TrickHouseEntrance_EventScript_1611AB
	map_script_2 0x40a7, 5, Route110_TrickHouseEntrance_EventScript_1611AB
	map_script_2 0x40a7, 6, Route110_TrickHouseEntrance_EventScript_1611BE
	.2byte 0

Route110_TrickHouseEntrance_EventScript_1610F4:: @ 81610F4
	reappear 1
	spritevisible 1, 29, 0
	spriteface 1, 4
	spriteface 255, 3
	end

Route110_TrickHouseEntrance_EventScript_161105:: @ 8161105
	reappear 1
	spriteinvisible 1, 29, 0
	switch 0x4044
	case 0, Route110_TrickHouseEntrance_EventScript_16116B
	case 1, Route110_TrickHouseEntrance_EventScript_161173
	case 2, Route110_TrickHouseEntrance_EventScript_161193
	case 3, Route110_TrickHouseEntrance_EventScript_161183
	case 4, Route110_TrickHouseEntrance_EventScript_16118B
	case 5, Route110_TrickHouseEntrance_EventScript_16117B
	case 6, Route110_TrickHouseEntrance_EventScript_16119B
	case 7, Route110_TrickHouseEntrance_EventScript_1611A3
	end

Route110_TrickHouseEntrance_EventScript_16116B:: @ 816116B
	movesprite 1, 6, 3
	end

Route110_TrickHouseEntrance_EventScript_161173:: @ 8161173
	movesprite 1, 11, 5
	end

Route110_TrickHouseEntrance_EventScript_16117B:: @ 816117B
	movesprite 1, 11, 1
	end

Route110_TrickHouseEntrance_EventScript_161183:: @ 8161183
	movesprite 1, 3, 1
	end

Route110_TrickHouseEntrance_EventScript_16118B:: @ 816118B
	movesprite 1, 0, 5
	end

Route110_TrickHouseEntrance_EventScript_161193:: @ 8161193
	movesprite 1, 9, 1
	end

Route110_TrickHouseEntrance_EventScript_16119B:: @ 816119B
	movesprite 1, 8, 1
	end

Route110_TrickHouseEntrance_EventScript_1611A3:: @ 81611A3
	movesprite 1, 4, 4
	end

Route110_TrickHouseEntrance_EventScript_1611AB:: @ 81611AB
	disappear 1
	end

Route110_TrickHouseEntrance_EventScript_1611AF:: @ 81611AF
	reappear 1
	movesprite 1, 5, 2
	spriteface 1, 2
	end

Route110_TrickHouseEntrance_EventScript_1611BE:: @ 81611BE
	reappear 1
	movesprite 1, 5, 2
	spriteface 1, 1
	end

Route110_TrickHouseEntrance_MapScript2_1611CD:: @ 81611CD
	map_script_2 0x40a6, 1, Route110_TrickHouseEntrance_EventScript_1611D7
	.2byte 0

Route110_TrickHouseEntrance_EventScript_1611D7:: @ 81611D7
	lockall
	pause 20
	compare 0x4044, 0
	callif 1, Route110_TrickHouseEntrance_EventScript_161327
	msgbox Route110_TrickHouseEntrance_Text_19BD82, 4
	closebutton
	pause 20
	move 1, Route110_TrickHouseEntrance_Movement_161315
	waitmove 0
	playsfx 178
	move 1, Route110_TrickHouseEntrance_Movement_16131E
	waitmove 0
	disappear 1
	setvar 0x40a7, 1
	setvar 0x40a6, 0
	releaseall
	end

@ 8161218
	releaseall
	end

Route110_TrickHouseEntrance_EventScript_16121A:: @ 816121A
	lockall
	switch 0x40a7
	case 0, Route110_TrickHouseEntrance_EventScript_16124D
	case 2, Route110_TrickHouseEntrance_EventScript_16136E
	case 3, Route110_TrickHouseEntrance_EventScript_161330
	case 6, Route110_TrickHouseEntrance_EventScript_161518
	end

Route110_TrickHouseEntrance_EventScript_16124D:: @ 816124D
	playsfx 21
	move 255, Route110_TrickHouseEntrance_Movement_1A0833
	waitmove 0
	move 255, Route110_TrickHouseEntrance_Movement_1A0835
	waitmove 0
	compare 0x4044, 0
	callif 1, Route110_TrickHouseEntrance_EventScript_1612CD
	compare 0x4044, 1
	callif 1, Route110_TrickHouseEntrance_EventScript_1612D6
	compare 0x4044, 2
	callif 1, Route110_TrickHouseEntrance_EventScript_1612DF
	compare 0x4044, 3
	callif 1, Route110_TrickHouseEntrance_EventScript_1612E8
	compare 0x4044, 4
	callif 1, Route110_TrickHouseEntrance_EventScript_1612F1
	compare 0x4044, 5
	callif 1, Route110_TrickHouseEntrance_EventScript_1612FA
	compare 0x4044, 6
	callif 1, Route110_TrickHouseEntrance_EventScript_161303
	compare 0x4044, 7
	callif 1, Route110_TrickHouseEntrance_EventScript_16130C
	closebutton
	setvar 0x40a6, 1
	warp Route110_TrickHouseEntrance, 255, 6, 2
	waitstate
	releaseall
	end

Route110_TrickHouseEntrance_EventScript_1612CD:: @ 81612CD
	msgbox Route110_TrickHouseEntrance_Text_19BA6E, 4
	return

Route110_TrickHouseEntrance_EventScript_1612D6:: @ 81612D6
	msgbox Route110_TrickHouseEntrance_Text_19BAC0, 4
	return

Route110_TrickHouseEntrance_EventScript_1612DF:: @ 81612DF
	msgbox Route110_TrickHouseEntrance_Text_19BB11, 4
	return

Route110_TrickHouseEntrance_EventScript_1612E8:: @ 81612E8
	msgbox Route110_TrickHouseEntrance_Text_19BB61, 4
	return

Route110_TrickHouseEntrance_EventScript_1612F1:: @ 81612F1
	msgbox Route110_TrickHouseEntrance_Text_19BBB4, 4
	return

Route110_TrickHouseEntrance_EventScript_1612FA:: @ 81612FA
	msgbox Route110_TrickHouseEntrance_Text_19BC04, 4
	return

Route110_TrickHouseEntrance_EventScript_161303:: @ 8161303
	msgbox Route110_TrickHouseEntrance_Text_19BC55, 4
	return

Route110_TrickHouseEntrance_EventScript_16130C:: @ 816130C
	msgbox Route110_TrickHouseEntrance_Text_19BCA8, 4
	return

Route110_TrickHouseEnd_Movement_161315:: @ 8161315
Route110_TrickHouseEntrance_Movement_161315:: @ 8161315
	step_01
	step_12
	step_02
	step_12
	step_00
	step_12
	step_03
	step_12
	step_end

Route110_TrickHouseEnd_Movement_16131E:: @ 816131E
Route110_TrickHouseEntrance_Movement_16131E:: @ 816131E
	step_01
	step_52
	step_32
	step_32
	step_32
	step_32
	step_32
	step_32
	step_end

Route110_TrickHouseEntrance_EventScript_161327:: @ 8161327
	msgbox Route110_TrickHouseEntrance_Text_19BCFD, 4
	return

Route110_TrickHouseEntrance_EventScript_161330:: @ 8161330
	msgbox Route110_TrickHouseEntrance_Text_19BF19, 4
	closebutton
	move 1, Route110_TrickHouseEntrance_Movement_1A0839
	waitmove 0
	playsfx 21
	move 1, Route110_TrickHouseEntrance_Movement_1A0833
	waitmove 0
	move 1, Route110_TrickHouseEntrance_Movement_1A0835
	waitmove 0
	msgbox Route110_TrickHouseEntrance_Text_19BFAB, 4
	move 1, Route110_TrickHouseEntrance_Movement_1A0841
	waitmove 0
	releaseall
	end

Route110_TrickHouseEntrance_EventScript_16136E:: @ 816136E
	move 1, Route110_TrickHouseEntrance_Movement_1A0839
	waitmove 0
	msgbox Route110_TrickHouseEntrance_Text_19C07E, 4
	compare 0x4044, 1
	jumpeq Route110_TrickHouseEntrance_EventScript_1613CE
	compare 0x4044, 2
	jumpeq Route110_TrickHouseEntrance_EventScript_1613FA
	compare 0x4044, 3
	jumpeq Route110_TrickHouseEntrance_EventScript_161426
	compare 0x4044, 4
	jumpeq Route110_TrickHouseEntrance_EventScript_161452
	compare 0x4044, 5
	jumpeq Route110_TrickHouseEntrance_EventScript_16147E
	compare 0x4044, 6
	jumpeq Route110_TrickHouseEntrance_EventScript_1614AA
	compare 0x4044, 7
	jumpeq Route110_TrickHouseEntrance_EventScript_1614D6
	end

Route110_TrickHouseEntrance_EventScript_1613CE:: @ 81613CE
	giveitem ITEM_RARE_CANDY
	compare RESULT, 1
	jumpeq Route110_TrickHouseEntrance_EventScript_161502
	compare RESULT, 0
	callif 1, Route110_TrickHouseEntrance_EventScript_1A02A5
	msgbox Route110_TrickHouseEntrance_Text_19C0FC, 4
	releaseall
	end

Route110_TrickHouseEntrance_EventScript_1613FA:: @ 81613FA
	giveitem ITEM_TIMER_BALL
	compare RESULT, 1
	jumpeq Route110_TrickHouseEntrance_EventScript_161502
	compare RESULT, 0
	callif 1, Route110_TrickHouseEntrance_EventScript_1A02A5
	msgbox Route110_TrickHouseEntrance_Text_19C0FC, 4
	releaseall
	end

Route110_TrickHouseEntrance_EventScript_161426:: @ 8161426
	giveitem ITEM_HARD_STONE
	compare RESULT, 1
	jumpeq Route110_TrickHouseEntrance_EventScript_161502
	compare RESULT, 0
	callif 1, Route110_TrickHouseEntrance_EventScript_1A02A5
	msgbox Route110_TrickHouseEntrance_Text_19C0FC, 4
	releaseall
	end

Route110_TrickHouseEntrance_EventScript_161452:: @ 8161452
	giveitem ITEM_SMOKE_BALL
	compare RESULT, 1
	jumpeq Route110_TrickHouseEntrance_EventScript_161502
	compare RESULT, 0
	callif 1, Route110_TrickHouseEntrance_EventScript_1A02A5
	msgbox Route110_TrickHouseEntrance_Text_19C0FC, 4
	releaseall
	end

Route110_TrickHouseEntrance_EventScript_16147E:: @ 816147E
	giveitem ITEM_TM12
	compare RESULT, 1
	jumpeq Route110_TrickHouseEntrance_EventScript_161502
	compare RESULT, 0
	callif 1, Route110_TrickHouseEntrance_EventScript_1A02A5
	msgbox Route110_TrickHouseEntrance_Text_19C0FC, 4
	releaseall
	end

Route110_TrickHouseEntrance_EventScript_1614AA:: @ 81614AA
	giveitem ITEM_MAGNET
	compare RESULT, 1
	jumpeq Route110_TrickHouseEntrance_EventScript_161502
	compare RESULT, 0
	callif 1, Route110_TrickHouseEntrance_EventScript_1A02A5
	msgbox Route110_TrickHouseEntrance_Text_19C0FC, 4
	releaseall
	end

Route110_TrickHouseEntrance_EventScript_1614D6:: @ 81614D6
	giveitem ITEM_PP_MAX
	compare RESULT, 1
	jumpeq Route110_TrickHouseEntrance_EventScript_161502
	compare RESULT, 0
	callif 1, Route110_TrickHouseEntrance_EventScript_1A02A5
	msgbox Route110_TrickHouseEntrance_Text_19C0FC, 4
	releaseall
	end

Route110_TrickHouseEntrance_EventScript_161502:: @ 8161502
	setvar 0x40c1, 0
	setvar 0x40a7, 3
	move 1, Route110_TrickHouseEntrance_Movement_1A0841
	waitmove 0
	releaseall
	end

Route110_TrickHouseEntrance_EventScript_161518:: @ 8161518
	move 1, Route110_TrickHouseEntrance_Movement_1A0839
	waitmove 0
	msgbox Route110_TrickHouseEntrance_Text_19C128, 4
	.ifdef SAPPHIRE
	givedecoration 32
	.else
	givedecoration 31
	.endif
	compare RESULT, 1
	jumpeq Route110_TrickHouseEntrance_EventScript_161551
	compare RESULT, 0
	callif 1, Route110_TrickHouseEntrance_EventScript_1A02B8
	msgbox Route110_TrickHouseEntrance_Text_19C18D, 4
	releaseall
	end

Route110_TrickHouseEntrance_EventScript_161551:: @ 8161551
	msgbox Route110_TrickHouseEntrance_Text_19C17E, 4
	closebutton
	move 1, Route110_TrickHouseEntrance_Movement_16309F
	waitmove 0
	move 1, Route110_TrickHouseEntrance_Movement_161315
	waitmove 0
	playsfx 178
	move 1, Route110_TrickHouseEntrance_Movement_16131E
	waitmove 0
	disappear 1
	setvar 0x40c1, 0
	setvar 0x40a7, 5
	releaseall
	end

Route110_TrickHouseEntrance_EventScript_16158A:: @ 816158A
	lockall
	switch 0x40a7
	case 0, Route110_TrickHouseEntrance_EventScript_1615BD
	case 1, Route110_TrickHouseEntrance_EventScript_1615C7
	case 4, Route110_TrickHouseEntrance_EventScript_1616B8
	case 5, Route110_TrickHouseEntrance_EventScript_1616C2
	end

Route110_TrickHouseEntrance_EventScript_1615BD:: @ 81615BD
	msgbox Route110_TrickHouseEntrance_Text_19BE6E, 4
	releaseall
	end

Route110_TrickHouseEntrance_EventScript_1615C7:: @ 81615C7
	msgbox Route110_TrickHouseEntrance_Text_19BE7D, 5
	closebutton
	compare RESULT, 1
	jumpeq Route110_TrickHouseEntrance_EventScript_1615DD
	releaseall
	end

Route110_TrickHouseEntrance_EventScript_1615DD:: @ 81615DD
	setmaptile 5, 1, 537, 0
	special 142
	pause 20
	move 255, Route110_TrickHouseEntrance_Movement_1A0856
	waitmove 0
	move 255, Route110_TrickHouseEntrance_Movement_16165E
	waitmove 0
	switch 0x4044
	case 0, Route110_TrickHouseEntrance_EventScript_161660
	case 1, Route110_TrickHouseEntrance_EventScript_16166B
	case 2, Route110_TrickHouseEntrance_EventScript_161676
	case 3, Route110_TrickHouseEntrance_EventScript_161681
	case 4, Route110_TrickHouseEntrance_EventScript_16168C
	case 5, Route110_TrickHouseEntrance_EventScript_161697
	case 6, Route110_TrickHouseEntrance_EventScript_1616A2
	case 7, Route110_TrickHouseEntrance_EventScript_1616AD
	end

Route110_TrickHouseEntrance_Movement_16165E:: @ 816165E
	step_54
	step_end

Route110_TrickHouseEntrance_EventScript_161660:: @ 8161660
	warp Route110_TrickHousePuzzle1, 255, 0, 21
	waitstate
	releaseall
	end

Route110_TrickHouseEntrance_EventScript_16166B:: @ 816166B
	warp Route110_TrickHousePuzzle2, 255, 0, 21
	waitstate
	releaseall
	end

Route110_TrickHouseEntrance_EventScript_161676:: @ 8161676
	warp Route110_TrickHousePuzzle3, 255, 0, 21
	waitstate
	releaseall
	end

Route110_TrickHouseEntrance_EventScript_161681:: @ 8161681
	warp Route110_TrickHousePuzzle4, 255, 0, 21
	waitstate
	releaseall
	end

Route110_TrickHouseEntrance_EventScript_16168C:: @ 816168C
	warp Route110_TrickHousePuzzle5, 255, 0, 21
	waitstate
	releaseall
	end

Route110_TrickHouseEntrance_EventScript_161697:: @ 8161697
	warp Route110_TrickHousePuzzle6, 255, 0, 21
	waitstate
	releaseall
	end

Route110_TrickHouseEntrance_EventScript_1616A2:: @ 81616A2
	warp Route110_TrickHousePuzzle7, 255, 0, 21
	waitstate
	releaseall
	end

Route110_TrickHouseEntrance_EventScript_1616AD:: @ 81616AD
	warp Route110_TrickHousePuzzle8, 255, 0, 21
	waitstate
	releaseall
	end

Route110_TrickHouseEntrance_EventScript_1616B8:: @ 81616B8
	msgbox Route110_TrickHouseEntrance_Text_19BEB3, 4
	releaseall
	end

Route110_TrickHouseEntrance_EventScript_1616C2:: @ 81616C2
	compare 0x4044, 8
	jumpeq Route110_TrickHouseEntrance_EventScript_1616D7
	msgbox Route110_TrickHouseEntrance_Text_19BE6E, 4
	releaseall
	end

Route110_TrickHouseEntrance_EventScript_1616D7:: @ 81616D7
	msgbox Route110_TrickHouseEntrance_Text_19BEB3, 4
	releaseall
	end

gUnknown_081616E1:: @ 81616E1
	lockall
	switch 0x4044
	case 0, Route110_TrickHouseEntrance_EventScript_161740
	case 1, Route110_TrickHouseEntrance_EventScript_161769
	case 2, Route110_TrickHouseEntrance_EventScript_161792
	case 3, Route110_TrickHouseEntrance_EventScript_1617BB
	case 4, Route110_TrickHouseEntrance_EventScript_1617E4
	case 5, Route110_TrickHouseEntrance_EventScript_16180D
	case 6, Route110_TrickHouseEntrance_EventScript_161836
	case 7, Route110_TrickHouseEntrance_EventScript_16185F
	end

Route110_TrickHouseEntrance_EventScript_161740:: @ 8161740
	compare 0x40AB, 0
	jumpeq Route110_TrickHouseEntrance_EventScript_161888
	msgbox UnknownString_819CAD1, 4
	playsfx SE_PIN
	setvar 0x40AB, 2
	setmaptile 13, 1, 523, 0
	special 142
	releaseall
	end

Route110_TrickHouseEntrance_EventScript_161769:: @ 8161769
	compare 0x40AC, 0
	jumpeq Route110_TrickHouseEntrance_EventScript_161888
	msgbox UnknownString_819CCCB, 4
	playsfx SE_PIN
	setvar 0x40AC, 2
	setmaptile 13, 1, 523, 0
	special 142
	releaseall
	end

Route110_TrickHouseEntrance_EventScript_161792:: @ 8161792
	compare 0x40AD, 0
	jumpeq Route110_TrickHouseEntrance_EventScript_161888
	msgbox UnknownString_819CEF9, 4
	playsfx SE_PIN
	setvar 0x40AD, 2
	setmaptile 13, 1, 523, 0
	special 142
	releaseall
	end

Route110_TrickHouseEntrance_EventScript_1617BB:: @ 81617BB
	compare 0x40AE, 0
	jumpeq Route110_TrickHouseEntrance_EventScript_161888
	msgbox UnknownString_819D164, 4
	playsfx SE_PIN
	setvar 0x40AE, 2
	setmaptile 13, 1, 523, 0
	special 142
	releaseall
	end

Route110_TrickHouseEntrance_EventScript_1617E4:: @ 81617E4
	compare 0x40AF, 0
	jumpeq Route110_TrickHouseEntrance_EventScript_161888
	msgbox UnknownString_819D3A5, 4
	playsfx SE_PIN
	setvar 0x40AF, 2
	setmaptile 13, 1, 523, 0
	special 142
	releaseall
	end

Route110_TrickHouseEntrance_EventScript_16180D:: @ 816180D
	compare 0x40B0, 0
	jumpeq Route110_TrickHouseEntrance_EventScript_161888
	msgbox UnknownString_819DC0A, 4
	playsfx SE_PIN
	setvar 0x40B0, 2
	setmaptile 13, 1, 523, 0
	special 142
	releaseall
	end

Route110_TrickHouseEntrance_EventScript_161836:: @ 8161836
	compare 0x40B1, 0
	jumpeq Route110_TrickHouseEntrance_EventScript_161888
	msgbox UnknownString_819DE8D, 4
	playsfx SE_PIN
	setvar 0x40B1, 2
	setmaptile 13, 1, 523, 0
	special 142
	releaseall
	end

Route110_TrickHouseEntrance_EventScript_16185F:: @ 816185F
	compare 0x40B2, 0
	jumpeq Route110_TrickHouseEntrance_EventScript_161888
	msgbox UnknownString_819E0FF, 4
	playsfx SE_PIN
	setvar 0x40B2, 2
	setmaptile 13, 1, 523, 0
	special 142
	releaseall
	end

Route110_TrickHouseEntrance_EventScript_161888:: @ 8161888
	msgbox UnknownString_819C21F, 4
	releaseall
	end

Route110_TrickHousePuzzle1_EventScript_161892:: @ 8161892
Route110_TrickHousePuzzle2_EventScript_161892:: @ 8161892
Route110_TrickHousePuzzle3_EventScript_161892:: @ 8161892
Route110_TrickHousePuzzle4_EventScript_161892:: @ 8161892
Route110_TrickHousePuzzle5_EventScript_161892:: @ 8161892
Route110_TrickHousePuzzle6_EventScript_161892:: @ 8161892
Route110_TrickHousePuzzle7_EventScript_161892:: @ 8161892
Route110_TrickHousePuzzle8_EventScript_161892:: @ 8161892
	msgbox Route110_TrickHousePuzzle1_Text_19C1FF, 4
	releaseall
	end

Route110_TrickHousePuzzle1_EventScript_16189C:: @ 816189C
Route110_TrickHousePuzzle2_EventScript_16189C:: @ 816189C
Route110_TrickHousePuzzle3_EventScript_16189C:: @ 816189C
Route110_TrickHousePuzzle4_EventScript_16189C:: @ 816189C
Route110_TrickHousePuzzle5_EventScript_16189C:: @ 816189C
Route110_TrickHousePuzzle6_EventScript_16189C:: @ 816189C
Route110_TrickHousePuzzle7_EventScript_16189C:: @ 816189C
Route110_TrickHousePuzzle8_EventScript_16189C:: @ 816189C
	fanfare 370
	message Route110_TrickHousePuzzle1_Text_19C1B8
	waitfanfare
	waittext
	msgbox Route110_TrickHousePuzzle1_Text_19C1CB, 4
	releaseall
	end

Route110_TrickHouseEntrance_EventScript_1618B0:: @ 81618B0
	lockall
	msgbox Route110_TrickHouseEntrance_Text_19BA56, 4
	releaseall
	compare 0x4044, 0
	callif 1, Route110_TrickHouseEntrance_EventScript_1618E1
	compare 0x4044, 1
	callif 1, Route110_TrickHouseEntrance_EventScript_1618F6
	compare 0x4044, 2
	callif 1, Route110_TrickHouseEntrance_EventScript_16190B
	setvar 0x40a5, 1
	end

Route110_TrickHouseEntrance_EventScript_1618E1:: @ 81618E1
	setvar 0x8004, 6
	setvar 0x8005, 3
	setvar 0x8006, 0
	call Route110_TrickHouseEntrance_EventScript_161920
	return

Route110_TrickHouseEntrance_EventScript_1618F6:: @ 81618F6
	setvar 0x8004, 11
	setvar 0x8005, 5
	setvar 0x8006, 0
	call Route110_TrickHouseEntrance_EventScript_161920
	return

Route110_TrickHouseEntrance_EventScript_16190B:: @ 816190B
	setvar 0x8004, 9
	setvar 0x8005, 2
	setvar 0x8006, 0
	call Route110_TrickHouseEntrance_EventScript_161920
	return

Route110_TrickHouseEntrance_EventScript_161920:: @ 8161920
	setanimation 0, 32772
	setanimation 1, 32773
	setanimation 2, 32774
	doanimation 54
	checkanimation 54
	pause 10
	return
