//
//  ScheduleController.h
//  Activity Tracker
//
//  Created by zupa-sia on 15/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

//Delegate protocol
@protocol ScheduleControllerDelegate <NSObject>

-(void)performScheduledTask;

@end

@interface ScheduleController : NSObject
{
    int restTimeFromPause;
    
    NSTimer* timer;
    id<ScheduleControllerDelegate> delegate;
}

@property (nonatomic, assign) id<ScheduleControllerDelegate>delegate;

-(void)pause;
-(void)start:(BOOL)reset;
-(void)performTask:(NSTimer*)theTimer;
-(void)toggle;
-(BOOL)isRunning;
-(int)remainingTime;

- (id)initWithDelegate:(id<ScheduleControllerDelegate>)del;


@end