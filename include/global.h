#ifndef GUARD_GLOBAL_H
#define GUARD_GLOBAL_H

#include "gba/gba.h"

#ifndef REVISION
#define REVISION 0
#endif

// Prevent cross-jump optimization.
#define BLOCK_CROSS_JUMP asm("");

// to help in decompiling
#define asm_comment(x) asm volatile("@ -- " x " -- ")

#define ARRAY_COUNT(array) (sizeof(array) / sizeof((array)[0]))

#define POKEMON_NAME_LENGTH 10
#define OT_NAME_LENGTH 7

extern u8 gStringVar1[];
extern u8 gStringVar2[];
extern u8 gStringVar3[];
extern u8 gStringVar4[];

enum
{
    VERSION_SAPPHIRE = 1,
    VERSION_RUBY = 2,
};

enum
{
    MALE,
    FEMALE
};

enum
{
    OPTIONS_BUTTON_MODE_NORMAL,
    OPTIONS_BUTTON_MODE_LR,
    OPTIONS_BUTTON_MODE_L_EQUALS_A
};

enum
{
    OPTIONS_TEXT_SPEED_SLOW,
    OPTIONS_TEXT_SPEED_MID,
    OPTIONS_TEXT_SPEED_FAST
};

enum
{
    OPTIONS_SOUND_MONO,
    OPTIONS_SOUND_STEREO
};

enum
{
    OPTIONS_BATTLE_STYLE_SHIFT,
    OPTIONS_BATTLE_STYLE_SET
};

enum
{
	SPEEDCHOICE_INSTANTTEXT_OFF,
	SPEEDCHOICE_INSTANTTEXT_ON
};

enum
{
	SPEEDCHOICE_SPINNERS_NERF,
	SPEEDCHOICE_SPINNERS_KEEP,
	SPEEDCHOICE_SPINNERS_HELL
};

enum
{
	SPEEDCHOICE_MAXVISION_NO,
	SPEEDCHOICE_MAXVISION_YES
};

enum
{
	SPEEDCHOICE_NERFROXANNE_NO,
	SPEEDCHOICE_NERFROXANNE_YES
};

enum
{
	SPEEDCHOICE_SUPERBIKE_NO,
	SPEEDCHOICE_SUPERBIKE_YES
};

enum
{
	SPEEDCHOICE_NERFRAREENC_NO,
	SPEEDCHOICE_NERFRAREENC_YES
};

struct Coords16
{
    s16 x;
    s16 y;
};

struct UCoords16
{
    u16 x;
    u16 y;
};

struct SecretBaseRecord
{
    u8 sbr_field_0; // ID?
    u8 sbr_field_1_0:4;
    u8 gender:1;
    u8 sbr_field_1_5:1;
    u8 sbr_field_2[7]; // 0xFF bytes?
    u8 trainerId[4]; // byte 0 is used for determining trainer class
    u16 sbr_field_e;
    u8 sbr_field_10;
    u8 sbr_field_11;
    u8 decorations[16];
    u8 sbr_field_22[16];
    u32 partyPersonality[6];
    u16 partyMoves[6 * 4];
    u16 partySpecies[6];
    u16 partyHeldItems[6];
    u8 partyLevels[6];
    u8 partyEVs[6];
};

#include "game_stat.h"
#include "fieldmap.h"
#include "berry.h"
#include "pokemon.h"

struct WarpData
{
    s8 mapGroup;
    s8 mapNum;
    s8 warpId;
    s16 x, y;
};

struct ItemSlot
{
    u16 itemId;
    u8 quantity;
};

struct Pokeblock
{
    u8 color;
    u8 spicy;
    u8 dry;
    u8 sweet;
    u8 bitter;
    u8 sour;
    u8 feel;
};

struct Roamer
{
    /*0x00*/ u32 ivs;
    /*0x04*/ u32 personality;
    /*0x08*/ u16 species;
    /*0x0A*/ u16 hp;
    /*0x0C*/ u8 level;
    /*0x0D*/ u8 status;
    /*0x0E*/ u8 cool;
    /*0x0F*/ u8 beauty;
    /*0x10*/ u8 cute;
    /*0x11*/ u8 smart;
    /*0x12*/ u8 tough;
    /*0x13*/ u8 active;
};

struct RamScriptData
{
    u8 magic;
    u8 mapGroup;
    u8 mapNum;
    u8 objectId;
    u8 script[995];
};

struct RamScript
{
    u32 checksum;
    struct RamScriptData data;
};

struct SB1_2EFC_Struct
{
    u8 unknown[0x20];
};

