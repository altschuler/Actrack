//
//  Painter.m
//  Actrack
//
//  Created by Simon Altschuler on 16/01/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Painter.h"

@implementation Painter

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

+ (void)drawToRect:(NSRect) rect
{
    NSBezierPath* thePath = [NSBezierPath bezierPath];

    [thePath moveToPoint:rect.origin];
    [thePath lineToPoint:NSMakePoint(rect.origin.x - 1,  rect.origin.y)];
    [thePath lineToPoint:NSMakePoint(NSMaxX(rect), NSMaxY(rect))];
    [thePath lineToPoint:NSMakePoint(rect.origin.x + 1,  NSMaxY(rect))];
    [thePath closePath];
    
    [thePath stroke];
}

@end
