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
    
    NSMutableArray* logs;
    NSMutableArray* dates;
}

-(IBAction)viewDidUpdate:(id)sender;

-(void)updateView;

@end
