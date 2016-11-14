#include "global.h"
#include "abilities.h"
#include "fieldmap.h"
#include "pokemon.h"
#include "rng.h"
#include "script.h"
#include "flag.h"
#include "var.h"

struct WildPokemon
{
    u8 minLevel;
    u8 maxLevel;
    u16 species;
};

struct WildPokemonInfo
{
    u8 encounterRate;
    struct WildPokemon *wildPokemon;
};

struct WildPokemonHeader
{
    u8 mapGroup;
    u8 mapNum;
    struct WildPokemonInfo *landMonsInfo;
    struct WildPokemonInfo *waterMonsInfo;
    struct WildPokemonInfo *rockSmashMonsInfo;
    struct WildPokemonInfo *fishingMonsInfo;
};

extern bool8 sub_805759C(u8);
extern void GetXYCoordsOneStepInFrontOfPlayer(void *, void *);
extern s16 sub_810CAE4(u8, struct Pokeblock *);
extern bool32 GetSafariZoneFlag(void);
extern u8 TestPlayerAvatarFlags(u8);
extern u8 MetatileBehavior_IsLandWildEncounter(u8);
extern u8 sub_81344CC(void);
extern u8 MetatileBehavior_IsWaterWildEncounter(u8);
extern void CheckForSafariZoneAndProceed(void);
extern u8 MetatileBehavior_IsBridge(u8);
extern void PlayerGetDestCoords(u16 *x, u16 *y);
extern void sub_80BEA50(u16);
extern void sav12_xor_increment(u8);
extern int MapGridGetMetatileBehaviorAt(int x, int y);
extern struct Pokeblock *SafariZoneGetActivePokeblock(void);

extern u16 gRoute119WaterTileData[];
extern struct WildPokemonHeader gWildMonHeaders[];
extern struct Pokemon gEnemyParty[6];
extern struct Pokemon gPlayerParty[6];
extern u16 gScriptResult;
extern struct WildPokemon gWildFeebasRoute119Data;
extern u8 Event_RepelWoreOff[];

EWRAM_DATA static u8 sWildEncountersDisabled = 0;
EWRAM_DATA static u32 sFeebasRngValue = 0;

#define NUM_FEEBAS_SPOTS 6

static u16 FeebasRandom(void);
static void FeebasSeedRng(u16 seed);

static bool8 RepelCheck(u8 level);
static void ApplyFluteEncounterRateMod(u32 *encRate);
static void ApplyCleanseTagEncounterRateMod(u32 *encRate);

void DisableWildEncounters(bool8 disabled)
{
    sWildEncountersDisabled = disabled;
}

static u16 GetRoute119WaterTileNum(s16 x, s16 y, u8 section)
{
    u16 xCur;
    u16 yCur;
    u16 yMin = gRoute119WaterTileData[section * 3 + 0];
    u16 yMax = gRoute119WaterTileData[section * 3 + 1];
    u16 tileNum = gRoute119WaterTileData[section * 3 + 2];
    
    for (yCur = yMin; yCur <= yMax; yCur++)
    {
        for (xCur = 0; xCur < gMapHeader.mapData->width; xCur++)
        {
            if (sub_805759C(MapGridGetMetatileBehaviorAt(xCur + 7, yCur + 7)) == TRUE)
            {
                tileNum++;
                if (x == xCur && y == yCur)
                    return tileNum;
            }
        }
    }
    return tileNum + 1;
}

