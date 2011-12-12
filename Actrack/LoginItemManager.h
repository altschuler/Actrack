//
//  LoginItem.h
//  Actrack
//
//  Created by Matz De Katz on 30/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginItemManager : NSObject
+ (BOOL) willStartAtLogin:(NSURL *)itemURL;
+ (void) setStartAtLogin:(NSURL *)itemURL enabled:(BOOL)enabled;
@end
