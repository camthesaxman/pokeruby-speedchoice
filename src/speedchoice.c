#include "gba/gba.h"
#include "main.h"
#include "menu.h"
#include "palette.h"
#include "sprite.h"
#include "sound.h"
#include "task.h"
#include "songs.h"
#include "string_util.h"

extern void remove_some_task(void);

//Task data
enum {
    TD_MENUSELECTION,
	TD_INSTANTTEXT,
	TD_SPINNERS,
	TD_MAXVISION,
	TD_NERFROXANNE,
	TD_SUPERBIKE,
	TD_NERFRAREENC,
};

//Menu items
enum {
    MENUITEM_INSTANTTEXT,
	MENUITEM_SPINNERS,
	MENUITEM_MAXVISION,
	MENUITEM_NERFROXANNE,
	MENUITEM_SUPERBIKE,
	MENUITEM_NERFRAREENC,
	MENUITEM_STARTGAME,
};

extern u8 gUnknown_0839F63C[];
extern u8 gUnknown_0839F5FC[];  //palette
extern u8 gSpeedchoiceText_Header[];
extern u8 gSpeedchoiceText_InstantText[];
extern u8 gSpeedchoiceText_Spinners[];
extern u8 gSpeedchoiceText_MaxVision[];
extern u8 gSpeedchoiceText_NerfRoxanne[];
extern u8 gSpeedchoiceText_SuperBike[];
extern u8 gSpeedchoiceText_NerfRareEnc[];
extern u8 gSpeedchoiceText_StartGame[];
extern u8 gSpeedchoiceText_On[];
extern u8 gSpeedchoiceText_Off[];
extern u8 gSpeedchoiceText_Yes[];
extern u8 gSpeedchoiceText_No[];
extern u8 gSpeedchoiceText_Hell[];
extern u8 gSpeedchoiceText_Why[];
extern u8 gSpeedchoiceText_Nerf[];
extern u8 gSpeedchoiceText_Keep[];
extern u8 gSpeedchoiceText_StartTheGame[];
extern u32 gCheckValue;

//functions
static void Task_SpeedchoiceMenuFadeIn(u8 taskId);
static void HighlightOptionMenuItem2(u8 index);
static void DrawOptionMenuChoice2(u8 *text, u8 x, u8 y, u8 style);
static void Task_SpeedchoiceMenuProcessInput(u8 taskId);
static u8 InstantText_ProcessInput(u8 selection);
static void InstantText_DrawChoices(u8 selection);
static u8 Spinners_ProcessInput(u8 selection);
static void Spinners_DrawChoices(u8 selection);
static void MaxVision_DrawChoices(u8 selection);
static void NerfRoxanne_DrawChoices(u8 selection);
static void SuperBike_DrawChoices(u8 selection);
static void NerfRareEnc_DrawChoices(u8 selection);
static void Task_AskToStartGame(u8 taskId);
static void Task_HandleYesNoStartGame(u8 taskId);
static void Task_SpeedchoiceMenuSave(u8 taskId);
static void Task_SpeedchoiceMenuFadeOut(u8 taskId);
static void Task_RedrawSpeedchoiceMenu(u8 taskId);
static void HighlightYesNoMenu(void);
static void HighlightTextBox(void);
static void Task_DrawYesNoText(u8 taskId);

extern void Task_NewGameSpeech1(u8 taskId);

static void MainCB(void)
{
    RunTasks();
    AnimateSprites();
    BuildOamBuffer();
    UpdatePaletteFade();
}

static void VBlankCB(void)
{
    LoadOam();
    ProcessSpriteCopyRequests();
    TransferPlttBuffer();
}

