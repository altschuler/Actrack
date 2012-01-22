//
//  OverviewViewController.h
//  Actrack
//
//  Created by Simon Altschuler on 20/01/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface OverviewViewController : NSViewController <NSComboBoxDelegate, NSComboBoxDataSource> {

    IBOutlet NSTextField *infoTextField;
    IBOutlet NSComboBox *dateComboBox;
    IBOutlet NSComboBox *projectComboBox;
    
    IBOutlet NSButton *dateRadioButton;
    IBOutlet NSButton *projectRadioButton;
    
    NSMutableArray* logs;
    NSMutableArray* dates;
    NSMutableArray* projects;
}

- (IBAction)viewDidUpdate:(id)sender;
- (IBAction)radioButtonDidClick:(id)sender;

- (void)updateView;

@end
