//
//  QuestionWindowController.h
//  Activity Tracker
//
//  Created by zupa-sia on 12/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "AbstractWindowController.h"
#import "QuestionWindowDelegate.h"
#import "ActivityModel.h"

@interface QuestionWindowController : AbstractWindowController <NSTextFieldDelegate, NSWindowDelegate, NSComboBoxDelegate, NSComboBoxDataSource>
{
    IBOutlet NSTextField* projectTextField;
    IBOutlet NSTextField* commentTextField;
    IBOutlet NSButton *notTodayCheckbox;
    IBOutlet NSComboBox *projectComboBox;
    NSMutableArray* projectIds;
    ActivityModel* lastAct;
    id<QuestionWindowDelegate> delegate;
}

@property (nonatomic, assign) id<QuestionWindowDelegate> delegate;

- (IBAction)submitButtonDidClick:(id)sender;
- (IBAction)skipButtonDidClick:(id)sender;

+ (void)openWindowWithDelegate:(id<QuestionWindowDelegate>)del;
- (void)closeWindow;

- (void)submitEntry;

@end
