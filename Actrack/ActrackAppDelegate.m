//
//  Activity_TrackerAppDelegate.m
//  Activity Tracker
//
//  Created by zupa-sia on 05/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ActrackAppDelegate.h"
#import "Settings.h"
#import "DatabaseService.h"
#import "FormattingUtils.h"

@implementation ActrackAppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{   
    DatabaseService* databaseService = [[DatabaseService alloc] init];
    BOOL databaseIsValid = [databaseService validateDatabase];
    
    if (!databaseIsValid)
        [[NSAlert alertWithMessageText:@"Database is invalid" defaultButton:@"Damn" alternateButton:nil otherButton:nil informativeTextWithFormat:@"The database structure could not be verified"] runModal];
    
    [databaseService release];
    
    askingController = [[AskingController alloc] initWithDelegate:self];
    [askingController start:YES];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(settingsDidUpdate:) name:@"SettingsDidUpdate" object:nil];
    
    hotKeyController = [[HotKeyController alloc] initWithDelegate:self];
    [hotKeyController registerKeyFromSettings];
}

-(void)hotKeyActivated
{
    [self askNow];
}

- (void)settingsDidUpdate:(NSNotification *)notification
{
    [hotKeyController registerKeyFromSettings];
    [self updateTimerInfoMenuItem];
}

-(void)performScheduledTask
{
    [self askNow];
    [askingController start:YES];
}

-(void)awakeFromNib
{
       
    //Init status item
    statusItem = [[[NSStatusBar systemStatusBar] statusItemWithLength:NSSquareStatusItemLength] retain];
    [statusItem setMenu:statusMenu];
    [self setStatusItemImage:@"k"];
    [statusItem setHighlightMode:YES];
}

- (void)setStatusItemImage:(NSString*)imageId
{
    [statusItem setImage:[[NSImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForImageResource:@"Logo_normal.png"]]];
    [statusItem setAlternateImage:[[NSImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForImageResource:@"Logo_alternative.png"]]]; 
}

-(void)updateTimerInfoMenuItem
{
    if (![askingController askingIsAllowed])
    {
        [[statusMenu itemWithTag:5] setTitle:@"Wont ask right now"]; 
    }
    else if ([askingController isRunning])
    {
        [[statusMenu itemWithTag:5] setTitle:[FormattingUtils secondsToTimeString:[askingController remainingTime]]];
    }
    else
    {
        [[statusMenu itemWithTag:5] setTitle:@"Paused"]; 
    }
}

-(void)menuWillOpen:(NSMenu *)menu
{
    [self updateTimerInfoMenuItem];
}

-(void)askNow
{
    [self showWindow:0];
}

- (IBAction)menuItemDidClick:(NSMenuItem*)sender
{
    if (sender.tag == 1)
    {
        [askingController toggle];
        
        NSString* logoName;   
        if ([askingController isRunning])
        {
            logoName = @"Logo";
            [[statusMenu itemWithTag:1] setTitle:@"Pause asking"];
        }
        else
        {
            logoName = @"Logo_paused";
            [[statusMenu itemWithTag:1] setTitle:@"Resume asking"];
        }  
        
        [statusItem setImage:[[NSImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForImageResource:[logoName stringByAppendingString:@"_normal.png"]]]];
        [statusItem setAlternateImage:[[NSImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForImageResource:[logoName stringByAppendingString:@"_alternative.png"]]]];
    }
    else if (sender.tag == 4)
    {
        [NSApp terminate:nil];
    }
    else
    {
        [self showWindow:(int)sender.tag];
    }
}

-(void)showWindow:(int)windowId
{
    if (windowId == 0) //Ask now
        [QuestionWindowController openWindowWithDelegate:self];
    else if (windowId == 2) //Settings
        [SettingsWindowController openWindow];
    else if (windowId == 3) //Log
        [LogWindowController openWindow];
}

-(void)pauseWasSelected
{
    [askingController pause];
    
    [[statusMenu itemWithTag:1] setTitle:@"Resume asking"];
    
    [statusItem setImage:[[NSImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForImageResource:@"Logo_paused_normal.png"]]];
    [statusItem setAlternateImage:[[NSImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForImageResource:@"Logo_paused_alternative.png"]]];
}

- (void)dealloc
{
    [super dealloc];
}

@end
