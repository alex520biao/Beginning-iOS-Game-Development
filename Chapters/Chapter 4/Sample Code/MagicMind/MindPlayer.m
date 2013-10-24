#import "MindPlayer.h"
#include <stdlib.h>
#include <time.h>

@implementation MindPlayer

// Pick the pegs for the rack
-(void) pickRack
{
    //	Seed the random number generator
    srandom( time( NULL ) );
    int randomNum;
    
    // Declare a peg
    Peg* peg=nil;
    
    for (int i=0; i<=3; i++)
    {
        // Generate random number to determine peg color
        randomNum = (random() % 6);
        
        // Create a new peg object based on the random number
        switch (randomNum) {
            case 0:
                // Use peg convenience initializer
                peg=[Peg pegWithColor:'r'];
                break;
            case 1:
                peg=[Peg pegWithColor:'y'];
                break;
            case 2:
                peg=[Peg pegWithColor:'g'];
                break;
            case 3:
                peg=[Peg pegWithColor:'b'];
                break;
            case 4:
                peg=[Peg pegWithColor:'o'];
                break;
            case 5:
                peg=[Peg pegWithColor:'k'];
                break;
            default:
                break;
        }
                
        // Add the peg to the rack
        rack[i] = peg;
        
    }
}

// Check the guess against the rack
-(NSString*) checkGuess:(NSString*) guess
{
    // Declare two ints to keep track of response criteria
    int correctColorAndPosition = 0;
    int correctColorOnly = 0;
    
    // Declare a string to temporarily hold the guess peg letter
    char tempGuessPeg;
    
    // Build a temporary rack
    char tempRack[4];
    for (int i=0;i<=3; i++) {
        tempRack[i] = rack[i].color;
    }
    
    // Loop through each peg letter in the guess
    for (int i=0; i<=3; i++) {
        tempGuessPeg = [guess characterAtIndex:i];
        
        // If pegs are identical, increment correctColorAndPosition
        if (tempGuessPeg==tempRack[i])
        {
            correctColorAndPosition++;
            
            // Take the color out of the temp rack because you cannot have
            // more than one match
            // Use x because that is not a color
            tempRack[i]='x';
            
        }
        else 
        {
            // Does a peg of this color exist in the rack?
            for (int j=0; j<=3; j++) {
                if (tempGuessPeg == tempRack[j]) {
                    correctColorOnly++;
                    // Take the color out of the temp rack
                    // Use x because that is not a color
                    tempRack[j]='x';
                    
                    // You must exit the inner loop because
                    // you found a matching color peg
                    break;
                }
            }
        }
        
    }
    
    // Determine if the user won
    if (correctColorAndPosition == 4)
    {
        return @"win";
    }
    else
    {
        return [NSString stringWithFormat:
                @"\nCorrect Color And Position: %i \nCorrect Color Only: %i",
                correctColorAndPosition, correctColorOnly];
        
    }
}

// Return rack string to print
-(NSString*) getRackString
{
    NSString* returnString = [NSString stringWithFormat:@"%c%c%c%c",
                              rack[0].color,rack[1].color,rack[2].color,
                              rack[3].color];
    
    return returnString;
    
}

// Clean up the memory used by the rack
-(void) cleanRack
{
    for (int i=0; i<=3; i++)
    {
        rack[i]=nil;
    }
}


@end