static bool8 CheckFeebas(void)
{
    u8 i;
    u16 feebasSpots[6];
    s16 x;
    s16 y;
    u8 route119section = 0;
    u16 waterTileNum;

    if (gSaveBlock1.location.mapGroup == 0 && gSaveBlock1.location.mapNum == 0x22)
    {
        GetXYCoordsOneStepInFrontOfPlayer(&x, &y);
        x -= 7;
        y -= 7;
        
#ifdef NONMATCHING
        if (y >= gRoute119WaterTileData[3 * 1 + 0] && y <= gRoute119WaterTileData[3 * 1 + 1])
            route119section = 1;
        if (y >= gRoute119WaterTileData[3 * 2 + 0] && y <= gRoute119WaterTileData[3 * 2 + 1])
            route119section = 2;
#else
        {
            register u16 *arr asm("r0");
            if (y >= (arr = gRoute119WaterTileData)[3 * 1 + 0] && y <= arr[3 * 1 + 1])
                route119section = 1;
            if (y >= arr[3 * 2 + 0] && y <= arr[3 * 2 + 1])
                route119section = 2;
        }
#endif
        
        if (Random() % 100 > 49) //50% chance of encountering Feebas
            return FALSE;
        FeebasSeedRng(gSaveBlock1.easyChatPairs[0].unk2);
        for (i = 0; i != NUM_FEEBAS_SPOTS;)
        {
            feebasSpots[i] = FeebasRandom() % 447;
            if (feebasSpots[i] == 0)
                feebasSpots[i] = 447;
            if (feebasSpots[i] < 1 || feebasSpots[i] >= 4)
                i++;
        }
        waterTileNum = GetRoute119WaterTileNum(x, y, route119section);
        for (i = 0; i < NUM_FEEBAS_SPOTS; i++)
        {
            if (waterTileNum == feebasSpots[i])
                return TRUE;
        }
    }
    return FALSE;
}

static u16 FeebasRandom(void)
{
    sFeebasRngValue = 12345 + 0x41C64E6D * sFeebasRngValue;
    return sFeebasRngValue >> 16;
}

static void FeebasSeedRng(u16 seed)
{
    sFeebasRngValue = seed;
}

static u8 ChooseWildMonIndex_Land(void)
{
    u8 val = Random() % 100;

	if (gSaveBlock2.speedchoiceNerfRareEnc == SPEEDCHOICE_NERFRAREENC_YES)
	{
		if(val < 15) // 15%
			return 0;
		if(val >= 15 && val < 25) // 10%
			return 1;
		if(val >= 25 && val < 35) // 10%
			return 2;
		if(val >= 35 && val < 45) // 10%
			return 3;
		if(val >= 45 && val < 55) // 10%
			return 4;
		if(val >= 55 && val < 65) // 10%
			return 5;
		if(val >= 65 && val < 75) // 10%
			return 6;
		if(val >= 75 && val < 80) // 5%
			return 7;
		if(val >= 80 && val < 85) // 5%
			return 8;
		if(val >= 85 && val < 90) // 5%
			return 9;
		if(val >= 90 && val < 95) // 5%
			return 10;
		else // 5%
			return 11;
	}
	else
	{
		if(val < 20)
			return 0;
		if(val >= 20 && val < 40)
			return 1;
		if(val >= 40 && val < 50)
			return 2;
		if(val >= 50 && val < 60)
			return 3;
		if(val >= 60 && val < 70)
			return 4;
		if(val >= 70 && val < 80)
			return 5;
		if(val >= 80 && val < 85)
			return 6;
		if(val >= 85 && val < 90)
			return 7;
		if(val >= 90 && val < 94)
			return 8;
		if(val >= 94 && val < 98)
			return 9;
		if(val == 98)
			return 10;
		else
			return 11;
	}
}

static u8 ChooseWildMonIndex_Water(void)
{
    u8 val = Random() % 100;

	if (gSaveBlock2.speedchoiceNerfRareEnc == SPEEDCHOICE_NERFRAREENC_YES)
	{
        if(val < 30) // 30%
            return 0;
        if(val >= 30 && val < 60) // 30%
            return 1;
        if(val >= 60 && val < 80) // 20%
            return 2;
        if(val >= 80 && val < 90) // 10%
            return 3;
        else // 10%
            return 4;
	}
	else
	{
        if(val < 60)
            return 0;
        if(val >= 60 && val < 90)
            return 1;
        if(val >= 90 && val < 95)
            return 2;
        if(val >= 95 && val < 99)
            return 3;
        else
            return 4;
	}
}

enum
{
    OLD_ROD,
    GOOD_ROD,
    SUPER_ROD
};

