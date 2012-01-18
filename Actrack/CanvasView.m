//
//  CanvasView.m
//  Actrack
//
//  Created by Simon Altschuler on 16/01/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "CanvasView.h"

@implementation CanvasView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)drawRect:(NSRect)rect
{
    NSBezierPath * path = [NSBezierPath bezierPath];
    
    NSPoint center = NSMakePoint([self bounds].size.width  * 0.50, [self bounds].size.height * 0.50);
    [path setLineWidth:1.0f];
    
    [path moveToPoint: center];
    [path appendBezierPathWithOvalInRect:NSMakeRect(center.x, center.y, 50, 50)];
  
    [[NSColor purpleColor] set];
    [path fill];
    
    [[NSColor blackColor] set];
    [path stroke];
}

-(BOOL)isFlipped
{
    return YES;
}

@end
