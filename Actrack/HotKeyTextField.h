//
//  KeyHandl+erTextField.h
//  Actrack
//
//  Created by Matz De Katz on 07/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <AppKit/AppKit.h>

@interface HotKeyTextField : NSTextField
{
    NSInteger selectedKeyCode;
}

@property (nonatomic) NSInteger selectedKeyCode;

@end
