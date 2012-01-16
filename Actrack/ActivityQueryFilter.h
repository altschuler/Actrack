//
//  ActQueryFilter.h
//  Actrack
//
//  Created by Simon Altschuler on 11/12/11.
//  
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
