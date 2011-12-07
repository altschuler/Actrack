//
//  TheListWindowController.m
//  Activity Tracker
//
//  Created by zupa-sia on 15/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LogWindowController.h"
#import "DatabaseService.h"

@implementation LogWindowController

static LogWindowController* activeWindowController;

- (id)init
{
    self = [super initWithWindowNibName:@"LogWindow"];
    if (self)
    {
        DatabaseService* dbman = [[[DatabaseService alloc] init] autorelease];
        [dbman updateArchivedStatus];
    }
    
    return self;
}

- (void)updateComboBoxes
{
    DatabaseService* dbman = [[[DatabaseService alloc] init] autorelease];
    
    NSString* query = @"select *,rowid from acts";
    
    if ([archiveCheckBox state] == NSOffState)
    {
        query = [query stringByAppendingString:@" where archived = 0"]; 
    }
    
    NSMutableArray* templogs =  [dbman getActsForQuery:query];    
    
    dates = [[NSMutableArray alloc] init];
    [dates addObject:@"All"];
    
    projectIds = [[NSMutableArray alloc] init];
    [projectIds addObject:@"All"];
    
    for (ActivityModel* act in templogs) 
    {
        if (![dates containsObject:act.timeStringDay])
            [dates addObject:act.timeStringDay];
        
        if (![projectIds containsObject:act.projectId])
            [projectIds addObject:act.projectId];
    }
    
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
    
    NSString* query = [self buildQueryFromUI];
    
    [queryTextField setStringValue:query];
    
    logs = [dbman getActsForQuery:query];
    
    [logTableView reloadData];
}

- (NSString*)buildQueryFromUI
{ 
    NSString* query = [[NSString alloc] initWithString:@"select *,rowid from acts"];
    BOOL firstParam = YES;
    
    if (![[dateComboBox stringValue] isEqualToString:@"All"])
    {
        if (firstParam)
            query = [query stringByAppendingString:@" where"];
        
        firstParam = NO;
        
        query = [query stringByAppendingFormat:@" timeStamp like '%@%%'",[dateComboBox stringValue]];
    }
    
    if (![[projectComboBox stringValue] isEqualToString:@"All"])
    {
        if (firstParam)
            query = [query stringByAppendingString:@" where"];
        else
            query = [query stringByAppendingString:@" and"];
        
        firstParam = NO;
        
        query = [query stringByAppendingFormat:@" projectId = %@",[projectComboBox stringValue]];
    }
    
    if ([archiveCheckBox state] == NSOffState)
    {
        if (firstParam)
            query = [query stringByAppendingString:@" where"];
        else
            query = [query stringByAppendingString:@" and"];
        
        firstParam = NO;
        
        query = [query stringByAppendingString:@" archived = 0"];
    }
    
    return query;
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row 
{
    NSCell* cell = [[NSCell alloc] init];
    
    ActivityModel* am = [logs objectAtIndex:row];
    
    if ([[tableColumn identifier] isEqualToString: @"comment"])
    {   
        cell.title = am.comment;
        [tableColumn.headerCell setTitle:@"Comment"];
    }
    else if ([[tableColumn identifier] isEqualToString: @"projectId"])
    {   
        cell.title = am.projectId;
        [tableColumn.headerCell setTitle:@"Project ID"];
    }
    else if ([[tableColumn identifier] isEqualToString: @"date"])
    {   
        cell.title = am.timeStamp;
        [tableColumn.headerCell setTitle:@"Date"];
    }
    
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
