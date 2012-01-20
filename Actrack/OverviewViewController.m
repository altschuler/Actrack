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
#import "FormattingUtils.h"
#import "ActivityService.h"
#import "ActivityQueryFilter.h"

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
    
    ActivityQueryFilter* filter = [[ActivityQueryFilter alloc] init];
    filter.dateString = [dateComboBox stringValue];
    filter.archived = YES;
    filter.isIdle = YES;
    
    logs = [activityService getActsWithFilter:filter];
    
    dates = [activityService getDistinctDates:YES];
    
    IntervalParser* intervalParser = [[IntervalParser alloc] init];
    NSMutableArray* parsed = [intervalParser summarizeForProjects:[intervalParser parse:logs]];
    
    [infoTextField setStringValue:@""];
    for (ProjectSummaryModel* intervalModel in parsed)
    {
        NSString* summaryEntry = [NSString stringWithFormat:@"%@Worked on %@ (%@)\n", [infoTextField stringValue], intervalModel.projectId, 
                                  [FormattingUtils secondsToTimeString:[intervalModel.timeInterval intValue] delimiter:@":"]];
        
        [infoTextField setStringValue:summaryEntry];
    }
    
    [dateComboBox reloadData];
    
    [intervalParser release];
    [filter release];
    
}

/* Delegate methods */
-(NSInteger)numberOfItemsInComboBox:(NSComboBox *)aComboBox
{
    return [dates count];
}

-(id)comboBox:(NSComboBox *)aComboBox objectValueForItemAtIndex:(NSInteger)index
{
    return [dates objectAtIndex:index];
}

@end
