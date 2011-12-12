//
//  ActivityIntervalModel.h
//  Actrack
//
//  Created by Matz De Katz on 12/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ActivityModel.h"

@interface ActivityIntervalModel : NSObject
{
    ActivityModel* activityModel;
}

@property (nonatomic, retain) ActivityModel* activityModel;

-(NSNumber*)timeInterval;
-(NSDate*)endDate;

@end
