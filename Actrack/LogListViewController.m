//
//  LogListViewController.m
//  Actrack
//
//  Created by Simon Altschuler on 20/01/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "LogListViewController.h"
#import "ActivityService.h"
#import "ActivityQueryFilter.h"
#import "ActivityIntervalModel.h"
#import "FormattingUtils.h"
#import "ProjectSummaryModel.h"
#import "RenameProjectWindowController.h"
#import "NSMutableArray+Reverse.h"

@implementation LogListViewController

-(void)awakeFromNib
{
    ActivityService* activityService = [[[ActivityService alloc] init] autorelease];
    [activityService updateArchivedStatus];
    
    sortAscending = YES;
    
    [self updateView];
}

/* Event handlers */
- (IBAction)deleteButtonDidClick:(id)sender 
{
    if ([logTableView selectedRow] != -1)
    {
        ActivityService* activityService = [[ActivityService alloc] init];
        
        //If sorting is applied descending we need to mirror the number in the count of entries
        NSInteger correctedRowIndex = sortAscending ? [logTableView selectedRow] : ([logs count] - 1 - [logTableView selectedRow]);
        
        ActivityModel* am = [logs objectAtIndex:correctedRowIndex];
        
        [activityService removeActivity:am];
        
        [activityService release];
        
        [self updateView];
    }
}

- (IBAction)renameButtonDidClick:(id)sender
{
    if([logTableView selectedRow] == -1)
    {
        [RenameProjectWindowController openWindowWithDelegate:self defaultProjectId:nil];
    }
    else
    {
        
        NSInteger correctedRowIndex = sortAscending ? [logTableView selectedRow] : ([logs count] - 1 - [logTableView selectedRow]);
        
        NSString* defaultProjectId = nil;
        
        ActivityModel* am = [logs objectAtIndex:correctedRowIndex];
        
        if (!am.isIdle)
            defaultProjectId = [am.projectId copy];
        
        [RenameProjectWindowController openWindowWithDelegate:self defaultProjectId:defaultProjectId];
        
        [defaultProjectId release];
    }
    
}

- (void)didRenameProject
{
    [self updateView];
}

- (IBAction)viewDidUpdate:(id)sender
{
    [self updateView];
}

- (void)updateView
{
    //Remove sorting indicator
    [logTableView setIndicatorImage:nil inTableColumn:lastClickedColumn];
    
    ActivityService* activityService = [[ActivityService alloc] init];
    
    BOOL archived = [archiveCheckBox state] == NSOnState;
    
    if (dates != nil)
    {
        [dates removeAllObjects];
        [dates release];
    }
    dates = [[NSMutableArray alloc] init];
    [dates addObject:@"All"];
    NSMutableArray* tempDates = [[activityService getDistinctDates:archived] reverse];
    [dates addObjectsFromArray:tempDates];
    //[tempDates release];
    [dateComboBox reloadData];
    
    if (projectIds != nil)
        [projectIds release];
    
    projectIds = [[NSMutableArray alloc] init];
    [projectIds addObject:@"All"];
    NSMutableArray* tempProjectIds = [activityService getDistinctProjectIds:archived];
    [projectIds addObjectsFromArray:tempProjectIds];
    //[tempProjectIds release];
    [projectComboBox reloadData];
    
    if ([[projectComboBox stringValue] length] == 0)
        [projectComboBox selectItemAtIndex:0];
    
    if ([[dateComboBox stringValue] length] == 0)
        [dateComboBox selectItemAtIndex:0];
    
    ActivityQueryFilter* filter = [self buildFilterFromUI];
    
    [logs release];
    logs = [activityService getActsWithFilter:filter];
    
    [activityService release];
    [filter release];
    
    [logTableView reloadData];
}


/* Delegate methods */
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

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row 
{
    //TODO cell caching?
    NSTextFieldCell* cell = [[[NSTextFieldCell alloc] init] autorelease];
    
    ActivityModel* am = [logs objectAtIndex:sortAscending ? row : [logs count] - 1 - row];
    
    if ([[tableColumn identifier] isEqualToString: @"comment"])
        cell.title = am.comment;
    else if ([[tableColumn identifier] isEqualToString: @"projectId"])
        cell.title = am.isIdle ? @"Idle" : am.projectId;
    else if ([[tableColumn identifier] isEqualToString: @"date"])
        cell.title = am.timeStringDay;
    else if ([[tableColumn identifier] isEqualToString: @"time"])
        cell.title = am.timeStringTime;
    
    //Gray out breaks
    if (am.isIdle)
    {
        [cell setTextColor:[NSColor grayColor]];
    }
    
    return cell;
}

