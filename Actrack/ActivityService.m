//
//  DatabaseService.m
//  Actrack
//
//  Created by Simon Altschuler on 14/11/11.
//  
//

#import "ActivityService.h"
#import "SettingService.h"

// String contains helper
#define contains(str1, str2) ([str1 rangeOfString: str2 ].location != NSNotFound)

@implementation ActivityService

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
    int archiveTime = [[SettingService getSetting:ArchiveTime] intValue];
    
    FMDatabase* database = [FMDatabase databaseWithPath:[SettingService pathForDatabaseFile]];
    
    [database open];
    
    NSString* query = [NSString stringWithFormat:@"update acts set archived = case when datetime(timeStamp) < datetime('now', '-%i days') then 1 else 0 end", archiveTime];
    
    BOOL success = [database executeBatch:query];

    [database close];
    
    return success;
}

- (NSString*) getLatestUsedProjectId
{
    //select projectId from acts order by rowId desc limit 1;
    
    FMDatabase* database = [FMDatabase databaseWithPath:[SettingService pathForDatabaseFile]];

    [database open];
    
    FMResultSet* result = [database executeQuery:@"select projectId from acts order by rowId desc limit 1"];
    
    [result next];
        
    NSString* latestProjectId = [result stringForColumn:@"projectId"];
    
    if ([database hadError])
        NSLog(@"DB Error %d: %@", [database lastErrorCode], [database lastErrorMessage]); 
    
    [database close];
    
    return latestProjectId;
}

