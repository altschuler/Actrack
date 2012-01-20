//
//  HotKeyController.m
//  Actrack
//
//  Created by Simon Altschuler on 07/12/11.
//  
//

#import "HotKeyManager.h"
#import "SettingService.h"

@implementation HotKeyManager

@synthesize delegate;

- (id)initWithDelegate:(id<HotKeyManagerDelegate>)del
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
    
    NSString* hotKeyString = [SettingService getSetting:HotKey];
    
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
    HotKeyManager* selfRef = (HotKeyManager*)userData;
    [[selfRef delegate] hotKeyActivated];
    return noErr; 
}

@end
