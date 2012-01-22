//
//  IntervalParser.h
//  Actrack
//
//  Created by Simon Altschuler on 12/12/11.
//  
//

#import <Foundation/Foundation.h>

@interface IntervalParser : NSObject

-(NSMutableArray*)parse:(NSMutableArray*)list;

//These are very confusing, summary for project = list of dates and vice versa
-(NSMutableArray*)summarizeForProjects:(NSMutableArray*)list;
-(NSMutableArray*)summarizeForDates:(NSMutableArray*)list;

@end
