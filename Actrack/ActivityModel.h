//
//  ActivityModel.h
//  Actrack
//
//  Created by Simon Altschuler on 14/11/11.
//  
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
