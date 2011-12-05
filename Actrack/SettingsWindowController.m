//
//  SettingsWindowController.m
//  Activity Tracker
//
//  Created by zupa-sia on 18/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SettingsWindowController.h"
#import "Settings.h"
#import "LoginItem.h"

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
    
    [autoStartCheckBox setState:[LoginItem willStartAtLogin:[[NSBundle mainBundle] bundleURL]]];
    
    NSInteger timeMin = [[Settings getSetting:AllowedTimeMin] intValue];
    [allowedTimeKnobMin setIntegerValue:timeMin];
    
    NSInteger timeMax = [[Settings getSetting:AllowedTimeMax] intValue];
    [allowedTimeKnobMax setIntegerValue:timeMax];
}

//Updates labels
- (void)updateView
{
    //Update slider labels
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setMaximumFractionDigits:1];
    [formatter setRoundingMode: NSNumberFormatterRoundHalfEven];

    NSNumber* a = [NSNumber numberWithDouble:[intervalSlider doubleValue]];
    NSString* intervalLabel = [NSString stringWithFormat:@"%@ hours",[formatter stringForObjectValue:a]];
    [selectedAskInterval setStringValue:intervalLabel];
    [formatter release];
    
    NSString* archiveTimeLabel = [NSString stringWithFormat:@"%@ days",[archiveTimeSlider stringValue]];
    [selectedArchiveTime setStringValue:archiveTimeLabel];
    
    NSInteger askDays = [[Settings getSetting:DaysToAsk] intValue];
    [askSun setState:askDays & 1];
    [askSat setState:askDays & 2];
    [askFri setState:askDays & 4];
    [askThu setState:askDays & 8];
    [askWed setState:askDays & 16];
    [askTue setState:askDays & 32];
    [askMon setState:askDays & 64];

    [allowedTimeKnobMin setIntegerValue:MIN([allowedTimeKnobMin intValue], [allowedTimeKnobMax intValue])];
    
    NSString* timeMinLabel = [NSString stringWithFormat:@"%i",[allowedTimeKnobMin intValue]];
    [selectedTimeMin setStringValue:timeMinLabel];
    
    [allowedTimeKnobMax setIntegerValue:MAX([allowedTimeKnobMin intValue], [allowedTimeKnobMax intValue])];
    NSString* timeMaxLabel = [NSString stringWithFormat:@"%i",[allowedTimeKnobMax intValue]];
    [selectedTimeMax setStringValue:timeMaxLabel];
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
    [LoginItem setStartAtLogin:[[NSBundle mainBundle] bundleURL] enabled:[autoStartCheckBox state] == NSOnState];
            
    BOOL askIntervalSuccess = [Settings setSetting:AskInterval toValue:[[NSNumber numberWithInt:([intervalSlider doubleValue])*3600] stringValue]];
    BOOL archiveTimeSuccess = [Settings setSetting:ArchiveTime toValue:[archiveTimeSlider stringValue]];
    BOOL daysToAskSuccess = [Settings setSetting:DaysToAsk toValue:[NSString stringWithFormat:@"%i",[self askDayStatesToInt]]];
    BOOL allowedTimeMinSuccess = [Settings setSetting:AllowedTimeMin toValue:[NSString stringWithFormat:@"%i",[allowedTimeKnobMin intValue]]];
    BOOL allowedTimeMaxSuccess = [Settings setSetting:AllowedTimeMax toValue:[NSString stringWithFormat:@"%i",[allowedTimeKnobMax intValue]]];
    
    if (askIntervalSuccess && archiveTimeSuccess && daysToAskSuccess && allowedTimeMinSuccess && allowedTimeMaxSuccess)
        [self closeWindow];
    else
        NSLog(@"Error saving settings.");
}

+(void)openWindow
{
    if (activeWindowController == nil)
        activeWindowController = [[SettingsWindowController alloc] init];
    
    [activeWindowController showWindow:self];
    [NSApp arrangeInFront:activeWindowController.window];
    [activeWindowController.window makeKeyAndOrderFront:nil];
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