-(void)tableView:(NSTableView *)tableView setObjectValue:(id)object forTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    //If sorting is applied descending we need to mirror the number in the count of entries
    NSInteger correctedRowIndex = sortAscending ? [logTableView selectedRow] : ([logs count] - 1 - [logTableView selectedRow]);
    ActivityModel* am = [logs objectAtIndex:correctedRowIndex];
    
    if (am.isIdle)
    {
        NSAlert *theAlert = [NSAlert alertWithMessageText:@"Cannot edit project id on Idle entries" defaultButton:@"Ok" alternateButton:nil otherButton:nil informativeTextWithFormat:@""];
        [theAlert runModal];
        return;
    }
    else if ([tableColumn.identifier isEqualToString:@"comment"])
    {
        am.comment = object;
    }
    else if ([tableColumn.identifier isEqualToString:@"projectId"])
    {
        am.projectId = object;
    }
    else 
    {
        // since date and time columns has had editing disabled, this will never occur
        NSAlert *theAlert = [NSAlert alertWithMessageText:@"Cannot edit date and time" defaultButton:@"Ok" alternateButton:nil otherButton:nil informativeTextWithFormat:@"This feature is not yet supported"];
        [theAlert runModal];
        [theAlert release];
        return;
    }
    
    ActivityService* activityService = [[ActivityService alloc] init];
    
    [activityService updateActivity:am];
    [activityService release];
    
    [self updateView];
}

-(BOOL)tableView:(NSTableView *)tableView shouldSelectTableColumn:(NSTableColumn *)tableColumn
{
    return NO;
}

-(void)tableView:(NSTableView *)tableView didClickTableColumn:(NSTableColumn *)tableColumn
{
    if (![lastClickedColumn.identifier isEqualToString:tableColumn.identifier])
    {
        sortAscending = YES;
        
        if ([tableColumn.identifier isEqualToString:@"projectId"])
        {
            [logs sortUsingComparator:^(id a, id b) {
                NSString *first = [(ActivityModel*)a projectId];
                NSString *second = [(ActivityModel*)b projectId];
                return [first compare:second];
            }];
        }
        else if ([tableColumn.identifier isEqualToString:@"comment"])
        {    
            [logs sortUsingComparator:^(id a, id b) {
                NSString *first = [(ActivityModel*)a comment];
                NSString *second = [(ActivityModel*)b comment];
                return [first compare:second];
            }];
        }
        else if ([tableColumn.identifier isEqualToString:@"date"])
        {
            [logs sortUsingComparator:^(id a, id b) {
                NSString *first = [(ActivityModel*)a timeStringDay];
                NSString *second = [(ActivityModel*)b timeStringDay];
                return [first compare:second];
            }];
        }
        else if ([tableColumn.identifier isEqualToString:@"time"])
        {
            [logs sortUsingComparator:^(id a, id b) {
                NSString *first = [(ActivityModel*)a timeStringTime];
                NSString *second = [(ActivityModel*)b timeStringTime];
                return [first compare:second];
            }];
        }
    } 
    else
    {
        sortAscending = !sortAscending;
    }
    
    [tableView setIndicatorImage:nil inTableColumn:lastClickedColumn];
    
    [tableView setIndicatorImage: sortAscending ? [NSImage imageNamed:@"NSAscendingSortIndicator"] : [NSImage imageNamed:@"NSDescendingSortIndicator"]  inTableColumn:tableColumn];
    
    lastClickedColumn = [tableColumn retain];
    
    [self updateView];
}


/* Utility methods */
- (ActivityQueryFilter*)buildFilterFromUI
{ 
    ActivityQueryFilter* filter = [[ActivityQueryFilter alloc] init];
    
    filter.dateString = [[dateComboBox stringValue] isEqualToString:@"All"] ? nil : [dateComboBox stringValue];
    filter.projectId = [[projectComboBox stringValue] isEqualToString:@"All"] ? nil : [projectComboBox stringValue];
    filter.archived = [archiveCheckBox state] == NSOnState;
    filter.isIdle = [idleCheckBox state] == NSOnState;
    
    return filter;
}

-(void)dealloc
{
    [logs release];
    [dates release];
    [projectIds release];
    
    [super dealloc];
}

@end