static u8 ChooseWildMonIndex_Fishing(u8 rod)
{
    u8 wildMonIndex = 0;
    u8 val = Random() % 100;

    switch (rod)
    {
        case 0: //old rod?
            if(val < 70) // 70%
                wildMonIndex = 0;
            else // 30%
                wildMonIndex = 1;
            return wildMonIndex;
        case 1: //good rod?
            if(val < 60)
                wildMonIndex = 2;
            if(val >= 60 && val < 80)
                wildMonIndex = 3;
            if(val >= 80 && val < 100)
                wildMonIndex = 4;
            return wildMonIndex;
        case 2: //super rod?
			if (gSaveBlock2.speedchoiceNerfRareEnc == SPEEDCHOICE_NERFRAREENC_YES)
			{
				if(val < 30) // 30%
					return 5;
				if(val >= 30 && val < 55) // 25%
					return 6;
				if(val >= 55 && val < 70) // 15%
					return 7;
				if(val >= 70 && val < 85) // 15%
					return 8;
				if(val >= 85 && val <= 100) // 15%
					return 9;
			}
			else
			{
				if(val < 40)
					wildMonIndex = 5;
				if(val >= 40 && val < 80)
					wildMonIndex = 6;
				if(val >= 80 && val < 95)
					wildMonIndex = 7;
				if(val >= 95 && val < 99)
					wildMonIndex = 8;
				if(val == 99)
					wildMonIndex = 9;
				return wildMonIndex;
			}
        default:
            return wildMonIndex;
    }
    return wildMonIndex;
}

static u8 ChooseWildMonLevel(struct WildPokemon *wildPokemon)
{
    u8 min;
    u8 max;
    u8 range;
    u8 rand;

    //Make sure minimum level is less than maximum level
    if (wildPokemon->maxLevel >= wildPokemon->minLevel)
    {
        min = wildPokemon->minLevel;
        max = wildPokemon->maxLevel;
    }
    else
    {
        min = wildPokemon->maxLevel;
        max = wildPokemon->minLevel;
    }
    range = max - min + 1;
    rand = Random() % range;
    return min + rand;
}

static u16 GetCurrentMapWildMonHeader(void)
{
    u16 i;

    for (i = 0; gWildMonHeaders[i].mapGroup != 0xFF; i++)
    {
        if (gWildMonHeaders[i].mapGroup == gSaveBlock1.location.mapGroup &&
        gWildMonHeaders[i].mapNum == gSaveBlock1.location.mapNum)
            return i;
    }
    return -1;
}

static u8 PickWildMonNature(void)
{
    u8 i;
    u8 j;
    struct Pokeblock *safariPokeblock;
    u8 natures[25];

    if (GetSafariZoneFlag() == TRUE && Random() % 100 < 80)
    {
        safariPokeblock = SafariZoneGetActivePokeblock();
        if (safariPokeblock != NULL)
        {
            for (i = 0; i < 25; i++)
                natures[i] = i;
            for (i = 0; i < 24; i++)
            {
                for (j = i + 1; j < 25; j++)
                {
                    if (Random() & 1)
                    {
                        u8 temp = natures[i];

                        natures[i] = natures[j];
                        natures[j] = temp;
                    }
                }
            }
            for (i = 0; i < 25; i++)
            {
                if (sub_810CAE4(natures[i], safariPokeblock) > 0)
                    return natures[i];
            }
        }
    }
    return Random() % 25;
}

static void CreateWildMon(u16 species, u8 b)
{
    ZeroEnemyPartyMons();
    CreateMonWithNature(&gEnemyParty[0], species, b, 0x20, PickWildMonNature());
}

static bool8 GenerateWildMon(struct WildPokemonInfo *wildMonInfo, u8 area, bool8 checkRepel)
{
    u8 wildMonIndex = 0;
    u8 level;

    switch (area)
    {
    case 0:
        wildMonIndex = ChooseWildMonIndex_Land();
        break;
    case 1:
        wildMonIndex = ChooseWildMonIndex_Water();
        break;
    case 2:
        wildMonIndex = ChooseWildMonIndex_Water();
        break;
    }
    level = ChooseWildMonLevel(&wildMonInfo->wildPokemon[wildMonIndex]);
    if (checkRepel == TRUE && RepelCheck(level) == FALSE)
        return FALSE;
    else
    {
        CreateWildMon(wildMonInfo->wildPokemon[wildMonIndex].species, level);
        return TRUE;
    }
}