struct SaveBlock1
{
    /*0x00*/ struct Coords16 pos;
    /*0x04*/ struct WarpData location;
    /*0x0C*/ struct WarpData warp1;
    /*0x14*/ struct WarpData warp2;
    /*0x1C*/ struct WarpData warp3;
    /*0x24*/ struct WarpData warp4;
    /*0x2C*/ u16 battleMusic;
    /*0x2E*/ u8 weather;
    /*0x2F*/ u8 filler_2F;
    /*0x30*/ u8 flashUsed;
    /*0x32*/ u16 mapDataId;
    u16 mapView[0x100];
    u8 playerPartyCount;
    struct Pokemon playerParty[6];
    u32 money;
    u16 coins;
    u16 registeredItem; // registered for use with SELECT button
    struct ItemSlot pcItems[50];
    struct ItemSlot bagPocket_Items[20];
    struct ItemSlot bagPocket_KeyItems[20];
    struct ItemSlot bagPocket_PokeBalls[16];
    struct ItemSlot bagPocket_TMHM[64];
    struct ItemSlot bagPocket_Berries[46];
    struct Pokeblock pokeblocks[40];
    u8 unk938[52];  // pokedex related
    u16 berryBlenderRecords[3];
    u8 filler_972[0x6];
    u16 trainerRematchStepCounter;
    u8 trainerRematches[100];
    struct MapObject mapObjects[16];
    /*0xC20*/ struct MapObjectTemplate mapObjectTemplates[64];
    /*0x1220*/ u8 flags[0x120];
    /*0x1340*/ u16 vars[0x100];
    /*0x1540*/ u32 gameStats[NUM_GAME_STATS];
    /*0x1608*/ struct BerryTree berryTrees[128];
    /*0x1A08*/ struct SecretBaseRecord secretBases[20];
    /*0x2688*/ u8 playerRoomDecor[12];
    /*0x2694*/ u8 playerRoomDecorPos[12];
    u8 decorDesk[10];
    u8 decorChair[10];
    u8 decorPlant[10];
    u8 decorOrnament[30];
    u8 decorMat[30];
    u8 decorPoster[10];
    u8 decorDoll[40];
    u8 decorCushion[10];
    u8 padding_2736[2];
    u8 tvShows[24][36]; // TODO: TV show struct
    /*0x2A98*/ u8 filler_2A98[0x64];
    /*0x2AFC*/ u16 outbreakPokemonSpecies;
    /*0x2AFE*/ u8 outbreakLocationMapNum;
    /*0x2AFF*/ u8 outbreakLocationMapGroup;
    /*0x2B00*/ u8 outbreakPokemonLevel;
    /*0x2B01*/ u8 filler_2B01[3];
    /*0x2B04*/ u16 outbreakPokemonMoves[4];
    /*0x2B0C*/ u8 unk2B0C;
    /*0x2B0D*/ u8 outbreakPokemonProbability;
    /*0x2B0E*/ u8 filler_2B0E[0x2C8];
    /*0x2DD6*/ u16 feebasLocationSeed;
    /*0x2DD8*/ u8 filler_2DD8[0x124];
    struct SB1_2EFC_Struct sb1_2EFC_struct[5];
    u8 filler_2F9C[0x1A8];
    /*0x3144*/ struct Roamer roamer;
    /*0x3158*/ u8 filler_3158[0x8];
    struct EnigmaBerry enigmaBerry;
    struct RamScript ramScript;
    u8 filler_3A7C[0x10];
    u8 unk3A8C[52]; //pokedex related
};

extern struct SaveBlock1 gSaveBlock1;

struct Time
{
    s16 days;
    s8 hours;
    s8 minutes;
    s8 seconds;
};

struct Pokedex
{
    /*0x00*/ u8 order;
    /*0x01*/ u8 unknown1;
    /*0x02*/ u8 nationalMagic; // must equal 0xDA in order to have National mode
    /*0x03*/ u8 unknown2;
    /*0x04*/ u32 unownPersonality; // set when you first see Unown
    /*0x08*/ u32 spindaPersonality; // set when you first see Spinda
    /*0x0C*/ u32 unknown3;
    /*0x10*/ u8 owned[52];
    /*0x44*/ u8 seen[52];
};

struct SaveBlock2
{
    /*0x00*/ u8 playerName[8];
    /*0x08*/ u8 playerGender; // MALE, FEMALE
    /*0x09*/ u8 sb2_field_9;
    /*0x0A*/ u8 playerTrainerId[4];
    /*0x0E*/ u16 playTimeHours;
    /*0x10*/ u8 playTimeMinutes;
    /*0x11*/ u8 playTimeSeconds;
    /*0x12*/ u8 playTimeVBlanks;
    /*0x13*/ u8 optionsButtonMode;  // OPTIONS_BUTTON_MODE_[NORMAL/LR/L_EQUALS_A]
             u16 optionsTextSpeed:3; // OPTIONS_TEXT_SPEED_[SLOW/MID/FAST]
             u16 optionsWindowFrameType:5; // Specifies one of the 20 decorative borders for text boxes
             u16 optionsSound:1; // OPTIONS_SOUND_[MONO/STEREO]
             u16 optionsBattleStyle:1; // OPTIONS_BATTLE_STYLE_[SHIFT/SET]
             u16 optionsBattleSceneOff:1; // whether battle animations are disabled
             u16 regionMapZoom:1; // whether the map is zoomed in
			 u8 speedchoiceInstantText:1;
			 u8 speedchoiceSpinners:2;
			 u8 speedchoiceMaxVision:1;
			 u8 speedchoiceNerfRoxanne:1;
			 u8 speedchoiceSuperBike:1;
			 u8 speedchoiceNerfRareEnc:1;
    /*0x18*/ struct Pokedex pokedex;
    /*0x90*/ u8 filler_90[0x8];
    /*0x98*/ struct Time localTimeOffset;
    /*0xA0*/ struct Time lastBerryTreeUpdate;
    /*0xA8*/ u8 filler_A8[0x7E8];
};

extern struct SaveBlock2 gSaveBlock2;

#endif // GUARD_GLOBAL_H
