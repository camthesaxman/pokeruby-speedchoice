#include "global.h"
#include "option_menu.h"
#include "main.h"
#include "menu.h"
#include "palette.h"
#include "sprite.h"
#include "task.h"

// global speedchoice config
#define CURRENT_OPTIONS_NUM 7
#define MAX_CHOICES 6
#define OPTIONS_PER_PAGE 5
#define ALLOPTIONS_PER_PAGE OPTIONS_PER_PAGE + 2 // page + start game
#define MAX_PAGES 2

#define MENUOPTIONCOORDS(i) (5 + (2 * i))

extern void SetPokemonCryStereo(u32 val);
extern void remove_some_task(void);

extern u8 gUnknown_0839F63C[];
extern u8 gUnknown_0839F5FC[];  //palette

enum
{
    // PAGE 1
    TD_TRUEMENUINDEX, // reflects true index and NOT current page index used to render highlight.
    TD_INSTANTTEXT,
    TD_SPINNERS,
    TD_MAX_VISION,
    TD_NERF_ROXANNE,
    TD_SUPER_BIKE,

    // PAGE 2
    TD_NEW_WILD_ENC,
    TD_EARLY_FLY,

    // last option for changing the current option
    TD_PAGEMENUINDEX = 14,
    TD_PAGE_NUM = 15 // last task data is 16 (1 indexed), so page num goes at the end.
};

// true index
enum
{
    // PAGE 1
    MENUITEM_INSTANTTEXT,
    MENUITEM_SPINNERS,
    MENUITEM_MAXVISION,
    MENUITEM_NERFROXANNE,
    MENUITEM_SUPERBIKE,
    
    // PAGE 2
    MENUITEM_NEWWILDENC,
    MENUITEM_EARLYFLY,

    // STATIC OPTIONS
    MENUITEM_PAGE = 15, // to make it match task data
    MENUITEM_START_GAME
};

// page index
enum
{
    OPTION_1,
    OPTION_2,
    OPTION_3,
    OPTION_4,
    OPTION_5,
    PAGE,
    START_GAME
};

enum
{
    YES,
    NO
};

enum
{
    ON,
    OFF
};

enum
{
    NERF,
    KEEP,
    HELL
};

const u8 gSpeedchoiceTextHeader[] = _("SPEEDCHOICE MENU");

// OPTION CHOICES
const u8 gSpeedchoiceTextYes[] = _("YES");
const u8 gSpeedchoiceTextNo[] = _("NO");
const u8 gSpeedchoiceTextOn[] = _("ON");
const u8 gSpeedchoiceTextOff[] = _("OFF");
const u8 gSpeedchoiceTextNerf[] = _("NERF");
const u8 gSpeedchoiceTextKeep[] = _("KEEP");
const u8 gSpeedchoiceTextHell[] = _("HELL");

// PAGE 1
const u8 gSpeedchoiceOptionInstantText[] = _("INSTANT TEXT");
const u8 gSpeedchoiceOptionSpinners[] = _("SPINNERS");
const u8 gSpeedchoiceOptionMaxVision[] = _("MAX VISION");
const u8 gSpeedchoiceOptionNerfRoxanne[] = _("NERF ROXANNE");
const u8 gSpeedchoiceOptionSuperBike[] = _("SUPER BIKE");

// PAGE 2
const u8 gSpeedchoiceOptionEarlyFly[] = _("EARLY FLY");
const u8 gSpeedchoiceOptionNewWildEnc[] = _("NEW WILD ENC.");

// CONSTANT OPTIONS
const u8 gSpeedchoiceOptionPage[] = _("PAGE");
const u8 gSpeedchoiceOptionStartGame[] = _("START GAME");

struct OptionChoiceConfig
{
    s16 x, y;
    u8 *string; // can be null
};

// every 5 elements belongs to a page, page struct is unnecessary.
struct SpeedchoiceOption
{
    u8 optionCount; // needed for process general input, im sure there's a way to avoid using this
    u8 *string;
    struct OptionChoiceConfig *options[MAX_CHOICES]; // use a NULL for non existent ones, optional things in structs were introduced in C++ and this is limited.
    bool8 enabled;
}; 

