//
//  QuestionWindowController.m
//  Actrack
//
//  Created by Simon Altschuler on 12/11/11.
//  
//

#import "QuestionWindowController.h"
#import "ActivityService.h"
#import "ActivityModel.h"
#import "NSButton+TextColor.h"

@implementation QuestionWindowController
@synthesize delegate;

static QuestionWindowController* activeWindowController;

- (id)init
{
    self = [super initWithWindowNibName:@"QuestionWindow"];
    if (self) 
    {
    }
    
    return self;
}

-(void)awakeFromNib
{
    [self setProjectIdSelection];
}

- (void)setProjectIdSelection;
{
    ActivityService* activityService = [[ActivityService alloc] init];
    
    if (projectIds != nil)
        [projectIds release];
    
    projectIds = [[NSMutableArray alloc] init];
    NSMutableArray* tempProjectIds = [activityService getDistinctProjectIds:YES];
    [projectIds addObjectsFromArray:tempProjectIds];
   
    [projectComboBox reloadData];
    
    [projectComboBox setStringValue:[activityService getLatestUsedProjectId]];
    
    [activityService release];
}

-(id)comboBox:(NSComboBox *)aComboBox objectValueForItemAtIndex:(NSInteger)index
{
    return [projectIds objectAtIndex:index];
    
    return nil;
}

-(NSInteger)numberOfItemsInComboBox:(NSComboBox *)comboBox
{
    return [projectIds count];
}

-(IBAction)submitButtonDidClick:(id)sender
{
    //TODO tell the user to put in some data
    if ([[projectComboBox stringValue] isEqualToString:@""] && ![isIdleCheckbox state])
        return;
    
    [self submitEntry];
}

/* Listen for key up to enable submitting by pressing return when inputs have focus */
-(void)keyUp:(NSEvent *)theEvent
{
    if ([theEvent keyCode] == 0x24) // 0x24 == RETURN
    {
        [self submitEntry];
    }  
}

- (void)submitEntry
{
    if ([[projectComboBox stringValue] isEqualToString:@""])
    {
        NSAlert* alert = [NSAlert alertWithMessageText:@"You must provide a project ID" defaultButton:@"OK" alternateButton:nil otherButton:nil informativeTextWithFormat:nil];
        [alert runModal];
        [alert release];
    }
    
    ActivityModel* am = [[ActivityModel alloc] init];
    am.comment = [commentTextField stringValue];
    am.projectId = [projectComboBox stringValue];
    am.timeStamp = [NSDate date];
    am.isIdle = [isIdleCheckbox state];
    
    if (am.isIdle)
    {
        am.projectId = @"";
    }
    
    ActivityService* activityService = [[ActivityService alloc] init];
    [activityService insertActivity:am];

    [activityService release];
    [am release];
    
    [self closeWindow];
}

- (IBAction)skipButtonDidClick:(id)sender 
{    
    [self closeWindow];
}

- (void)windowDidLoad
{
    [self.window setBackgroundColor:[NSColor colorWithPatternImage:[NSImage imageNamed:@"QuestionWindowBackgroundWithControls.png"]]];
    
    [super windowDidLoad];
}

+ (void)openWindowWithDelegate:(id<QuestionWindowDelegate>)del
{
    if (activeWindowController == nil)
    {
        activeWindowController = [[QuestionWindowController alloc] init];
        [activeWindowController setDelegate:del];
    }
    
    [NSApp activateIgnoringOtherApps:YES];    
    [activeWindowController showWindow:self];
    [[activeWindowController window] makeKeyAndOrderFront:nil];
    [NSApp arrangeInFront:[activeWindowController window]];
}

- (IBAction)isIdleCheckboxDidChange:(id)sender
{
    [projectComboBox setEnabled:![isIdleCheckbox state]];
}

-(void)showWindow:(id)sender
{
    [super showWindow:sender];
    [[self window] makeKeyWindow];
    [[self window] makeFirstResponder:projectComboBox];
}

- (void)closeWindow
{
    if ([notTodayCheckbox state] == NSOnState)
        [[activeWindowController delegate] pauseWasSelected];
    
    [self close];
    
    [activeWindowController release];
    activeWindowController = nil;
}

- (BOOL)windowShouldClose:(id)sender
{
    [self closeWindow];
    
    return NO;
}

@end
