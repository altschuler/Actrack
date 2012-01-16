//
//  Settings.h
//  Actrack
//
//  Created by Simon Altschuler on 15/11/11.
//  
//

#import <Foundation/Foundation.h>

typedef enum {
    AskInterval = 1,
    ArchiveTime = 2,
    DaysToAsk = 3,
    AllowedTimeMin = 4,
    AllowedTimeMax = 5,
    HotKey = 6
} Setting;

@interface SettingService : NSObject

+(id)getSetting:(Setting)settingId;
+(BOOL)setSetting:(Setting)settingId toValue:(id)newValue;

+(NSString*)pathForDatabaseFile;
+(NSString *)getSettingStringForId:(Setting)settingId; 
+(int)getSettingIndexForId:(Setting)settingId; 

@end
