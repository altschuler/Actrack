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
    
    IBOutlet NSComboBox *projectComboBox;
    IBOutlet NSComboBox *dateComboBox;
    IBOutlet NSTableView *logTableView;
    IBOutlet NSTextField *queryTextField;
    IBOutlet NSButton* archiveCheckBox;
}

- (IBAction)runQueryButtonDidClick:(id)sender;
- (IBAction)deleteButtonDidClick:(id)sender;

- (ActivityQueryFilter*)buildFilterFromUI;

- (void)updateLogTableView;
- (void)updateComboBoxes;
- (void)updateView;

+ (void)openWindow;
- (void)closeWindow;

@end
