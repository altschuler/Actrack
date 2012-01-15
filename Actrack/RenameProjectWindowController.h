//
//  RenameProjectWindowController.h
//  Actrack
//
//  Created by Simon Altschuler on 12/01/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "AbstractWindowController.h"

@protocol RenameProjectWindowControllerDelegate

- (void)didRenameProject;

@end

@interface RenameProjectWindowController : AbstractWindowController<NSWindowDelegate, NSComboBoxDelegate, NSComboBoxDataSource>
{
    id delegate;
    NSMutableArray* projectIds;
    
    IBOutlet NSComboBox *projectToRenameComboBox;
    IBOutlet NSTextField *newNameTextfield;
}

@property (nonatomic, assign) id<RenameProjectWindowControllerDelegate> delegate;

- (IBAction)renameButtonDidClick:(id)sender;
- (IBAction)cancelButtonDidClick:(id)sender;

+ (void)openWindowWithDelegate:(id<RenameProjectWindowControllerDelegate>)del;
- (void)closeWindow;

@end


