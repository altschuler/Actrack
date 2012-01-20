//
//  QuestionWindowController.h
//  Actrack
//
//  Created by Simon Altschuler on 12/11/11.
//  
//

#import <Cocoa/Cocoa.h>
#import "QuestionWindowDelegate.h"
#import "ActivityModel.h"

@interface QuestionWindowController : NSWindowController <NSTextFieldDelegate, NSWindowDelegate, NSComboBoxDelegate, NSComboBoxDataSource>
{
    IBOutlet NSTextField* commentTextField;
    IBOutlet NSButton *notTodayCheckbox;
    IBOutlet NSComboBox *projectComboBox;
    IBOutlet NSButton *isIdleCheckbox;
    NSMutableArray* projectIds;
    ActivityModel* lastAct;
    id<QuestionWindowDelegate> delegate;
}

@property (nonatomic, assign) id<QuestionWindowDelegate> delegate;

- (IBAction)submitButtonDidClick:(id)sender;
- (IBAction)skipButtonDidClick:(id)sender;
- (IBAction)isIdleCheckboxDidChange:(id)sender;

+ (void)openWindowWithDelegate:(id<QuestionWindowDelegate>)del;
- (void)closeWindow;

- (void)submitEntry;
- (void)setProjectIdSelection;

@end
