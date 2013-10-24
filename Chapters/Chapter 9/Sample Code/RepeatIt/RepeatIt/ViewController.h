//
//  ViewController.h
//  RepeatIt
//
//  Created by Alessi Patrick on 9/19/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVfoundation.h>

#define IMAGE_SIZE      140
#define SPACING         10


@interface ViewController : UIViewController <AVAudioPlayerDelegate> {

    // The button images
    UIImageView *image0;
    UIImageView *image1;
    UIImageView *image2;
    UIImageView *image3;
    
    // Track if a sequence is playing
    BOOL playingSequence;
        
    // The computer's button sequence
    NSMutableArray* sequence;
    
    // The audio players
    AVAudioPlayer *audioPlayer0;
    AVAudioPlayer *audioPlayer1;
    AVAudioPlayer *audioPlayer2;
    AVAudioPlayer *audioPlayer3;
    
    int buttonCounter;
    
}

-(void) loadImages;
-(void) addToSequence;
-(void) playSequence;
-(void) playButton:(int) buttonNumber;
-(void) endGameWithMessage:(NSString*) message;
-(void) playerFinished;

@end
