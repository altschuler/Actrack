//
//  FormattingUtils.h
//  Actrack
//
//  Created by Matz De Katz on 06/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FormattingUtils : NSObject

+(NSString*)secondsToTimeString:(NSInteger)seconds;
+(NSString*)niceHour:(NSNumber*)hours;

@end
