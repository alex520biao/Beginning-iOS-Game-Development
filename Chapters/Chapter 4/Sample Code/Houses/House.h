#import <Foundation/Foundation.h>
@interface House : NSObject
{
    NSString* color;
}
-(void) setColor:(NSString*) theColor;
-(NSString*) getColor;
-(void) enterFrontDoor;
@end