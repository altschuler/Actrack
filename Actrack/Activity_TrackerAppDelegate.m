//
//  Activity_TrackerAppDelegate.m
//  Activity Tracker
//
//  Created by zupa-sia on 05/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Activity_TrackerAppDelegate.h"
#import "Settings.h"

@implementation Activity_TrackerAppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{   
    scheduler = [[ScheduleController alloc] initWithDelegate:self];
    
    [scheduler start:YES];
}

-(void)performScheduledTask
{
    [self askNow];
    [scheduler start:YES];
}

-(void)awakeFromNib
{
    //Init status item
    statusItem = [[[NSStatusBar systemStatusBar] statusItemWithLength:NSSquareStatusItemLength] retain];
    
    [statusItem setMenu:statusMenu];
    [statusItem setImage:[[NSImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForImageResource:@"Logo_normal.png"]]];
    [statusItem setAlternateImage:[[NSImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForImageResource:@"Logo_alternative.png"]]];
    
    [statusItem setHighlightMode:YES];
}

- (void)updateTimerInfoMenuItem
{
    
    if ([scheduler isRunning])
    {
        int sec = [scheduler remainingTime] % 60;
        int min = (([scheduler remainingTime] - sec) / 60) % 60;
        int hour = ([scheduler remainingTime] - ([scheduler remainingTime] % 3600)) / 3600;
        
        NSString* timeLabel = @"Will ask in ";
        if (hour > 0)
            timeLabel = [timeLabel stringByAppendingFormat:@"%ih",hour];
        
        if (min > 0 || hour != 0)
            timeLabel = [timeLabel stringByAppendingFormat:@"%im",min];
        
        timeLabel = [timeLabel stringByAppendingFormat:@"%is",sec];
        
        
        [[statusMenu itemWithTag:5] setTitle:timeLabel];
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
        [scheduler toggle];
        
        NSString* logoName;   
        if ([scheduler isRunning])
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
    NSWindowController* relatedWindowController;
    
    if (windowId == 0) //Ask now
    {
        relatedWindowController = [[QuestionWindowController alloc] init];
    }
    else if (windowId == 2) //Settings
    {
        relatedWindowController = [[SettingsWindowController alloc] init];
    }
    else if (windowId == 3) //Log
    {
        relatedWindowController = [[LogWindowController alloc] init];
    }
    else if (windowId == 4) //Quit
    {
        relatedWindowController = [[QuitWindowController alloc] init];
    }
    
    [relatedWindowController showWindow:self];
    [NSApp arrangeInFront:relatedWindowController.window];
    [relatedWindowController.window makeKeyAndOrderFront:nil];
}

- (void)dealloc
{
    [super dealloc];
}

@end
