//
//  ProjectSummaryModel.h
//  Actrack
//
//  Created by Matz De Katz on 14/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
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
