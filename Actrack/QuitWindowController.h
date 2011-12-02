//
//  QuitWindow.h
//  Activity Tracker
//
//  Created by zupa-sia on 12/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <AppKit/AppKit.h>
#import "AbstractWindowController.h"

@interface QuitWindowController : AbstractWindowController
{
    NSWindow* window;
}

- (IBAction)buttonDidClick:(NSButton*)sender;

@end