static u16 GenerateFishingWildMon(struct WildPokemonInfo *wildMonInfo, u8 rod)
{
    u8 wildMonIndex = ChooseWildMonIndex_Fishing(rod);
    u8 level = ChooseWildMonLevel(&wildMonInfo->wildPokemon[wildMonIndex]);

    CreateWildMon(wildMonInfo->wildPokemon[wildMonIndex].species, level);
    return wildMonInfo->wildPokemon[wildMonIndex].species;
}

static bool8 SetUpMassOutbreakEncounter(bool8 checkRepel)
{
    u16 i;

    if (checkRepel == TRUE && RepelCheck(gSaveBlock1.outbreakPokemonLevel) == 0)
        return FALSE;
    else
    {
        CreateWildMon(gSaveBlock1.outbreakPokemonSpecies, gSaveBlock1.outbreakPokemonLevel);
        for (i = 0; i < 4; i++)
            SetMonMoveSlot(&gEnemyParty[0], gSaveBlock1.outbreakPokemonMoves[i], i);
        return TRUE;
    }
}

static bool8 DoMassOutbreakEncounterTest(void)
{
    if (gSaveBlock1.outbreakPokemonSpecies != 0
     && gSaveBlock1.location.mapNum == gSaveBlock1.outbreakLocationMapNum
     && gSaveBlock1.location.mapGroup == gSaveBlock1.outbreakLocationMapGroup)
    {
        if (Random() % 100 < gSaveBlock1.outbreakPokemonProbability)
            return TRUE;
    }
    return FALSE;
}

static bool8 DoWildEncounterRateDiceRoll(u16 encounterRate)
{
    if (Random() % 2880 < encounterRate)
        return TRUE;
    else
        return FALSE;
}

static bool8 DoWildEncounterTest(u32 encounterRate, bool8 ignoreAbility)
{
    encounterRate *= 16;
    if (TestPlayerAvatarFlags(6))
        encounterRate = encounterRate * 80 / 100;
    ApplyFluteEncounterRateMod(&encounterRate);
    ApplyCleanseTagEncounterRateMod(&encounterRate);
    if (!ignoreAbility)
    {
        // UB: Too few arguments for function 'GetMonData'
        if (!GetMonData(&gPlayerParty[0], MON_DATA_SANITY_BIT3))
        {
            u32 ability = GetMonAbility(&gPlayerParty[0]);
            if (ability == ABILITY_STENCH)
                encounterRate /= 2;
            if (ability == ABILITY_ILLUMINATE)
                encounterRate *= 2;
        }
    }
    if (encounterRate > 2880)
        encounterRate = 2880;
    return DoWildEncounterRateDiceRoll(encounterRate);
}

static bool8 DoGlobalWildEncounterDiceRoll(void)
{
    if (Random() % 100 >= 60)
        return FALSE;
    else
        return TRUE;
}