const struct OptionChoiceConfig OptionChoiceConfigYesNo[MAX_CHOICES] = 
{
    { 0, 0, (u8 *)&gSpeedchoiceTextYes },
    { 0, 0, (u8 *)&gSpeedchoiceTextNo },
    { -1, -1, NULL },
    { -1, -1, NULL },
    { -1, -1, NULL },
    { -1, -1, NULL }
};

const struct OptionChoiceConfig OptionChoiceConfigOnOff[MAX_CHOICES] = 
{
    { 0, 0, (u8 *)&gSpeedchoiceTextOn },
    { 0, 0, (u8 *)&gSpeedchoiceTextOff },
    { -1, -1, NULL },
    { -1, -1, NULL },
    { -1, -1, NULL },
    { -1, -1, NULL }
};

const struct OptionChoiceConfig OptionChoiceConfigNerfKeep[MAX_CHOICES] = 
{
    { 0, 0, (u8 *)&gSpeedchoiceTextNerf },
    { 0, 0, (u8 *)&gSpeedchoiceTextKeep },
    { 0, 0, (u8 *)&gSpeedchoiceTextHell },
    { -1, -1, NULL },
    { -1, -1, NULL },
    { -1, -1, NULL }
};

const struct SpeedchoiceOption SpeedchoiceOptions[CURRENT_OPTIONS_NUM] = 
{
    { 2, (u8 *)&gSpeedchoiceOptionInstantText, (struct OptionChoiceConfig *)OptionChoiceConfigOnOff, FALSE },
    { 3, (u8 *)&gSpeedchoiceOptionSpinners, (struct OptionChoiceConfig *)OptionChoiceConfigNerfKeep, FALSE },
    { 2, (u8 *)&gSpeedchoiceOptionMaxVision, (struct OptionChoiceConfig *)OptionChoiceConfigOnOff, FALSE },
    { 2, (u8 *)&gSpeedchoiceOptionNerfRoxanne, (struct OptionChoiceConfig *)OptionChoiceConfigYesNo, FALSE },
    { 2, (u8 *)&gSpeedchoiceOptionSuperBike, (struct OptionChoiceConfig *)OptionChoiceConfigOnOff, FALSE },
    { 2, (u8 *)&gSpeedchoiceOptionNewWildEnc, (struct OptionChoiceConfig *)OptionChoiceConfigOnOff, FALSE },
    { 2, (u8 *)&gSpeedchoiceOptionEarlyFly, (struct OptionChoiceConfig *)OptionChoiceConfigYesNo, FALSE }
};

static void Task_SpeedchoiceMenuFadeIn(u8);
static void Task_SpeedchoiceMenuProcessInput(u8);

// for selecting options. not unstubbed yet.
/*static u8 ProcessGeneralInput(struct SpeedchoiceOption *option, u8 selection)
{
    if(gMain.newKeys & DPAD_RIGHT)
    {
        if(selection == (option->optionCount - 1)) // options are indexed by 0.
            selection = 0;
        else
            selection++;
    }
    // i dont return immediately because emulators could hold both right and left down.
    if(gMain.newKeys & DPAD_LEFT)
    {
        if(selection == 0)
            selection = (option->optionCount - 1); // indexed by 0.
        else
            selection--;
    }
    return selection;
}*/

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

void RedrawSpeedchoiceWindows(void)
{
    MenuDrawTextWindow(2, 0, 27, 3);
    MenuDrawTextWindow(2, 4, 27, 19);
}

u8 GetPageDrawCount(u8 page)
{
    return (ARRAY_COUNT(SpeedchoiceOptions) - (OPTIONS_PER_PAGE * (page - 1))) < OPTIONS_PER_PAGE ? 5 : (ARRAY_COUNT(SpeedchoiceOptions) - (OPTIONS_PER_PAGE * (page - 1)));
}

