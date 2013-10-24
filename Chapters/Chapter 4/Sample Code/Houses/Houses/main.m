//
//  main.m
//  Houses
//
//  Created by Alessi Patrick on 10/6/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "House.h"
#import "Mansion.h"
#import "Colonial.h"

int main (int argc, const char * argv[])
{
    // Create houses
    House* redHouse;
    redHouse = [[House alloc] init];
    [redHouse setColor:@"Red"];
    Colonial* greenHouse = [[Colonial alloc] init];
    [greenHouse setColor:@"Green"];
    Mansion* yellowHouse = [[Mansion alloc] init];
    [yellowHouse setColor:@"Yellow"];
    // Print houses and enter
    NSLog(@"redHouse is %@", [redHouse getColor]);
    [redHouse enterFrontDoor];
    NSLog(@"greenHouse is %@", [greenHouse getColor]);
    [greenHouse enterFrontDoor];
    NSLog(@"yellowHouse is %@", [yellowHouse getColor]);
    [yellowHouse enterFrontDoor];
    
    // Call subclass methods
    [greenHouse goUpstairs];
    [yellowHouse useElevator:4];
    
    return 0;
}

