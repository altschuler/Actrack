//
//  ProjectSummaryModel.h
//  Actrack
//
//  Created by Simon Altschuler on 14/12/11.
//  
//

#import <Foundation/Foundation.h>

@interface ProjectSummaryModel : NSObject
{
    NSString* projectId;
    NSNumber* timeInterval;
    NSMutableArray* activityModels;
}

@property (nonatomic, copy) NSString* projectId;
@property (nonatomic, copy) NSNumber* timeInterval;
@property (nonatomic, retain) NSMutableArray* activityModels;

@end
