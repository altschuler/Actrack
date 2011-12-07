//
//  Settings.m
//  Activity Tracker
//
//  Created by zupa-sia on 15/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Settings.h"
#import "FMDatabase.h"

@implementation Settings

+(void)initialize
{
    [super initialize];
}

+(NSString*)getSetting:(Setting)settingId
{
    FMDatabase* db = [FMDatabase databaseWithPath:[self pathForDatabaseFile]];
    
    [db open];
    
    FMResultSet* result = [db executeQuery:@"select * from settings"];
    
    [result next];
    
    NSString* settingValue = [result stringForColumnIndex:[Settings getSettingIndexForId:settingId]];
    
    [db close];
    
    return settingValue;
}

+(BOOL)setSetting:(Setting)settingId toValue:(id)newValue
{
    FMDatabase* database = [FMDatabase databaseWithPath:[Settings pathForDatabaseFile]];
    
    [database open];
    
    NSError* err = nil;
    NSString* query = [NSString stringWithFormat:@"update settings set %@ = %@ where rowid = 1", [Settings getSettingStringForId:settingId],newValue];
    
    BOOL success = [database executeUpdate:query error:&err withArgumentsInArray:nil orVAList:nil];
    
    if (success == NO)
    {
        NSAlert *theAlert = [NSAlert alertWithError:err];
        [theAlert runModal]; // Ignore return value.
    }
    
    [database close];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SettingsDidUpdate" object:[NSNumber numberWithInt:settingId]];
    
    return success;
}
                      
+(NSString*)pathForDatabaseFile
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
        
    NSString *folder = @"~/Library/Application Support/Actrack/";
    folder = [folder stringByExpandingTildeInPath];
        
    if ([fileManager fileExistsAtPath: folder] == NO)
    {
        [fileManager createDirectoryAtPath:folder withIntermediateDirectories:YES attributes:nil error:nil];
    }
        
    return [folder stringByAppendingPathComponent:@"appdb.db"];    
}

+(NSString *)getSettingStringForId:(Setting)settingId
{
    switch (settingId) {
        case AskInterval:
            return @"askInterval";
            break;
            
        case ArchiveTime:
            return @"archiveTime";
            break;
            
        case DaysToAsk:
            return @"daysToAsk";
            break;
            
        case AllowedTimeMin:
            return @"allowedTimeSpanMin";
            break;
            
        case AllowedTimeMax:
            return @"allowedTimeSpanMax";
            break;
            
        case HotKey:
            return @"hotkey";
            break;
            
        default:
            return nil;
    }
}

+(int)getSettingIndexForId:(Setting)settingId
{
    switch (settingId) {
        case AskInterval:
            return 0;
            break;
            
        case ArchiveTime:
            return 1;
            break;
            
        case DaysToAsk:
            return 2;
            break;
            
        case AllowedTimeMin:
            return 3;
            break;
            
        case AllowedTimeMax:
            return 4;
            break;
            
        case HotKey:
            return 5;
            break;
            
        default:
            return -1;
    }
}

@end
