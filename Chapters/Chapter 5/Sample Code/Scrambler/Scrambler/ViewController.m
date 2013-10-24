//
//  ViewController.m
//  Scrambler
//
//  Created by Alessi Patrick on 10/7/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController
@synthesize guessText;
@synthesize scrambledWord;
@synthesize remainingTime;
@synthesize playerScore;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Intialize the game model
    gameModel = [[ScramblerModel alloc] init];
    // Display the time, score and scrambled word in the view
    remainingTime.text = [NSString stringWithFormat:@"%i",gameModel.time];
    playerScore.text = [NSString stringWithFormat:@"%i",gameModel.score];
    scrambledWord.text = [gameModel getScrambledWord];
    // Start the game timer
    gameTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                  target:self
                                                selector:@selector(timerFired:)
                                                userInfo:nil
                                                 repeats:YES];
}

- (void)viewDidUnload
{
    [self setGuessText:nil];
    [self setScrambledWord:nil];
    [self setRemainingTime:nil];
    [self setPlayerScore:nil];
    
    gameModel=nil;
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)guessTap:(id)sender {
    // Check the guess against the currentWord
    BOOL guessCorrect = [gameModel checkGuess:guessText.text];
    // Clear the guess text UI widget
    guessText.text=@"";
    if (guessCorrect)
    {
        if (gameModel.score==10)
        {
            // The game is over
            [self endGameWithMessage:@"You win!"];
        }
        else
        {
            // Update the view with the next scrambled word
            scrambledWord.text = [gameModel getScrambledWord];
        }
    }
    // Update the view
    remainingTime.text = [NSString stringWithFormat:@"%i",gameModel.time];
    playerScore.text = [NSString stringWithFormat:@"%i",gameModel.score];
}

-(void) endGameWithMessage:(NSString*) message
{
    // Call this method to end the game
    // Invalidate the timer
    [gameTimer invalidate];
    // Show an alert with the results
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Game Over"
                                                    message:message
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles: nil];
    [alert show];
}

- (void)timerFired:(NSTimer*)theTimer
{
    // The timer fires this method every second
    [gameModel timerTick];
    if (gameModel.time<=0) {
        remainingTime.text = 0;
        [self endGameWithMessage:@"You are out of time. You lose!"];
    }
    else
        remainingTime.text = [NSString stringWithFormat:@"%i", gameModel.time];
}


@end
