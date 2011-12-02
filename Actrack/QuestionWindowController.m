//
//  QuestionWindowController.m
//  Activity Tracker
//
//  Created by zupa-sia on 12/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "QuestionWindowController.h"
#import "DBManager.h"
#import "ActivityModel.h"

@implementation QuestionWindowController

static QuestionWindowController* activeWindowController;

- (id)init
{
    self = [super initWithWindowNibName:@"QuestionWindow"];
    if (self) 
    {
        // Initialization code here.
    }
    
    return self;
}

-(IBAction)submitButtonDidClick:(id)sender
{
    [self submitEntry];
}

-(void)keyUp:(NSEvent *)theEvent
{
    if ([theEvent keyCode] == 0x24)
    {
        [self submitEntry];
    }
        
}

- (void)submitEntry
{
    ActivityModel* am = [[ActivityModel alloc] init];
    am.comment = [commentTextField stringValue];
    am.projectId = [projectTextField stringValue];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    am.timeStamp = [formatter stringFromDate:[NSDate date]];
    
    DBManager* dbman = [[DBManager alloc] init];
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

+(void)openWindow
{
    if (activeWindowController == nil)
        activeWindowController = [[QuestionWindowController alloc] init];
    
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
