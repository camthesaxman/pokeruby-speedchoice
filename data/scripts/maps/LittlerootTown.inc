LittlerootTown_MapScripts:: @ 814D509
	map_script 3, LittlerootTown_MapScript1_14D514
	map_script 2, LittlerootTown_MapScript2_14D5D5
	.byte 0

LittlerootTown_MapScript1_14D514:: @ 814D514
	setflag 2063
	compare 0x4092, 2
	callif 1, LittlerootTown_EventScript_14D57B
	checkflag 82
	callif 0, LittlerootTown_EventScript_14D583
	compare 0x4050, 3
	callif 1, LittlerootTown_EventScript_14D5A6
	compare 0x4082, 4
	callif 1, LittlerootTown_EventScript_14D570
	compare 0x408c, 4
	callif 1, LittlerootTown_EventScript_14D570
	compare 0x40c7, 1
	callif 1, LittlerootTown_EventScript_14D567
	compare 0x408d, 3
	callif 1, LittlerootTown_EventScript_14D563
	end

LittlerootTown_EventScript_14D563:: @ 814D563
	setflag 301
	return

LittlerootTown_EventScript_14D567:: @ 814D567
	setvar 0x40c7, 2
	setflag 979
	return

LittlerootTown_EventScript_14D570:: @ 814D570
	setvar 0x4082, 5
	setvar 0x408c, 5
	return

LittlerootTown_EventScript_14D57B:: @ 814D57B
	movespriteperm 4, 14, 8
	return

LittlerootTown_EventScript_14D583:: @ 814D583
	compare 0x4050, 0
	jumpeq LittlerootTown_EventScript_14D59A
	movespriteperm 1, 10, 1
	spritebehave 1, 7
	return

LittlerootTown_EventScript_14D59A:: @ 814D59A
	movespriteperm 1, 7, 2
	spritebehave 1, 8
	return

LittlerootTown_EventScript_14D5A6:: @ 814D5A6
	clearflag 752
	spritebehave 4, 8
	checkgender
	compare RESULT, 0
	callif 1, LittlerootTown_EventScript_14D5C5
	compare RESULT, 1
	callif 1, LittlerootTown_EventScript_14D5CD
	return

LittlerootTown_EventScript_14D5C5:: @ 814D5C5
	movespriteperm 4, 5, 9
	return

LittlerootTown_EventScript_14D5CD:: @ 814D5CD
	movespriteperm 4, 14, 9
	return

LittlerootTown_MapScript2_14D5D5:: @ 814D5D5
	map_script_2 0x4092, 1, LittlerootTown_EventScript_14D5EF
	map_script_2 0x4092, 2, LittlerootTown_EventScript_14D60D
	map_script_2 0x4092, 7, LittlerootTown_EventScript_14D6C5
	.2byte 0

LittlerootTown_EventScript_14D5EF:: @ 814D5EF
	lockall
	setvar 0x8004, 5
	setvar 0x8005, 8
	call LittlerootTown_EventScript_14D62B
	setflag 761
	warpmuted LittlerootTown_BrendansHouse_1F, 255, 8, 8
	waitstate
	releaseall
	end

LittlerootTown_EventScript_14D60D:: @ 814D60D
	lockall
	setvar 0x8004, 14
	setvar 0x8005, 8
	call LittlerootTown_EventScript_14D62B
	setflag 762
	warpmuted LittlerootTown_MaysHouse_1F, 255, 2, 8
	waitstate
	releaseall
	end

LittlerootTown_EventScript_14D62B:: @ 814D62B
	pause 15
	playsfx 10
	move 255, LittlerootTown_Movement_14D6C0
	waitmove 0
	setdooropened 0x8004, 0x8005
	doorchange
	reappear 4
	move 4, LittlerootTown_Movement_14D6AC
	waitmove 0
	setdoorclosed 0x8004, 0x8005
	doorchange
	pause 10
	move 4, LittlerootTown_Movement_14D6AE
	waitmove 0
	msgbox LittlerootTown_Text_16A7C9, 4
	closebutton
	move 4, LittlerootTown_Movement_14D6B1
	move 255, LittlerootTown_Movement_14D6B8
	waitmove 0
	setdooropened 0x8004, 0x8005
	doorchange
	move 4, LittlerootTown_Movement_14D6B5
	move 255, LittlerootTown_Movement_14D6BD
	waitmove 0
	setflag 752
	setvar 0x4092, 3
	spriteinvisible 255, 0, 0
	setdoorclosed 0x8004, 0x8005
	doorchange
	clearflag 868
	clearflag 0x4000
	return

