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
    
    for (int i = 0; i < listCount; i++) 
    {
        ActivityIntervalModel* intervalModel = [[ActivityIntervalModel alloc] init];
        
        ActivityModel* activityModel = [list objectAtIndex:i];
        
        intervalModel.activityModel = activityModel;
        
        if (i < listCount - 1)
        {
            ActivityModel* nextActivityModel = (ActivityModel*)[list objectAtIndex:i + 1];
            
            intervalModel.endDate = [nextActivityModel.timeStamp copy];
            NSLog(@"%@    =     %i",[activityModel timeString],[[intervalModel timeInterval] intValue]);
        }
        else
        {
            intervalModel.endDate = nil;
        }
        
        [parsed addObject:intervalModel];
        
    }
    
    return parsed;
}

@end