- (NSMutableArray*) getActsWithFilter:(ActivityQueryFilter*)filter
{
    FMDatabase* database = [FMDatabase databaseWithPath:[SettingService pathForDatabaseFile]];
    
    [database open];

    NSString* archived = filter.archived ? @"%" : [[NSNumber numberWithBool:filter.archived] stringValue];
    NSString* projectId = filter.projectId == nil ? [NSString stringWithString:@"%"] : filter.projectId;
    NSString* dateString = filter.dateString == nil ? [NSString stringWithString:@"%"] : [NSString stringWithFormat:@"%@%%",filter.dateString];
    
    FMResultSet* result = [database executeQuery:@"select *,rowid from acts where archived like ? and projectId like ? and timeStamp like ?", archived, projectId, dateString];
    
    NSMutableArray* logs = [[NSMutableArray alloc] init];
    
    while ([result next])
    {
        ActivityModel* am = [[ActivityModel alloc] init];
        am.projectId = [result stringForColumn:@"projectId"];
        am.comment = [result stringForColumn:@"comment"];
        am.timeStamp = [NSDate dateWithNaturalLanguageString:[result stringForColumn:@"timeStamp"]];
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

- (NSMutableArray*) getActs:(BOOL)archived
{
    FMDatabase* database = [FMDatabase databaseWithPath:[SettingService pathForDatabaseFile]];
    
    [database open];
    
    FMResultSet* result = [database executeQuery:@"select *,rowid from acts where archived like ?",archived ? @"%" : [NSNumber numberWithBool:archived]];
    
    NSMutableArray* logs = [[NSMutableArray alloc] init];
    
    while ([result next])
    {
        ActivityModel* am = [[ActivityModel alloc] init];
        am.projectId = [result stringForColumn:@"projectId"];
        am.comment = [result stringForColumn:@"comment"];
        am.timeStamp = [NSDate dateWithNaturalLanguageString:[result stringForColumn:@"timeStamp"]];
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


- (NSMutableArray*) getDistinctDates:(BOOL)archived
{
    FMDatabase* database = [FMDatabase databaseWithPath:[SettingService pathForDatabaseFile]];
    
    [database open];
    
    FMResultSet* result = [database executeQuery:@"select distinct substr(timeStamp,1,10) from acts where archived like ?",archived ? @"%" : [NSNumber numberWithBool:archived]];
    
    NSMutableArray* logs = [[NSMutableArray alloc] init];
    
    while ([result next])
    {   
        [logs addObject:[result stringForColumn:@"substr(timeStamp,1,10)"]];
    }
    
    [database close];
    
    return logs;
}

- (NSMutableArray*) getDistinctProjectIds:(BOOL)archived
{
    FMDatabase* database = [FMDatabase databaseWithPath:[SettingService pathForDatabaseFile]];
    
    [database open];
    
    FMResultSet* result = [database executeQuery:@"select distinct projectId from acts where archived like ? and projectId != null",archived ? @"%" : [NSNumber numberWithBool:archived]];
    
    NSMutableArray* logs = [[NSMutableArray alloc] init];
    
    while ([result next])
    {   
        [logs addObject:[result stringForColumn:@"projectId"]];
    }
    
    [database close];
    
    return logs;
}

- (BOOL) validateDatabase
{
    FMDatabase* database = [FMDatabase databaseWithPath:[SettingService pathForDatabaseFile]];
    
    [database open];
    NSString* settingsQuery = @"create table if not exists settings (askInterval int default 3600, archiveTime int default 7, daysToAsk int default 124, allowedTimeSpanMin int default 8, allowedTimeSpanMax int default 20, hotkey text default 'none')";
    BOOL settingsSuccess = [database executeUpdate:settingsQuery error:nil withArgumentsInArray:nil orVAList:nil];
    
    BOOL actsSuccess = [database executeUpdate:@"create table if not exists acts (projectId int, comment text, timeStamp text, archived int)" error:nil withArgumentsInArray:nil orVAList:nil];
    
    /*
     
     Updating older version of the database to latest format
     
     */
    
    //Check whether the settings table has the all required fields
    FMResultSet* settingsTableResult = [database executeQuery:@"select sql from sqlite_master where tbl_name = 'settings'"];
    [settingsTableResult next];
    
    
    NSString* settingsSql = [settingsTableResult stringForColumn:@"sql"];
    if (!contains(settingsSql, @"hotkey"))
    {
        //The settings table is invalid. Drop it and create again.
        [database closeOpenResultSets];
        [database executeUpdate:@"drop table settings"];
        settingsSuccess = [database executeUpdate:settingsQuery error:nil withArgumentsInArray:nil orVAList:nil];
    }
    
    //Make sure settings has a row with data
    FMResultSet* countResult = [database executeQuery:@"select count(*) from settings"];
    [countResult next];
    
    NSInteger count = [countResult intForColumn:@"count(*)"];
    
    if (count == 0)
        [database executeUpdate:@"insert into settings default values"];
    
    [database close];
    
    return actsSuccess && settingsSuccess;
}

- (BOOL) insertActivity:(ActivityModel*)activity
{
    FMDatabase* database = [FMDatabase databaseWithPath:[SettingService pathForDatabaseFile]];
    
    [database open];
    
    NSError* err = nil;
    NSArray* args = [NSArray arrayWithObjects:activity.projectId, activity.comment, activity.timeString, nil];
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
    FMDatabase* database = [FMDatabase databaseWithPath:[SettingService pathForDatabaseFile]];
    
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

-(BOOL)updateActivity:(ActivityModel*)activity
{
    FMDatabase* database = [FMDatabase databaseWithPath:[SettingService pathForDatabaseFile]];
    
    [database open];
    
    NSError* err = nil;
    BOOL success = [database executeUpdate:@"update acts set projectId = ?, comment = ? where rowid = ?", activity.projectId, activity.comment, activity.actId];
    
    if (success == NO)
    {
        NSAlert *theAlert = [NSAlert alertWithError:err];
        [theAlert runModal];
    }
    
    [database close];
    
    return success;   
}

- (BOOL) renameProject:(NSString*)oldName toName:(NSString*)newName
{
    FMDatabase* database = [FMDatabase databaseWithPath:[SettingService pathForDatabaseFile]];
    
    [database open];
    
    NSError* err = nil;
    BOOL success = [database executeUpdate:@"update acts set projectId = ? where projectId = ?",newName,oldName];
    
    if (success == NO)
    {
        NSAlert *theAlert = [NSAlert alertWithError:err];
        [theAlert runModal];
    }
    
    [database close];
    
    return success; 
}

@end
