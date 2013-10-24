//
//  ViewController.h
//  Blocker
//
//  Created by Alessi Patrick on 9/9/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <AVFoundation/AVfoundation.h>

#import "BlockView.h"
#import "BlockerModel.h"

@interface ViewController : UIViewController {
    BlockerModel* gameModel;
    CADisplayLink* gameTimer;
    UIImageView* ball;  
    UIImageView* paddle;
    AVAudioPlayer *musicPlayer;
    
}

-(void) updateDisplay:(CADisplayLink*)sender ;
-(void) endGameWithMessage:(NSString*) message;

@end
