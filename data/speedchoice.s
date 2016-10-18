	.include "asm/macros.s"
	.include "constants/constants.s"

	.section .rodata

@ fix the offsets at a known location.
gIntroMonID::
	.2byte SPECIES_AZURILL

gSpeedchoiceText_Header::
	.string "{PALETTE 9}SPEEDCHOICE$"

gSpeedchoiceText_InstantText::
	.string "{PALETTE 9}INSTANT TEXT$"

gSpeedchoiceText_Spinners::
	.string "{PALETTE 9}SPINNERS$"

gSpeedchoiceText_MaxVision::
	.string "{PALETTE 9}MAX VISION$"

gSpeedchoiceText_NerfRoxanne::
	.string "{PALETTE 9}NERF ROXANNE$"

gSpeedchoiceText_SuperBike::
	.string "{PALETTE 9}SUPER BIKE$"

gSpeedchoiceText_NerfRareEnc::
	.string "{PALETTE 9}NERF RARE ENC.$"

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

gSpeedchoiceText_StartTheGame::
	.string "Start the game?$"
