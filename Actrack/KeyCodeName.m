//
//  KeyCodeName.m
//  Actrack
//
//  Created by Simon Altschuler on 13/01/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "KeyCodeName.h"
#import "Carbon/Carbon.h"

@implementation KeyCodeName

+ (NSString*) getKeyNameFromKeyCode:(NSInteger)keyCode
{
    switch (keyCode)
    {
        case kVK_Return: return @"Return";
        case kVK_Tab: return @"Tab";
        case kVK_Space: return @"Space";
        case kVK_Delete: return @"Delete";
        case kVK_Escape: return @"Escape";
        case kVK_Command: return @"Command";
        case kVK_Shift: return @"Shift";
        case kVK_CapsLock: return @"CapsLock";
        case kVK_Option: return @"Option";
        case kVK_Control: return @"Control";
        case kVK_RightShift: return @"RightShift";
        case kVK_RightOption: return @"RightOption";
        case kVK_RightControl: return @"RightControl";
        case kVK_Function: return @"Function";
        case kVK_F17: return @"F17";
        case kVK_VolumeUp: return @"VolumeUp";
        case kVK_VolumeDown: return @"VolumeDown";
        case kVK_Mute: return @"Mute";
        case kVK_F18: return @"F18";
        case kVK_F19: return @"F19";
        case kVK_F20: return @"F20";
        case kVK_F5: return @"F5";
        case kVK_F6: return @"F6";
        case kVK_F7: return @"F7";
        case kVK_F3: return @"F3";
        case kVK_F8: return @"F8";
        case kVK_F9: return @"F9";
        case kVK_F11: return @"F11";
        case kVK_F13: return @"F13";
        case kVK_F16: return @"F16";
        case kVK_F14: return @"F14";
        case kVK_F10: return @"F10";
        case kVK_F12: return @"F12";
        case kVK_F15: return @"F15";
        case kVK_Help: return @"Help";
        case kVK_Home: return @"Home";
        case kVK_PageUp: return @"PageUp";
        case kVK_ForwardDelete: return @"ForwardDelete";
        case kVK_F4: return @"F4";
        case kVK_End: return @"End";
        case kVK_F2: return @"F2";
        case kVK_PageDown: return @"PageDown";
        case kVK_F1: return @"F1";
        case kVK_LeftArrow: return @"LeftArrow";
        case kVK_RightArrow: return @"RightArrow";
        case kVK_DownArrow: return @"DownArrow";
        case kVK_UpArrow: return @"UpArrow";
        case kVK_ANSI_Backslash: return @"Backslash";
        case kVK_ANSI_Comma: return @"Comma";
        case kVK_ANSI_Slash: return @"Slash";
        case kVK_ANSI_N: return @"N";
        case kVK_ANSI_M: return @"M";
        case kVK_ANSI_Period: return @"Period";
        case kVK_ANSI_Grave: return @"Grave";
        case kVK_ANSI_KeypadDecimal: return @"KeypadDecimal";
        case kVK_ANSI_KeypadMultiply: return @"KeypadMultiply";
        case kVK_ANSI_KeypadPlus: return @"KeypadPlus";
        case kVK_ANSI_KeypadClear: return @"KeypadClear";
        case kVK_ANSI_KeypadDivide: return @"KeypadDivide";
        case kVK_ANSI_KeypadEnter: return @"KeypadEnter";
        case kVK_ANSI_KeypadMinus: return @"KeypadMinus";
        case kVK_ANSI_KeypadEquals: return @"KeypadEquals";
        case kVK_ANSI_Keypad0: return @"Keypad0";
        case kVK_ANSI_Keypad1: return @"Keypad1";
        case kVK_ANSI_Keypad2: return @"Keypad2";
        case kVK_ANSI_Keypad3: return @"Keypad3";
        case kVK_ANSI_Keypad4: return @"Keypad4";
        case kVK_ANSI_Keypad5: return @"Keypad5";
        case kVK_ANSI_Keypad6: return @"Keypad6";
        case kVK_ANSI_Keypad7: return @"Keypad7";
        case kVK_ANSI_Keypad8: return @"Keypad8";
        case kVK_ANSI_Keypad9: return @"Keypad9";
        case kVK_JIS_Yen: return @"JIS_Yen";
        case kVK_JIS_Underscore: return @"JIS_Underscore";
        case kVK_JIS_KeypadComma: return @"JIS_KeypadComma";
        case kVK_ANSI_A: return @"A";
        case kVK_ANSI_S: return @"S";
        case kVK_ANSI_D: return @"D";
        case kVK_ANSI_F: return @"F";
        case kVK_ANSI_H: return @"H";
        case kVK_ANSI_G: return @"G";
        case kVK_ANSI_Z: return @"Z";
        case kVK_ANSI_X: return @"X";
        case kVK_ANSI_C: return @"C";
        case kVK_ANSI_V: return @"V";
        case kVK_ANSI_B: return @"B";
        case kVK_ANSI_Q: return @"Q";
        case kVK_ANSI_W: return @"W";
        case kVK_ANSI_E: return @"E";
        case kVK_ANSI_R: return @"R";
        case kVK_ANSI_Y: return @"Y";
        case kVK_ANSI_T: return @"T";
        case kVK_ANSI_1: return @"1";
        case kVK_ANSI_2: return @"2";
        case kVK_ANSI_3: return @"3";
        case kVK_ANSI_4: return @"4";
        case kVK_ANSI_6: return @"6";
        case kVK_ANSI_5: return @"5";
        case kVK_ANSI_Equal: return @"Equal";
        case kVK_ANSI_9: return @"9";
        case kVK_ANSI_7: return @"7";
        case kVK_ANSI_Minus: return @"Minus";
        case kVK_ANSI_8: return @"8";
        case kVK_ANSI_0: return @"0";
        case kVK_ANSI_RightBracket: return @"RightBracket";
        case kVK_ANSI_O: return @"O";
        case kVK_ANSI_U: return @"U";
        case kVK_ANSI_LeftBracket: return @"LeftBracket";
        case kVK_ANSI_I: return @"I";
        case kVK_ANSI_P: return @"P";
        case kVK_ANSI_L: return @"L";
        case kVK_ANSI_J: return @"J";
        case kVK_ANSI_Quote: return @"Quote";
        case kVK_ANSI_K: return @"K";
        case kVK_ANSI_Semicolon: return @"Semicolon";
        default : return @"Unkown";    
    }
}

