//
//  ViewController.m
//  Blocker
//
//  Created by Alessi Patrick on 9/9/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // initialize the game model
    gameModel = [[BlockerModel alloc] init];
    
    
    // Iterate over the blocks in the model, drawing them
    for (BlockView* bv in gameModel.blocks) {
        //	Add the block to the array
        [self.view addSubview:bv];
    }
    
    
    // Draw the paddle 
    paddle = [[UIImageView alloc] initWithImage:
              [UIImage imageNamed:@"paddle.png"]];
    
    // Set the paddle position based on the model
    [paddle setFrame:gameModel.paddleRect];
    
    [self.view addSubview:paddle];
    
    // Draw the ball
    ball = [[UIImageView alloc] initWithImage:
            [UIImage imageNamed:@"ball.png"]];
    
    [ball setFrame:gameModel.ballRect];
    
    [self.view addSubview:ball];
    
    // Init music player
    NSURL *musicSoundURL = [NSURL fileURLWithPath: [[NSBundle mainBundle] pathForResource: @"BlockerMusic"
                                                                                   ofType: @"aiff"]];
    
    musicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:musicSoundURL error:nil];
    
    // Set to loop indefinitely
    musicPlayer.numberOfLoops = -1;
    
    // Set the volume
    musicPlayer.volume = 0.3;
    
    // Start the music
    [musicPlayer play];
    
    // Set up the CADisplayLink for the animation
    gameTimer = [CADisplayLink displayLinkWithTarget:self 
                                            selector:@selector(updateDisplay:)];
    
    
    // Add the display link to the current run loop
    [gameTimer addToRunLoop:[NSRunLoop currentRunLoop] 
                    forMode:NSDefaultRunLoopMode];
    
}

-(void) updateDisplay:(CADisplayLink*)sender 
{
    // This method is called by the gameTimer each time the display should 
    // update
    
    // Update the model
    [gameModel updateModelWithTime:sender.timestamp];
    
    // Update the display
    [ball setFrame:gameModel.ballRect];
    [paddle setFrame:gameModel.paddleRect];
    
    if ([gameModel.blocks count] == 0)
    {
        // No more blocks, end the game
        [self endGameWithMessage:@"You destroyed all of the blocks"];
        
    }
    
    
}

-(void) endGameWithMessage:(NSString*) message
{
    // Call this method to end the game
    // Invalidate the timer
    [gameTimer invalidate];
    
    // Stop the music
    [musicPlayer stop];
    
    // Show an alert with the results
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Game Over"
                                                    message:message
                                                   delegate:self 
                                          cancelButtonTitle:@"OK" 
                                          otherButtonTitles: nil];
    [alert show];   
}

- (void)viewDidUnload
{
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

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    // Iterate over all touches
    for (UITouch* t in touches)
    {
        CGFloat delta = [t locationInView:self.view].x - 
        [t previousLocationInView:self.view].x; 
        
        CGRect newPaddleRect = gameModel.paddleRect;
        newPaddleRect.origin.x += delta;
        gameModel.paddleRect = newPaddleRect;
        
    }
}

@end