bool8 StandardWildEncounter(u16 a, u16 b)
{
    u16 headerNum;
    struct Roamer *roamer;

    if (sWildEncountersDisabled == TRUE)
        return 0;
    else
    {
        headerNum = GetCurrentMapWildMonHeader();
        if (headerNum != 0xFFFF)
        {
            if (MetatileBehavior_IsLandWildEncounter(a) == TRUE)
            {
                if (gWildMonHeaders[headerNum].landMonsInfo)
                {
                    if (b != a && !DoGlobalWildEncounterDiceRoll())
                        return 0;

                    if (DoWildEncounterTest(gWildMonHeaders[headerNum].landMonsInfo->encounterRate, 0) == TRUE)
                    {
                        if (sub_81344CC() == TRUE)
                        {
                            roamer = &gSaveBlock1.roamer;
                            if (RepelCheck(roamer->level))
                            {
                                sub_8081A5C();
                                return 1;
                            }
                        }
                        else
                        {
                            if (DoMassOutbreakEncounterTest() == TRUE && SetUpMassOutbreakEncounter(1) == TRUE)
                            {
                                CheckForSafariZoneAndProceed();
                                return 1;
                            }
                            if (GenerateWildMon(gWildMonHeaders[headerNum].landMonsInfo, 0, TRUE) == TRUE)
                            {
                                goto label;
                            }
                        }
                    }
                }
            }
            else if (MetatileBehavior_IsWaterWildEncounter(a) == TRUE
             || (TestPlayerAvatarFlags(8) && MetatileBehavior_IsBridge(a) == TRUE))
            {
                if (gWildMonHeaders[headerNum].waterMonsInfo)
                {
                    if (b != a && !DoGlobalWildEncounterDiceRoll())
                        return 0;

                    if (DoWildEncounterTest(gWildMonHeaders[headerNum].waterMonsInfo->encounterRate, 0) == TRUE)
                    {
                        if (sub_81344CC() == TRUE)
                        {
                            roamer = &gSaveBlock1.roamer;
                            if (RepelCheck(roamer->level))
                            {
                                sub_8081A5C();
                                return 1;
                            }
                        }
                        else
                        {
                            //_08085268
                            if (GenerateWildMon(gWildMonHeaders[headerNum].waterMonsInfo, 1, TRUE) == TRUE)
                            {
                            label:
                                //_0808527A
                                CheckForSafariZoneAndProceed();
                                return 1;
                            }
                        }
                    }
                }
            }
        }
    }
    return 0;
}

void RockSmashWildEncounter(void)
{
    u16 headerNum = GetCurrentMapWildMonHeader();

    if (headerNum != 0xFFFF)
    {
        struct WildPokemonInfo *wildPokemonInfo = gWildMonHeaders[headerNum].rockSmashMonsInfo;

        if (wildPokemonInfo == NULL)
        {
            gScriptResult = 0;
            return;
        }
        else if (DoWildEncounterTest(wildPokemonInfo->encounterRate, 1) == TRUE
         && GenerateWildMon(wildPokemonInfo, 2, TRUE) == TRUE)
        {
            CheckForSafariZoneAndProceed();
            gScriptResult = 1;
            return;
        }
    }
    gScriptResult = 0;
    return;
}

bool8 SweetScentWildEncounter(void)
{
    s16 x;
    s16 y;
    u16 headerNum;
    struct WildPokemonInfo *wildPokemonInfo;

    PlayerGetDestCoords(&x, &y);
    if ((headerNum = GetCurrentMapWildMonHeader()) != 0xFFFF)
    {
        if (MetatileBehavior_IsLandWildEncounter(MapGridGetMetatileBehaviorAt(x, y)) == 1)
        {
            wildPokemonInfo = gWildMonHeaders[headerNum].landMonsInfo;
            if (wildPokemonInfo == NULL)
                return FALSE;
            if (sub_81344CC() == TRUE)
            {
                sub_8081A5C();
                return TRUE;
            }
            if (DoMassOutbreakEncounterTest() == TRUE)
                SetUpMassOutbreakEncounter(0);
            else
                GenerateWildMon(wildPokemonInfo, 0, FALSE);
            CheckForSafariZoneAndProceed();
            return TRUE;
        }
        else if (MetatileBehavior_IsWaterWildEncounter(MapGridGetMetatileBehaviorAt(x, y)) == 1)
        {
            wildPokemonInfo = gWildMonHeaders[headerNum].waterMonsInfo;
            if (wildPokemonInfo == NULL)
                return FALSE;
            if (sub_81344CC() == TRUE)
            {
                sub_8081A5C();
                return TRUE;
            }
            GenerateWildMon(wildPokemonInfo, 1, FALSE);
            CheckForSafariZoneAndProceed();
            return TRUE;
        }
    }
    return FALSE;
}

bool8 GetFishingWildMonListHeader(void)
{
    u16 headerNum = GetCurrentMapWildMonHeader();

    if (headerNum != 0xFFFF && gWildMonHeaders[headerNum].fishingMonsInfo != NULL)
        return TRUE;
    else
        return FALSE;
}