void CB2_InitSpeedchoiceMenu()
{

	switch(gMain.state)
    {
        default:
        case 0:
        {
            u8 *addr;
            u32 size;
            
            SetVBlankCallback(NULL);
            REG_DISPCNT = 0;
            REG_BG2CNT = 0;
            REG_BG1CNT = 0;
            REG_BG0CNT = 0;
            REG_BG2HOFS = 0;
            REG_BG2VOFS = 0;
            REG_BG1HOFS = 0;
            REG_BG1VOFS = 0;
            REG_BG0HOFS = 0;
            REG_BG0VOFS = 0;
            addr = (u8 *)VRAM;
            size = 0x18000;
            while(1)
            {
                DmaFill16(3, 0, addr, 0x1000);
                addr += 0x1000;
                size -= 0x1000;
                if(size <= 0x1000)
                {
                    DmaFill16(3, 0, addr, size);
                    break;
                }
            }
            DmaClear32(3, OAM, OAM_SIZE);
            DmaClear16(3, PLTT, PLTT_SIZE);
            gMain.state++;
            break;
        }
        case 1:
            ResetPaletteFade();
            remove_some_task();
            ResetTasks();
            ResetSpriteData();
            gMain.state++;
            break;
        case 2:
            SetUpWindowConfig(&gWindowConfig_81E71B4);
            gMain.state++;
            break;
        case 3:
            MultistepInitMenuWindowBegin(&gWindowConfig_81E71B4);
            gMain.state++;
            break;
        case 4:
            if(!MultistepInitMenuWindowContinue())
                return;
            gMain.state++;
            break;
        case 5:
            LoadPalette(gUnknown_0839F5FC, 0x80, 0x40);
            CpuCopy16(gUnknown_0839F63C, (void *)0x0600BEE0, 0x40);
            gMain.state++;
            break;
        case 6:
            BeginNormalPaletteFade(-1, 0, 0x10, 0, 0);
            gMain.state++;
            break;
        case 7:
        {
            u16 savedIme;
            
            REG_WIN0H = 0;
            REG_WIN0V = 0;
            REG_WIN1H = 0;
            REG_WIN1V = 0;
            REG_WININ = 0x1111;
            REG_WINOUT = 0x31;
            REG_BLDCNT = 0xE1;
            REG_BLDALPHA = 0;
            REG_BLDY = 7;
            savedIme = REG_IME;
            REG_IME = 0;
            REG_IE |= INTR_FLAG_VBLANK;
            REG_IME = savedIme;
            REG_DISPSTAT |= DISPSTAT_VBLANK_INTR;
            SetVBlankCallback(VBlankCB);
            REG_DISPCNT = DISPCNT_MODE_0 | DISPCNT_OBJ_1D_MAP | DISPCNT_BG0_ON | DISPCNT_OBJ_ON |
              DISPCNT_WIN0_ON | DISPCNT_WIN1_ON;
            gMain.state++;
            break;
        }
        case 8:
        {
			 u8 taskId = CreateTask(Task_SpeedchoiceMenuFadeIn, 0);
			 
			 gTasks[taskId].data[TD_MENUSELECTION] = 0;
             gTasks[taskId].data[TD_INSTANTTEXT] = gSaveBlock2.speedchoiceInstantText;
             gTasks[taskId].data[TD_SPINNERS] = gSaveBlock2.speedchoiceSpinners;
             gTasks[taskId].data[TD_MAXVISION] = gSaveBlock2.speedchoiceMaxVision;
             gTasks[taskId].data[TD_NERFROXANNE] = gSaveBlock2.speedchoiceNerfRoxanne;
             gTasks[taskId].data[TD_SUPERBIKE] = gSaveBlock2.speedchoiceSuperBike;
             gTasks[taskId].data[TD_NERFRAREENC] = gSaveBlock2.speedchoiceNerfRareEnc;
			 
			MenuDrawTextWindow(2, 0, 27, 3);
            MenuDrawTextWindow(2, 4, 27, 19);
            
            MenuPrint(gSpeedchoiceText_Header, 4, 1);
            MenuPrint(gSpeedchoiceText_InstantText, 4, 5);
            MenuPrint(gSpeedchoiceText_Spinners, 4, 7);
            MenuPrint(gSpeedchoiceText_MaxVision, 4, 9);
            MenuPrint(gSpeedchoiceText_NerfRoxanne, 4, 11);
            MenuPrint(gSpeedchoiceText_SuperBike, 4, 13);
            MenuPrint(gSpeedchoiceText_NerfRareEnc, 4, 15);
            MenuPrint(gSpeedchoiceText_StartGame, 4, 17);
			
			InstantText_DrawChoices(gTasks[taskId].data[TD_INSTANTTEXT]);
            Spinners_DrawChoices(gTasks[taskId].data[TD_SPINNERS]);
            MaxVision_DrawChoices(gTasks[taskId].data[TD_MAXVISION]);
            NerfRoxanne_DrawChoices(gTasks[taskId].data[TD_NERFROXANNE]);
            SuperBike_DrawChoices(gTasks[taskId].data[TD_SUPERBIKE]);
            NerfRareEnc_DrawChoices(gTasks[taskId].data[TD_NERFRAREENC]);
            
            REG_WIN0H = WIN_RANGE(17, 223);
            REG_WIN0V = WIN_RANGE(1, 31);
            
            HighlightOptionMenuItem2(gTasks[taskId].data[TD_MENUSELECTION]);
			PlayBGM(BGM_CONLOBBY);
            gMain.state++;
            break;
		}
		case 9:
			SetMainCallback2(MainCB);
			return;
	}
}

