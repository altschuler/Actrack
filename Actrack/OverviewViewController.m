//
//  OverviewViewController.m
//  Actrack
//
//  Created by Simon Altschuler on 20/01/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "OverviewViewController.h"
#import "IntervalParser.h"
#import "ProjectSummaryModel.h"
#import "DateSummaryModel.h"
#import "FormattingUtils.h"
#import "ActivityService.h"
#import "ActivityQueryFilter.h"
#import "NSMutableArray+Reverse.h"

@implementation OverviewViewController

-(void)awakeFromNib
{   
    [self updateView];
}

-(IBAction)viewDidUpdate:(id)sender
{
    [self updateView];
}

-(void)updateView
{
    ActivityService* activityService = [[ActivityService alloc] init];
    
    
    if (dates != nil)
    {
        [dates removeAllObjects];
        [dates release];
    }
    dates = [[NSMutableArray alloc] init];
    NSMutableArray* tempDates = [[activityService getDistinctDates:YES] reverse];
    [dates addObjectsFromArray:tempDates];
    //[tempDates release];
    [dateComboBox reloadData];
    
    if (projects != nil)
    {
        [projects removeAllObjects];
        [projects release];
    }
    projects = [[NSMutableArray alloc] init];
    NSMutableArray* tempProjectIds = [activityService getDistinctProjectIds:YES];
    [projects addObjectsFromArray:tempProjectIds];
    //[tempProjectIds release];
    [projectComboBox reloadData];
    
    if ([[projectComboBox stringValue] length] == 0)
        [projectComboBox selectItemAtIndex:0];
    
    if ([[dateComboBox stringValue] length] == 0)
        [dateComboBox selectItemAtIndex:0];
    
    [projectComboBox setStringValue:[projects objectAtIndex:0]];
    
    
    ActivityQueryFilter* filter = [[ActivityQueryFilter alloc] init];
    filter.archived = YES;
    filter.isIdle = YES;
    
    IntervalParser* intervalParser = [[IntervalParser alloc] init];
    NSMutableArray* parsed;
    
    [infoTextField setStringValue:@""];
    
    if ([dateRadioButton state] == NSOnState) //Date selected
    {
        //Collect entries
        filter.dateString = [dateComboBox stringValue];

        [logs release];
        logs = [activityService getActsWithFilter:filter];
        
        parsed = [intervalParser parse:logs];
        
        //Update comboboxes
        [projectComboBox setEnabled:NO];
        [dateComboBox setEnabled:YES];
        
        NSMutableArray* summarized = [[intervalParser summarizeForProjects:parsed] retain];
        
        for (ProjectSummaryModel* intervalModel in summarized)
        {
            NSString* label = [NSString stringWithFormat:@"%@: %@",[intervalModel.projectId isEqualToString:@""] ? @"Break" : intervalModel.projectId, 
                               [FormattingUtils secondsToTimeString:[intervalModel.timeInterval intValue] delimiter:@":"]];
            NSString* summaryEntry = [NSString stringWithFormat:@"%@%@\n", [infoTextField stringValue], label];
            
            [infoTextField setStringValue:summaryEntry];
        }
        
        //[summarized removeAllObjects];
        [summarized release];
    }
    else if ([projectRadioButton state] == NSOnState) //Project selected
    {
        //Collect entries
        filter.projectId = [projectComboBox stringValue];
        
        [logs release];
        logs = [activityService getActsWithFilter:filter];
        
        parsed = [intervalParser parse:logs];
        
        //Update comboboxes
        [projectComboBox setEnabled:YES];
        [dateComboBox setEnabled:NO];
        
        NSMutableArray* summarized = [[intervalParser summarizeForDates:parsed] retain];
        
        for (DateSummaryModel* intervalModel in summarized)
        {
            NSString* label = [NSString stringWithFormat:@"%@: %@",intervalModel.timeStringDay, 
                               [FormattingUtils secondsToTimeString:[intervalModel.timeInterval intValue] delimiter:@":"]];
            NSString* summaryEntry = [NSString stringWithFormat:@"%@%@\n", [infoTextField stringValue], label];
            
            [infoTextField setStringValue:summaryEntry];
        }
        
        //[summarized removeAllObjects];
        [summarized release];
    }
    
    [activityService release];
    [parsed release];
    [intervalParser release];
    [filter release];
    
}

- (IBAction)radioButtonDidClick:(id)sender
{
    if ([[sender identifier] isEqualToString:@"date"])
    {
        [projectComboBox setEnabled:NO];
        [dateComboBox setEnabled:YES];   
        [dateRadioButton setState:NSOnState];   
        [projectRadioButton setState:NSOffState];
    }
    else if ([[sender identifier] isEqualToString:@"project"])
    {
        [projectComboBox setEnabled:YES];
        [dateComboBox setEnabled:NO];   
        [dateRadioButton setState:NSOffState];   
        [projectRadioButton setState:NSOnState];
    }
    
    [self updateView];
}

/* Delegate methods */
-(NSInteger)numberOfItemsInComboBox:(NSComboBox *)aComboBox
{
    if ([aComboBox isEqualTo:projectComboBox])
        return [projects count];
    else if ([aComboBox isEqualTo:dateComboBox])
        return [dates count];
    else
        return 0;
}

-(id)comboBox:(NSComboBox *)aComboBox objectValueForItemAtIndex:(NSInteger)index
{
    if ([aComboBox isEqualTo:projectComboBox])
        return [projects objectAtIndex:index];
    else if ([aComboBox isEqualTo:dateComboBox])
        return [dates objectAtIndex:index];
    else
        return nil;
}

-(void)dealloc
{
    //[dates release];
    [logs release];
    //[projects release];
    
    [super dealloc];
}

@end
