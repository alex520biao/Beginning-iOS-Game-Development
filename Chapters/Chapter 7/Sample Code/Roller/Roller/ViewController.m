//
//  ViewController.m
//  Roller
//
//  Created by Alessi Patrick on 9/13/11.
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
    
    // Configure the accelerometer
    UIAccelerometer*  theAccelerometer = [UIAccelerometer sharedAccelerometer];
    // Use 30Hz update frequency
    theAccelerometer.updateInterval = 1 / 30;
    theAccelerometer.delegate = self;
    
    // Initialize the velocity vector
    ballVelocity.x=0;
    ballVelocity.y=0;
    
    // Draw the ball
    ball = [[UIImageView alloc] initWithImage:
            [UIImage imageNamed:@"ball.png"]];
    
    CGSize ballSize = [ball.image size];
    
    [ball setFrame:CGRectMake(180.0, 220.0, 
                              ballSize.width, ballSize.height)];
    
    [self.view addSubview:ball];
    
    // Set up the CADisplayLink for the animation
    gameTimer = [CADisplayLink displayLinkWithTarget:self 
                                            selector:@selector(updateDisplay:)];
    
    
    // Add the display link to the current run loop
    [gameTimer addToRunLoop:[NSRunLoop currentRunLoop] 
                    forMode:NSDefaultRunLoopMode];
    
    
}

- (void)accelerometer:(UIAccelerometer *)accelerometer 
        didAccelerate:(UIAcceleration *)acceleration
{
    
    ballVelocity.x += acceleration.x;
    ballVelocity.y -= acceleration.y;
    
    
}

-(void) updateDisplay:(CADisplayLink*)sender 
{
    // This method is called by the gameTimer each time the display should 
    // update
    
    CGPoint center = ball.center;
    
    // Stop the ball if it's reached a boundary
    if (center.x<0 || center.x > self.view.bounds.size.width) {
        ballVelocity.x= -1 * ballVelocity.x;
    }
    if (center.y<0 || center.y>self.view.bounds.size.height)
    {
        ballVelocity.y= -1 * ballVelocity.y;
    }
    
    // Move the ball
    
    center.x = center.x + ballVelocity.x;
    center.y = center.y + ballVelocity.y;
    
    ball.center = center;
    
    
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

@end
