//
//  QuitWindow.m
//  Activity Tracker
//
//  Created by zupa-sia on 12/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "QuitWindowController.h"

@implementation QuitWindowController

- (id)init
{
    self = [super initWithWindowNibName:@"QuitWindow"];
    if (self) 
    {
        // Initialization code here.
    }
    
    return self;
}

- (IBAction)buttonDidClick:(NSButton*)sender
{
    if (sender.tag == 0) //Terminate Actrack
    {
        [NSApp terminate:nil];
    }
    else if (sender.tag == 1) //Cancel
    {
        [self closeWindow];
    }
}
@end
