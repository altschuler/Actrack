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
    ActivityService* dbman = [[[ActivityService alloc] init] autorelease];
    
    projectIds = [dbman getDistinctProjectIds:YES];    
    [projectComboBox reloadData];
    
    [projectComboBox setStringValue:[dbman getLatestUsedProjectId]];
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
    ActivityModel* am = [[ActivityModel alloc] init];
    am.comment = [commentTextField stringValue];
    am.projectId = [projectComboBox stringValue];
    am.timeStamp = [NSDate date];
    
    ActivityService* dbman = [[ActivityService alloc] init];
    [dbman insertActivity:am];
    
    [self closeWindow];
}

- (IBAction)skipButtonDidClick:(id)sender 
{    
    [self closeWindow];
}

- (void)windowDidLoad
{
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
