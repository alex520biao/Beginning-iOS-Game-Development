//
//  ScramblerPlayer.h
//  Scrambler
//
//  Created by Alessi Patrick on 10/7/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScramblerPlayer : NSObject {
    // The chosen words for the game
    NSMutableArray* scrambledWords;
}

-(NSString*) getNextWord;
-(NSString*) scrambleWord:(NSString*) wordToScramble;
-(int) getRemainingWordCount;
-(void) initializeWordList;

@end