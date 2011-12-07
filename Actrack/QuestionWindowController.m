//
//  QuestionWindowController.m
//  Activity Tracker
//
//  Created by zupa-sia on 12/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "QuestionWindowController.h"
#import "DatabaseService.h"
#import "ActivityModel.h"

@implementation QuestionWindowController
@synthesize delegate;

static QuestionWindowController* activeWindowController;

- (id)init
{
    self = [super initWithWindowNibName:@"QuestionWindow"];
    if (self) 
    {
        DatabaseService* dbman = [[[DatabaseService alloc] init] autorelease];
        
        NSString* query = @"select *,rowid from acts where archived = 0";
        
        NSMutableArray* templogs =  [dbman getActsForQuery:query];    
        
        projectIds = [[NSMutableArray alloc] init];
        
        lastAct = [templogs objectAtIndex:0];
        
        for (ActivityModel* act in templogs) 
        {
            if (![projectIds containsObject:act.projectId])
                [projectIds addObject:act.projectId];
            
            if (act.actId > lastAct.actId)
                lastAct = act;
        }
        
        [projectComboBox selectItemAtIndex:[projectIds count]-1];
        [projectComboBox reloadData];
    }
    
    return self;
}

-(void)awakeFromNib
{
    //set current project to the last detected one (assuming this is the latest) -2 because theres a blank entry (to be fixed)
    [projectComboBox selectItemAtIndex:[projectComboBox numberOfItems]-2];
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
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    am.timeStamp = [formatter stringFromDate:[NSDate date]];
    
    DatabaseService* dbman = [[DatabaseService alloc] init];
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
