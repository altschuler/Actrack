//
//  ActQueryFilter.m
//  Actrack
//
//  Created by Simon Altschuler on 11/12/11.
//  
//

#import "ActivityQueryFilter.h"

@implementation ActivityQueryFilter

@synthesize archived, projectId, dateString, isIdle;

-(void)dealloc
{
    [projectId release];
    [dateString release];
    
    [super dealloc];
}

@end
