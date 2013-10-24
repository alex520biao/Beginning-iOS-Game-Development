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



@end
