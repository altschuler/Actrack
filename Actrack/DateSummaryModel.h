//
//  DateSummaryModel.h
//  Actrack
//
//  Created by Simon Altschuler on 21/01/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateSummaryModel : NSObject
{
    NSString* timeStringDay;
    NSNumber* timeInterval;
    NSMutableArray* activityModels;
}

@property (nonatomic, copy) NSString* timeStringDay;
@property (nonatomic, copy) NSNumber* timeInterval;
@property (nonatomic, retain) NSMutableArray* activityModels;

@end
