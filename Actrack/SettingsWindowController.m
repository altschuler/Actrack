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
        [NSTimer scheduledTimerWithTimeInterval:.1 target:self selector:@selector(initUI:) userInfo:nil repeats:NO];
    }
    
    return self;
}

- (IBAction)cancelButtonDidClick:(id)sender
{
    [self closeWindow];
}

-(void)initUI:(NSTimer *)timer
{
    [intervalTextField setStringValue:[NSString stringWithFormat:@"%@",[Settings getSetting:AskInterval]]];
    [archiveTimeTextField setStringValue:[NSString stringWithFormat:@"%@",[Settings getSetting:ArchiveTime]]];
    [autoStartCheckBox setState:[LoginItem willStartAtLogin:[[NSBundle mainBundle] bundleURL]]];
}

-(IBAction)saveButtonDidClick:(id)sender
{
    [LoginItem setStartAtLogin:[[NSBundle mainBundle] bundleURL] enabled:[autoStartCheckBox state] == NSOnState];
    
    BOOL success = YES;
    
    success = success ? [Settings setSetting:AskInterval toValue:[intervalTextField stringValue]] : success;
    success = success ? [Settings setSetting:ArchiveTime toValue:[archiveTimeTextField stringValue]] : success;
    
    if (success)
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
    //since activeWindowController and self is the same, close first then kill
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