LittlerootTown_Movement_14D6AC:: @ 814D6AC
	step_down
	step_end

LittlerootTown_Movement_14D6AE:: @ 814D6AE
	step_down
	step_27
	step_end

LittlerootTown_Movement_14D6B1:: @ 814D6B1
	step_14
	step_13
	step_up
	step_end

LittlerootTown_Movement_14D6B5:: @ 814D6B5
	step_up
	step_54
	step_end

LittlerootTown_Movement_14D6B8:: @ 814D6B8
	step_14
	step_13
	step_right
	step_26
	step_end

LittlerootTown_Movement_14D6BD:: @ 814D6BD
	step_up
	step_up
	step_end

LittlerootTown_Movement_14D6C0:: @ 814D6C0
	step_45
	step_14
	step_14
	step_14
	step_end

LittlerootTown_EventScript_14D6C5:: @ 814D6C5
	lockall
	setvar 0x4092, 8
	releaseall
	end

LittlerootTown_EventScript_14D6CD:: @ 814D6CD
	msgbox LittlerootTown_Text_16AC00, 2
	end

LittlerootTown_EventScript_14D6D6:: @ 814D6D6
	msgbox LittlerootTown_Text_16AC56, 2
	end

LittlerootTown_EventScript_14D6DF:: @ 814D6DF
	lock
	faceplayer
	checkflag 116
	jumpeq LittlerootTown_EventScript_14D72F
	checkflag 82
	jumpeq LittlerootTown_EventScript_14D722
	compare 0x4050, 0
	jumpif 5, LittlerootTown_EventScript_14D708
	msgbox LittlerootTown_Text_16ACEB, 4
	release
	end

LittlerootTown_EventScript_14D708:: @ 814D708
	msgbox LittlerootTown_Text_16AD82, 4
	closebutton
	move 1, LittlerootTown_Movement_1A083D
	waitmove 0
	setvar 0x4050, 2
	release
	end

LittlerootTown_EventScript_14D722:: @ 814D722
	special 148
	msgbox LittlerootTown_Text_16ADF2, 4
	release
	end

LittlerootTown_EventScript_14D72F:: @ 814D72F
	msgbox LittlerootTown_Text_16AE25, 4
	release
	end

LittlerootTown_EventScript_14D739:: @ 814D739
	lockall
	move 1, LittlerootTown_Movement_14D779
	waitmove 0
	call LittlerootTown_EventScript_14D755
	move 1, LittlerootTown_Movement_14D789
	waitmove 0
	releaseall
	end

LittlerootTown_EventScript_14D755:: @ 814D755
	msgbox LittlerootTown_Text_16ACEB, 4
	closebutton
	move 1, LittlerootTown_Movement_14D787
	move 255, LittlerootTown_Movement_14D793
	waitmove 0
	msgbox LittlerootTown_Text_16AD3C, 4
	closebutton
	return

LittlerootTown_Movement_14D779:: @ 814D779
	step_03
	step_13
	step_51
	step_49
	step_13
	step_18
	step_18
	step_18
	step_18
	step_16
	step_16
	step_17
	step_00
	step_end

LittlerootTown_Movement_14D787:: @ 814D787
	step_down
	step_end

LittlerootTown_Movement_14D789:: @ 814D789
	step_right
	step_down
	step_down
	step_left
	step_left
	step_left
	step_left
	step_up
	step_25
	step_end

LittlerootTown_Movement_14D793:: @ 814D793
	step_40
	step_down
	step_41
	step_end

LittlerootTown_EventScript_14D797:: @ 814D797
	lockall
	move 1, LittlerootTown_Movement_14D7B3
	waitmove 0
	call LittlerootTown_EventScript_14D755
	move 1, LittlerootTown_Movement_14D7C0
	waitmove 0
	releaseall
	end

LittlerootTown_Movement_14D7B3:: @ 814D7B3
	step_03
	step_13
	step_51
	step_49
	step_13
	step_18
	step_18
	step_18
	step_16
	step_16
	step_18
	step_00
	step_end

