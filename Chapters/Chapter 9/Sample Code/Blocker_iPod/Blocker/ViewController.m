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
    
    // Initialize the selectedSong flag
    selectedSong=NO;
    
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
    
    
    // Configure the audio session to allow the music and sound effects to play
    NSError *setCategoryErr = nil;
    
    [[AVAudioSession sharedInstance]
     setCategory: AVAudioSessionCategoryAmbient
     error: &setCategoryErr];
    
}

-(void) startGame
{
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
    
    if (!selectedSong)
    {
        // Instantiate the music picker to allow player to choose music
        MPMediaPickerController *musicPicker =
        [[MPMediaPickerController alloc] initWithMediaTypes: MPMediaTypeMusic];                   
        
        // Set the delegate
        [musicPicker setDelegate: self];                                      
        
        // Limit the player to picking only one song
        [musicPicker setAllowsPickingMultipleItems: NO];
        
        // Show the music picker
        [self presentModalViewController: musicPicker animated: YES];
        
        
    }
}

- (void) mediaPicker: (MPMediaPickerController *) mediaPicker
   didPickMediaItems: (MPMediaItemCollection *) collection {
    
    // Finished with the picker, so dismiss it
    [self dismissModalViewControllerAnimated: YES];
    
    // Set the selectedSong flag
    selectedSong=YES;
    
    // Use the application music player and not the iPod player
    MPMusicPlayerController* appMusicPlayer =
    [MPMusicPlayerController applicationMusicPlayer];
    
    // Set to repeat the song
    [appMusicPlayer setRepeatMode: MPMusicRepeatModeOne];
    
    // Set the queue of songs to play based on what the player chose
    [appMusicPlayer setQueueWithItemCollection: collection];
    
    // Set the volume
    [appMusicPlayer setVolume:0.3];
    
    // Start the player
    [appMusicPlayer play];
    
    // Give music player a couple of seconds to start, then start game
    [self performSelector:@selector(startGame)
               withObject:nil afterDelay:2.0];
    
}


- (void) mediaPickerDidCancel: (MPMediaPickerController *) mediaPicker {
    
    // Finished with the picker, so dismiss it
    [self dismissModalViewControllerAnimated: YES];
    
    // Set the selectedSong flag
    selectedSong=YES;
    
    // Start the game
    [self  startGame];
    
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
