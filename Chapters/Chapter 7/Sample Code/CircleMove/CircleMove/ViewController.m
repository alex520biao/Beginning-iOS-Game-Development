//
//  ViewController.m
//  CircleMove
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
	// Do any additional setup after loading the view, typically from a nib.
    
    // Draw the ball
    ball = [[UIImageView alloc] initWithImage:
            [UIImage imageNamed:@"ball.png"]];
    
    ballSize = [ball.image size];
    
    [ball setFrame:CGRectMake(180.0, 220.0, 
                              ballSize.width, ballSize.height)];
    
    [self.view addSubview:ball];
    
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

#pragma mark - Touch methods to move circle
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // Loop over each touch and log
    for (UITouch* t in touches)
    {
        CGPoint touchLocation;
        
        touchLocation = [t locationInView:self.view];
        
        // Move the ball by setting its frame to the touch position
        [ball setFrame:CGRectMake(touchLocation.x, touchLocation.y, 
                                  ballSize.width, ballSize.height)];
        
        
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    // Loop over each touch and log
    for (UITouch* t in touches)
    {
        CGPoint touchLocation;
        
        touchLocation = [t locationInView:self.view];
        
        // Move the ball by setting its frame to the touch position
        [ball setFrame:CGRectMake(touchLocation.x, touchLocation.y, 
                                  ballSize.width, ballSize.height)];        
    }
}




@end