static void Task_RedrawSpeedchoiceMenu(u8 taskId)
{
	MenuDrawTextWindow(2, 0, 27, 3);
    MenuDrawTextWindow(2, 4, 27, 19);
            
    MenuPrint(gSpeedchoiceText_Header, 4, 1);
    MenuPrint(gSpeedchoiceText_InstantText, 4, 5);
    MenuPrint(gSpeedchoiceText_Spinners, 4, 7);
    MenuPrint(gSpeedchoiceText_MaxVision, 4, 9);
    MenuPrint(gSpeedchoiceText_NerfRoxanne, 4, 11);
    MenuPrint(gSpeedchoiceText_SuperBike, 4, 13);
    MenuPrint(gSpeedchoiceText_NerfRareEnc, 4, 15);
    MenuPrint(gSpeedchoiceText_StartGame, 4, 17);
			
	InstantText_DrawChoices(gTasks[taskId].data[TD_INSTANTTEXT]);
    Spinners_DrawChoices(gTasks[taskId].data[TD_SPINNERS]);
    MaxVision_DrawChoices(gTasks[taskId].data[TD_MAXVISION]);
    NerfRoxanne_DrawChoices(gTasks[taskId].data[TD_NERFROXANNE]);
    SuperBike_DrawChoices(gTasks[taskId].data[TD_SUPERBIKE]);
    NerfRareEnc_DrawChoices(gTasks[taskId].data[TD_NERFRAREENC]);
            
    REG_WIN0H = WIN_RANGE(17, 223);
    REG_WIN0V = WIN_RANGE(1, 31);
            
    HighlightOptionMenuItem2(gTasks[taskId].data[TD_MENUSELECTION]);
	
	gTasks[taskId].func = Task_SpeedchoiceMenuProcessInput;
}

static void Task_SpeedchoiceMenuFadeIn(u8 taskId)
{
    if(!gPaletteFade.active)
    {
        gTasks[taskId].func = Task_SpeedchoiceMenuProcessInput;
    }
}

#define WIN_RANGE_(a, b) (((a) << 8) + (b))

static void HighlightOptionMenuItem2(u8 index)
{
    REG_WIN1H = WIN_RANGE(24, 215);
    REG_WIN1V = WIN_RANGE_(index * 16 + 40, index * 16 + 56);
}

static void HighlightTextBox()
{
	REG_WIN1H = WIN_RANGE(1, 241);
    REG_WIN1V = WIN_RANGE(114, 160);
}

static void HighlightYesNoMenu()
{
	REG_WIN0H = WIN_RANGE(168, 242);
	REG_WIN0V = WIN_RANGE_(64, 112);
}

static void DrawOptionMenuChoice2(u8 *text, u8 x, u8 y, u8 style)
{
    u8 dst[16];
    u16 i;
    
    for(i = 0; *text != EOS && i <= 14; i++)
        dst[i] = *(text++);
    
    dst[2] = style;
    dst[i] = EOS;
    MenuPrint_PixelCoords(dst, x, y, 1);
}

static u32 CalculateCheckValue()
{
	u32 checkValue;
	
	// calculate CV.
	checkValue = gSaveBlock2.speedchoiceInstantText << 1;
	checkValue += gSaveBlock2.speedchoiceSpinners << 2; // takes 2 bits.
	checkValue += gSaveBlock2.speedchoiceMaxVision << 4;
	checkValue += gSaveBlock2.speedchoiceNerfRoxanne << 5;
	checkValue += gSaveBlock2.speedchoiceSuperBike << 6;
	checkValue += gSaveBlock2.speedchoiceNerfRareEnc << 7;
	
	// seed RNG with checkValue for more hash-like number.
	checkValue = 0x41c64e6d * checkValue + 0x00006073;
	
	// xor with randomizer value.
	checkValue = checkValue ^ gCheckValue;
	
	// get rid of sign extension.
	checkValue = (checkValue << 1) >> 1;
	
	return checkValue;
}

