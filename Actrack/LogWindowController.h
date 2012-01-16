//
//  TheListWindowController.h
//  Actrack
//
//  Created by Simon Altschuler on 15/11/11.
//  
//

#import <Cocoa/Cocoa.h>
#import "ActivityQueryFilter.h"
#import "AbstractWindowController.h"
#import "RenameProjectWindowController.h"


@interface LogWindowController : AbstractWindowController<NSTableViewDelegate, NSTableViewDataSource, NSComboBoxDelegate, NSComboBoxDataSource, NSWindowDelegate, RenameProjectWindowControllerDelegate>
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
- (IBAction)renameButtonDidClick:(id)sender;
- (IBAction)viewDidUpdate:(id)sender;

- (ActivityQueryFilter*)buildFilterFromUI;

- (void)updateView;
- (void)didRenameProject;
+ (void)openWindow;
- (void)closeWindow;

@end
