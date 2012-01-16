//
//  LoginItem.h
//  Actrack
//
//  Created by Simon Altschuler on 30/11/11.
//  
//

#import <Foundation/Foundation.h>

@interface LoginItemManager : NSObject
+ (BOOL) willStartAtLogin:(NSURL *)itemURL;
+ (void) setStartAtLogin:(NSURL *)itemURL enabled:(BOOL)enabled;
@end
