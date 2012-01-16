//
//  TheListWindowController.m
//  Activity Tracker
//
//  Created by zupa-sia on 15/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LogWindowController.h"
#import "ActivityService.h"
#import "ActivityQueryFilter.h"
#import "IntervalParser.h"
#import "ActivityIntervalModel.h"
#import "FormattingUtils.h"
#import "ProjectSummaryModel.h"
#import "RenameProjectWindowController.h"

@implementation LogWindowController

static LogWindowController* activeWindowController;

- (id)init
{
    self = [super initWithWindowNibName:@"LogWindow"];
    if (self)
    {
        ActivityService* dbman = [[[ActivityService alloc] init] autorelease];
        [dbman updateArchivedStatus];
    }
    
    return self;
}

-(void)awakeFromNib
{
    [self updateView];
}

- (IBAction)viewDidUpdate:(id)sender
{
    [self updateView];
}

- (void)updateView
{
    ActivityService* activityService = [[ActivityService alloc] init];
    
    BOOL archived = [archiveCheckBox state] == NSOnState;
    
    dates = [[NSMutableArray alloc] init];
    [dates addObject:@"All"];
    [dates addObjectsFromArray:[activityService getDistinctDates:archived]];
    [dateComboBox reloadData];
    
    projectIds = [[NSMutableArray alloc] init];
    [projectIds addObject:@"All"];
    [projectIds addObjectsFromArray:[activityService getDistinctProjectIds:archived]];
    [projectComboBox reloadData];
    
    if ([[projectComboBox stringValue] length] == 0)
        [projectComboBox selectItemAtIndex:0];
    
    if ([[dateComboBox stringValue] length] == 0)
        [dateComboBox selectItemAtIndex:0];
    
    logs = [activityService getActsWithFilter:[self buildFilterFromUI]];
    
    [logTableView reloadData];
    
    IntervalParser* intervalParser = [[IntervalParser alloc] init];
    NSMutableArray* parsed = [intervalParser summarizeForProjects:[intervalParser parse:logs]];

    [summaryTextfield setStringValue:@""];
    for (ProjectSummaryModel* intervalModel in parsed) 
    {
        NSString* summaryEntry = [NSString stringWithFormat:@"%@Worked on %@ (%@)\n", [summaryTextfield stringValue], intervalModel.projectId, 
                                  [FormattingUtils secondsToTimeString:[intervalModel.timeInterval intValue] delimiter:@":"]];
        
        [summaryTextfield setStringValue:summaryEntry];
    }
}

-(id)comboBox:(NSComboBox *)aComboBox objectValueForItemAtIndex:(NSInteger)index
{
    if ([[aComboBox identifier] isEqual:@"dateComboBox"]) 
    {
        return [dates objectAtIndex:index];
    }
    else if ([[aComboBox identifier] isEqual:@"projectComboBox"]) 
    {
        return [projectIds objectAtIndex:index];
    }
    
    return nil;
}

-(NSInteger)numberOfItemsInComboBox:(NSComboBox *)comboBox
{
    if ([[comboBox identifier] isEqual:@"dateComboBox"]) 
    {
        return [dates count];
    }
    else if ([[comboBox identifier] isEqual:@"projectComboBox"]) 
    {
        return [projectIds count];
    }
    
    return 0;
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView 
{
    return logs.count;
}

- (ActivityQueryFilter*)buildFilterFromUI
{ 
    ActivityQueryFilter* filter = [[ActivityQueryFilter alloc] init];
    
    filter.dateString = [[dateComboBox stringValue] isEqualToString:@"All"] ? nil : [dateComboBox stringValue];
    filter.projectId = [[projectComboBox stringValue] isEqualToString:@"All"] ? nil : [projectComboBox stringValue];
    filter.archived = [archiveCheckBox state] == NSOnState;

    return filter;
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row 
{
    NSCell* cell = [[NSCell alloc] init];
    
    ActivityModel* am = [logs objectAtIndex:row];
    
    if ([[tableColumn identifier] isEqualToString: @"comment"])
        cell.title = am.comment;
    else if ([[tableColumn identifier] isEqualToString: @"projectId"])
        cell.title = am.projectId;
    else if ([[tableColumn identifier] isEqualToString: @"date"])
        cell.title = am.timeStringDay;
    else if ([[tableColumn identifier] isEqualToString: @"time"])
        cell.title = am.timeStringTime;
    
    return cell;
}

-(void)tableView:(NSTableView *)tableView setObjectValue:(id)object forTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    ActivityModel* am = [logs objectAtIndex:[logTableView selectedRow]];
    
    if ([tableColumn.identifier isEqualToString:@"comment"])
    {
        am.comment = object;
    }
    else if ([tableColumn.identifier isEqualToString:@"projectId"])
    {
        am.projectId = object;
    }
    else 
    {
        NSAlert *theAlert = [NSAlert alertWithMessageText:@"Cannot edit date and time" defaultButton:@"Ok..." alternateButton:nil otherButton:nil informativeTextWithFormat:@"This feature is not yet supported"];
        [theAlert runModal];
        return;
    }
    
    ActivityService* activityService = [[ActivityService alloc] init];
    
    [activityService updateActivity:am];
    
    [self updateView];
    
}

- (IBAction)deleteButtonDidClick:(id)sender 
{
    if ([logTableView selectedRow] != -1)
    {
        ActivityService* activityService = [[ActivityService alloc] init];
    
        ActivityModel* am = [logs objectAtIndex:[logTableView selectedRow]];
    
        [activityService removeActivity:am];
        
        [self updateView];
    }
}

- (IBAction)renameButtonDidClick:(id)sender
{
    [RenameProjectWindowController openWindowWithDelegate:self];
}

- (void)didRenameProject
{
    [self updateView];
}

+(void)openWindow
{
    if (activeWindowController == nil)
        activeWindowController = [[LogWindowController alloc] init];
    
    [activeWindowController showWindow:self];
    [NSApp arrangeInFront:activeWindowController.window];
    [NSApp activateIgnoringOtherApps:YES];
    [activeWindowController.window makeKeyAndOrderFront:nil];
}

-(void)showWindow:(id)sender
{
    [[self window] makeFirstResponder:projectComboBox];
    
    [super showWindow:sender];
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
