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
    ActivityService* activityService = [[[ActivityService alloc] init] autorelease];

    dates = [activityService getDistinctDates:YES];
    [dates reverse];
    
    [dateComboBox reloadData];
    [dateComboBox setStringValue:[dates objectAtIndex:0]];
    
    projects = [activityService getDistinctProjectIds:YES];
    [projects reverse];
    
    [projectComboBox reloadData];
    [projectComboBox setStringValue:[projects objectAtIndex:0]];
    
    [self updateView];
}

-(IBAction)viewDidUpdate:(id)sender
{
    [self updateView];
}

-(void)updateView
{
    ActivityService* activityService = [[[ActivityService alloc] init] autorelease];
    
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
        
        logs = [activityService getActsWithFilter:filter];
        
        parsed = [intervalParser parse:logs];
        
        //Update comboboxes
        [projectComboBox setEnabled:NO];
        [dateComboBox setEnabled:YES];
        
        NSMutableArray* summarized = [intervalParser summarizeForProjects:parsed];
        
        for (ProjectSummaryModel* intervalModel in summarized)
        {
            NSString* label = [NSString stringWithFormat:@"%@: %@",[intervalModel.projectId isEqualToString:@""] ? @"Break" : intervalModel.projectId, 
                               [FormattingUtils secondsToTimeString:[intervalModel.timeInterval intValue] delimiter:@":"]];
            NSString* summaryEntry = [NSString stringWithFormat:@"%@%@\n", [infoTextField stringValue], label];
            
            [infoTextField setStringValue:summaryEntry];
        }
        
        [summarized release];
    }
    else if ([projectRadioButton state] == NSOnState) //Project selected
    {
        //Collect entries
        filter.projectId = [projectComboBox stringValue];
        
        logs = [activityService getActsWithFilter:filter];
        
        parsed = [intervalParser parse:logs];
        
        //Update comboboxes
        [projectComboBox setEnabled:YES];
        [dateComboBox setEnabled:NO];
        
        NSMutableArray* summarized = [intervalParser summarizeForDates:parsed];
        
        for (DateSummaryModel* intervalModel in summarized)
        {
            NSString* label = [NSString stringWithFormat:@"%@: %@",intervalModel.timeStringDay, 
                               [FormattingUtils secondsToTimeString:[intervalModel.timeInterval intValue] delimiter:@":"]];
            NSString* summaryEntry = [NSString stringWithFormat:@"%@%@\n", [infoTextField stringValue], label];
            
            [infoTextField setStringValue:summaryEntry];
        }
        
        [summarized release];
    }
    
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

@end
