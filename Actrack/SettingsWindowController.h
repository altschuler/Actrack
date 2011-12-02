//
//  SettingsWindowController.h
//  Activity Tracker
//
//  Created by zupa-sia on 18/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "AbstractWindowController.h"

@interface SettingsWindowController : AbstractWindowController
{
    IBOutlet NSTextField* intervalTextField;
    IBOutlet NSTextField* archiveTimeTextField;
    IBOutlet NSView* view;
    IBOutlet NSButton *autoStartCheckBox;
}

- (void)initUI:(NSTimer*)timer;
- (IBAction)saveButtonDidClick:(id)sender;
- (IBAction)cancelButtonDidClick:(id)sender;
- (void)initUI:(NSTimer *)timer;

+ (void)openWindow;
- (void)closeWindow;

@end
