//
//  main.m
//  MagicMind
//
//  Created by Alessi Patrick on 8/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MindPlayer.h"

int main (int argc, const char * argv[])
{
        
    MindPlayer* computerPlayer = [[MindPlayer alloc] init];
    
    // State of the game
    BOOL playerWon = NO;
    int guessNumber = 1;
    
    NSString* checkGuessStatus;
    char guess[5];
    
    // Pick the rack
    [computerPlayer pickRack];
    
    // Game loop
    do
    {
        // Tell the user which guess this is
        NSLog(@"You are on guess number %i",guessNumber);
        
        // Ask for a guess
        NSLog(@"Enter your guess: ");
        scanf("%s", &guess); 
        NSString* guessString = [NSString stringWithCString:guess 
                                                   encoding:NSMacOSRomanStringEncoding];
        
        // Check the guess
        checkGuessStatus = [computerPlayer checkGuess:guessString];
        
        // Check to see if the player won
        if ([checkGuessStatus isEqualToString:@"win"])
        {
            playerWon = YES;
            
            // Tell the user that they won
            NSLog(@"You are a winner!");
        }
        else
        {
            // Show the guess status
            NSLog(@"%@",checkGuessStatus);
            
            // Increment the guess number
            guessNumber++;
        }
        
    }
    while (playerWon==NO && guessNumber<=10);
    
    // If the player didn't win
    if (playerWon == NO)
    {
        // Print a message and the rack
        NSLog(@"Sorry, you lost. The rack was: %@",
              [computerPlayer getRackString] );
    }
    
    // Clean up the rack
    [computerPlayer cleanRack];
    
    // Clean up the computer player
    computerPlayer=nil;
    
    return 0;
}

