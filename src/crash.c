#include "global.h"
#include "main.h"
#include "sound.h"
#include "songs.h"
#include "task.h"
#include "sprite.h"
#include "palette.h"
#include "menu.h"
#include "string_util.h"

extern void WaitForVBlank(void);

extern u8 gUnknown_0839F63C[];
extern u8 gUnknown_0839F5FC[];  //palette

u32 const gRandomizerCheckValue = 0;

enum
{
    TASK_OVERFLOW
};

struct CrashExceptionInfo
{
    u8 *string;
};

struct CrashScreen
{
    u32 registers[13]; // r0-r12
    void (* returnPointer)(void); // lr
    u32 *stackPointer; // sp
    u32 statusRegister;
    u32 stackTrace[7]; // last contents of sp
    u8 exception;
};

const u8 gCrashScreenHeaderText[] = _("An error occured - give this to the devs.");
const u8 gCrashScreenRegisterR0[] = _("r0: ");
const u8 gCrashScreenRegisterR1[] = _("r1: ");
const u8 gCrashScreenRegisterR2[] = _("r2: ");
const u8 gCrashScreenRegisterR3[] = _("r3: ");
const u8 gCrashScreenRegisterR4[] = _("r4: ");
const u8 gCrashScreenRegisterR5[] = _("r5: ");
const u8 gCrashScreenRegisterR6[] = _("r6: ");
const u8 gCrashScreenRegisterR7[] = _("r7: ");
const u8 gCrashScreenRegisterR8[] = _("r8: ");
const u8 gCrashScreenRegisterR9[] = _("r9: ");
const u8 gCrashScreenRegisterR10[] = _("r10: ");
const u8 gCrashScreenRegisterR11[] = _("r11: ");
const u8 gCrashScreenRegisterR12[] = _("r12: ");
const u8 gCrashScreenRegisterLR[] = _("lr: ");
const u8 gCrashScreenRegisterStatusFlags[] = _("cp: ");
const u8 gCrashScreenRegisterSP[] = _("sp: ");
const u8 gCrashScreenStackTrace[] = _("trace: ");

const u8 gCrashScreenPlaceholderText[] = _("{STR_VAR_1}");

const u8 gCrashScreenExceptionTaskOverflow[] = _("TASK OVERFLOW");

EWRAM_DATA u32 CrashException = {0};
EWRAM_DATA struct CrashScreen gCrashScreenInfo = {0};

void DoCrashScreen(void);

// copy the registers and current information to the struct.
__attribute__((naked))
void Crash(void)
{
    asm(".syntax unified\n\
    push {lr}\n\
    mov lr, r12\n\
    push {lr}\n\
    mov lr, r11\n\
    push {lr}\n\
    mov lr, r10\n\
    push {lr}\n\
    mov lr, r9\n\
    push {lr}\n\
    mov lr, r8\n\
    push {r0-r7, lr}\n\
    pop {r0}\n\
    ldr r1, CrashPool\n\
    str r0, [r1]\n\
    ldr r0, CrashPool\n\
    pop {r1}\n\
    str r1, [r0, #0x4]\n\
    pop {r1}\n\
    str r1, [r0, #0x8]\n\
    pop {r1}\n\
    str r1, [r0, #0xC]\n\
    pop {r1}\n\
    str r1, [r0, #0x10]\n\
    pop {r1}\n\
    str r1, [r0, #0x14]\n\
    pop {r1}\n\
    str r1, [r0, #0x18]\n\
    pop {r1}\n\
    str r1, [r0, #0x1C]\n\
    pop {r1}\n\
    str r1, [r0, #0x20]\n\
    pop {r1}\n\
    str r1, [r0, #0x24]\n\
    pop {r1}\n\
    str r1, [r0, #0x28]\n\
    pop {r1}\n\
    str r1, [r0, #0x2C]\n\
    pop {r1}\n\
    str r1, [r0, #0x30]\n\
    pop {r1}\n\
    str r1, [r0, #0x34]\n\
    mov r1, sp\n\
    str r1, [r0, #0x38] @ the stack pointer is equal to its state from the previous function after the push/pops used to preserve the registers and lr.\n\
    ldr r1, [sp]\n\
    str r1, [r0, #0x40]\n\
    ldr r1, [sp, #0x4]\n\
    str r1, [r0, #0x44]\n\
    ldr r1, [sp, #0x8]\n\
    str r1, [r0, #0x48]\n\
    ldr r1, [sp, #0xC]\n\
    str r1, [r0, #0x4C]\n\
    ldr r1, [sp, #0x10]\n\
    str r1, [r0, #0x50]\n\
    ldr r1, [sp, #0x14]\n\
    str r1, [r0, #0x54]\n\
    ldr r1, [sp, #0x18]\n\
    str r1, [r0, #0x58]\n\
.align 2\n\
    bx pc @ switch to ARM\n\
    nop @ it takes 1 cycle to switch.\n\
    .arm\n\
    mrs r1, cpsr\n\
    str r1, [r0, #0x3C]\n\
    bl DoCrashScreen\n\
    .align 2, 0\n\
CrashPool: .4byte gCrashScreenInfo\n\
    .syntax divided");
}

