//
//  TheListWindowController.m
//  Activity Tracker
//
//  Created by zupa-sia on 15/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LogWindowController.h"
#import "DatabaseService.h"
#import "ActivityQueryFilter.h"
#import "IntervalParser.h"
#import "ActivityIntervalModel.h"

@implementation LogWindowController

static LogWindowController* activeWindowController;

- (id)init
{
    self = [super initWithWindowNibName:@"LogWindow"];
    if (self)
    {
        DatabaseService* dbman = [[[DatabaseService alloc] init] autorelease];
        [dbman updateArchivedStatus];
        
        IntervalParser* intervalParser = [[IntervalParser alloc] init];
        NSMutableArray* parsed = [intervalParser parseList:[dbman getActs:NO]];
        for (ActivityIntervalModel* intervalModel in parsed) 
        {
            NSLog(@"%@",intervalModel.timeInterval);
        }
    }
    
    return self;
}

- (void)updateComboBoxes
{
    DatabaseService* dbman = [[[DatabaseService alloc] init] autorelease];
    
    BOOL archived = [archiveCheckBox state] == NSOnState;

    dates = [[NSMutableArray alloc] init];
    [dates addObject:@"All"];
    [dates addObjectsFromArray:[dbman getDistinctDates:archived]];
    
    projectIds = [[NSMutableArray alloc] init];
    [projectIds addObject:@"All"];
    [projectIds addObjectsFromArray:[dbman getDistinctProjectIds:archived]];
    
    [projectComboBox reloadData];
    [dateComboBox reloadData];
}

-(void)awakeFromNib
{
    [self updateView];
}

- (void)updateView
{
    [self updateComboBoxes];
    
    [dateComboBox selectItemAtIndex:0];
    [projectComboBox selectItemAtIndex:0];
    
    [self updateLogTableView]; 
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

- (void)updateLogTableView
{
    DatabaseService* dbman = [[DatabaseService alloc] init];
    
    logs = [dbman getActsWithFilter:[self buildFilterFromUI]];
    
    [logTableView reloadData];
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

- (IBAction) runQueryButtonDidClick:(id)sender
{
    [self updateLogTableView];
    [self updateComboBoxes];
}

- (IBAction)deleteButtonDidClick:(id)sender 
{
    if ([logTableView selectedRow] != -1)
    {
        DatabaseService* dbman = [[DatabaseService alloc] init];
    
        ActivityModel* am = [logs objectAtIndex:[logTableView selectedRow]];
    
        [dbman removeActivity:am];
    
        [self updateView];
    }
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
