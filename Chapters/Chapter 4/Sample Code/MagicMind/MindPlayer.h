#import <Foundation/Foundation.h>
#import "Peg.h"

@interface MindPlayer : NSObject {
    // An arrray to hold the rack
    Peg* rack[4];
    
    
}

// Pick the pegs for the rack
-(void) pickRack;

// Check the guess against the rack
-(NSString*) checkGuess:(NSString*) guess;

// Return rack string to print
-(NSString*) getRackString;

// Clean up the memory used by the rack
-(void) cleanRack;



@end
