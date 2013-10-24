//
//  ViewController.m
//  ImageAnimation
//
//  Created by Alessi Patrick on 9/14/11.
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
    
    // Set up the image view
    UIImageView* animatedImages = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 100, 100)];
    [self.view addSubview:animatedImages];
    
    // Load the images into an array
    NSMutableArray *imageArray = [[NSMutableArray alloc] initWithCapacity:10];
    NSString* fileName;
    
    // Build the file names dynamically
    for (int i=1; i<=10; i++) {
        fileName = [NSString stringWithFormat: @"Clock%i.png",i];
        [imageArray addObject:[UIImage imageNamed:fileName]];
        
    }
    
    // Configure the animation
    animatedImages.animationImages = imageArray;
    animatedImages.animationDuration = 1;
    
    // Start the animation
    [animatedImages startAnimating];
    
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
