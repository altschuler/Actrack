//
//  RenameProjectWindowController.m
//  Actrack
//
//  Created by Simon Altschuler on 12/01/12.
//
//

#import "RenameProjectWindowController.h"
#import "ActivityService.h"

@implementation RenameProjectWindowController

@synthesize delegate, projectId;

static RenameProjectWindowController* activeWindowController;

-(id)init
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
    NSMutableArray* tempProjectIds = [activityService getDistinctProjectIds:YES];
    [projectIds addObjectsFromArray:tempProjectIds];
    //[tempProjectIds release];
    
    if (activeWindowController.projectId != nil)
        [projectToRenameComboBox setStringValue:activeWindowController.projectId];
    
    [projectToRenameComboBox reloadData];
    
    [activityService release];
}

-(id)comboBox:(NSComboBox *)aComboBox objectValueForItemAtIndex:(NSInteger)index
{
    return [projectIds objectAtIndex:index];
}

-(NSInteger)numberOfItemsInComboBox:(NSComboBox *)aComboBox
{
    return [projectIds count];
}

+ (RenameProjectWindowController*)openWindowWithDelegate:(id<RenameProjectWindowControllerDelegate>)del defaultProjectId:(NSString*)projectId
{
    if (activeWindowController == nil)
    {
        activeWindowController = [[RenameProjectWindowController alloc] init];
        [activeWindowController setDelegate:del];
        [activeWindowController setProjectId:projectId];
    }
    
    [activeWindowController showWindow:self];
    [NSApp arrangeInFront:activeWindowController.window];
    [NSApp activateIgnoringOtherApps:YES];
    [activeWindowController.window makeKeyAndOrderFront:nil];
    
    return activeWindowController;
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
             
        [activeWindowController.delegate didRenameProject];
        [self closeWindow];
    }
}



- (IBAction)cancelButtonDidClick:(id)sender
{
    [self closeWindow];
}

@end
