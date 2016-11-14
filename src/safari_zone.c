#include "global.h"
#include "flag.h"
#include "main.h"
#include "script.h"
#include "string_util.h"

struct PokeblockFeeder
{
    /*0x00*/ s16 x;
    /*0x02*/ s16 y;
    /*0x04*/ s8 mapNum;
    /*0x05*/ u8 stepCounter;
    /*0x08*/ struct Pokeblock pokeblock;
};

#define NUM_POKEBLOCK_FEEDERS 10

void ClearAllPokeblockFeeders(void);
void DecrementFeederStepCounters(void);
extern void c2_exit_to_overworld_2_switch(void);
extern void c2_exit_to_overworld_1_continue_scripts_restart_music(void);
extern void sub_8080E44(void);
extern void CB2_LoadMap(void);
extern void sav12_xor_increment(u8);
extern void warp_in(void);
extern void GetXYCoordsOneStepInFrontOfPlayer(void *, void *);
extern void PlayerGetDestCoords(u16 *, u16 *);

extern u8 gUnknown_02024D26;

EWRAM_DATA u8 gNumSafariBalls = 0;
EWRAM_DATA static u16 gSafariZoneStepCounter = 0;
EWRAM_DATA static struct PokeblockFeeder gPokeblockFeeders[NUM_POKEBLOCK_FEEDERS] = {0};

extern void (*gUnknown_0300485C)(void);

extern u8 gUnknown_081C340A;
extern u8 gUnknown_081C342D;
extern u8 gUnknown_081C3448;
extern u8 gUnknown_081C3459;
extern u8 *gPokeblockNames[];

extern u16 gScriptResult;

bool32 GetSafariZoneFlag(void)
{
    return FlagGet(SYS_SAFARI_MODE);
}

void SetSafariZoneFlag(void)
{
    FlagSet(SYS_SAFARI_MODE);
}

void ResetSafariZoneFlag(void)
{
    FlagReset(SYS_SAFARI_MODE);
}

void EnterSafariMode(void)
{
    sav12_xor_increment(0x11);
    SetSafariZoneFlag();
    ClearAllPokeblockFeeders();
    gNumSafariBalls = 30;
    gSafariZoneStepCounter = 500;
}

void ExitSafariMode(void)
{
    ResetSafariZoneFlag();
    ClearAllPokeblockFeeders();
    gNumSafariBalls = 0;
    gSafariZoneStepCounter = 0;
}

bool8 SafariZoneTakeStep(void)
{
    if (GetSafariZoneFlag() == FALSE)
    {
        return FALSE;
    }

    DecrementFeederStepCounters();
    gSafariZoneStepCounter--;
    if (gSafariZoneStepCounter == 0)
    {
        ScriptContext1_SetupScript(&gUnknown_081C3448);
        return TRUE;
    }
    return FALSE;
}

void SafariZoneRetirePrompt(void)
{
    ScriptContext1_SetupScript(&gUnknown_081C342D);
}

void sub_80C824C(void)
{
    if (gNumSafariBalls != 0)
    {
        SetMainCallback2(c2_exit_to_overworld_2_switch);
    }
    else if (gUnknown_02024D26 == 8)
    {
        ScriptContext2_RunNewScript(&gUnknown_081C340A);
        warp_in();
        gUnknown_0300485C = sub_8080E44;
        SetMainCallback2(CB2_LoadMap);
    }
    else if (gUnknown_02024D26 == 7)
    {
        ScriptContext1_SetupScript(&gUnknown_081C3459);
        ScriptContext1_Stop();
        SetMainCallback2(c2_exit_to_overworld_1_continue_scripts_restart_music);
    }
}

static void ClearPokeblockFeeder(u8 index)
{
    memset(&gPokeblockFeeders[index], 0, sizeof(struct PokeblockFeeder));
}

static void ClearAllPokeblockFeeders(void)
{
    memset(gPokeblockFeeders, 0, sizeof(gPokeblockFeeders));
}

void SafariZoneGetPokeblockNameInFeeder(void)
{
    s16 x, y;
    u16 i;

    GetXYCoordsOneStepInFrontOfPlayer(&x, &y);

    for (i = 0; i < NUM_POKEBLOCK_FEEDERS; i++)
    {
        if (gSaveBlock1.location.mapNum == gPokeblockFeeders[i].mapNum
         && gPokeblockFeeders[i].x == x
         && gPokeblockFeeders[i].y == y)
        {
            gScriptResult = i;
            StringCopy(gStringVar1, gPokeblockNames[gPokeblockFeeders[i].pokeblock.color]);
            return;
        }
    }

    gScriptResult = -1;
}

static void GetPokeblockFeederWithinRange(void)
{
    s16 x, y;
    u16 i;

    PlayerGetDestCoords(&x, &y);

    for (i = 0; i < NUM_POKEBLOCK_FEEDERS; i++)
    {
        if (gSaveBlock1.location.mapNum == gPokeblockFeeders[i].mapNum)
        {
            //Get absolute value of x and y distance from Pokeblock feeder on current map
            x -= gPokeblockFeeders[i].x;
            y -= gPokeblockFeeders[i].y;
            if (x < 0)
                x *= -1;
            if (y < 0)
                y *= -1;
            if ((x + y) <= 5)
            {
                gScriptResult = i;
                return;
            }
        }
    }

    gScriptResult = -1;
}

struct Pokeblock *unref_sub_80C8418(void)
{
    SafariZoneGetPokeblockNameInFeeder();

    if (gScriptResult == 0xFFFF)
        return NULL;
    else
        return &gPokeblockFeeders[gScriptResult].pokeblock;
}


struct Pokeblock *SafariZoneGetActivePokeblock(void)
{
    GetPokeblockFeederWithinRange();

    if (gScriptResult == 0xFFFF)
        return NULL;
    else
        return &gPokeblockFeeders[gScriptResult].pokeblock;
}


void SafariZoneActivatePokeblockFeeder(u8 pokeblock_index)
{
    s16 x, y;
    u8 i;

    for (i = 0; i < NUM_POKEBLOCK_FEEDERS; i++)
    {
        //Find free entry in gPokeblockFeeders
        if (gPokeblockFeeders[i].mapNum == 0
         && gPokeblockFeeders[i].x == 0
         && gPokeblockFeeders[i].y == 0)
        {
            //Initialize Pokeblock feeder
            GetXYCoordsOneStepInFrontOfPlayer(&x, &y);
            gPokeblockFeeders[i].mapNum = gSaveBlock1.location.mapNum;
            gPokeblockFeeders[i].pokeblock = gSaveBlock1.pokeblocks[pokeblock_index];
            gPokeblockFeeders[i].stepCounter = 100;
            gPokeblockFeeders[i].x = x;
            gPokeblockFeeders[i].y = y;
            break;
        }
    }
}

static void DecrementFeederStepCounters(void)
{
    u8 i;

    for (i = 0; i < NUM_POKEBLOCK_FEEDERS; i++)
    {
        if (gPokeblockFeeders[i].stepCounter != 0)
        {
            gPokeblockFeeders[i].stepCounter--;
            if (gPokeblockFeeders[i].stepCounter == 0)
                ClearPokeblockFeeder(i);
        }
    }
}

bool8 unref_sub_80C853C(void)
{
    SafariZoneGetPokeblockNameInFeeder();

    if (gScriptResult == 0xFFFF)
    {
        return FALSE;
    }

    ConvertIntToDecimalStringN(gStringVar2,
        gPokeblockFeeders[gScriptResult].stepCounter,
        STR_CONV_MODE_LEADING_ZEROS, 3);

    return TRUE;
}
