#include "global.h"
#include "event_data.h"
#include "flags.h"
#include "task.h"
#include "menu.h"
#include "palette.h"
#include "field_player_avatar.h"
#include "speedchoice.h"

struct FieldMoveFuncStruct
{
    bool8 (*func)(void);
    u8 var;
};

extern struct FieldMoveFuncStruct gFieldMoveFuncs[];

extern u8 sub_80F9344(void);

extern void sub_808ABF4(u8);
extern void sub_808AAF0(u8);
extern void sub_808AB34(u8);

extern void sub_806D538(u8, u8);

extern void sub_806D5A4(void);
extern void sub_8133D28(u8);

extern u8 sub_806E834(u8 *message, u8 arg1);

extern u8 gUnknown_0202FFAA[];
extern u8 gUnknown_0202FFA8;

extern u8 gOtherText_CantBeUsedBadge[];

void PokemonMenu_FieldMove(u8 taskId)
{
    s16 *data = gTasks[taskId].data;
    
    sub_8072DEC();
    
    data[11] = gUnknown_0202FFAA[gUnknown_0202FFA8] - 10;
    
    if(sub_80F9344() == TRUE)
    {
        MenuZeroFillWindowRect(0x13, 0, 0x1D, 0x13);
        
        if((u16)(data[11] - 11) < 2)
        {
            sub_806D538(9, 0);
        }
        else
        {
            goto gotoLabel;
        }
    }
    else if(data[11] <= 7 && FlagGet(data[11] + BADGE01_GET) != TRUE && (data[11] != 5 || CheckSpeedchoiceOption(TD_EARLY_FLY, YES) == FALSE) && (data[11] != 6 || (CheckSpeedchoiceOption(TD_AQUALESS, KEEP) == TRUE))) // EARLY FLY
    {
        MenuZeroFillWindowRect(0x13, 0, 0x1D, 0x13);
        sub_806D5A4();
        sub_806E834(gOtherText_CantBeUsedBadge, 1);
        gTasks[taskId].func = sub_808AAF0;
        return;
    }
    else if(gFieldMoveFuncs[data[11]].func() == TRUE)
    {
        gUnknown_0202FFA8 = 0;
        
        if((u16)(data[11] - 11) > 1)
        {
            gTasks[taskId].func = sub_808AB34;
            BeginNormalPaletteFade(0xFFFFFFFF, 0, 0, 0x10, 0);
            return;
        }
        else
        {
            sub_8133D28(taskId);
            return;
        }
    }
    else
    {
        MenuZeroFillWindowRect(0x13, 0, 0x1D, 0x13);

        if(data[11] == 4 && TestPlayerAvatarFlags(8) != FALSE)
        {
            sub_806D538(8, 0);
        }
        else
        {
gotoLabel:
            sub_806D538(gFieldMoveFuncs[data[11]].var, 0);
        }
    }
    gTasks[taskId].func = sub_808ABF4;
}
