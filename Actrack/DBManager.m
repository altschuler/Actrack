//
//  DBManager.m
//  Activity Tracker
//
//  Created by zupa-sia on 14/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DBManager.h"
#import "Settings.h"

@implementation DBManager

- (id) init
{
    self = [super init];
    if (self) 
    {
    }
    
    return self;
}

-(BOOL)updateArchivedStatus
{
    int archiveTime = (int)[[Settings getSetting:ArchiveTime] intValue];
    
    FMDatabase* database = [FMDatabase databaseWithPath:[Settings pathForDatabaseFile]];
    
    [database open];
    
    NSString* query = [NSString stringWithFormat:@"update acts set archived = case when datetime(timeStamp) < datetime('now', '-%i days') then 1 else 0 end", archiveTime];
    
    BOOL success = [database executeBatch:query];

    [database close];
    
    return success;
}

- (NSMutableArray*) getActsForQuery:(NSString*)query
{
    FMDatabase* database = [FMDatabase databaseWithPath:[Settings pathForDatabaseFile]];
    
    [database open];
    
    FMResultSet* result = [database executeQuery:query];
    
    NSMutableArray* logs = [[NSMutableArray alloc] init];
    
    while ([result next])
    {
        ActivityModel* am = [[ActivityModel alloc] init];
        am.projectId = [result stringForColumn:@"projectId"];
        am.comment = [result stringForColumn:@"comment"];
        am.timeStamp = [result stringForColumn:@"timeStamp"];
        am.actId = [result stringForColumn:@"rowid"];
        
        if (am.timeStamp == nil)
        {
            NSLog(@"Skipping log due to invalid date");
            continue;
        }
        
        [logs addObject:am];
    }
    
    [database close];
    
    return logs;
}

- (BOOL) insertActivity:(ActivityModel*)activity
{
    FMDatabase* database = [FMDatabase databaseWithPath:[Settings pathForDatabaseFile]];
    
    [database open];
    
    NSError* err = nil;
    NSArray* args = [NSArray arrayWithObjects:activity.projectId, activity.comment, activity.timeStamp, nil];
    BOOL success = [database executeUpdate:@"insert into acts (projectId, comment, timeStamp) values (?,?,?)" error:&err withArgumentsInArray:args orVAList:nil];
    
    if (success == NO)
    {
        NSAlert *theAlert = [NSAlert alertWithError:err];
        [theAlert runModal];
    }
    
    [database close];
    
    return success; 
}

-(BOOL)removeActivity:(ActivityModel*)activity
{
    FMDatabase* database = [FMDatabase databaseWithPath:[Settings pathForDatabaseFile]];
    
    [database open];
    
    NSError* err = nil;
    NSArray* args = [NSArray arrayWithObjects:activity.actId, nil];
    BOOL success = [database executeUpdate:@"delete from acts where rowid = ?" error:&err withArgumentsInArray:args orVAList:nil];
    
    if (success == NO)
    {
        NSAlert *theAlert = [NSAlert alertWithError:err];
        [theAlert runModal];
    }
    
    [database close];
    
    return success;   
}

@end
