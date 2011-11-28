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
    NSString* timeStamp;
}

@property (nonatomic, copy) NSString* actId;
@property (nonatomic, copy) NSString* projectId;
@property (nonatomic, copy) NSString* comment;
@property (nonatomic, copy) NSString* timeStamp;

-(NSString*)timeStringDay;

@end
