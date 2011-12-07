//
//  Activity_TrackerAppDelegate.h
//  Activity Tracker
//
//  Created by zupa-sia on 05/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "QuestionWindowController.h"
#import "LogWindowController.h"
#import "SettingsWindowController.h"
#import "AskingController.h"
#import "QuestionWindowDelegate.h"
#import "Carbon/Carbon.h"

@interface ActrackAppDelegate : NSObject <NSApplicationDelegate, NSMenuDelegate, AskingControllerDelegate, QuestionWindowDelegate> 
{
    IBOutlet NSMenu* statusMenu;
    NSStatusItem* statusItem;
    AskingController* askingController;
}

@property (assign) IBOutlet NSWindow *window;

- (IBAction)menuItemDidClick:(NSMenuItem*)sender;
- (void)askNow;
- (void)showWindow:(int)windowId;
- (void)updateTimerInfoMenuItem;
- (void)settingsDidUpdate:(NSNotification *)notification;
- (void)setStatusItemImage:(NSString*)imageId;

OSStatus myHotKeyHandler(EventHandlerCallRef nextHandler, EventRef anEvent, void *userData);

@end
