//
//  RenameProjectWindowController.h
//  Actrack
//
//  Created by Simon Altschuler on 12/01/12.
//
//

@protocol RenameProjectWindowControllerDelegate

- (void)didRenameProject;

@end

@interface RenameProjectWindowController : NSWindowController<NSWindowDelegate, NSComboBoxDelegate, NSComboBoxDataSource>
{
    id delegate;
    NSMutableArray* projectIds;
    NSString* projectId;
    
    IBOutlet NSComboBox *projectToRenameComboBox;
    IBOutlet NSTextField *newNameTextfield;
}

@property (nonatomic, assign) id<RenameProjectWindowControllerDelegate> delegate;
@property (nonatomic, copy) NSString* projectId;

- (IBAction)renameButtonDidClick:(id)sender;
- (IBAction)cancelButtonDidClick:(id)sender;

+ (RenameProjectWindowController*)openWindowWithDelegate:(id<RenameProjectWindowControllerDelegate>)del defaultProjectId:(NSString*)projectId;

- (void)closeWindow;

@end


