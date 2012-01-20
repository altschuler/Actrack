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
#import "AskingManager.h"
#import "QuestionWindowDelegate.h"
#import "HotKeyManager.h"

@interface ActrackAppDelegate : NSObject <NSApplicationDelegate, NSMenuDelegate, AskingManagerDelegate, QuestionWindowDelegate, HotKeyManagerDelegate> 
{
    IBOutlet NSMenu* statusMenu;
    NSStatusItem* statusItem;
    AskingManager* askingController;
    HotKeyManager* hotKeyController;
}

@property (assign) IBOutlet NSWindow *window;

- (IBAction)menuItemDidClick:(NSMenuItem*)sender;
- (void)askNow;
- (void)showWindow:(int)windowId;
- (void)updateTimerInfoMenuItem;

- (void)systemWillSleep;
- (void)systemDidWake;

- (void)updateStatusItem;

- (void)settingsDidUpdate:(NSNotification *)notification;
- (void)setStatusItemImage:(NSString*)imageId;


@end
