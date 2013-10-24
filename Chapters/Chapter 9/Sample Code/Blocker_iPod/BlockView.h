#import <UIKit/UIKit.h>

#define RED_COLOR 0
#define GREEN_COLOR 1
#define BLUE_COLOR 2


@interface BlockView : UIView {
    
    int color;
}

- (id)initWithFrame:(CGRect)frame color:(int) inputColor;

@property int color;

@end
