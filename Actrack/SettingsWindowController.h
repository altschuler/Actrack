//
//  SettingsWindowController.h
//  Activity Tracker
//
//  Created by zupa-sia on 18/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface SettingsWindowController : NSWindowController
{
    IBOutlet NSTextField* intervalTextField;
    IBOutlet NSTextField* archiveTimeTextField;
    IBOutlet NSView* view;
    
}

- (void)initUI:(NSTimer*)timer;
- (IBAction)saveButtonDidClick:(id)sender;
- (IBAction)cancelButtonDidClick:(id)sender;
- (void)initUI:(NSTimer *)timer;

@end
