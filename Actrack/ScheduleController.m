//
//  ScheduleController.m
//  Activity Tracker
//
//  Created by zupa-sia on 15/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ScheduleController.h"
#import "Settings.h"

@implementation ScheduleController

@synthesize delegate;

- (id)initWithDelegate:(id<ScheduleControllerDelegate>)del
{
    self = [super init];
    if (self) 
    {   
        delegate = del;
        restTimeFromPause = -1;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(settingsDidUpdate:) name:@"SettingsDidUpdate" object:nil];
    }
    
    return self;
}

- (void)settingsDidUpdate:(NSNotification *)notification
{
    //Reset the timer if AskInterval has been updated
    if ([notification object] == [NSNumber numberWithInt:AskInterval])
        [self start:YES];
}

-(void)performTask:(NSTimer*)theTimer
{
    [delegate performScheduledTask];
}

-(void)pause
{
    restTimeFromPause = [self remainingTime];
    
    //Kill the timer thoroughly
    [timer invalidate];
    [timer release];
    timer = nil;
}

-(void)start:(BOOL)reset
{
    // "Safety" limit of 10 seconds
    if ([[Settings getSetting:AskInterval] intValue] < 10)
        return;
    
    int askInterval = [[Settings getSetting:AskInterval] intValue];
   
    timer = [NSTimer scheduledTimerWithTimeInterval:((reset || restTimeFromPause == -1) ? askInterval : restTimeFromPause) target:self selector:@selector(performTask:) userInfo:nil repeats:NO];
}

-(void)toggle
{
    if ([self isRunning])
        [self pause];
    else
        [self start:NO];
}

-(int)remainingTime
{
    return [[timer fireDate] timeIntervalSinceNow];
}

-(BOOL)isRunning
{
    return timer != nil;
}

-(void)dealloc
{
    [timer invalidate];
    
    [super dealloc];
}

@end
