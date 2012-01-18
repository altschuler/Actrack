//
//  FormattingUtils.m
//  Actrack
//
//  Created by Simon Altschuler on 06/12/11.
//  
//

#import "FormattingUtils.h"

@implementation FormattingUtils

+(NSString*)secondsToTimeString:(NSInteger)seconds delimiter:(NSString*)delim
{
    NSInteger sec = seconds % 60;
    NSInteger min = ((seconds - sec) / 60) % 60;
    NSInteger hour = (seconds - (seconds % 3600)) / 3600;
    
    NSString* timeLabel = [[NSString alloc] init];
    if (hour > 0)
        timeLabel = [timeLabel stringByAppendingFormat:hour > 9 ? @"%i%@" : @"0%i%@",hour,delim];
    
    if (min > 0 || hour != 0)
        timeLabel = [timeLabel stringByAppendingFormat:min > 9 ? @"%i%@" : @"0%i%@",min,delim];
    
    timeLabel = [timeLabel stringByAppendingFormat:sec > 9 ? @"%i" : @"0%i",sec];  
    
    return timeLabel;
}

+(NSString*)secondsToNiceTime:(NSInteger)seconds
{
    NSInteger sec = seconds % 60;
    NSInteger min = ((seconds - sec) / 60) % 60;
    NSInteger hour = (seconds - (seconds % 3600)) / 3600;
    
    NSString* timeLabel = [[NSString alloc] init];
    if (hour > 0)
        timeLabel = [timeLabel stringByAppendingFormat:@"%ih",hour];
    
    if (min > 0 || hour != 0)
        timeLabel = [timeLabel stringByAppendingFormat:@"%im",min];
 
    return timeLabel;
}

+(NSString*)secondsToClockString:(NSInteger)seconds
{
    NSInteger sec = seconds % 60;
    NSInteger min = ((seconds - sec) / 60) % 60;
    NSInteger hour = (seconds - (seconds % 3600)) / 3600;
    
    NSString* timeLabel = [[NSString alloc] init];
    timeLabel = [timeLabel stringByAppendingFormat:hour > 9 ? @"%i:" : @"0%i:", hour];
    timeLabel = [timeLabel stringByAppendingFormat:min > 9 ? @"%i" : @"0%i", min]; 
    
    return timeLabel;
}

@end
