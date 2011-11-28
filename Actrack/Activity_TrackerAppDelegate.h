//
//  Activity_TrackerAppDelegate.h
//  Activity Tracker
//
//  Created by zupa-sia on 05/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "QuitWindowController.h"
#import "QuestionWindowController.h"
#import "LogWindowController.h"
#import "SettingsWindowController.h"
#import "ScheduleController.h"

@interface Activity_TrackerAppDelegate : NSObject <NSApplicationDelegate, NSMenuDelegate, ScheduleControllerDelegate> 
{
    QuitWindowController* quitWindowController;
    QuestionWindowController* questionWindowController;
    
    IBOutlet NSMenu* statusMenu;
    NSStatusItem* statusItem;
    ScheduleController* scheduler;
}

@property (assign) IBOutlet NSWindow *window;

- (IBAction)menuItemDidClick:(NSMenuItem*)sender;
- (void)askNow;
- (void)showWindow:(int)windowId;
- (void)updateTimerInfoMenuItem;

@end