void DrawPageOptionChoices(struct SpeedchoiceOption *option, u8 page)
{
    u8 i;

    for(i = 0; option->options[i]->string != NULL && i < MAX_CHOICES; i++)
    {
        s16 x = option->options[i]->x;
        s16 y = option->options[i]->y;
        
        MenuPrint(option->options[i]->string, x, y);
    }
}

void DrawPageOptions(u8 page)
{
    u8 i;
    u8 drawCount = GetPageDrawCount(page);

    RedrawSpeedchoiceWindows();

    // print page options.
    for(i = 0; i < drawCount; i++)
    {
        struct SpeedchoiceOption *option = (struct SpeedchoiceOption *)&SpeedchoiceOptions[i + (OPTIONS_PER_PAGE * (page - 1))];
        u8 *string = option->string;

        MenuPrint(string, 4, MENUOPTIONCOORDS(i)); // the 5 here does not represent options_per_page, it's just a coincidence.
        DrawPageOptionChoices(option, page);
    }
    
    MenuPrint(gSpeedchoiceOptionPage, 4, MENUOPTIONCOORDS(6));
    MenuPrint(gSpeedchoiceOptionStartGame, 4, MENUOPTIONCOORDS(7));
}

#define min(a, b) (a < b ? a : b)
#define max(a, b) (a > b ? a : b)

void SetPageIndexFromTrueIndex(u8 taskId, s16 index) // data is s16.
{
    if(index == MENUITEM_PAGE || index == MENUITEM_START_GAME)
        gTasks[taskId].data[TD_PAGEMENUINDEX] = index;
    else
        gTasks[taskId].data[TD_PAGEMENUINDEX] = (min((index % OPTIONS_PER_PAGE), OPTIONS_PER_PAGE));
}

void CB2_InitSpeedchoiceMenu(void)
{
    switch (gMain.state)
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
            while (1)
            {
                DmaFill16(3, 0, addr, 0x1000);
                addr += 0x1000;
                size -= 0x1000;
                if (size <= 0x1000)
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
            if (!MultistepInitMenuWindowContinue())
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

            // set default options and current selection.
            gTasks[taskId].data[TD_TRUEMENUINDEX] = 0;
            gTasks[taskId].data[TD_PAGEMENUINDEX] = 0;
            
            // PAGE 1
            gTasks[taskId].data[TD_INSTANTTEXT] = OFF;
            gTasks[taskId].data[TD_SPINNERS] = KEEP;
            gTasks[taskId].data[TD_MAX_VISION] = OFF;
            gTasks[taskId].data[TD_NERF_ROXANNE] = NO;
            gTasks[taskId].data[TD_SUPER_BIKE] = OFF;
            
            // PAGE 2
            gTasks[taskId].data[TD_NEW_WILD_ENC] = OFF;
            gTasks[taskId].data[TD_EARLY_FLY] = NO;
            gTasks[taskId].data[TD_PAGE_NUM] = 1;
            
            RedrawSpeedchoiceWindows();
            DrawPageOptions(1);
            
            REG_WIN0H = WIN_RANGE(17, 223);
            REG_WIN0V = WIN_RANGE(1, 31);

            //HighlightOptionMenuItem(gTasks[taskId].data[TD_TRUEMENUINDEX]); not yet.
            gMain.state++;
            break;
        }
        case 9:
            SetMainCallback2(MainCB);
            return;
    }
}

static void Task_SpeedchoiceMenuFadeIn(u8 taskId)
{
    if (!gPaletteFade.active)
    {
        gTasks[taskId].func = Task_SpeedchoiceMenuProcessInput;
    }
}

// lastOrFirst, TRUE means last, FALSE means first available
u8 GetPageOptionTrueIndex(bool8 lastOrFirst, u8 page)
{
    (lastOrFirst) ? (OPTIONS_PER_PAGE * (page - 1)) + GetPageDrawCount(page) : (OPTIONS_PER_PAGE * (page - 1)) + 1;
}

// same as above, but return the page index.
u8 GetPageOptionPageIndex(bool8 lastOrFirst, u8 page)
{
    (lastOrFirst) ? GetPageDrawCount(page) : 1;
}

