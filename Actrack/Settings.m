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

+(id)getSetting:(Setting)settingId
{
    FMDatabase* db = [FMDatabase databaseWithPath:[self pathForDatabaseFile]];
    
    [db open];
    
    FMResultSet* result = [db executeQuery:@"select * from settings"];
    
    [result next];
    
    id settingValue = [result objectForColumnIndex:[Settings getSettingIndexForId:settingId]];
    
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
            
        default:
            return -1;
    }
}

@end