static void Task_SpeedchoiceMenuProcessInput(u8 taskId)
{
	u8 i;
	
	 if(gMain.newKeys & A_BUTTON)
    {
        if(gTasks[taskId].data[TD_MENUSELECTION] == MENUITEM_STARTGAME)
		{
			gTasks[taskId].func = Task_SpeedchoiceMenuSave; // save the options.
		}
    }
    else if(gMain.newKeys & DPAD_UP)
    {
        if(gTasks[taskId].data[TD_MENUSELECTION] > 0)
            gTasks[taskId].data[TD_MENUSELECTION]--;
        else
            gTasks[taskId].data[TD_MENUSELECTION] = 6;
        HighlightOptionMenuItem2(gTasks[taskId].data[TD_MENUSELECTION]);
    }
    else if(gMain.newKeys & DPAD_DOWN)
    {
        if(gTasks[taskId].data[TD_MENUSELECTION] <= 5)
            gTasks[taskId].data[TD_MENUSELECTION]++;
        else
            gTasks[taskId].data[TD_MENUSELECTION] = 0;
        HighlightOptionMenuItem2(gTasks[taskId].data[TD_MENUSELECTION]);
    }
    else
    {
        switch(gTasks[taskId].data[TD_MENUSELECTION])
        {
            case MENUITEM_INSTANTTEXT:
				gTasks[taskId].data[TD_INSTANTTEXT] = InstantText_ProcessInput(gTasks[taskId].data[TD_INSTANTTEXT]);
                InstantText_DrawChoices(gTasks[taskId].data[TD_INSTANTTEXT]);
                break;
			case MENUITEM_SPINNERS:
                gTasks[taskId].data[TD_SPINNERS] = Spinners_ProcessInput(gTasks[taskId].data[TD_SPINNERS]);
                Spinners_DrawChoices(gTasks[taskId].data[TD_SPINNERS]);
                break;
			case MENUITEM_MAXVISION:
                gTasks[taskId].data[TD_MAXVISION] = InstantText_ProcessInput(gTasks[taskId].data[TD_MAXVISION]);
                MaxVision_DrawChoices(gTasks[taskId].data[TD_MAXVISION]);
                break;
			case MENUITEM_NERFROXANNE:
                gTasks[taskId].data[TD_NERFROXANNE] = InstantText_ProcessInput(gTasks[taskId].data[TD_NERFROXANNE]);
                NerfRoxanne_DrawChoices(gTasks[taskId].data[TD_NERFROXANNE]);
                break;
			case MENUITEM_SUPERBIKE:
                gTasks[taskId].data[TD_SUPERBIKE] = InstantText_ProcessInput(gTasks[taskId].data[TD_SUPERBIKE]);
                SuperBike_DrawChoices(gTasks[taskId].data[TD_SUPERBIKE]);
                break;
            case MENUITEM_NERFRAREENC:
                gTasks[taskId].data[TD_NERFRAREENC] = InstantText_ProcessInput(gTasks[taskId].data[TD_NERFRAREENC]);
                NerfRareEnc_DrawChoices(gTasks[taskId].data[TD_NERFRAREENC]);
                break;
        }
    }
}

static u8 InstantText_ProcessInput(u8 selection)
{
    if(gMain.newKeys & (DPAD_LEFT | DPAD_RIGHT))
        selection ^= 1;
    return selection;
}

static void InstantText_DrawChoices(u8 selection)
{
    u8 styles[2];
    
    styles[0] = 0xF;
    styles[1] = 0xF;
    styles[selection] = 0x8;
    
    DrawOptionMenuChoice2(gSpeedchoiceText_Off, 155, 40, styles[0]);
    DrawOptionMenuChoice2(gSpeedchoiceText_On, 184, 40, styles[1]);
}

static u8 Spinners_ProcessInput(u8 selection)
{
    if(gMain.newKeys & DPAD_RIGHT)
    {
        if(selection <= 1)
            selection++;
        else
            selection = 0;
    }
    if(gMain.newKeys & DPAD_LEFT)
    {
        if(selection != 0)
            selection--;
        else
            selection = 2;
    }
    return selection;
}

static void Task_AskToStartGame(u8 taskId)
{
	if (MenuUpdateWindowText())
    {
        DisplayYesNoMenu(21, 8, 1);
		HighlightYesNoMenu();
        gTasks[taskId].func = Task_HandleYesNoStartGame;
    }
}

