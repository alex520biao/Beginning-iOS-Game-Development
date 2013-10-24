//
//  ViewController.m
//  RepeatIt
//
//  Created by Alessi Patrick on 9/19/11.
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
    
    // Load the images
    [self loadImages];
    
    // Initialize the playingSequence flag
    playingSequence = NO;
    
    // Initialize the sequence
    sequence = [[NSMutableArray alloc] initWithCapacity:100];
    
    //	Seed the random number generator
    srandom( time( NULL ) );
    
    // Init the audio players and load the sound files
    NSURL *sound0URL = [NSURL fileURLWithPath: 
                        [[NSBundle mainBundle] pathForResource: @"0"
                                                        ofType: @"aiff"]];
    
    audioPlayer0 = [[AVAudioPlayer alloc] 
                    initWithContentsOfURL:sound0URL error:nil];
    
    NSURL *sound1URL = [NSURL fileURLWithPath: 
                        [[NSBundle mainBundle] pathForResource: @"1"
                                                        ofType: @"aiff"]];
    
    audioPlayer1 = [[AVAudioPlayer alloc] 
                    initWithContentsOfURL:sound1URL error:nil];
    
    NSURL *sound2URL = [NSURL fileURLWithPath: 
                        [[NSBundle mainBundle] pathForResource: @"2"
                                                        ofType: @"aiff"]];
    
    audioPlayer2 = [[AVAudioPlayer alloc] 
                    initWithContentsOfURL:sound2URL error:nil];
    
    NSURL *sound3URL = [NSURL fileURLWithPath:
                        [[NSBundle mainBundle] pathForResource: @"3"
                                                        ofType: @"aiff"]];
    
    audioPlayer3 = [[AVAudioPlayer alloc] 
                    initWithContentsOfURL:sound3URL error:nil];
    
    // Set up the audio player delegates
    [audioPlayer0 setDelegate: self];
    [audioPlayer1 setDelegate: self];
    [audioPlayer2 setDelegate: self];
    [audioPlayer3 setDelegate: self];
    
    // Prepare to play sounds
    [audioPlayer0 prepareToPlay];
    [audioPlayer1 prepareToPlay];
    [audioPlayer2 prepareToPlay];
    [audioPlayer3 prepareToPlay];
    
    // Configure the audio session
    NSError *setCategoryErr = nil;
    [[AVAudioSession sharedInstance]
     setCategory: AVAudioSessionCategoryAmbient
     error: &setCategoryErr];
    
    
    // Start the game by adding the first note to the sequence
    [self addToSequence];
    
    // Play the sequence
    [self playSequence];
    
}

-(void) loadImages
{
    // Load the image views
    image0 = [[UIImageView alloc] 
              initWithImage: [UIImage imageNamed:@"0_light.png"]
              highlightedImage: [UIImage imageNamed:@"0.png"]];
    image1 = [[UIImageView alloc] 
              initWithImage: [UIImage imageNamed:@"1_light.png"]
              highlightedImage: [UIImage imageNamed:@"1.png"]];
    image2 = [[UIImageView alloc] 
              initWithImage: [UIImage imageNamed:@"2_light.png"]
              highlightedImage: [UIImage imageNamed:@"2.png"]];
    image3 = [[UIImageView alloc] 
              initWithImage: [UIImage imageNamed:@"3_light.png"]
              highlightedImage: [UIImage imageNamed:@"3.png"]];
    
    // Size and position the images
    CGRect position = CGRectMake(0, 0, IMAGE_SIZE, IMAGE_SIZE);
    image0.frame = position;
    [self.view addSubview:image0];
    
    position = CGRectMake(IMAGE_SIZE+SPACING, 0, IMAGE_SIZE, IMAGE_SIZE);
    image1.frame = position;
    [self.view addSubview:image1];
    
    position = CGRectMake(0, IMAGE_SIZE+SPACING,IMAGE_SIZE, IMAGE_SIZE);
    image2.frame = position;
    [self.view addSubview:image2];
    
    position = CGRectMake(IMAGE_SIZE+SPACING, IMAGE_SIZE+SPACING, 
                          IMAGE_SIZE, IMAGE_SIZE);
    image3.frame = position;
    [self.view addSubview:image3];
    
    // Enable touch on images
    image0.userInteractionEnabled=YES;
    image1.userInteractionEnabled=YES;
    image2.userInteractionEnabled=YES;
    image3.userInteractionEnabled=YES;
    
    // Set view tags used to identify each view
    image0.tag=0;
    image1.tag=1;
    image2.tag=2;
    image3.tag=3;
    
}

-(void) addToSequence
{
    // Pick a random number from 0 to 3
    int randomNum = (random() % 4);
    
    // Add the number to the sequence
    [sequence addObject:[NSNumber numberWithInt:randomNum]];
    
}

