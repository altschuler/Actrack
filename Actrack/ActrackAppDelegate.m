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
    
//    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
//    BOOL isReturningUser = [defaults boolForKey:@"isReturningUser"];
//    if (!isReturningUser)
//    {
//        NSLog(@"Firstimer");
//        [defaults setBool:YES forKey:@"isReturningUser"];
//    }
    
    
}
- (void)settingsDidUpdate:(NSNotification *)notification
{
    [self updateTimerInfoMenuItem];
}

-(void)performScheduledTask
{
    [self askNow];
    [askingController start:YES];
}

-(void)awakeFromNib
{
    //Register global hotkey. This must be moved elsewhere!
    EventHotKeyRef myHotKeyRef;     
    EventHotKeyID myHotKeyID;     
    EventTypeSpec eventType;
    eventType.eventClass=kEventClassKeyboard;     
    eventType.eventKind=kEventHotKeyPressed;
    
    InstallApplicationEventHandler(&myHotKeyHandler,1,&eventType,(void*)self,NULL);
    
    myHotKeyID.signature='mhk1';     
    myHotKeyID.id=1;
    
    RegisterEventHotKey(kVK_RightArrow, cmdKey+optionKey, myHotKeyID, GetApplicationEventTarget(), 0, &myHotKeyRef);
    
    //Init status item
    statusItem = [[[NSStatusBar systemStatusBar] statusItemWithLength:NSSquareStatusItemLength] retain];
    [statusItem setMenu:statusMenu];
    [self setStatusItemImage:@"k"];
    [statusItem setHighlightMode:YES];
}

OSStatus myHotKeyHandler(EventHandlerCallRef nextHandler, EventRef anEvent, void *userData) 
{         
    ActrackAppDelegate* selfRef = (ActrackAppDelegate*)userData;
    [selfRef askNow];
    return noErr; 
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
