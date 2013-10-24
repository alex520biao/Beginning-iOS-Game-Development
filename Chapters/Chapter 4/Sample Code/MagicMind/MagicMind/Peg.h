#import <Foundation/Foundation.h>


@interface Peg : NSObject {
    char color;
}

@property char color;
+(Peg*) pegWithColor: (char) theColor;

@end
