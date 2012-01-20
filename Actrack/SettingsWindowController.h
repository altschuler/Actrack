//
//  SettingsWindowController.h
//  Actrack
//
//  Created by Simon Altschuler on 18/11/11.
//  
//

#import <Cocoa/Cocoa.h>
#import "HotKeyTextField.h"

@interface SettingsWindowController : NSWindowController <NSWindowDelegate, NSTextFieldDelegate>
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
    
    IBOutlet NSButton *hotkeyCheckbox;
    IBOutlet HotKeyTextField *hotkeyTextField;
    IBOutlet NSTextField *hotkeyLabel;
    
    IBOutlet NSView *aboutButton;
    
    int hotkeyValue;
}

- (IBAction)hotkeyCheckBoxDidClick:(id)sender;
- (IBAction)saveButtonDidClick:(id)sender;
- (IBAction)cancelButtonDidClick:(id)sender;
- (IBAction)aboutButtonDidClick:(id)sender;
- (IBAction)sliderDidChange:(id)sender;

- (void)updateView;
- (void)initView;

- (NSInteger)askDayStatesToInt;

+ (void)openWindow;
- (void)closeWindow;

@end
