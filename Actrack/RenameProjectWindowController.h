//
//  RenameProjectWindowController.h
//  Actrack
//
//  Created by Simon Altschuler on 12/01/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "AbstractWindowController.h"

@interface RenameProjectWindowController : AbstractWindowController
{
    IBOutlet NSTextField *projectToRenameTextfield;
    IBOutlet NSTextField *newNameTextfield;
}

- (IBAction)renameButtonDidClick:(id)sender;
- (IBAction)cancelButtonDidClick:(id)sender;

+(void)openWindow;
-(void)closeWindow;

@end
