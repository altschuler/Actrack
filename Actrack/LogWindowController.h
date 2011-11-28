//
//  TheListWindowController.h
//  Activity Tracker
//
//  Created by zupa-sia on 15/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface LogWindowController : NSWindowController<NSTableViewDelegate, NSTableViewDataSource, NSComboBoxDelegate, NSComboBoxDataSource>
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

- (NSString*)buildQueryFromUI;
- (void)updateLogTableView;
- (void)updateComboBoxes;

@end
