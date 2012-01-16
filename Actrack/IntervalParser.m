//
//  IntervalParser.m
//  Actrack
//
//  Created by Simon Altschuler on 12/12/11.
//  
//

#import "IntervalParser.h"
#import "ActivityIntervalModel.h"
#import "ActivityModel.h"
#import "ProjectSummaryModel.h"

@implementation IntervalParser

-(NSMutableArray*)parse:(NSMutableArray*)list
{
    NSMutableArray* parsed = [[NSMutableArray alloc] init];
    
    NSInteger listCount = [list count];
    
    [list sortUsingSelector:@selector(compareDates:)];
    
    ActivityModel* lastActivityModel = nil;
    
    for (int i = 0; i < listCount; i++) 
    {
        ActivityModel* activityModel = [list objectAtIndex:i];
        
        if (lastActivityModel == nil)
        {
            lastActivityModel = activityModel;
            continue;
        }
        
        ActivityIntervalModel* intervalModel = [[ActivityIntervalModel alloc] init];
        intervalModel.activityModel = [lastActivityModel copy];
        intervalModel.endDate = [activityModel.timeStamp copy];
        
        lastActivityModel = activityModel;
        
        [parsed addObject:intervalModel];
    }
    
    ActivityIntervalModel* intervalModel = [[ActivityIntervalModel alloc] init];
    intervalModel.activityModel = [lastActivityModel copy];
    intervalModel.endDate = [intervalModel.startDate dateByAddingTimeInterval:3600]; //Assume last entry was worked on for 1 hour. TODO!
    
    [parsed addObject:intervalModel];
    
    return parsed;
}

-(NSMutableArray*)summarizeForProjects:(NSMutableArray*)list
{
    NSMutableArray* parsed = [[NSMutableArray alloc] init];
    
    for (ActivityIntervalModel* intervalModel in list) 
    {
        BOOL found = false;
        for (ProjectSummaryModel* summaryModel in parsed)
        {
            if ([summaryModel.projectId isEqualToString:intervalModel.activityModel.projectId])
            {
                summaryModel.timeInterval = [NSNumber numberWithDouble:[summaryModel.timeInterval doubleValue] + [intervalModel.timeInterval doubleValue]];
                [[summaryModel activityModels] addObject:intervalModel.activityModel];
                found = true;
            }
        }
        
        if (!found)
        {
            ProjectSummaryModel* summaryModel = [[ProjectSummaryModel alloc] init];
            summaryModel.timeInterval = intervalModel.timeInterval;
            summaryModel.projectId = intervalModel.activityModel.projectId;
            [summaryModel.activityModels addObject:summaryModel];
            [parsed addObject:summaryModel];
        }
        
    }
    
    return parsed;
}

@end
