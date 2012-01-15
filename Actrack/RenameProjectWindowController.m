//
//  RenameProjectWindowController.m
//  Actrack
//
//  Created by Simon Altschuler on 12/01/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "RenameProjectWindowController.h"
#import "ActivityService.h"

@implementation RenameProjectWindowController

@synthesize delegate;

static RenameProjectWindowController* activeWindowController;

- (id) init
{
    self = [super initWithWindowNibName:@"RenameProjectWindow"];
    if (self)
    {
        
    }
    return self;
}

-(void)awakeFromNib
{
    ActivityService* activityService = [[ActivityService alloc] init];
    
    projectIds = [[NSMutableArray alloc] init];
    [projectIds addObjectsFromArray:[activityService getDistinctProjectIds:YES]];
    [projectToRenameComboBox reloadData];
}

-(id)comboBox:(NSComboBox *)aComboBox objectValueForItemAtIndex:(NSInteger)index
{
    return [projectIds objectAtIndex:index];
    
    return nil;
}

-(NSInteger)numberOfItemsInComboBox:(NSComboBox *)aComboBox
{
    return [projectIds count];
}

+ (void)openWindowWithDelegate:(id<RenameProjectWindowControllerDelegate>)del
{
    if (activeWindowController == nil)
    {
        activeWindowController = [[RenameProjectWindowController alloc] init];
        [activeWindowController setDelegate:del];
    }
    
    [activeWindowController showWindow:self];
    [NSApp arrangeInFront:activeWindowController.window];
    [NSApp activateIgnoringOtherApps:YES];
    [activeWindowController.window makeKeyAndOrderFront:nil];
}

-(void)closeWindow
{
    //since activeWindowController and self is the same, close first then kill
    [self close];
    
    [activeWindowController release];
    activeWindowController = nil;
}


- (IBAction)renameButtonDidClick:(id)sender
{
    ActivityService* activityService = [[ActivityService alloc] init];
    
    if ([[projectToRenameComboBox stringValue] isNotEqualTo:@""] && [[newNameTextfield stringValue] isNotEqualTo:@""])
    {
        BOOL success = [activityService renameProject:[projectToRenameComboBox stringValue] toName:[newNameTextfield stringValue]];
        if (!success)
        {
            NSAlert *alert = [[NSAlert alloc] init];
            [alert setMessageText:@"Rename project error"];
            [alert setInformativeText:@"Error 10: Error occured while renaming project"];
            
            [alert release];
            alert = nil;
        }
        
        [self.delegate didRenameProject];
        [self closeWindow];
    }
}

- (IBAction)cancelButtonDidClick:(id)sender
{
    [self closeWindow];
}

@end