LittlerootTown_Movement_14D7C0:: @ 814D7C0
	step_left
	step_down
	step_left
	step_left
	step_left
	step_25
	step_end

LittlerootTown_EventScript_14D7C7:: @ 814D7C7
	lockall
	move 1, LittlerootTown_Movement_1A0843
	waitmove 0
	move 255, LittlerootTown_Movement_1A083F
	waitmove 0
	msgbox LittlerootTown_Text_16AD82, 4
	closebutton
	move 1, LittlerootTown_Movement_1A083D
	waitmove 0
	setvar 0x4050, 2
	releaseall
	end

LittlerootTown_EventScript_14D7F6:: @ 814D7F6
	msgbox LittlerootTown_Text_16AE50, 3
	end

LittlerootTown_EventScript_14D7FF:: @ 814D7FF
	msgbox LittlerootTown_Text_16AE87, 3
	end

LittlerootTown_EventScript_14D808:: @ 814D808
	lockall
	checkgender
	compare RESULT, 0
	callif 1, LittlerootTown_EventScript_14D822
	compare RESULT, 1
	callif 1, LittlerootTown_EventScript_14D82B
	releaseall
	end

LittlerootTown_EventScript_14D822:: @ 814D822
	msgbox LittlerootTown_Text_16AEA1, 4
	return

LittlerootTown_EventScript_14D82B:: @ 814D82B
	msgbox LittlerootTown_Text_16AEAC, 4
	return

LittlerootTown_EventScript_14D834:: @ 814D834
	lockall
	checkgender
	compare RESULT, 0
	callif 1, LittlerootTown_EventScript_14D84E
	compare RESULT, 1
	callif 1, LittlerootTown_EventScript_14D857
	releaseall
	end

LittlerootTown_EventScript_14D84E:: @ 814D84E
	msgbox LittlerootTown_Text_16AEAC, 4
	return

LittlerootTown_EventScript_14D857:: @ 814D857
	msgbox LittlerootTown_Text_16AEA1, 4
	return

LittlerootTown_EventScript_14D860:: @ 814D860
	lockall
	setvar 0x8008, 0
	movesprite 4, 10, 9
	jump LittlerootTown_EventScript_14D8B6
	end

LittlerootTown_EventScript_14D873:: @ 814D873
	lockall
	setvar 0x8008, 1
	movesprite 4, 11, 9
	jump LittlerootTown_EventScript_14D8B6
	end

LittlerootTown_EventScript_14D886:: @ 814D886
	lockall
	setvar 0x8008, 2
	jump LittlerootTown_EventScript_14D8B6
	end

LittlerootTown_EventScript_14D892:: @ 814D892
	lockall
	setvar 0x8008, 3
	jump LittlerootTown_EventScript_14D8B6
	end

LittlerootTown_EventScript_14D89E:: @ 814D89E
	lockall
	setvar 0x8008, 4
	jump LittlerootTown_EventScript_14D8B6
	end

LittlerootTown_EventScript_14D8AA:: @ 814D8AA
	lockall
	setvar 0x8008, 5
	jump LittlerootTown_EventScript_14D8B6
	end

LittlerootTown_EventScript_14D8B6:: @ 814D8B6
	checkgender
	compare RESULT, 0
	callif 1, LittlerootTown_EventScript_14D93C
	compare RESULT, 1
	callif 1, LittlerootTown_EventScript_14D947
	checkgender
	compare RESULT, 0
	callif 1, LittlerootTown_EventScript_14D926
	compare RESULT, 1
	callif 1, LittlerootTown_EventScript_14D931
	msgbox LittlerootTown_Text_16A8EE, 4
	closebutton
	checkgender
	compare RESULT, 0
	callif 1, LittlerootTown_EventScript_14D952
	compare RESULT, 1
	callif 1, LittlerootTown_EventScript_14D995
	call LittlerootTown_EventScript_14DD38
	checkgender
	compare RESULT, 0
	callif 1, LittlerootTown_EventScript_14DAAA
	compare RESULT, 1
	callif 1, LittlerootTown_EventScript_14DAED
	jump LittlerootTown_EventScript_14DD2B
	end

LittlerootTown_EventScript_14D926:: @ 814D926
	setvar 0x8009, 5
	setvar 0x800a, 8
	return

