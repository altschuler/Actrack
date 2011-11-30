//
//  SettingsWindowController.m
//  Activity Tracker
//
//  Created by zupa-sia on 18/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SettingsWindowController.h"
#import "Settings.h"

@implementation SettingsWindowController

- (id)init
{
    self = [super initWithWindowNibName:@"SettingsWindow"];
    if (self)
    {
        
        [NSTimer scheduledTimerWithTimeInterval:.1 target:self selector:@selector(initUI:) userInfo:nil repeats:NO];
    }
    
    return self;
}

- (IBAction)cancelButtonDidClick:(id)sender
{
    [self close];
}

-(void)initUI:(NSTimer *)timer
{
    [intervalTextField setStringValue:[NSString stringWithFormat:@"%@",[Settings getSetting:AskInterval]]];
    [archiveTimeTextField setStringValue:[NSString stringWithFormat:@"%@",[Settings getSetting:ArchiveTime]]];
}

-(IBAction)saveButtonDidClick:(id)sender
{
    
    BOOL success = YES;
    
    success = success ? [Settings setSetting:AskInterval toValue:[intervalTextField stringValue]] : success;
    success = success ? [Settings setSetting:ArchiveTime toValue:[archiveTimeTextField stringValue]] : success;
    
    if (success)
    {
        [self close];
    }
    else
        NSLog(@"Error saving settings.");
}



@end