enum
{
    FIRST,
    LAST
};

static void Task_SpeedchoiceMenuProcessInput(u8 taskId)
{
    if (gMain.newKeys & A_BUTTON)
    {
        if (gTasks[taskId].data[TD_PAGEMENUINDEX] == MENUITEM_START_GAME) // START_GAME
        {// start game? WIP
        }
    }
    else if (gMain.newKeys & DPAD_UP)
    {
        if(gTasks[taskId].data[TD_PAGEMENUINDEX] == MENUITEM_PAGE) // page index is 15, but the last index may be less than that. set it to the last of the current page's index.
            gTasks[taskId].data[TD_TRUEMENUINDEX] = GetPageOptionTrueIndex(LAST, gTasks[taskId].data[TD_PAGE_NUM]); // set the entry to the last available option.
        else if(gTasks[taskId].data[TD_TRUEMENUINDEX] > GetPageOptionTrueIndex(FIRST, gTasks[taskId].data[TD_PAGE_NUM]))
            gTasks[taskId].data[TD_TRUEMENUINDEX]--; // index can be 16 and reduced to page.
        else
            gTasks[taskId].data[TD_TRUEMENUINDEX] = MENUITEM_START_GAME;

        SetPageIndexFromTrueIndex(taskId, gTasks[taskId].data[TD_TRUEMENUINDEX]);
    }
    else if (gMain.newKeys & DPAD_DOWN)
    {
        if(gTasks[taskId].data[TD_TRUEMENUINDEX] == GetPageOptionTrueIndex(LAST, gTasks[taskId].data[TD_PAGE_NUM]))
            gTasks[taskId].data[TD_TRUEMENUINDEX] = MENUITEM_PAGE; // you are at the last option when you press down, go to page index.
        else if(gTasks[taskId].data[TD_TRUEMENUINDEX] < MENUITEM_START_GAME)
            gTasks[taskId].data[TD_TRUEMENUINDEX]++;
        else
            gTasks[taskId].data[TD_TRUEMENUINDEX] = GetPageOptionTrueIndex(FIRST, gTasks[taskId].data[TD_PAGE_NUM]);
        
        SetPageIndexFromTrueIndex(taskId, gTasks[taskId].data[TD_TRUEMENUINDEX]);
    }
    else
    {
        // WIP
    }
}