#define WIN_RANGE_(a, b) (((a) << 8) + (b))

// todo: make this a general handler with its own palette and screen handling so it can be used for other games.
void DoCrashScreen(void)
{
    gCrashScreenInfo.exception = CrashException;

    PlayBGM(BGM_STOP);
    {
    u8 *addr;
    u32 size;

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
    REG_WIN1H = WIN_RANGE(0, 240);
    REG_WIN1V = WIN_RANGE_(0, 240);
    DmaClear32(3, OAM, OAM_SIZE);
    DmaClear16(3, PLTT, PLTT_SIZE);
    ResetPaletteFade();
    SetUpWindowConfig(&gWindowConfig_81E71B4);
    MultistepInitMenuWindowBegin(&gWindowConfig_81E71B4);
    while(!MultistepInitMenuWindowContinue()) // don't return!
        ;
    LoadPalette(gUnknown_0839F5FC, 0x80, 0x40);
    CpuCopy16(gUnknown_0839F63C, (void *)0x0600BEE0, 0x40);
    }
    MenuDrawTextWindow(0, 0, 29, 19);
    MenuPrint(gCrashScreenHeaderText, 1, 1);
    MenuPrint(gCrashScreenRegisterR0, 1, 5);
    MenuPrint(gCrashScreenRegisterR1, 1, 7);
    MenuPrint(gCrashScreenRegisterR2, 1, 9);
    MenuPrint(gCrashScreenRegisterR3, 1, 11);
    MenuPrint(gCrashScreenRegisterR4, 1, 13);
    MenuPrint(gCrashScreenRegisterR5, 1, 15);
    MenuPrint(gCrashScreenRegisterR6, 1, 17);
    
    // print r0.
    ConvertIntToHexStringN(gStringVar1, gCrashScreenInfo.registers[0], STR_CONV_MODE_LEADING_ZEROS, 8);
    MenuPrint(gCrashScreenPlaceholderText, 4, 5);
    ConvertIntToHexStringN(gStringVar1, gCrashScreenInfo.registers[1], STR_CONV_MODE_LEADING_ZEROS, 8);
    MenuPrint(gCrashScreenPlaceholderText, 4, 7);
    ConvertIntToHexStringN(gStringVar1, gCrashScreenInfo.registers[2], STR_CONV_MODE_LEADING_ZEROS, 8);
    MenuPrint(gCrashScreenPlaceholderText, 4, 9);
    ConvertIntToHexStringN(gStringVar1, gCrashScreenInfo.registers[3], STR_CONV_MODE_LEADING_ZEROS, 8);
    MenuPrint(gCrashScreenPlaceholderText, 4, 11);
    ConvertIntToHexStringN(gStringVar1, gCrashScreenInfo.registers[4], STR_CONV_MODE_LEADING_ZEROS, 8);
    MenuPrint(gCrashScreenPlaceholderText, 4, 13);
    ConvertIntToHexStringN(gStringVar1, gCrashScreenInfo.registers[5], STR_CONV_MODE_LEADING_ZEROS, 8);
    MenuPrint(gCrashScreenPlaceholderText, 4, 15);
    ConvertIntToHexStringN(gStringVar1, gCrashScreenInfo.registers[6], STR_CONV_MODE_LEADING_ZEROS, 8);
    MenuPrint(gCrashScreenPlaceholderText, 4, 17);

    MenuPrint(gCrashScreenRegisterR7, 11, 5);
    MenuPrint(gCrashScreenRegisterR8, 11, 7);
    MenuPrint(gCrashScreenRegisterR9, 11, 9);
    MenuPrint(gCrashScreenRegisterR10, 11, 11);
    MenuPrint(gCrashScreenRegisterR11, 11, 13);
    MenuPrint(gCrashScreenRegisterR12, 11, 15);
    MenuPrint(gCrashScreenRegisterLR, 11, 17);

    ConvertIntToHexStringN(gStringVar1, gCrashScreenInfo.registers[7], STR_CONV_MODE_LEADING_ZEROS, 8);
    MenuPrint(gCrashScreenPlaceholderText, 14, 5);
    ConvertIntToHexStringN(gStringVar1, gCrashScreenInfo.registers[8], STR_CONV_MODE_LEADING_ZEROS, 8);
    MenuPrint(gCrashScreenPlaceholderText, 14, 7);
    ConvertIntToHexStringN(gStringVar1, gCrashScreenInfo.registers[9], STR_CONV_MODE_LEADING_ZEROS, 8);
    MenuPrint(gCrashScreenPlaceholderText, 14, 9);
    ConvertIntToHexStringN(gStringVar1, gCrashScreenInfo.registers[10], STR_CONV_MODE_LEADING_ZEROS, 8);
    MenuPrint(gCrashScreenPlaceholderText, 14, 11);
    ConvertIntToHexStringN(gStringVar1, gCrashScreenInfo.registers[11], STR_CONV_MODE_LEADING_ZEROS, 8);
    MenuPrint(gCrashScreenPlaceholderText, 14, 13);
    ConvertIntToHexStringN(gStringVar1, gCrashScreenInfo.registers[12], STR_CONV_MODE_LEADING_ZEROS, 8);
    MenuPrint(gCrashScreenPlaceholderText, 14, 15);
    ConvertIntToHexStringN(gStringVar1, (u32)gCrashScreenInfo.returnPointer, STR_CONV_MODE_LEADING_ZEROS, 8);
    MenuPrint(gCrashScreenPlaceholderText, 14, 17);
    
    MenuPrint(gCrashScreenRegisterStatusFlags, 1, 3);
    
    ConvertIntToHexStringN(gStringVar1, gCrashScreenInfo.statusRegister, STR_CONV_MODE_LEADING_ZEROS, 8);
    MenuPrint(gCrashScreenPlaceholderText, 4, 3);
    
    MenuPrint(gCrashScreenRegisterSP, 11, 3);
    
    ConvertIntToHexStringN(gStringVar1, (u32)gCrashScreenInfo.stackPointer, STR_CONV_MODE_LEADING_ZEROS, 8);
    MenuPrint(gCrashScreenPlaceholderText, 14, 3);
    
    MenuPrint(gCrashScreenStackTrace, 21, 3);
    
    ConvertIntToHexStringN(gStringVar1, gCrashScreenInfo.stackTrace[0], STR_CONV_MODE_LEADING_ZEROS, 8);
    MenuPrint(gCrashScreenPlaceholderText, 21, 5);
    ConvertIntToHexStringN(gStringVar1, gCrashScreenInfo.stackTrace[1], STR_CONV_MODE_LEADING_ZEROS, 8);
    MenuPrint(gCrashScreenPlaceholderText, 21, 7);
    ConvertIntToHexStringN(gStringVar1, gCrashScreenInfo.stackTrace[2], STR_CONV_MODE_LEADING_ZEROS, 8);
    MenuPrint(gCrashScreenPlaceholderText, 21, 9);
    ConvertIntToHexStringN(gStringVar1, gCrashScreenInfo.stackTrace[3], STR_CONV_MODE_LEADING_ZEROS, 8);
    MenuPrint(gCrashScreenPlaceholderText, 21, 11);
    ConvertIntToHexStringN(gStringVar1, gCrashScreenInfo.stackTrace[4], STR_CONV_MODE_LEADING_ZEROS, 8);
    MenuPrint(gCrashScreenPlaceholderText, 21, 13);
    ConvertIntToHexStringN(gStringVar1, gCrashScreenInfo.stackTrace[5], STR_CONV_MODE_LEADING_ZEROS, 8);
    MenuPrint(gCrashScreenPlaceholderText, 21, 15);
    ConvertIntToHexStringN(gStringVar1, gCrashScreenInfo.stackTrace[6], STR_CONV_MODE_LEADING_ZEROS, 8);
    MenuPrint(gCrashScreenPlaceholderText, 21, 17);

    while(1)
    {
        WaitForVBlank();
    }
}
