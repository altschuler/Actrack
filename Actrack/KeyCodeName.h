//
//  KeyCodeName.h
//  Actrack
//
//  Created by Simon Altschuler on 13/01/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KeyCodeName : NSObject
{
    NSDictionary* keyCodeNameRelation;
}

+ (NSString*) getKeyNameFromKeyCode:(NSInteger)keyCode;

@end
