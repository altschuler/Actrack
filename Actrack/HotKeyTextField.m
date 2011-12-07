//
//  KeyHandl+erTextField.m
//  Actrack
//
//  Created by Matz De Katz on 07/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HotKeyTextField.h"

@implementation HotKeyTextField
@synthesize selectedKeyCode;

-(void)keyUp:(NSEvent *)theEvent
{
    selectedKeyCode = [theEvent keyCode];
    [self setStringValue:[NSString stringWithFormat:@"%d",[self selectedKeyCode]]];
}

-(void)setEnabled:(BOOL)flag
{
    if (!flag)
    {
        [self setTextColor:[NSColor disabledControlTextColor]];
        [self setStringValue:@"none"];
    }
    else if (selectedKeyCode)
    {
        [self setTextColor:[NSColor blackColor]];
        [self setStringValue:[NSString stringWithFormat:@"%d",[self selectedKeyCode]]];
    }
    else
    {
        [self setTextColor:[NSColor blackColor]];
        [self setStringValue:@""];
    }
    
    [super setEnabled:flag];
}

@end