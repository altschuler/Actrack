//
//  LogListViewController.h
//  Actrack
//
//  Created by Simon Altschuler on 20/01/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ActivityQueryFilter.h"
#import "RenameProjectWindowController.h"

@interface LogListViewController: NSViewController <NSTableViewDelegate, NSTableViewDataSource, NSComboBoxDelegate, NSComboBoxDataSource,RenameProjectWindowControllerDelegate> 
{
    NSMutableArray* logs;
    NSMutableArray* dates;
    NSMutableArray* projectIds;
    
    IBOutlet NSComboBox *projectComboBox;
    IBOutlet NSComboBox *dateComboBox;
    IBOutlet NSTableView *logTableView;
    IBOutlet NSTextField *queryTextField;
    IBOutlet NSButton* archiveCheckBox;
    IBOutlet NSButton *idleCheckBox;
    
    NSTableColumn* lastClickedColumn;
    BOOL sortAscending;
}

- (IBAction)deleteButtonDidClick:(id)sender;
- (IBAction)renameButtonDidClick:(id)sender;
- (IBAction)viewDidUpdate:(id)sender;

- (ActivityQueryFilter*)buildFilterFromUI;

- (void)updateView;
- (void)didRenameProject;

@end
