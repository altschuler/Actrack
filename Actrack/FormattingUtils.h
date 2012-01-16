//
//  FormattingUtils.h
//  Actrack
//
//  Created by Simon Altschuler on 06/12/11.
//  
//

#import <Foundation/Foundation.h>

@interface FormattingUtils : NSObject

+(NSString*)secondsToTimeString:(NSInteger)seconds delimiter:(NSString*)delim;
+(NSString*)secondsToClockString:(NSInteger)seconds;

@end
