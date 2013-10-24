//
//  ViewController.m
//  MultiToucher
//
//  Created by Alessi Patrick on 9/12/11.
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
    
        self.view.multipleTouchEnabled = YES;
    
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

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // Loop over each touch and log
    for (UITouch* t in touches)
    {
        CGPoint touchLocation;
        
        touchLocation = [t locationInView:self.view];
        
        NSLog(@"touchedBegan at: %f, %f",touchLocation.x, touchLocation.y);
        
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    // Loop over each touch and log
    for (UITouch* t in touches)
    {
        CGPoint touchLocation;
        
        touchLocation = [t locationInView:self.view];
        
        NSLog(@"touchesMoved at: %f, %f",touchLocation.x, touchLocation.y);
        
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    // Loop over each touch and log
    for (UITouch* t in touches)
    {
        CGPoint touchLocation;
        
        touchLocation = [t locationInView:self.view];
        
        NSLog(@"touchesEnded at: %f, %f",touchLocation.x, touchLocation.y);
        
    }
}

@end
