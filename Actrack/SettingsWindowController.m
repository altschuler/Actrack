//
//  SettingsWindowController.m
//  Activity Tracker
//
//  Created by zupa-sia on 18/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SettingsWindowController.h"
#import "Settings.h"
#import "LoginItemManager.h"

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
    double askinterval = [[Settings getSetting:AskInterval] doubleValue]/3600;
    [intervalSlider setDoubleValue:askinterval];
    
    NSInteger archiveTime = [[Settings getSetting:ArchiveTime] intValue];
    [archiveTimeSlider setIntegerValue:archiveTime];
    
    [autoStartCheckBox setState:[LoginItemManager willStartAtLogin:[[NSBundle mainBundle] bundleURL]]];
    
    NSInteger timeMin = [[Settings getSetting:AllowedTimeMin] intValue];
    [allowedTimeKnobMin setIntegerValue:timeMin];
    
    NSInteger timeMax = [[Settings getSetting:AllowedTimeMax] intValue];
    [allowedTimeKnobMax setIntegerValue:timeMax];
    
    NSInteger askDays = [[Settings getSetting:DaysToAsk] intValue];
    [askSun setState:askDays & 1];
    [askSat setState:askDays & 2];
    [askFri setState:askDays & 4];
    [askThu setState:askDays & 8];
    [askWed setState:askDays & 16];
    [askTue setState:askDays & 32];
    [askMon setState:askDays & 64];
    
    NSString* hotkey = [Settings getSetting:HotKey];
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

    NSNumber* a = [NSNumber numberWithDouble:[intervalSlider doubleValue]];
    NSString* intervalLabel = [NSString stringWithFormat:@"%@ hours",[formatter stringForObjectValue:a]];
    [selectedAskInterval setStringValue:intervalLabel];
    [formatter release];
    
    NSString* archiveTimeLabel = [NSString stringWithFormat:@"%@ days",[archiveTimeSlider stringValue]];
    [selectedArchiveTime setStringValue:archiveTimeLabel];
    

    [allowedTimeKnobMin setIntegerValue:MIN([allowedTimeKnobMin intValue], [allowedTimeKnobMax intValue])];
    
    NSString* timeMinLabel = [NSString stringWithFormat:@"%i",[allowedTimeKnobMin intValue]];
    [selectedTimeMin setStringValue:timeMinLabel];
    
    [allowedTimeKnobMax setIntegerValue:MAX([allowedTimeKnobMin intValue], [allowedTimeKnobMax intValue])];
    NSString* timeMaxLabel = [NSString stringWithFormat:@"%i",[allowedTimeKnobMax intValue]];
    [selectedTimeMax setStringValue:timeMaxLabel];
    
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
            
    BOOL askIntervalSuccess = [Settings setSetting:AskInterval toValue:[[NSNumber numberWithInt:([intervalSlider doubleValue])*3600] stringValue]];
    BOOL archiveTimeSuccess = [Settings setSetting:ArchiveTime toValue:[archiveTimeSlider stringValue]];
    BOOL daysToAskSuccess = [Settings setSetting:DaysToAsk toValue:[NSString stringWithFormat:@"%i",[self askDayStatesToInt]]];
    BOOL allowedTimeMinSuccess = [Settings setSetting:AllowedTimeMin toValue:[NSString stringWithFormat:@"%i",[allowedTimeKnobMin intValue]]];
    BOOL allowedTimeMaxSuccess = [Settings setSetting:AllowedTimeMax toValue:[NSString stringWithFormat:@"%i",[allowedTimeKnobMax intValue]]];
    
    NSString* hotKeySetting;
    if ([hotkeyCheckbox state] == NSOffState)
        hotKeySetting = @"'none'"; //THIS IS A MAJOR FUCKING HACK!
    else
        hotKeySetting = [NSString stringWithFormat:@"%i",[hotkeyTextField selectedKeyCode]];
    
    BOOL hotKeySuccess = [Settings setSetting:HotKey toValue:hotKeySetting];
    
    
    if (askIntervalSuccess && archiveTimeSuccess && daysToAskSuccess && allowedTimeMinSuccess && allowedTimeMaxSuccess & hotKeySuccess)
        [self closeWindow];
    else
        NSLog(@"Error saving settings.");
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
