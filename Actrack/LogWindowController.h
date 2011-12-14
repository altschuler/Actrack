//
//  TheListWindowController.h
//  Activity Tracker
//
//  Created by zupa-sia on 15/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ActivityQueryFilter.h"
#import "AbstractWindowController.h"


@interface LogWindowController : AbstractWindowController<NSTableViewDelegate, NSTableViewDataSource, NSComboBoxDelegate, NSComboBoxDataSource, NSWindowDelegate>
{
    NSMutableArray* logs;
    NSMutableArray* dates;
    NSMutableArray* projectIds;
    
    /* List view */
    IBOutlet NSComboBox *projectComboBox;
    IBOutlet NSComboBox *dateComboBox;
    IBOutlet NSTableView *logTableView;
    IBOutlet NSTextField *queryTextField;
    IBOutlet NSButton* archiveCheckBox;
    
    /* Summary view */
    IBOutlet NSTextField *summaryTextfield;
    IBOutlet NSTextField *summaryTitleTextfield;
}

- (IBAction)deleteButtonDidClick:(id)sender;
- (IBAction)viewDidUpdate:(id)sender;

- (ActivityQueryFilter*)buildFilterFromUI;

- (void)updateView;

+ (void)openWindow;
- (void)closeWindow;

@end
