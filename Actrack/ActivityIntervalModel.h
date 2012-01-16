//
//  ActivityIntervalModel.h
//  Actrack
//
//  Created by Simon Altschuler on 12/12/11.
//  
//

#import <Foundation/Foundation.h>
#import "ActivityModel.h"

@interface ActivityIntervalModel : NSObject
{
    ActivityModel* activityModel;
    NSDate* endDate;
}

@property (nonatomic, retain) ActivityModel* activityModel;
@property (nonatomic, copy) NSDate* endDate;

-(NSDate*)startDate;

-(NSNumber*)timeInterval;

@end
