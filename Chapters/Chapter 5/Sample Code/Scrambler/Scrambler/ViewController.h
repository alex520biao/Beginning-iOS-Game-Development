//
//  ViewController.h
//  Scrambler
//
//  Created by Alessi Patrick on 10/7/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScramblerModel.h"

@interface ViewController : UIViewController
{
    ScramblerModel* gameModel;
    NSTimer* gameTimer;
}

- (IBAction)guessTap:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *guessText;
@property (weak, nonatomic) IBOutlet UILabel *scrambledWord;
@property (weak, nonatomic) IBOutlet UILabel *remainingTime;
@property (weak, nonatomic) IBOutlet UILabel *playerScore;


-(void) endGameWithMessage:(NSString*) message;

@end
