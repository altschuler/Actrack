//
//  HotKeyController.h
//  Actrack
//
//  Created by Simon Altschuler on 07/12/11.
//  
//

#import <Foundation/Foundation.h>
#import "Carbon/Carbon.h"

@protocol HotKeyManagerDelegate <NSObject>

- (void) hotKeyActivated;

@end


@interface HotKeyManager : NSObject
{
    id<HotKeyManagerDelegate> delegate;
    EventHotKeyRef myHotKeyRef;
}

@property (nonatomic, assign) id<HotKeyManagerDelegate>delegate;

- (void)registerKeyFromSettings;

OSStatus hotKeyHandler(EventHandlerCallRef nextHandler, EventRef anEvent, void *userData);

@end
