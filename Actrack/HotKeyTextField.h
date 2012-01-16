//
//  KeyHandl+erTextField.h
//  Actrack
//
//  Created by Simon Altschuler on 07/12/11.
//  
//

#import <AppKit/AppKit.h>

@interface HotKeyTextField : NSTextField
{
    NSInteger selectedKeyCode;
}

@property (nonatomic) NSInteger selectedKeyCode;

@end
