//
//  DBManager.h
//  Activity Tracker
//
//  Created by zupa-sia on 14/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ActivityModel.h"
#import "ActivityQueryFilter.h"
#import "FMDatabase.h"
#import "FMResultSet.h"

@interface ActivityService : NSObject

- (BOOL) validateDatabase;
- (BOOL) updateArchivedStatus;
- (BOOL) insertActivity:(ActivityModel*)activity;
- (BOOL) removeActivity:(ActivityModel*)activity;
- (BOOL) renameProject:(NSString*)oldName toName:(NSString*)newName;

- (NSMutableArray*) getActs:(BOOL)archived;
- (NSMutableArray*) getActsWithFilter:(ActivityQueryFilter*)filter;

- (NSMutableArray*) getDistinctDates:(BOOL)archived;
- (NSMutableArray*) getDistinctProjectIds:(BOOL)archived;

- (NSString*) getLatestUsedProjectId;

@end
