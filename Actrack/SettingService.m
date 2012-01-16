//
//  Settings.m
//  Actrack
//
//  Created by Simon Altschuler on 15/11/11.
//  
//

#import "SettingService.h"
#import "FMDatabase.h"

static NSString* databaseFilePath = nil;

@implementation SettingService

+(void)initialize
{
    [super initialize];
}

+(NSString*)getSetting:(Setting)settingId
{
    FMDatabase* db = [FMDatabase databaseWithPath:[self pathForDatabaseFile]];

    [db open];
    
    FMResultSet* result = [db executeQuery:@"select * from settings"];

    NSString* settingValue;
    if ([result next])
        settingValue = [result stringForColumn:[SettingService getSettingStringForId:settingId]];
    
    [db close];
    
    return settingValue;
}

+(BOOL)setSetting:(Setting)settingId toValue:(id)newValue
{
    FMDatabase* database = [FMDatabase databaseWithPath:[SettingService pathForDatabaseFile]];
    
    [database open];

    BOOL success;
    switch (settingId) {
        case AskInterval:
            success = [database executeUpdate:@"update settings set askInterval = ?", newValue];
            break;
            
        case ArchiveTime:
            success = [database executeUpdate:@"update settings set archiveTime = ?", newValue];
            break;
            
        case DaysToAsk:
            success = [database executeUpdate:@"update settings set daysToAsk = ?", newValue];
            break;
            
        case AllowedTimeMin:
            success = [database executeUpdate:@"update settings set allowedTimeSpanMin = ?", newValue];
            break;
            
        case AllowedTimeMax:
            success = [database executeUpdate:@"update settings set allowedTimeSpanMax = ?", newValue];
            break;
            
        case HotKey:
            success = [database executeUpdate:@"update settings set hotkey = ?", newValue];
            break;
            
        default:
            success = NO;
            break;
    }

    
    [database close];
    if (success)
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SettingsDidUpdate" object:[NSNumber numberWithInt:settingId]];
    
    return success;
}
                      
+(NSString*)pathForDatabaseFile
{
    if (databaseFilePath != nil)
    {
        [databaseFilePath retain];
        return databaseFilePath;
    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
        
    NSString *folder = @"~/Library/Application Support/Actrack/";
    folder = [folder stringByExpandingTildeInPath];
        
    if ([fileManager fileExistsAtPath: folder] == NO)
    {
        [fileManager createDirectoryAtPath:folder withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    databaseFilePath = [folder stringByAppendingPathComponent:@"appdb.db"];
    
    return databaseFilePath;
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
