//
//  NSMutableArray+Reverse.m
//  Actrack
//
//  Created by Simon Altschuler on 21/01/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "NSMutableArray+Reverse.h"

@implementation NSMutableArray (NSMutableArray_Reverse)

- (NSMutableArray*)reverse
{
    NSUInteger i = 0;
    NSUInteger j = [self count] - 1;
    while (i < j) {
        [self exchangeObjectAtIndex:i withObjectAtIndex:j];
        i++;
        j--;
    }
    
    return self;
}

@end
