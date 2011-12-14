//
//  ActivityIntervalModel.m
//  Actrack
//
//  Created by Matz De Katz on 12/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ActivityIntervalModel.h"

@implementation ActivityIntervalModel

@synthesize activityModel, endDate;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

-(NSNumber*)timeInterval
{
    return [NSNumber numberWithDouble:[[self endDate] timeIntervalSince1970] - [[self startDate] timeIntervalSince1970]];
}

-(NSDate*)startDate
{
    return [[self activityModel] timeStamp];
}

@end
