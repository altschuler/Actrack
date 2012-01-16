//
//  HotKeyController.h
//  Actrack
//
//  Created by Simon Altschuler on 07/12/11.
//  
//

#import <Foundation/Foundation.h>
#import "Carbon/Carbon.h"

@protocol HotKeyControllerDelegate <NSObject>

- (void) hotKeyActivated;

@end


@interface HotKeyController : NSObject
{
    id<HotKeyControllerDelegate> delegate;
    EventHotKeyRef myHotKeyRef;
}

@property (nonatomic, assign) id<HotKeyControllerDelegate>delegate;

- (void)registerKeyFromSettings;

OSStatus hotKeyHandler(EventHandlerCallRef nextHandler, EventRef anEvent, void *userData);

@end
