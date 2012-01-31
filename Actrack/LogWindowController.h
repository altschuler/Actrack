//
//  TheListWindowController.h
//  Actrack
//
//  Created by Simon Altschuler on 15/11/11.
//  
//

#import <Cocoa/Cocoa.h>

@interface LogWindowController : NSWindowController<NSWindowDelegate>
{     
}

+ (void)openWindow;
- (void)closeWindow;

@end
