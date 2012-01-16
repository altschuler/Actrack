//
//  KeyCodeName.h
//  Actrack
//
//  Created by Simon Altschuler on 13/01/12.
//
//

#import <Foundation/Foundation.h>

@interface KeyCodeName : NSObject
{
    NSDictionary* keyCodeNameRelation;
}

+ (NSString*) getKeyNameFromKeyCode:(NSInteger)keyCode;

@end