void FishingWildEncounter(u8 rod)
{
    u16 species;

    if (CheckFeebas() == TRUE)
    {
        u8 level = ChooseWildMonLevel(&gWildFeebasRoute119Data);

        species = gWildFeebasRoute119Data.species;
        CreateWildMon(species, level);
    }
    else
    {
        species = GenerateFishingWildMon(
          gWildMonHeaders[GetCurrentMapWildMonHeader()].fishingMonsInfo,
          rod);
    }
    sav12_xor_increment(12);
    sub_80BEA50(species);
    CheckForSafariZoneAndProceed();
}

u16 GetLocalWildMon(bool8 *isWaterMon)
{
    u16 headerNum;
	u8 loopCount;
    struct WildPokemonInfo *landMonsInfo;
    struct WildPokemonInfo *waterMonsInfo;

    *isWaterMon = FALSE;
    headerNum = GetCurrentMapWildMonHeader();
    if (headerNum == 0xFFFF)
        return 0;

    landMonsInfo = gWildMonHeaders[headerNum].landMonsInfo;
    waterMonsInfo = gWildMonHeaders[headerNum].waterMonsInfo;
    //Neither
    if (landMonsInfo == NULL && waterMonsInfo == NULL)
        return 0;
    //Land Pokemon
    if (landMonsInfo != NULL && waterMonsInfo == NULL)
        return landMonsInfo->wildPokemon[ChooseWildMonIndex_Land()].species;
    //Water Pokemon
    if (landMonsInfo == NULL && waterMonsInfo != NULL)
    {
        *isWaterMon = TRUE;
        return waterMonsInfo->wildPokemon[ChooseWildMonIndex_Water()].species;
    }
    //Either land or water Pokemon
    if ((Random() % 100) < 80)
        return landMonsInfo->wildPokemon[ChooseWildMonIndex_Land()].species;
    else
    {
        *isWaterMon = TRUE;
        return waterMonsInfo->wildPokemon[ChooseWildMonIndex_Water()].species;
    }
}

u16 GetMirageIslandMon(void)
{
    u16 headerNum = GetCurrentMapWildMonHeader();

    if (headerNum != 0xFFFF)
    {
        struct WildPokemonInfo *waterMonsInfo = gWildMonHeaders[headerNum].waterMonsInfo;

        if (waterMonsInfo)
            return waterMonsInfo->wildPokemon[ChooseWildMonIndex_Water()].species;
    }
    return 0;
}

bool8 UpdateRepelCounter(void)
{
    u16 steps = VarGet(VAR_REPEL_STEP_COUNT);

    if (steps != 0)
    {
        steps--;
        VarSet(VAR_REPEL_STEP_COUNT, steps);
        if (steps == 0)
        {
            ScriptContext1_SetupScript(Event_RepelWoreOff);
            return TRUE;
        }
    }
    return FALSE;
}

//Returns FALSE if Repel prevents wild Pokemon at the specified level from appearing
static bool8 RepelCheck(u8 level)
{
    u8 i;

    if (!VarGet(VAR_REPEL_STEP_COUNT))
        return TRUE;
    else
    {
        for (i = 0; i < 6; i++)
        {
            // UB: Too few arguments for function 'GetMonData'
            if (GetMonData(&gPlayerParty[i], MON_DATA_HP) && !GetMonData(&gPlayerParty[i], MON_DATA_IS_EGG))
            {
                if (level < (u8)GetMonData(&gPlayerParty[i], MON_DATA_LEVEL))
                    return FALSE;
                else
                    return TRUE;
            }
        }
        return FALSE;
    }
}

static void ApplyFluteEncounterRateMod(u32 *encRate)
{
    if (FlagGet(SYS_ENC_UP_ITEM) == TRUE)
        *encRate += *encRate / 2;
    else if (FlagGet(SYS_ENC_DOWN_ITEM) == TRUE)
        *encRate = *encRate / 2;
}

static void ApplyCleanseTagEncounterRateMod(u32 *encRate)
{
    // UB: Too few arguments for function 'GetMonData'
    if (GetMonData(&gPlayerParty[0], MON_DATA_HELD_ITEM) == 0xBE)
        *encRate = *encRate * 2 / 3;
}
