LilycoveCity_MoveDeletersHouse_MapScripts:: @ 8159AAD
	.byte 0

LilycoveCity_MoveDeletersHouse_EventScript_159AAE:: @ 8159AAE
	lockall
	move 1, LilycoveCity_MoveDeletersHouse_Movement_1A0839
	waitmove 0
	msgbox LilycoveCity_MoveDeletersHouse_Text_18B622, 5
	switch RESULT
	case 1, LilycoveCity_MoveDeletersHouse_EventScript_159ADE
	case 0, LilycoveCity_MoveDeletersHouse_EventScript_159B7B
	releaseall
	end

LilycoveCity_MoveDeletersHouse_EventScript_159ADE:: @ 8159ADE
	msgbox LilycoveCity_MoveDeletersHouse_Text_18B68C, 4
	special 159
	waitstate
	compare 0x8004, 255
	jumpeq LilycoveCity_MoveDeletersHouse_EventScript_159B7B
	special 328
	compare RESULT, 1
	jumpeq LilycoveCity_MoveDeletersHouse_EventScript_159B71
	special 223
	compare RESULT, 1
	jumpeq LilycoveCity_MoveDeletersHouse_EventScript_159B64
	msgbox LilycoveCity_MoveDeletersHouse_Text_18B6B0, 4
	fadescreen 1
	special 220
	fadescreen 0
	compare 0x8005, 4
	jumpeq LilycoveCity_MoveDeletersHouse_EventScript_159ADE
	special 222
	msgbox LilycoveCity_MoveDeletersHouse_Text_18B6F2, 5
	switch RESULT
	case 1, LilycoveCity_MoveDeletersHouse_EventScript_159B53
	case 0, LilycoveCity_MoveDeletersHouse_EventScript_159B7B
	releaseall
	end

LilycoveCity_MoveDeletersHouse_EventScript_159B53:: @ 8159B53
	special 221
	fanfare 378
	waitfanfare
	msgbox LilycoveCity_MoveDeletersHouse_Text_18B71E, 4
	releaseall
	end

LilycoveCity_MoveDeletersHouse_EventScript_159B64:: @ 8159B64
	special 222
	msgbox LilycoveCity_MoveDeletersHouse_Text_18B6D0, 4
	releaseall
	end

LilycoveCity_MoveDeletersHouse_EventScript_159B71:: @ 8159B71
	msgbox LilycoveCity_MoveDeletersHouse_Text_18B78C, 4
	releaseall
	end

LilycoveCity_MoveDeletersHouse_EventScript_159B7B:: @ 8159B7B
	msgbox LilycoveCity_MoveDeletersHouse_Text_18B757, 4
	releaseall
	end
