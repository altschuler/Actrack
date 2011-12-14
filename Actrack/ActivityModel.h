//
//  ActivityModel.h
//  Activity Tracker
//
//  Created by zupa-sia on 14/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActivityModel : NSObject
{
    NSString* actId;
    NSString* projectId;
    NSString* comment;
    NSDate* timeStamp;
}

@property (nonatomic, copy) NSString* actId;
@property (nonatomic, copy) NSString* projectId;
@property (nonatomic, copy) NSString* comment;
@property (nonatomic, retain) NSDate* timeStamp;

-(NSString*)timeStringDay;
-(NSString*)timeStringTime;
-(NSString*)timeString;

-(NSComparisonResult) compareDates:(ActivityModel*)activityModel;

@end
