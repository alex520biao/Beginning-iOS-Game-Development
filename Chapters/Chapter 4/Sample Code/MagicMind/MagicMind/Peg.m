#import "Peg.h"


@implementation Peg
@synthesize color;

+(Peg*) pegWithColor: (char) theColor
{
    // Create the peg
    Peg* thePeg = [[Peg alloc] init];
        
    // Set the peg's color
    thePeg.color = theColor;
    
    // Return the peg
    return thePeg;
    
}

@end