-(void) playSequence
{
    // Reset the button counter
    buttonCounter = 0;    
    
    // Sequence is playing
    playingSequence=YES;
    
    // Play the first button    
    [self playButton:
     [(NSNumber*)[sequence objectAtIndex:buttonCounter] intValue]];
}

-(void) playButton:(int) buttonNumber
{
    
    // Highlight the image and play the sound
    switch (buttonNumber) {
        case 0:
            image0.highlighted = YES;
            audioPlayer0.currentTime = 0;
            [audioPlayer0 play];
            
            break;
        case 1:
            image1.highlighted = YES;
            audioPlayer1.currentTime = 0;
            [audioPlayer1 play];
            
            break;
        case 2:
            image2.highlighted = YES;
            audioPlayer2.currentTime = 0;
            [audioPlayer2 play];
            
            break;
        case 3:
            image3.highlighted = YES;
            audioPlayer3.currentTime = 0;
            [audioPlayer3 play];
            
            break;
        default:
            break;
    }
    
}

- (void) audioPlayerDidFinishPlaying: (AVAudioPlayer *) player
                        successfully: (BOOL) completed {
    
    if (completed == YES) {
        
        // Finished playing a sound
        
        
        // Depending of the file that was played, un-highlight
        // the appropriate button
        NSString *urlString = [player.url lastPathComponent];
        if ([urlString isEqualToString:@"0.aiff"])
        {
            image0.highlighted = NO;
        }
        else if([urlString isEqualToString:@"1.aiff"])
        {
            image1.highlighted = NO;
        }
        else if([urlString isEqualToString:@"2.aiff"])
        {
            image2.highlighted = NO;
        }        
        else if([urlString isEqualToString:@"3.aiff"])
        {
            image3.highlighted = NO;
        }    
        
        // If we are playing the computer sequence
        if (playingSequence)
        {
            // Increment the button counter and see if we are finished
            if (++buttonCounter<[sequence count])
            {
                // Not finished the sequence
                // play the next button
                [self playButton:
                 [(NSNumber*)[sequence objectAtIndex:buttonCounter] intValue]];
                
            }
            else
            {
                // Finished the sequence
                // Reset the button counter
                buttonCounter=0;
                
                // Indicate that the sequence is finished playing
                playingSequence=NO;
            }
        }
    }
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // User needs to repeat the sequence
    
    // Ignore user input if playing the sequence or the player is finished
    
    if(!playingSequence && buttonCounter < [sequence count])    {
        
        // Get any touch
        UITouch* t = [touches anyObject];
        
        // If the touch was on a UIImageView
        if ([t.view class] == [UIImageView class])
        {
            // Get the tappedImageView
            UIImageView *tappedImageView = (UIImageView*) t.view;
            
            // Play the sound
            [self playButton:tappedImageView.tag];
            
            // Get the correct button for the location in the sequence
            int correctButton = 
            [(NSNumber*)[sequence objectAtIndex:buttonCounter] intValue];
            
            // Did the user tap the correct button?
            if (tappedImageView.tag == correctButton)
            {
                // Player tapped correct button
                buttonCounter++;
                
                // Is the sequence complete?
                if ([sequence count]==buttonCounter)
                {
                    // Player played all sounds so wait 2 seconds then
                    // run the playerFinished routine
                    [self performSelector:@selector(playerFinished)
                               withObject:nil afterDelay:2.0];
                    
                }
                
            }
            else
            {
                // Player tapped incorrect button
                [self endGameWithMessage:@"You missed."];
            }
            
        }
    }
    
}

-(void) playerFinished
{
    // The player correctly finished the sequence
    // Add a new note to the sequence
    [self addToSequence];
    
    // Play the sequence back
    [self playSequence];
    
}

-(void) endGameWithMessage:(NSString*) message
{
    // Call this method to end the game    
    // Show an alert with the results
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Game Over"
                                                    message:message
                                                   delegate:self 
                                          cancelButtonTitle:@"OK" 
                                          otherButtonTitles: nil];
    [alert show];   

    
    
}

- (void)alertView:(UIAlertView *)alertView 
didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    // User acknowledged the alert
    // Reset the game and start again
    [sequence removeAllObjects];
    buttonCounter=0;
    [self addToSequence];
    
    // Play the sequence back
    [self playSequence];
    
    
}


- (void)viewDidUnload
{
    // Release any retained subviews of the main view.
    image0=nil;
    image1=nil;
    image2=nil;
    image3=nil;
    
    sequence=nil;

    audioPlayer0=nil;
    audioPlayer1=nil;
    audioPlayer2=nil;
    audioPlayer3=nil;
    
    [super viewDidUnload];
    
    
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

@end
