#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

// Constants defining image sizes for the ships
#define SHIP1_WIDTH     337
#define SHIP1_HEIGHT    125
#define SHIP2_WIDTH     337
#define SHIP2_HEIGHT    116
#define SHIP3_WIDTH     340
#define SHIP3_HEIGHT    169

@interface ViewController : UIViewController {
    CALayer *ship1;
    CALayer *ship2;
    CALayer *ship3;
    BOOL alternate;
}

-(void) addShipLayers;
-(void) returnShipsToDefaultState;
-(void) handletap:(UIGestureRecognizer *)gestureRecognizer;


@end
