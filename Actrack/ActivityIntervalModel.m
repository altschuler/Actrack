//
//  ActivityIntervalModel.m
//  Actrack
//
//  Created by Simon Altschuler on 12/12/11.
//  
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
