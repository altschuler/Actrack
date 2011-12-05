//
//  SettingsWindowController.h
//  Activity Tracker
//
//  Created by zupa-sia on 18/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "AbstractWindowController.h"

@interface SettingsWindowController : AbstractWindowController <NSWindowDelegate>
{
    IBOutlet NSTextField* appVersionTextField;
    IBOutlet NSButton *autoStartCheckBox;
    IBOutlet NSSlider *intervalSlider;
    IBOutlet NSSlider *archiveTimeSlider;
    
    IBOutlet NSButton *askMon;
    IBOutlet NSButton *askTue;
    IBOutlet NSButton *askWed;
    IBOutlet NSButton *askThu;
    IBOutlet NSButton *askFri;
    IBOutlet NSButton *askSat;
    IBOutlet NSButton *askSun;
    
    IBOutlet NSSlider *allowedTimeKnobMin;
    IBOutlet NSSlider *allowedTimeKnobMax;
    
    IBOutlet NSTextField *selectedAskInterval;
    IBOutlet NSTextField *selectedArchiveTime;
    
    IBOutlet NSTextField *selectedTimeMin;
    IBOutlet NSTextField *selectedTimeMax;
}

- (IBAction)saveButtonDidClick:(id)sender;
- (IBAction)cancelButtonDidClick:(id)sender;
- (IBAction)sliderDidChange:(id)sender;

- (void)updateView;
- (void)initView;

- (NSInteger)askDayStatesToInt;

+ (void)openWindow;
- (void)closeWindow;

@end
