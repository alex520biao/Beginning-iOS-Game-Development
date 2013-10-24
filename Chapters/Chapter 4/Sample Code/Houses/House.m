#import "House.h"
@implementation House
-(void) setColor:(NSString*) theColor
{
    color = theColor;
}
-(NSString*) getColor
{
    return color;
}
-(void) enterFrontDoor
{
    NSLog(@"Entering front door");
}
@end