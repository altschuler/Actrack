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
-(NSMutableArray*)summarizeForProjects:(NSMutableArray*)list;

@end
