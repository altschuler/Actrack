//
//  IntervalParser.h
//  Actrack
//
//  Created by Matz De Katz on 12/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IntervalParser : NSObject

-(NSMutableArray*)parse:(NSMutableArray*)list;
-(NSMutableArray*)summarizeForProjects:(NSMutableArray*)list;

@end
