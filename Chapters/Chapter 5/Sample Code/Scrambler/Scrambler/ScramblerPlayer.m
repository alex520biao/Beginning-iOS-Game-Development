//
//  ScramblerPlayer.m
//  Scrambler
//
//  Created by Alessi Patrick on 10/7/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ScramblerPlayer.h"

@implementation ScramblerPlayer

- (id)init
{
    self = [super init];
    if (self) {
        // Initia lize the word list
        [self initializeWordList];
    }
    return self;
}


-(NSString*) scrambleWord:(NSString*) wordToScramble
{
    // This method scrambles a word
    // Allocate an array to hold the used numbers
    NSMutableSet *usedNumberSet= [[NSMutableSet alloc]init];
    // Allocate a string that you will use to build the output
    NSMutableString *outputString = [[NSMutableString alloc]init];
    // Loop the number of times that there are letters in the word
    for (int i=0; i<[wordToScramble length]; i++) {
        // Pick a number
        int randomNum = random() % [wordToScramble length];
        // Is the number in the set?
        while ([usedNumberSet containsObject:[NSNumber numberWithInt:randomNum]] ==YES)
        {
            // If the number is in the list, you need to pick a different number
            randomNum = random() % [wordToScramble length];
        }
        // The number is not in the list
        // Add it to the list of used numbers
        [usedNumberSet addObject:[NSNumber numberWithInt:randomNum]];
        // Append the character at the position chosen to the outputString
        [outputString appendFormat:@"%c",
         [wordToScramble characterAtIndex:randomNum]];
    }
    return outputString;
}

-(void) initializeWordList
{
    // This method creates the chosen word list
    NSArray *masterWordList = [NSArray arrayWithObjects:
                               @"well", @"coin", @"address", @"novel",
                               @"mat", @"panther", @"chip", @"jump", @"scream",
                               @"spring", @"toothpick", @"shampoo", @"value",
                               @"buoy", @"skirt", @"general", @"ink",
                               @"engineer", @"epidemic", @"parasite", @"menu",
                               @"clay", @"sunglasses", @"ridge",@"noun",@"mill",
                               @"antique",@"gang",@"planet",@"headline",
                               @"ketchup",@"passion",@"queue",@"word",@"band",
                               @"thief",@"mustard",@"seat",@"sofa",
                               @"queue",@"flamenco",@"comet",@"pebble",
                               @"herald",@"factory",@"stew",@"loop",
                               @"velcro",@"thermostat",@"loaf",@"leaf",
                               @"salmon",@"curtain",
                               nil];
    // Initalize the scrambled word list
    scrambledWords = [[NSMutableArray alloc]
                      initWithCapacity:[masterWordList count]];
    // Seed the random number generator
    srandom( time( NULL ) );
    int randomNum;
    // Choose 10 words and them to the chosen words mutable array
    for (int i=0; i<10; i++) {
        // Generate random number to pick word
        randomNum = (random() % [masterWordList count]);
        // Add the word to the chosenWords mutable array
        [scrambledWords addObject:[masterWordList objectAtIndex:randomNum]];
    }
}


-(NSString*) getNextWord
{
    NSString* returnString = nil;
    if ([scrambledWords count] > 0)
    {
        // Get the string to return
        returnString = [scrambledWords objectAtIndex:0];
        // Remove the string from the array
        [scrambledWords removeObjectAtIndex:0];
    }
    return returnString;
}

-(int) getRemainingWordCount
{
    return [scrambledWords count];
}


@end
