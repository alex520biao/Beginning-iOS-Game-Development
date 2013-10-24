//
//  GameState.m
//  TicTac
//
//  Created by Alessi Patrick on 8/26/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "GameState.h"

@implementation GameState
@synthesize playersTurn,boardState;


-(id) init
{
    self = [super init];
    
    if (self) {
        // Alloc and init the board state
        boardState = [[NSMutableArray alloc] initWithCapacity:9]; 
        
        playersTurn=TTxPlayerTurn;
        
    }
    
    return self;
    
}


#pragma mark NSCoding methods
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeObject: boardState forKey:@"BoardState"];
    [aCoder encodeInt:playersTurn forKey:@"PlayersTurn"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    boardState = [aDecoder decodeObjectForKey:@"BoardState"];
    playersTurn = [aDecoder decodeIntForKey:@"PlayersTurn"];
    
    return self;
    
}

@end
