#ifndef GUARD_SPEEDCHOICE_H
#define GUARD_SPEEDCHOICE_H

enum
{
    // PAGE 1
    TD_INSTANTTEXT,
    TD_SPINNERS,
    TD_MAX_VISION,
    TD_NERF_ROXANNE,
    TD_SUPER_BIKE,

    // PAGE 2
    TD_NEW_WILD_ENC,
    TD_EARLY_FLY,

    // last option for changing the current option
    TD_TRUEMENUINDEX = 13, // reflects true index and NOT current page index used to render highlight.
    TD_PAGEMENUINDEX = 14,
    TD_PAGE_NUM = 15 // last task data is 16 (1 indexed), so page num goes at the end.
	// start game does not have data associated with it, so its entry is empty here.
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

enum
{
    FIRST,
    LAST
};

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
    struct OptionChoiceConfig *options; // use a NULL for non existent ones, optional things in structs were introduced in C++ and this is limited.
    bool8 enabled;
}; 

void CB2_InitSpeedchoiceMenu(void);
bool8 CheckSpeedchoiceOption(u8, u8);

#endif
