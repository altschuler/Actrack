//
//  HotKeyController.m
//  Actrack
//
//  Created by Matz De Katz on 07/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HotKeyController.h"
#import "Settings.h"

@implementation HotKeyController

@synthesize delegate;

- (id)initWithDelegate:(id<HotKeyControllerDelegate>)del
{
    self = [super init];
    if (self) 
    {   
        delegate = del;
    }
    
    return self;
}

- (void)registerKeyFromSettings
{
    UnregisterEventHotKey(myHotKeyRef);
    
    NSString* hotKeyString = [Settings getSetting:HotKey];
    
    if ([hotKeyString isEqualToString:@"none"])
        return;
    
    NSInteger hotKeyCode = [hotKeyString intValue];
      
    EventHotKeyID myHotKeyID;     
    EventTypeSpec eventType;
    eventType.eventClass = kEventClassKeyboard;     
    eventType.eventKind = kEventHotKeyPressed;
    
    InstallApplicationEventHandler(&hotKeyHandler, 1, &eventType, (void*)self, NULL);
    
    myHotKeyID.signature = 'mhk1';     
    myHotKeyID.id = 1;
    
    RegisterEventHotKey([[NSString stringWithFormat:@"%i",hotKeyCode] doubleValue], cmdKey+optionKey, myHotKeyID, GetApplicationEventTarget(), 0, &myHotKeyRef); 
}

OSStatus hotKeyHandler(EventHandlerCallRef nextHandler, EventRef anEvent, void *userData) 
{         
    HotKeyController* selfRef = (HotKeyController*)userData;
    [[selfRef delegate] hotKeyActivated];
    return noErr; 
}

@end