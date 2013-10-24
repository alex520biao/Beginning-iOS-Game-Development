//
//  ViewController.h
//  SimonSays
//
//  Created by Alessi Patrick on 9/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShapeView.h"

@interface ViewController : UIViewController {
    UILabel* simonLabel;
    NSTimer* gameTimer;
    
    // Track what simon said
    int shouldTouchShape;
    bool simonSaid;
    
    // Timer length
    float timerLength;
}

-(void) getSimonString;
- (void)timerFired:(NSTimer*)theTimer;
-(void) endGameWithMessage:(NSString*) message;

@end