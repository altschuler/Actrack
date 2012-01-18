//
//  ScheduleController.h
//  Actrack
//
//  Created by Simon Altschuler on 15/11/11.
//  
//

//Delegate protocol

@protocol AskingControllerDelegate <NSObject>

-(void)performScheduledTask;

@end

@interface AskingController : NSObject
{
    BOOL wasRunningWhenSleepOccured;
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

-(void)handleSystemWillSleep;
-(void)handleSystemDidWake;

- (id)initWithDelegate:(id<AskingControllerDelegate>)del;

- (void)settingsDidUpdate:(NSNotification *)notification;

@end