LittlerootTown_EventScript_14D931:: @ 814D931
	setvar 0x8009, 14
	setvar 0x800a, 8
	return

LittlerootTown_EventScript_14D93C:: @ 814D93C
	move 4, LittlerootTown_Movement_1A0843
	waitmove 0
	return

LittlerootTown_EventScript_14D947:: @ 814D947
	move 4, LittlerootTown_Movement_1A083F
	waitmove 0
	return

LittlerootTown_EventScript_14D952:: @ 814D952
	compare 0x8008, 0
	callif 1, LittlerootTown_EventScript_14D9D8
	compare 0x8008, 1
	callif 1, LittlerootTown_EventScript_14D9ED
	compare 0x8008, 2
	callif 1, LittlerootTown_EventScript_14DA02
	compare 0x8008, 3
	callif 1, LittlerootTown_EventScript_14DA17
	compare 0x8008, 4
	callif 1, LittlerootTown_EventScript_14DA2C
	compare 0x8008, 5
	callif 1, LittlerootTown_EventScript_14DA41
	return

LittlerootTown_EventScript_14D995:: @ 814D995
	compare 0x8008, 0
	callif 1, LittlerootTown_EventScript_14D9D8
	compare 0x8008, 1
	callif 1, LittlerootTown_EventScript_14D9ED
	compare 0x8008, 2
	callif 1, LittlerootTown_EventScript_14DA56
	compare 0x8008, 3
	callif 1, LittlerootTown_EventScript_14DA6B
	compare 0x8008, 4
	callif 1, LittlerootTown_EventScript_14DA80
	compare 0x8008, 5
	callif 1, LittlerootTown_EventScript_14DA95
	return

LittlerootTown_EventScript_14D9D8:: @ 814D9D8
	move 255, LittlerootTown_Movement_1A0845
	waitmove 0
	move 4, LittlerootTown_Movement_14DC76
	waitmove 0
	return

LittlerootTown_EventScript_14D9ED:: @ 814D9ED
	move 255, LittlerootTown_Movement_1A0845
	waitmove 0
	move 4, LittlerootTown_Movement_14DC7D
	waitmove 0
	return

LittlerootTown_EventScript_14DA02:: @ 814DA02
	move 255, LittlerootTown_Movement_1A083F
	waitmove 0
	move 4, LittlerootTown_Movement_14DC84
	waitmove 0
	return

LittlerootTown_EventScript_14DA17:: @ 814DA17
	move 255, LittlerootTown_Movement_1A083F
	waitmove 0
	move 4, LittlerootTown_Movement_14DC89
	waitmove 0
	return

LittlerootTown_EventScript_14DA2C:: @ 814DA2C
	move 255, LittlerootTown_Movement_1A083F
	waitmove 0
	move 4, LittlerootTown_Movement_14DC8F
	waitmove 0
	return

LittlerootTown_EventScript_14DA41:: @ 814DA41
	move 255, LittlerootTown_Movement_1A083F
	waitmove 0
	move 4, LittlerootTown_Movement_14DC92
	waitmove 0
	return

LittlerootTown_EventScript_14DA56:: @ 814DA56
	move 255, LittlerootTown_Movement_1A0843
	waitmove 0
	move 4, LittlerootTown_Movement_14DC96
	waitmove 0
	return

LittlerootTown_EventScript_14DA6B:: @ 814DA6B
	move 255, LittlerootTown_Movement_1A0843
	waitmove 0
	move 4, LittlerootTown_Movement_14DC9A
	waitmove 0
	return

LittlerootTown_EventScript_14DA80:: @ 814DA80
	move 255, LittlerootTown_Movement_1A0843
	waitmove 0
	move 4, LittlerootTown_Movement_14DC9D
	waitmove 0
	return

LittlerootTown_EventScript_14DA95:: @ 814DA95
	move 255, LittlerootTown_Movement_1A0843
	waitmove 0
	move 4, LittlerootTown_Movement_14DCA3
	waitmove 0
	return

