//
//  ScheduleController.h
//  Activity Tracker
//
//  Created by zupa-sia on 15/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

//Delegate protocol

@protocol AskingControllerDelegate <NSObject>

-(void)performScheduledTask;

@end

@interface AskingController : NSObject
{
    int restTimeFromPause;
    
    NSTimer* timer;
    id<AskingControllerDelegate> delegate;
}

@property (nonatomic, assign) id<AskingControllerDelegate>delegate;



-(void)pause;
-(void)start:(BOOL)reset;
-(void)performTask:(NSTimer*)theTimer;
-(void)toggle;
-(BOOL)isRunning;
-(BOOL)askingIsAllowed;
-(int)remainingTime;


- (id)initWithDelegate:(id<AskingControllerDelegate>)del;

- (void)settingsDidUpdate:(NSNotification *)notification;

@end