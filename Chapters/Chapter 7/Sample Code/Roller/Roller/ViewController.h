#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface ViewController : 
UIViewController <UIAccelerometerDelegate>
{
    CGPoint ballVelocity;
    
    CADisplayLink* gameTimer;
    
    UIImageView* ball;  
    
    
}

@end