LittlerootTown_EventScript_14DAAA:: @ 814DAAA
	compare 0x8008, 0
	callif 1, LittlerootTown_EventScript_14DB30
	compare 0x8008, 1
	callif 1, LittlerootTown_EventScript_14DB3B
	compare 0x8008, 2
	callif 1, LittlerootTown_EventScript_14DB46
	compare 0x8008, 3
	callif 1, LittlerootTown_EventScript_14DB6C
	compare 0x8008, 4
	callif 1, LittlerootTown_EventScript_14DB92
	compare 0x8008, 5
	callif 1, LittlerootTown_EventScript_14DBB8
	return

LittlerootTown_EventScript_14DAED:: @ 814DAED
	compare 0x8008, 0
	callif 1, LittlerootTown_EventScript_14DB30
	compare 0x8008, 1
	callif 1, LittlerootTown_EventScript_14DB3B
	compare 0x8008, 2
	callif 1, LittlerootTown_EventScript_14DBDE
	compare 0x8008, 3
	callif 1, LittlerootTown_EventScript_14DC04
	compare 0x8008, 4
	callif 1, LittlerootTown_EventScript_14DC2A
	compare 0x8008, 5
	callif 1, LittlerootTown_EventScript_14DC50
	return

LittlerootTown_EventScript_14DB30:: @ 814DB30
	move 4, LittlerootTown_Movement_14DCA8
	waitmove 0
	return

LittlerootTown_EventScript_14DB3B:: @ 814DB3B
	move 4, LittlerootTown_Movement_14DCAE
	waitmove 0
	return

LittlerootTown_EventScript_14DB46:: @ 814DB46
	move 4, LittlerootTown_Movement_14DCB4
	waitmove 0
	setdooropened 0x8009, 0x800a
	doorchange
	move 4, LittlerootTown_Movement_14DCE0
	waitmove 0
	spriteinvisible 4, 0, 9
	setdoorclosed 0x8009, 0x800a
	doorchange
	return

LittlerootTown_EventScript_14DB6C:: @ 814DB6C
	move 4, LittlerootTown_Movement_14DCBA
	waitmove 0
	setdooropened 0x8009, 0x800a
	doorchange
	move 4, LittlerootTown_Movement_14DCE0
	waitmove 0
	spriteinvisible 4, 0, 9
	setdoorclosed 0x8009, 0x800a
	doorchange
	return

LittlerootTown_EventScript_14DB92:: @ 814DB92
	move 4, LittlerootTown_Movement_14DCC1
	waitmove 0
	setdooropened 0x8009, 0x800a
	doorchange
	move 4, LittlerootTown_Movement_14DCE0
	waitmove 0
	spriteinvisible 4, 0, 9
	setdoorclosed 0x8009, 0x800a
	doorchange
	return

LittlerootTown_EventScript_14DBB8:: @ 814DBB8
	move 4, LittlerootTown_Movement_14DCC5
	waitmove 0
	setdooropened 0x8009, 0x800a
	doorchange
	move 4, LittlerootTown_Movement_14DCE0
	waitmove 0
	spriteinvisible 4, 0, 9
	setdoorclosed 0x8009, 0x800a
	doorchange
	return

LittlerootTown_EventScript_14DBDE:: @ 814DBDE
	move 4, LittlerootTown_Movement_14DCCA
	waitmove 0
	setdooropened 0x8009, 0x800a
	doorchange
	move 4, LittlerootTown_Movement_14DCE0
	waitmove 0
	spriteinvisible 4, 0, 9
	setdoorclosed 0x8009, 0x800a
	doorchange
	return

LittlerootTown_EventScript_14DC04:: @ 814DC04
	move 4, LittlerootTown_Movement_14DCCF
	waitmove 0
	setdooropened 0x8009, 0x800a
	doorchange
	move 4, LittlerootTown_Movement_14DCE0
	waitmove 0
	spriteinvisible 4, 0, 9
	setdoorclosed 0x8009, 0x800a
	doorchange
	return

LittlerootTown_EventScript_14DC2A:: @ 814DC2A
	move 4, LittlerootTown_Movement_14DCD3
	waitmove 0
	setdooropened 0x8009, 0x800a
	doorchange
	move 4, LittlerootTown_Movement_14DCE0
	waitmove 0
	spriteinvisible 4, 0, 9
	setdoorclosed 0x8009, 0x800a
	doorchange
	return

LittlerootTown_EventScript_14DC50:: @ 814DC50
	move 4, LittlerootTown_Movement_14DCDA
	waitmove 0
	setdooropened 0x8009, 0x800a
	doorchange
	move 4, LittlerootTown_Movement_14DCE0
	waitmove 0
	spriteinvisible 4, 0, 9
	setdoorclosed 0x8009, 0x800a
	doorchange
	return

