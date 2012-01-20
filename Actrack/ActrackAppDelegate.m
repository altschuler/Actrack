//
//  ActrackAppDelegate.m
//  Actrack
//
//  Created by Simon Altschuler on 05/11/11.
//  
//

#import "ActrackAppDelegate.h"
#import "SettingService.h"
#import "ActivityService.h"
#import "FormattingUtils.h"

@implementation ActrackAppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{   
    //Validate the database structure
    ActivityService* databaseService = [[ActivityService alloc] init];
    BOOL databaseIsValid = [databaseService validateDatabase];
    
    if (!databaseIsValid)
        [[NSAlert alertWithMessageText:@"Database is invalid" defaultButton:@"Damn" alternateButton:nil otherButton:nil informativeTextWithFormat:@"The database structure could not be verified. It is recommended to install a fresh copy of Actrack."] runModal];
    [databaseService release];
    
    //Init asking controller
    askingController = [[AskingManager alloc] initWithDelegate:self];
    
    //Setup event handling
    //Local events
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(settingsDidUpdate:) name:@"SettingsDidUpdate" object:nil];
    
    //System events
    NSNotificationCenter* workspaceNotificationCenter = [[[NSWorkspace alloc] init] notificationCenter];
    [workspaceNotificationCenter addObserver:self selector:@selector(systemWillSleep) name:NSWorkspaceWillSleepNotification object:nil];
    [workspaceNotificationCenter addObserver:self selector:@selector(systemDidWake) name:NSWorkspaceDidWakeNotification object:nil];
    
    //Register the hot key (if applicable)
    hotKeyController = [[HotKeyManager alloc] initWithDelegate:self];
    [hotKeyController registerKeyFromSettings];
    
    //Start asking in the specified interval
    [askingController start:YES];
}

- (void)systemWillSleep
{
    [askingController handleSystemWillSleep];
}

- (void)systemDidWake
{
    [askingController handleSystemDidWake];
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
        [[statusMenu itemWithTag:5] setTitle:[NSString stringWithFormat:@"Will ask in %@", [FormattingUtils secondsToTimeString:[askingController remainingTime] delimiter:@":"]]];
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
    if (sender.tag == 1) // pause
    {
        [askingController toggle];
        
        [self updateStatusItem];
    }
    else if (sender.tag == 4) // quit
    {
        [NSApp terminate:nil];
    }
    else
    {
        [self showWindow:(int)sender.tag];
    }
}

- (void)updateStatusItem
{ 
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

-(void)showWindow:(int)windowId
{
    if (windowId == 0) // ask now
        [QuestionWindowController openWindowWithDelegate:self];
    else if (windowId == 2) // settings
        [SettingsWindowController openWindow];
    else if (windowId == 3) // log
        [LogWindowController openWindow];
}

-(void)pauseWasSelected
{
    [askingController pause];
    
    [self updateStatusItem];
}

- (void)dealloc
{
    [super dealloc];
}

@end
