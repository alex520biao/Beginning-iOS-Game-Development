//
//  ScramblerModel.h
//  Scrambler
//
//  Created by Alessi Patrick on 10/7/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ScramblerPlayer.h"

@interface ScramblerModel : NSObject {
    ScramblerPlayer* computerPlayer;
    int time;
    int score;
    NSString* currentWord;
}

@property (readonly) int time;
@property (readonly) int score;

-(NSString*) getScrambledWord;
-(BOOL) checkGuess:(NSString*) guess;
-(void) timerTick;

@end