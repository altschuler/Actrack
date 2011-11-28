//
//  Settings.h
//  Activity Tracker
//
//  Created by zupa-sia on 15/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    AskInterval = 1,
    ArchiveTime = 2
} Setting;

@interface Settings : NSObject

+(id)getSetting:(Setting)settingId;
+(BOOL)setSetting:(Setting)settingId toValue:(id)newValue;

+(NSString*)pathForDatabaseFile;
+(NSString *)getSettingStringForId:(Setting)settingId; 
+(int)getSettingIndexForId:(Setting)settingId; 

@end
