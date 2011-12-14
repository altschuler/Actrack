//
//  IntervalParser.m
//  Actrack
//
//  Created by Matz De Katz on 12/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "IntervalParser.h"
#import "ActivityIntervalModel.h"
#import "ActivityModel.h"

@implementation IntervalParser

-(NSMutableArray*)parseList:(NSMutableArray*)list
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
    
    return parsed;
}

@end
