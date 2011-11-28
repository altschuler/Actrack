//
//  QuestionWindowController.h
//  Activity Tracker
//
//  Created by zupa-sia on 12/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface QuestionWindowController : NSWindowController 
{
    IBOutlet NSTextField* projectTextField;
    IBOutlet NSTextField* commentTextField;
}

-(IBAction)submitButtonDidClick:(id)sender;
- (IBAction)skipButtonDidClick:(id)sender;

@end
