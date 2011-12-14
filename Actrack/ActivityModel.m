//
//  ActivityModel.m
//  Activity Tracker
//
//  Created by zupa-sia on 14/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ActivityModel.h"

@implementation ActivityModel

@synthesize actId, projectId, comment, timeStamp;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

-(NSComparisonResult) compareDates:(ActivityModel*)activityModel
{
    return [timeStamp compare:activityModel.timeStamp];
}

-(NSString*)timeString
{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *dateString = [dateFormatter stringFromDate:[self timeStamp]];
    
    [dateFormatter release];
    
    return dateString;
}

-(NSString*)timeStringDay
{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *dateString = [dateFormatter stringFromDate:[self timeStamp]];
    
    [dateFormatter release];
    
    return dateString;
}

-(NSString*)timeStringTime
{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    
    NSString *dateString = [dateFormatter stringFromDate:[self timeStamp]];
    
    [dateFormatter release];
    
    return dateString;
}

- (id)copyWithZone:(NSZone *)zone
{
    ActivityModel* am = [[ActivityModel alloc] init];
    am.comment = [self.comment copy];
    am.actId = [self.actId copy];
    am.projectId = [self.projectId copy];
    am.timeStamp = [self.timeStamp copy];
    
    return am;
}

@end
