//
//  GameState.h
//  TicTac
//
//  Created by Alessi Patrick on 8/26/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    TTxPlayerTurn = 1,      // The x player's turn
    TToPlayerTurn = 2       // The o player's turn
} TTPlayerTurn;


@interface GameState : NSObject <NSCoding>
{
    TTPlayerTurn playersTurn;
    NSMutableArray* boardState;
    
}

@property TTPlayerTurn playersTurn;
@property (strong, nonatomic) NSMutableArray* boardState;


@end