static void Task_HandleYesNoStartGame(u8 taskId)
{
	 switch (ProcessMenuInputNoWrap_())
    {
		case 0: // YES
			PlayBGM(BGM_STOP);
			PlaySE(SE_SELECT);
			BeginNormalPaletteFade(-1, 0, 0, 0x10, 0);
			gTasks[taskId].func = Task_SpeedchoiceMenuFadeOut;
			break;
		case -1:
		case 1: // NO
			PlaySE(SE_SELECT);
			REG_WIN1H = WIN_RANGE(0, 0); // unhighlight the text box and YES/NO window before redrawing.
			REG_WIN1V = WIN_RANGE(0, 0);
			REG_WIN0H = WIN_RANGE(0, 0);
			REG_WIN0V = WIN_RANGE_(0, 0);
			gTasks[taskId].func = Task_RedrawSpeedchoiceMenu;
			break;
	}
}

static void Spinners_DrawChoices(u8 selection)
{
    u8 styles[3];
    
    styles[0] = 0xF;
    styles[1] = 0xF;
    styles[2] = 0xF;
    styles[selection] = 0x8;
    
    DrawOptionMenuChoice2(gSpeedchoiceText_Nerf, 124, 56, styles[0]);
    DrawOptionMenuChoice2(gSpeedchoiceText_Keep, 154, 56, styles[1]);
    DrawOptionMenuChoice2(gSpeedchoiceText_Hell, 184, 56, styles[2]);
}

static void MaxVision_DrawChoices(u8 selection)
{
    u8 styles[2];
    
    styles[0] = 0xF;
    styles[1] = 0xF;
    styles[selection] = 0x8;
    
    DrawOptionMenuChoice2(gSpeedchoiceText_No, 155, 72, styles[0]);
    DrawOptionMenuChoice2(gSpeedchoiceText_Yes, 184, 72, styles[1]);
}

static void NerfRoxanne_DrawChoices(u8 selection)
{
    u8 styles[2];
    
    styles[0] = 0xF;
    styles[1] = 0xF;
    styles[selection] = 0x8;
    
    DrawOptionMenuChoice2(gSpeedchoiceText_No, 155, 88, styles[0]);
    DrawOptionMenuChoice2(gSpeedchoiceText_Yes, 184, 88, styles[1]);
}

static void SuperBike_DrawChoices(u8 selection)
{
    u8 styles[2];
    
    styles[0] = 0xF;
    styles[1] = 0xF;
    styles[selection] = 0x8;
    
    DrawOptionMenuChoice2(gSpeedchoiceText_No, 155, 104, styles[0]);
    DrawOptionMenuChoice2(gSpeedchoiceText_Yes, 184, 104, styles[1]);
}

static void NerfRareEnc_DrawChoices(u8 selection)
{
    u8 styles[2];
    
    styles[0] = 0xF;
    styles[1] = 0xF;
    styles[selection] = 0x8;
    
    DrawOptionMenuChoice2(gSpeedchoiceText_No, 155, 120, styles[0]);
    DrawOptionMenuChoice2(gSpeedchoiceText_Yes, 184, 120, styles[1]);
}

static void Task_SpeedchoiceMenuSave(u8 taskId)
{
	u32 checkValue;
	
    gSaveBlock2.speedchoiceInstantText = gTasks[taskId].data[TD_INSTANTTEXT];
    gSaveBlock2.speedchoiceSpinners = gTasks[taskId].data[TD_SPINNERS];
    gSaveBlock2.speedchoiceMaxVision = gTasks[taskId].data[TD_MAXVISION];
    gSaveBlock2.speedchoiceNerfRoxanne = gTasks[taskId].data[TD_NERFROXANNE];
    gSaveBlock2.speedchoiceSuperBike = gTasks[taskId].data[TD_SUPERBIKE];
    gSaveBlock2.speedchoiceNerfRareEnc = gTasks[taskId].data[TD_NERFRAREENC];
	
	// calculate check Value.
	checkValue = ConvertIntToHexStringN(gStringVar1, CalculateCheckValue(), STR_CONV_MODE_LEADING_ZEROS, 8);

    gTasks[taskId].func = Task_DrawYesNoText;
}

static void Task_DrawYesNoText(u8 taskId)
{
	MenuDrawTextWindow(2, 14, 27, 19);
	HighlightTextBox();
	MenuPrint(gSpeedchoiceText_StartTheGame, 3, 15);

    gTasks[taskId].func = Task_AskToStartGame;
}

static void Task_SpeedchoiceMenuFadeOut(u8 taskId)
{
    if(!gPaletteFade.active)
    {
        gTasks[taskId].func = Task_NewGameSpeech1;
    }
}