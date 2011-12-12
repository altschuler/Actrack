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
    
    for (int i = 0; i < [list count]; i++) 
    {
        ActivityIntervalModel* intervalModel = [[ActivityIntervalModel alloc] init];
        
        ActivityModel* activityModel = [list objectAtIndex:i];
        
        intervalModel.activityModel = activityModel;
        
    }
    
    return parsed;
}

@end
