//
//  KeyHandl+erTextField.m
//  Actrack
//
//  Created by Simon Altschuler on 07/12/11.
//  
//

#import "HotKeyTextField.h"
#import "KeyCodeName.h"

@implementation HotKeyTextField
@synthesize selectedKeyCode;

-(void)keyUp:(NSEvent *)theEvent
{
    selectedKeyCode = [theEvent keyCode];
    [self setStringValue:[KeyCodeName getKeyNameFromKeyCode:[self selectedKeyCode]]];
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
        [self setStringValue:[KeyCodeName getKeyNameFromKeyCode:[self selectedKeyCode]]];
    }
    else
    {
        [self setTextColor:[NSColor blackColor]];
        [self setStringValue:@""];
    }
    
    [super setEnabled:flag];
}

@end
