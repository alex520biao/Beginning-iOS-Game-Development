//
//  Mansion.m
//  Houses
//
//  Created by Alessi Patrick on 10/6/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Mansion.h"

@implementation Mansion

-(void) useElevator:(int) floor
{
    NSLog(@"Going to floor: %i",floor);
}

-(void) enterFrontDoor
{
    NSLog(@"The butler awaits.");
}

@end