@end
/*
"kVK_Return",                   
"kVK_Tab"    ,              
"kVK_Space"   ,            
"kVK_Delete"   ,           
"kVK_Escape"    ,          
"kVK_Command"    ,         
"kVK_Shift",        
"kVK_CapsLock",
"kVK_Option",          
"kVK_Control",             
"kVK_RightShift",          
"kVK_RightOption ",        
"kVK_RightControl  ",      
"kVK_RightOption     ",    
"kVK_RightControl      ",  
"kVK_Function            ",
"kVK_F17                 ",
"kVK_VolumeUp            ",
"kVK_VolumeDown          ",
"kVK_Mute                ",
"kVK_F18                 ",
"kVK_F19                 ",
"kVK_F20                 ",
"kVK_F5                  ",
"kVK_F6                  ",
"kVK_F7                  ",
"kVK_F3                  ",
"kVK_F8                  ",
"kVK_F9                  ",
"kVK_F11                 ",
"kVK_F13                 ",
"kVK_F16                 ",
"kVK_F14                 ",
"kVK_F10                 ",
"kVK_F12                 ",
"kVK_F15                 ",
"kVK_Help                ",
"kVK_Home                ",
"kVK_PageUp              ",
"kVK_ForwardDelete       ",
"kVK_F4                 ",
"kVK_End                ",
"kVK_F2                 ",
"kVK_PageDown           ",
"kVK_F1                 ",
"kVK_LeftArrow          ",
"kVK_RightArrow         ",
"kVK_DownArrow          ",
"kVK_UpArrow   ",

 "kVK_ANSI_Backslash",           
 "kVK_ANSI_Comma      ",         
 "kVK_ANSI_Slash        ",       
 "kVK_ANSI_N               ",    
 "kVK_ANSI_M                 ",  
 "kVK_ANSI_Period              ",
 "kVK_ANSI_Grave               ",
 "kVK_ANSI_KeypadDecimal       ",
 "kVK_ANSI_KeypadMultiply      ",
 "kVK_ANSI_KeypadPlus          ",
 "kVK_ANSI_KeypadClear         ",
 "kVK_ANSI_KeypadDivide        ",
 "kVK_ANSI_KeypadEnter         ",
 "kVK_ANSI_KeypadMinus         ",
 "kVK_ANSI_KeypadEquals        ",
 "kVK_ANSI_Keypad0             ",
 "kVK_ANSI_Keypad1             ",
 "kVK_ANSI_Keypad2             ",
 "kVK_ANSI_Keypad3             ",
 "kVK_ANSI_Keypad4             ",
 "kVK_ANSI_Keypad5             ",
 "kVK_ANSI_Keypad6             ",
 "kVK_ANSI_Keypad7             ",
 "kVK_ANSI_Keypad8             ",
 "kVK_ANSI_Keypad9             ",

 "kVK_JIS_Yen                  ",
 "kVK_JIS_Underscore           ",
 "kVK_JIS_KeypadComma          ",
 "kVK_RightOption              ",
 "kVK_RightControl             ",
 "kVK_Function                 ",
 "kVK_F17                      ",
 "kVK_VolumeUp                 ",
 "kVK_VolumeDown               ",
 "kVK_Mute                     ",
 "kVK_F18                      ",
 "kVK_F19                      ",
 "kVK_F20                      ",
 "kVK_F5                       ",
 "kVK_F6                       ",
 "kVK_F7                       ",
 "kVK_F3                       ",
 "kVK_F8                       ",
 "kVK_F9                       ",
 "kVK_F11                      ",
 "kVK_F13                      ",
 "kVK_F16                      ",
 "kVK_F14                      ",
 "kVK_F10                      ",
 "kVK_F12                      ",
 "kVK_F15                      ",
 "kVK_Help                     ",
 "kVK_Home                     ",
 "kVK_PageUp                   ",
 "kVK_ForwardDelete            ",
 "kVK_F4                       ",
 "kVK_End                      ",
 "kVK_F2                       ",
 "kVK_PageDown                 ",
 "kVK_F1                       ",
 "kVK_LeftArrow                ",
 "kVK_RightArrow               ",
 "kVK_DownArrow                ",
 "kVK_UpArrow                  ",

 "kVK_ANSI_Backslash           ",
 "kVK_ANSI_Comma               ",
 "kVK_ANSI_Slash               ",
 "kVK_ANSI_N                   ",
 "kVK_ANSI_M                   ",
 "kVK_ANSI_Period              ",
 "kVK_ANSI_Grave               ",
 "kVK_ANSI_KeypadDecimal       ",
 "kVK_ANSI_KeypadMultiply      ",
 "kVK_ANSI_KeypadPlus          ",
 "kVK_ANSI_KeypadClear         ",
 "kVK_ANSI_KeypadDivide        ",
 "kVK_ANSI_KeypadEnter         ",
 "kVK_ANSI_KeypadMinus         ",
 "kVK_ANSI_KeypadEquals        ",
 "kVK_ANSI_Keypad0             ",
 "kVK_ANSI_Keypad1             ",
 "kVK_ANSI_Keypad2             ",
 "kVK_ANSI_Keypad3             ",
 "kVK_ANSI_Keypad4             ",
 "kVK_ANSI_Keypad5             ",
 "kVK_ANSI_Keypad6             ",
 "kVK_ANSI_Keypad7             ",
 "kVK_ANSI_Keypad8             ",
 "kVK_ANSI_Keypad9             ",

 "kVK_ANSI_A                   ",
 "kVK_ANSI_S                   ",
 "kVK_ANSI_A                   ",
 "kVK_ANSI_S                   ",
 "kVK_ANSI_D                   ",
 "kVK_ANSI_F                   ",
 "kVK_ANSI_H                   ",
 "kVK_ANSI_G                   ",
 "kVK_ANSI_Z                   ",
 "kVK_ANSI_X                   ",
 "kVK_ANSI_C                   ",
 "kVK_ANSI_V                   ",
 "kVK_ANSI_B                   ",
 "kVK_ANSI_Q                   ",
 "kVK_ANSI_W                   ",
 "kVK_ANSI_E                   ",
 "kVK_ANSI_R                   ",
 "kVK_ANSI_Y                   ",
 "kVK_ANSI_T                   ",
 "kVK_ANSI_1                   ",
 "kVK_ANSI_2                   ",
 "kVK_ANSI_3                   ",
 "kVK_ANSI_4                   ",
 "kVK_ANSI_6                   ",
 "kVK_ANSI_5                   ",
 "kVK_ANSI_Equal               ",
 "kVK_ANSI_9                   ",
 "kVK_ANSI_7                   ",
 "kVK_ANSI_Minus               ",
 "kVK_ANSI_8                   ",
 "kVK_ANSI_0                   ",
 "kVK_ANSI_RightBracket        ",
 "kVK_ANSI_O                   ",
 "kVK_ANSI_U                   ",
 "kVK_ANSI_LeftBracket         ",
 "kVK_ANSI_I                   ",
 "kVK_ANSI_P                   ",
 "kVK_ANSI_L                   ",
 "kVK_ANSI_J                   ",
 "kVK_ANSI_Quote               ",
 "kVK_ANSI_K                   ",
 "kVK_ANSI_Semicolon           ",
 "kVK_ANSI_Backslash           ",
 "kVK_ANSI_Comma               ",
 "kVK_ANSI_Backslash           ",
 "kVK_ANSI_Comma               ",
 "kVK_ANSI_Slash               ",
 "kVK_ANSI_N                   ",
 "kVK_ANSI_M                   ",
 "kVK_ANSI_Period              ",
 "kVK_ANSI_Grave               ",
 "kVK_ANSI_KeypadDecimal       ",
 "kVK_ANSI_KeypadMultiply      ",
 "kVK_ANSI_KeypadPlus          ",
 "kVK_ANSI_KeypadClear         ",
 "kVK_ANSI_KeypadDivide        ",
 "kVK_ANSI_KeypadEnter         ",
 "kVK_ANSI_KeypadMinus         ",
 "kVK_ANSI_KeypadEquals        ",
 "kVK_ANSI_Keypad0             ",
 "kVK_ANSI_Keypad1             ",
 "kVK_ANSI_Keypad2             ",
 "kVK_ANSI_Keypad3             ",
 "kVK_ANSI_Keypad4             ",
 "kVK_ANSI_Keypad5             ",
 "kVK_ANSI_Keypad6             ",
 "kVK_ANSI_Keypad7             ",
 "kVK_ANSI_Keypad8             ",
 "kVK_ANSI_Keypad9             "*/