//
//  ScheduleController.m
//  Actrack
//
//  Created by Simon Altschuler on 15/11/11.
//  
//

#import "AskingManager.h"
#import "SettingService.h"

@implementation AskingManager

@synthesize delegate;

- (id)initWithDelegate:(id<AskingManagerDelegate>)del
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
    if ([self askingIsAllowed])
        [delegate performScheduledTask];
}

-(BOOL)askingIsAllowed
{
    /* 
     Validation priority: 
     1. ask interval is 0
     2. current day is allowed
     3. current time is allowed 
     */
    
    /* Check if ask interval is 0 (=never ask) */
    if ([[SettingService getSetting:AskInterval] intValue] == 0)
        return NO;
    
    /* Check if the current day is allowed */
    NSInteger askDays = [[SettingService getSetting:DaysToAsk] intValue];
    NSInteger currentDay = [[[NSCalendar currentCalendar] components:NSWeekdayCalendarUnit fromDate:[NSDate date]] weekday];
    
    currentDay = --currentDay < 1 ? 7 : currentDay;
    currentDay = pow(2, currentDay-1);
    
    //Since the least significant bit has the value for sunday, we reverse the bit order
    uint temp = 0;
    NSInteger length = 7; 
    while (length-- > 0)
    {
        temp = (temp << 1) | (currentDay & 0x01);
        currentDay >>= 1;
    }
    currentDay = temp;
    
    //if the current day is not allowed return no
    if (!(askDays & currentDay))
        return NO;
    
    /* Check if the current hour is allowed */
    NSInteger currentHour = [[[NSCalendar currentCalendar] components:NSHourCalendarUnit fromDate:[NSDate date]] hour];
    if (!(currentHour >= [[SettingService getSetting:AllowedTimeMin] intValue] && currentHour < [[SettingService getSetting:AllowedTimeMax] intValue]))
        return NO;
    
    return YES;
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
    if ([[SettingService getSetting:AskInterval] intValue] < 10)
        return;
    
    int askInterval = [[SettingService getSetting:AskInterval] intValue];
   
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

-(void)handleSystemWillSleep
{
    //Save the state so we can resume on wake if needed
    wasRunningWhenSleepOccured = self.isRunning;
    
    @try {
        if (wasRunningWhenSleepOccured)
            [self pause];
    }
    @catch (NSException *exception) {
        //There's not much we can do here :-(
    }
}

-(void)handleSystemDidWake
{
    // if something went wrong when handling system sleep, the timer might not have been paused. 
    // thus we need to check if it has gone below zero
    
    if (wasRunningWhenSleepOccured)
    {
        [self start:NO];   
    }
}

-(void)dealloc
{
    [timer invalidate];
    
    [super dealloc];
}

@end
