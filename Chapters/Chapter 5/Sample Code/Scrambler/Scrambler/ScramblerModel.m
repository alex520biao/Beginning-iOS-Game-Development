//
//  ScramblerModel.m
//  Scrambler
//
//  Created by Alessi Patrick on 10/7/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ScramblerModel.h"

@implementation ScramblerModel
@synthesize time,score;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialize the game model
        computerPlayer = [[ScramblerPlayer alloc] init];
        // Initialize time
        time = 60;
        // Initialize score
        score = 0;
        // Get the first word from the list
        currentWord = [computerPlayer getNextWord];
    }
    return self;
}

-(BOOL) checkGuess:(NSString*) guess
{
    if ([guess isEqualToString:currentWord])
    {
        // Add one to the score
        score++;
        // Add 15 seconds to the timer
        time+=15;
        // If there are more words, pick the next word
        if ([computerPlayer getRemainingWordCount] > 0)
        {
            currentWord = [computerPlayer getNextWord];
        }
        else
        {
            // No more words, so clean up
            currentWord=nil;
        }
        return YES;
    }
    else
    {
        // Subtract 10 from the time
        time-=10;
        return NO;
    }
}

-(NSString*) getScrambledWord
{
    return [computerPlayer scrambleWord:currentWord];
}

-(void) timerTick
{
    time--;
}


@end