LittlerootTown_Movement_14DC76:: @ 814DC76
	step_up
	step_up
	step_up
	step_up
	step_up
	step_up
	step_end

LittlerootTown_Movement_14DC7D:: @ 814DC7D
	step_up
	step_up
	step_up
	step_up
	step_up
	step_up
	step_end

LittlerootTown_Movement_14DC84:: @ 814DC84
	step_right
	step_right
	step_right
	step_right
	step_end

LittlerootTown_Movement_14DC89:: @ 814DC89
	step_right
	step_right
	step_right
	step_right
	step_right
	step_end

LittlerootTown_Movement_14DC8F:: @ 814DC8F
	step_right
	step_right
	step_end

LittlerootTown_Movement_14DC92:: @ 814DC92
	step_right
	step_right
	step_right
	step_end

LittlerootTown_Movement_14DC96:: @ 814DC96
	step_left
	step_left
	step_left
	step_end

LittlerootTown_Movement_14DC9A:: @ 814DC9A
	step_left
	step_left
	step_end

LittlerootTown_Movement_14DC9D:: @ 814DC9D
	step_left
	step_left
	step_left
	step_left
	step_left
	step_end

LittlerootTown_Movement_14DCA3:: @ 814DCA3
	step_left
	step_left
	step_left
	step_left
	step_end

LittlerootTown_Movement_14DCA8:: @ 814DCA8
	step_down
	step_down
	step_down
	step_down
	step_down
	step_end

LittlerootTown_Movement_14DCAE:: @ 814DCAE
	step_down
	step_down
	step_down
	step_down
	step_down
	step_end

LittlerootTown_Movement_14DCB4:: @ 814DCB4
	step_left
	step_left
	step_left
	step_left
	step_26
	step_end

LittlerootTown_Movement_14DCBA:: @ 814DCBA
	step_left
	step_left
	step_left
	step_left
	step_left
	step_26
	step_end

LittlerootTown_Movement_14DCC1:: @ 814DCC1
	step_left
	step_left
	step_26
	step_end

LittlerootTown_Movement_14DCC5:: @ 814DCC5
	step_left
	step_left
	step_left
	step_26
	step_end

LittlerootTown_Movement_14DCCA:: @ 814DCCA
	step_right
	step_right
	step_right
	step_26
	step_end

LittlerootTown_Movement_14DCCF:: @ 814DCCF
	step_right
	step_right
	step_26
	step_end

LittlerootTown_Movement_14DCD3:: @ 814DCD3
	step_right
	step_right
	step_right
	step_right
	step_right
	step_26
	step_end

LittlerootTown_Movement_14DCDA:: @ 814DCDA
	step_right
	step_right
	step_right
	step_right
	step_26
	step_end

LittlerootTown_Movement_14DCE0:: @ 814DCE0
	step_up
	step_end

LittlerootTown_EventScript_14DCE2:: @ 814DCE2
	lock
	faceplayer
	checkgender
	compare RESULT, 0
	callif 1, LittlerootTown_EventScript_14D926
	compare RESULT, 1
	callif 1, LittlerootTown_EventScript_14D931
	call LittlerootTown_EventScript_14DD38
	move 4, LittlerootTown_Movement_1A0841
	waitmove 0
	setdooropened 0x8009, 0x800a
	doorchange
	move 4, LittlerootTown_Movement_14DCE0
	waitmove 0
	spriteinvisible 4, 0, 9
	setdoorclosed 0x8009, 0x800a
	doorchange
	jump LittlerootTown_EventScript_14DD2B
	end

LittlerootTown_EventScript_14DD2B:: @ 814DD2B
	disappear 4
	setflag 2144
	setvar 0x4050, 4
	release
	end

LittlerootTown_EventScript_14DD38:: @ 814DD38
	msgbox LittlerootTown_Text_16A8FD, 4
	fanfare 370
	message LittlerootTown_Text_16AA32
	waitfanfare
	waittext
	setflag 274
	msgbox LittlerootTown_Text_16AA5C, 4
	msgbox LittlerootTown_Text_16AB10, 4
	closebutton
	pause 30
	return
