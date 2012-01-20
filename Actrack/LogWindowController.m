//
//  TheListWindowController.m
//  Actrack
//
//  Created by Simon Altschuler on 15/11/11.
//  
//

#import "LogWindowController.h"
#import "Painter.h"
#import "CanvasView.h"

@implementation LogWindowController

static LogWindowController* activeWindowController;

- (id)init
{
    self = [super initWithWindowNibName:@"LogWindow"];
    if (self)
    {
    }
    return self;
}

-(void)awakeFromNib
{
    CanvasView* cv = [[CanvasView alloc] initWithFrame:visualCanvas.frame];
    [visualCanvas addSubview:cv];
}

+(void)openWindow
{
    if (activeWindowController == nil)
        activeWindowController = [[LogWindowController alloc] init];
    
    [activeWindowController showWindow:self];
    [NSApp activateIgnoringOtherApps:YES];
    [activeWindowController.window makeKeyAndOrderFront:nil];
}

-(void)closeWindow
{
    [self close];
    
    [activeWindowController release];
    activeWindowController = nil;
}

-(BOOL)windowShouldClose:(id)sender
{
    [self closeWindow];
    
    return NO;
}

@end
