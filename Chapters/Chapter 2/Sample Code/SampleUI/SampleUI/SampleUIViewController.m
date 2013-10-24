//
//  SampleUIViewController.m
//  SampleUI
//
//  Created by Alessi Patrick on 8/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SampleUIViewController.h"

@implementation SampleUIViewController
@synthesize myLabel;

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
    
    counter = 0;
    self.myLabel.text = [[NSNumber numberWithInt:counter] stringValue];
}

- (void)viewDidUnload
{
    [self setMyLabel:nil];
    mySlider = nil;
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

- (IBAction)buttonPressed:(id)sender {
    // Increment the counter
    counter++;
    
    // Update the label using the outlet
    self.myLabel.text = [[NSNumber numberWithInt:counter] stringValue];

    // Move the slider using the outlet
    mySlider.value = counter;
    
}

- (IBAction)sliderMoved:(id)sender {
    // Update the counter using the slider
    counter = mySlider.value;
    
    // Update the label using the outlet
    self.myLabel.text = [[NSNumber numberWithInt:counter] stringValue];

    
}
@end
