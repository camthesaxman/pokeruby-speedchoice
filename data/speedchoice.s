	.include "asm/macros.s"
	.include "constants/constants.s"

	.section .rodata

@ fix the offsets at a known location.
gIntroMonID::
	.2byte SPECIES_AZURILL

gSpeedchoiceText_Header::
	.string "{PALETTE 9}SPEEDCHOICE MENU$"

gSpeedchoiceText_InstantText::
	.string "{PALETTE 9}INSTANT TEXT$"

gSpeedchoiceText_Spinners::
	.string "{PALETTE 8}SPINNERS$"

gSpeedchoiceText_MaxVision::
	.string "{PALETTE 8}MAX VISION$"

gSpeedchoiceText_NerfRoxanne::
	.string "{PALETTE 8}NERF ROXANNE$"

gSpeedchoiceText_SuperBike::
	.string "{PALETTE 8}SUPER BIKE$"

gSpeedchoiceText_NerfRareEnc::
	.string "{PALETTE 8}NERF RARE ENC.$"

gSpeedchoiceText_StartGame::
	.string "{PALETTE 9}START GAME$"

gSpeedchoiceText_On::
	.string "{PALETTE 15}ON$"

gSpeedchoiceText_Off::
	.string "{PALETTE 15}OFF$"

gSpeedchoiceText_Yes::
	.string "{PALETTE 15}YES$"
	
gSpeedchoiceText_No::
	.string "{PALETTE 15}NO$"

gSpeedchoiceText_Hell::
	.string "{PALETTE 15}HELL$"
	
gSpeedchoiceText_Why::
	.string "{PALETTE 15}WHY$"

gSpeedchoiceText_Nerf::
	.string "{PALETTE 15}NERF$"

gSpeedchoiceText_Keep::
	.string "{PALETTE 15}KEEP$"

gSpeedchoiceText_StartTheGame::
	.string "CV: NO CV YET\nStart the game?$"