//
//  RenameProjectWindowController.m
//  Actrack
//
//  Created by Simon Altschuler on 12/01/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "RenameProjectWindowController.h"

@implementation RenameProjectWindowController

static RenameProjectWindowController* activeWindowController;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

+(void)openWindow
{
    if (activeWindowController == nil)
        activeWindowController = [[RenameProjectWindowController alloc] init];
    
    [activeWindowController showWindow:self];
    [NSApp arrangeInFront:activeWindowController.window];
    [NSApp activateIgnoringOtherApps:YES];
    [activeWindowController.window makeKeyAndOrderFront:nil];
}

-(void)closeWindow
{
    //since activeWindowController and self is the same, close first then kill
    [self close];
    
    [activeWindowController release];
    activeWindowController = nil;
}


- (IBAction)renameButtonDidClick:(id)sender
{
    
}

- (IBAction)cancelButtonDidClick:(id)sender
{
    [self closeWindow];
}

@end
