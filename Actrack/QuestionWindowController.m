//
//  QuestionWindowController.m
//  Activity Tracker
//
//  Created by zupa-sia on 12/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "QuestionWindowController.h"
#import "DBManager.h"
#import "ActivityModel.h"

@implementation QuestionWindowController

- (id)init
{
    self = [super initWithWindowNibName:@"QuestionWindow"];
    if (self) 
    {
        // Initialization code here.
    }
    
    return self;
}

-(IBAction)submitButtonDidClick:(id)sender
{
    ActivityModel* am = [[ActivityModel alloc] init];
    am.comment = [commentTextField stringValue];
    am.projectId = [projectTextField stringValue];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    am.timeStamp = [formatter stringFromDate:[NSDate date]];
        
    DBManager* dbman = [[DBManager alloc] init];
    [dbman insertActivity:am];
    
    [self close];
}

- (IBAction)skipButtonDidClick:(id)sender 
{    
    [self close];
}

- (void)windowDidLoad
{
    [super windowDidLoad];
}
@end
