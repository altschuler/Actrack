//
//  ActrackAppDelegate.h
//  Actrack
//
//  Created by Simon Altschuler on 05/11/11.
//  
//

#import <Cocoa/Cocoa.h>
#import "QuestionWindowController.h"
#import "LogWindowController.h"
#import "SettingsWindowController.h"
#import "AskingController.h"
#import "QuestionWindowDelegate.h"
#import "HotKeyController.h"

@interface ActrackAppDelegate : NSObject <NSApplicationDelegate, NSMenuDelegate, AskingControllerDelegate, QuestionWindowDelegate, HotKeyControllerDelegate> 
{
    IBOutlet NSMenu* statusMenu;
    NSStatusItem* statusItem;
    AskingController* askingController;
    HotKeyController* hotKeyController;
}

@property (assign) IBOutlet NSWindow *window;

- (IBAction)menuItemDidClick:(NSMenuItem*)sender;
- (void)askNow;
- (void)showWindow:(int)windowId;
- (void)updateTimerInfoMenuItem;
- (void)systemWillSleep;
- (void)systemDidWake;
- (void)settingsDidUpdate:(NSNotification *)notification;
- (void)setStatusItemImage:(NSString*)imageId;


@end
