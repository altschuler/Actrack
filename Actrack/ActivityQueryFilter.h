//
//  ActQueryFilter.h
//  Actrack
//
//  Created by Matz De Katz on 11/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActivityQueryFilter : NSObject
{
    BOOL archived;
    NSString* projectId;
    NSString* dateString;
}

@property (nonatomic) BOOL archived;
@property (nonatomic, copy) NSString* projectId;
@property (nonatomic, copy) NSString* dateString;

@end
