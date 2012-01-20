//
//  ScheduleController.h
//  Actrack
//
//  Created by Simon Altschuler on 15/11/11.
//  
//

//Delegate protocol

@protocol AskingManagerDelegate <NSObject>

-(void)performScheduledTask;

@end

@interface AskingManager : NSObject
{
    BOOL wasRunningWhenSleepOccured;
    int restTimeFromPause;
    
    NSTimer* timer;
    id<AskingManagerDelegate> delegate;
}

@property (nonatomic, assign) id<AskingManagerDelegate>delegate;

-(void)pause;
-(void)start:(BOOL)reset;
-(void)performTask:(NSTimer*)theTimer;
-(void)toggle;
-(BOOL)isRunning;
-(BOOL)askingIsAllowed;
-(int)remainingTime;

-(void)handleSystemWillSleep;
-(void)handleSystemDidWake;

- (id)initWithDelegate:(id<AskingManagerDelegate>)del;

- (void)settingsDidUpdate:(NSNotification *)notification;

@end