/*

static void Task_OptionMenuProcessInput(u8 taskId)
{
    if (gMain.newKeys & A_BUTTON)
    {
        if (gTasks[taskId].data[TD_MENUSELECTION] == MENUITEM_CANCEL)
            gTasks[taskId].func = Task_OptionMenuSave;
    }
    else if (gMain.newKeys & B_BUTTON)
    {
        gTasks[taskId].func = Task_OptionMenuSave;
    }
    else if (gMain.newKeys & DPAD_UP)
    {
        if (gTasks[taskId].data[TD_MENUSELECTION] > 0)
            gTasks[taskId].data[TD_MENUSELECTION]--;
        else
            gTasks[taskId].data[TD_MENUSELECTION] = 6;
        HighlightOptionMenuItem(gTasks[taskId].data[TD_MENUSELECTION]);
    }
    else if (gMain.newKeys & DPAD_DOWN)
    {
        if (gTasks[taskId].data[TD_MENUSELECTION] <= 5)
            gTasks[taskId].data[TD_MENUSELECTION]++;
        else
            gTasks[taskId].data[TD_MENUSELECTION] = 0;
        HighlightOptionMenuItem(gTasks[taskId].data[TD_MENUSELECTION]);
    }
    else
    {
        switch (gTasks[taskId].data[TD_MENUSELECTION])
        {
            case MENUITEM_TEXTSPEED:
                gTasks[taskId].data[TD_TEXTSPEED] = TextSpeed_ProcessInput(gTasks[taskId].data[TD_TEXTSPEED]);
                TextSpeed_DrawChoices(gTasks[taskId].data[TD_TEXTSPEED]);
                break;
            case MENUITEM_BATTLESCENE:
                gTasks[taskId].data[TD_BATTLESCENE] = BattleScene_ProcessInput(gTasks[taskId].data[TD_BATTLESCENE]);
                BattleScene_DrawChoices(gTasks[taskId].data[TD_BATTLESCENE]);
                break;
            case MENUITEM_BATTLESTYLE:
                gTasks[taskId].data[TD_BATTLESTYLE] = BattleStyle_ProcessInput(gTasks[taskId].data[TD_BATTLESTYLE]);
                BattleStyle_DrawChoices(gTasks[taskId].data[TD_BATTLESTYLE]);
                break;
            case MENUITEM_SOUND:
                gTasks[taskId].data[TD_SOUND] = Sound_ProcessInput(gTasks[taskId].data[TD_SOUND]);
                Sound_DrawChoices(gTasks[taskId].data[TD_SOUND]);
                break;
            case MENUITEM_BUTTONMODE:
                gTasks[taskId].data[TD_BUTTONMODE] = ButtonMode_ProcessInput(gTasks[taskId].data[TD_BUTTONMODE]);
                ButtonMode_DrawChoices(gTasks[taskId].data[TD_BUTTONMODE]);
                break;
            case MENUITEM_FRAMETYPE:
                gTasks[taskId].data[TD_FRAMETYPE] = FrameType_ProcessInput(gTasks[taskId].data[TD_FRAMETYPE]);
                FrameType_DrawChoices(gTasks[taskId].data[TD_FRAMETYPE]);
                break;
        }
    }
}

static void Task_OptionMenuSave(u8 taskId)
{
    gSaveBlock2.optionsTextSpeed = gTasks[taskId].data[TD_TEXTSPEED];
    gSaveBlock2.optionsBattleSceneOff = gTasks[taskId].data[TD_BATTLESCENE];
    gSaveBlock2.optionsBattleStyle = gTasks[taskId].data[TD_BATTLESTYLE];
    gSaveBlock2.optionsSound = gTasks[taskId].data[TD_SOUND];
    gSaveBlock2.optionsButtonMode = gTasks[taskId].data[TD_BUTTONMODE];
    gSaveBlock2.optionsWindowFrameType = gTasks[taskId].data[TD_FRAMETYPE];

    BeginNormalPaletteFade(-1, 0, 0, 0x10, 0);
    gTasks[taskId].func = Task_OptionMenuFadeOut;
}

static void Task_OptionMenuFadeOut(u8 taskId)
{
    if (!gPaletteFade.active)
    {
        DestroyTask(taskId);
        SetMainCallback2(gMain.savedCallback);
    }
}

//This version uses addition '+' instead of OR '|'.
#define WIN_RANGE_(a, b) (((a) << 8) + (b))

static void HighlightOptionMenuItem(u8 index)
{
    REG_WIN1H = WIN_RANGE(24, 215);
    REG_WIN1V = WIN_RANGE_(index * 16 + 40, index * 16 + 56);
}

static void DrawOptionMenuChoice(u8 *text, u8 x, u8 y, u8 style)
{
    u8 dst[16];
    u16 i;

    for (i = 0; *text != EOS && i <= 14; i++)
        dst[i] = *(text++);

    dst[2] = style;
    dst[i] = EOS;
    MenuPrint_PixelCoords(dst, x, y, 1);
}

static u8 TextSpeed_ProcessInput(u8 selection)
{
    if (gMain.newKeys & DPAD_RIGHT)
    {
        if (selection <= 1)
            selection++;
        else
            selection = 0;
    }
    if (gMain.newKeys & DPAD_LEFT)
    {
        if (selection != 0)
            selection--;
        else
            selection = 2;
    }
    return selection;
}

static void TextSpeed_DrawChoices(u8 selection)
{
    u8 styles[3];

    styles[0] = 0xF;
    styles[1] = 0xF;
    styles[2] = 0xF;
    styles[selection] = 0x8;

    DrawOptionMenuChoice(gSystemText_Slow, 120, 40, styles[0]);
    DrawOptionMenuChoice(gSystemText_Mid, 155, 40, styles[1]);
    DrawOptionMenuChoice(gSystemText_Fast, 184, 40, styles[2]);
}

static u8 BattleScene_ProcessInput(u8 selection)
{
    if (gMain.newKeys & (DPAD_LEFT | DPAD_RIGHT))
        selection ^= 1;
    return selection;
}

static void BattleScene_DrawChoices(u8 selection)
{
    u8 styles[2];

    styles[0] = 0xF;
    styles[1] = 0xF;
    styles[selection] = 0x8;

    DrawOptionMenuChoice(gSystemText_On, 120, 56, styles[0]);
    DrawOptionMenuChoice(gSystemText_Off, 190, 56, styles[1]);
}

static u8 BattleStyle_ProcessInput(u8 selection)
{
    if (gMain.newKeys & (DPAD_LEFT | DPAD_RIGHT))
        selection ^= 1;
    return selection;
}

static void BattleStyle_DrawChoices(u8 selection)
{
    u8 styles[2];

    styles[0] = 0xF;
    styles[1] = 0xF;
    styles[selection] = 0x8;

    DrawOptionMenuChoice(gSystemText_Shift, 120, 72, styles[0]);
    DrawOptionMenuChoice(gSystemText_Set, 190, 72, styles[1]);
}

static u8 Sound_ProcessInput(u8 selection)
{
    if (gMain.newKeys & (DPAD_LEFT | DPAD_RIGHT))
    {
        selection ^= 1;
        SetPokemonCryStereo(selection);
    }
    return selection;
}

static void Sound_DrawChoices(u8 selection)
{
    u8 styles[3];

    styles[0] = 0xF;
    styles[1] = 0xF;
    styles[selection] = 0x8;

    DrawOptionMenuChoice(gSystemText_Mono, 120, 88, styles[0]);
    DrawOptionMenuChoice(gSystemText_Stereo, 172, 88, styles[1]);
}

static u8 FrameType_ProcessInput(u8 selection)
{
    if (gMain.newKeys & DPAD_RIGHT)
    {
        if (selection <= 18)
            selection++;
        else
            selection = 0;
        MenuLoadTextWindowGraphics_OverrideFrameType(selection);
    }
    if (gMain.newKeys & DPAD_LEFT)
    {
        if (selection != 0)
            selection--;
        else
            selection = 19;
        MenuLoadTextWindowGraphics_OverrideFrameType(selection);
    }
    return selection;
}

#define CHAR_0 0xA1 //Character code of '0' character

static void FrameType_DrawChoices(u8 selection)
{
    u8 text[8];
    u8 n = selection + 1;
    u16 i;

    for (i = 0; gSystemText_Terminator[i] != EOS && i <= 5; i++)
        text[i] = gSystemText_Terminator[i];

    //Convert number to decimal string
    if (n / 10 != 0)
    {
        text[i] = n / 10 + CHAR_0;
        i++;
        text[i] = n % 10 + CHAR_0;
        i++;
    }
    else
    {
        text[i] = n % 10 + CHAR_0;
        i++;
        text[i] = CHAR_SPACE;
        i++;
    }

    text[i] = EOS;
    MenuPrint(gSystemText_Type, 15, 15);
    MenuPrint(text, 18, 15);
}

static u8 ButtonMode_ProcessInput(u8 selection)
{
    if (gMain.newKeys & DPAD_RIGHT)
    {
        if (selection <= 1)
            selection++;
        else
            selection = 0;
    }
    if (gMain.newKeys & DPAD_LEFT)
    {
        if (selection != 0)
            selection--;
        else
            selection = 2;
    }
    return selection;
}

static void ButtonMode_DrawChoices(u8 selection)
{
    u8 styles[3];

    styles[0] = 0xF;
    styles[1] = 0xF;
    styles[2] = 0xF;
    styles[selection] = 0x8;

    DrawOptionMenuChoice(gSystemText_Normal, 120, 104, styles[0]);
    DrawOptionMenuChoice(gSystemText_LR, 166, 104, styles[1]);
    DrawOptionMenuChoice(gSystemText_LA, 188, 104, styles[2]);
}
*/