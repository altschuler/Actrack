//
//  SettingsWindowController.m
//  Actrack
//
//  Created by Simon Altschuler on 18/11/11.
//  
//

#import "SettingsWindowController.h"
#import "SettingService.h"
#import "LoginItemManager.h"
#import "FormattingUtils.h"

@implementation SettingsWindowController

static SettingsWindowController* activeWindowController;

- (id)init
{
    self = [super initWithWindowNibName:@"SettingsWindow"];
    if (self)
    {


    }
    
    return self;
}

-(void)awakeFromNib
{
    [self initView];
    [self updateView];
}

- (IBAction)cancelButtonDidClick:(id)sender
{
    [self closeWindow];
}

-(void)initView
{
    //Update ui states
    double askinterval = [[SettingService getSetting:AskInterval] doubleValue]/3600;
    [intervalSlider setDoubleValue:askinterval];
    
    NSInteger archiveTime = [[SettingService getSetting:ArchiveTime] intValue];
    [archiveTimeSlider setIntegerValue:archiveTime];
    
    [autoStartCheckBox setState:[LoginItemManager willStartAtLogin:[[NSBundle mainBundle] bundleURL]]];
    
    NSInteger timeMin = [[SettingService getSetting:AllowedTimeMin] intValue];
    [allowedTimeKnobMin setIntegerValue:timeMin];
    
    NSInteger timeMax = [[SettingService getSetting:AllowedTimeMax] intValue];
    [allowedTimeKnobMax setIntegerValue:timeMax];
    
    NSInteger askDays = [[SettingService getSetting:DaysToAsk] intValue];
    [askSun setState:askDays & 1];
    [askSat setState:askDays & 2];
    [askFri setState:askDays & 4];
    [askThu setState:askDays & 8];
    [askWed setState:askDays & 16];
    [askTue setState:askDays & 32];
    [askMon setState:askDays & 64];
    
    NSString* hotkey = [SettingService getSetting:HotKey];
    if (![hotkey isEqualToString:@"none"]) // kill magic string!
    {
        [hotkeyCheckbox setState:NSOnState];
        [hotkeyTextField setSelectedKeyCode:[hotkey intValue]];
    }
    else
        [hotkeyCheckbox setState:NSOffState];
}

//Updates dependant ui (labels, enabled, etc)
- (void)updateView
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setMaximumFractionDigits:1];
    [formatter setRoundingMode: NSNumberFormatterRoundHalfEven];

    [selectedAskInterval setStringValue:[NSString stringWithFormat:@"%@ hours",[formatter stringForObjectValue:[NSNumber numberWithDouble:[intervalSlider doubleValue]]]]];
    
    [formatter release];
    
    [selectedArchiveTime setStringValue:[NSString stringWithFormat:@"%@ days",[archiveTimeSlider stringValue]]];
    
    [allowedTimeKnobMin setIntegerValue:MIN([allowedTimeKnobMin intValue], [allowedTimeKnobMax intValue])];
    [selectedTimeMin setStringValue:[NSString stringWithFormat:@"%@",[FormattingUtils secondsToClockString:[allowedTimeKnobMin intValue] * 3600]]];
    
    [allowedTimeKnobMax setIntegerValue:MAX([allowedTimeKnobMin intValue], [allowedTimeKnobMax intValue])];
    [selectedTimeMax setStringValue:[NSString stringWithFormat:@"%@",[FormattingUtils secondsToClockString:[allowedTimeKnobMax intValue] * 3600]]];
    
    BOOL enabled = [hotkeyCheckbox state] == NSOnState;
    [hotkeyLabel setTextColor:enabled ? [NSColor blackColor] : [NSColor disabledControlTextColor]];
    [hotkeyTextField setEnabled:enabled];
}

- (IBAction)hotkeyCheckBoxDidClick:(id)sender 
{
    [self updateView];
}

- (IBAction)sliderDidChange:(id)sender
{
    [self updateView];
}

- (NSInteger)askDayStatesToInt
{
    NSInteger askDays = [askSun state] + ([askSat state] << 1) + ([askFri state] << 2) + ([askThu state] << 3) + ([askWed state] << 4) + ([askTue state] << 5) + ([askMon state] << 6); 
    return askDays;
}

-(IBAction)saveButtonDidClick:(id)sender
{
    [LoginItemManager setStartAtLogin:[[NSBundle mainBundle] bundleURL] enabled:[autoStartCheckBox state] == NSOnState];
            
    BOOL askIntervalSuccess = [SettingService setSetting:AskInterval toValue:[[NSNumber numberWithInt:([intervalSlider doubleValue])*3600] stringValue]];
    BOOL archiveTimeSuccess = [SettingService setSetting:ArchiveTime toValue:[archiveTimeSlider stringValue]];
    BOOL daysToAskSuccess = [SettingService setSetting:DaysToAsk toValue:[NSString stringWithFormat:@"%i",[self askDayStatesToInt]]];
    BOOL allowedTimeMinSuccess = [SettingService setSetting:AllowedTimeMin toValue:[NSString stringWithFormat:@"%i",[allowedTimeKnobMin intValue]]];
    BOOL allowedTimeMaxSuccess = [SettingService setSetting:AllowedTimeMax toValue:[NSString stringWithFormat:@"%i",[allowedTimeKnobMax intValue]]];
    
    NSString* hotKeySetting;
    if ([hotkeyCheckbox state] == NSOffState)
        hotKeySetting = @"none";
    else
        hotKeySetting = [NSString stringWithFormat:@"%i",[hotkeyTextField selectedKeyCode]];
    
    BOOL hotKeySuccess = [SettingService setSetting:HotKey toValue:hotKeySetting];
    
    
    if (askIntervalSuccess && archiveTimeSuccess && daysToAskSuccess && allowedTimeMinSuccess && allowedTimeMaxSuccess & hotKeySuccess)
        [self closeWindow];
    else
        NSLog(@"Error saving settings.");
}

- (IBAction)aboutButtonDidClick:(id)sender
{
    NSAlert *theAlert = [NSAlert alertWithMessageText:@"Actrack v0.9.2b" defaultButton:@"Great" alternateButton:nil otherButton:nil informativeTextWithFormat:@"Actrack is developed and maintained by Simon Altschuler (simon@altschuler.dk). Any feedback is greatly appreciated!\n\nActrack is open sourced via GitHub: https://github.com/altschuler/Actrack"];

    [theAlert runModal];
}

+(void)openWindow
{
    if (activeWindowController == nil)
        activeWindowController = [[SettingsWindowController alloc] init];
    
    [activeWindowController showWindow:self];
    [NSApp activateIgnoringOtherApps:YES];
    [activeWindowController.window makeKeyAndOrderFront:nil];
}

-(void)showWindow:(id)sender
{
    [[self window] makeFirstResponder:intervalSlider];
    
    [super showWindow:sender];
}


-(void)closeWindow
{
    [self close];
    
    [activeWindowController release];
    activeWindowController = nil;
}

-(BOOL)windowShouldClose:(id)sender
{
    [self closeWindow];
    
    return NO;
}

@end
