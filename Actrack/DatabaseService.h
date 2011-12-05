//
//  DBManager.h
//  Activity Tracker
//
//  Created by zupa-sia on 14/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ActivityModel.h"
#import "FMDatabase.h"
#import "FMResultSet.h"

@interface DatabaseService : NSObject
{
    
}

- (BOOL) validateDatabase;
- (BOOL) updateArchivedStatus;
- (BOOL) insertActivity:(ActivityModel*)activity;
- (BOOL) removeActivity:(ActivityModel*)activity;

- (NSMutableArray*) getActsForQuery:(NSString*)query;

@end
