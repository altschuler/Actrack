//
//  FormattingUtils.m
//  Actrack
//
//  Created by Matz De Katz on 06/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FormattingUtils.h"

@implementation FormattingUtils

+(NSString*)secondsToTimeString:(NSInteger)seconds
{
    NSInteger sec = seconds % 60;
    NSInteger min = ((seconds - sec) / 60) % 60;
    NSInteger hour = (seconds - (seconds % 3600)) / 3600;
    
    NSString* timeLabel = @"Will ask in ";
    if (hour > 0)
        timeLabel = [timeLabel stringByAppendingFormat:@"%ih",hour];
    
    if (min > 0 || hour != 0)
        timeLabel = [timeLabel stringByAppendingFormat:@"%im",min];
    
    timeLabel = [timeLabel stringByAppendingFormat:@"%is",sec];  
    
    return timeLabel;
}

@end
