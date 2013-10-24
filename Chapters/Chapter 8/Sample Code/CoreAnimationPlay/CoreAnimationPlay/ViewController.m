//
//  ViewController.m
//  CoreAnimationPlay
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
    
    // Configure gesture recognizer
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] 
                                   initWithTarget:self 
                                   action:@selector(handletap:)];
    tap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tap];
    
    // Set the background image by setting the contents of the view's layer
    UIImage *bg = [UIImage imageNamed:@"Background.png"];
    self.view.layer.contents = (id)[bg CGImage];        
    
    // Set the alternate instance variable
    alternate = YES;
    
    // Add layers for the ships
    [self addShipLayers];
    
    
    
}

-(void) addShipLayers
{
    // Create ship layers
    UIImage *shipImage = [UIImage imageNamed:@"SpaceShip_1.png"];
    ship1 = [[CALayer alloc] init];
    ship1.frame = 
    CGRectMake(0, 0, SHIP1_WIDTH/3, SHIP1_HEIGHT/3);
    ship1.contents = (id)[shipImage CGImage];
    
    shipImage = [UIImage imageNamed:@"SpaceShip_2.png"];
    ship2 = [[CALayer alloc] init];
    ship2.frame = 
    CGRectMake(50,50, SHIP2_WIDTH/3, SHIP2_HEIGHT/3);
    ship2.contents = (id)[shipImage CGImage];
    
    shipImage = [UIImage imageNamed:@"SpaceShip_3.png"];
    ship3 = [[CALayer alloc] init];
    ship3.frame = 
    CGRectMake(100, 100, SHIP3_WIDTH/3, SHIP3_HEIGHT/3);
    ship3.contents = (id)[shipImage CGImage];
    
    // Add ship1 layer to the view's layer
    [self.view.layer addSublayer:ship1];
    
    // Add ships 2 and 3 as sublayers of ship 1
    [ship1 addSublayer:ship2];
    [ship1 addSublayer:ship3];
    
}


- (void)handletap:(UIGestureRecognizer *)gestureRecognizer
{
    if(alternate)
    {
        // Set the anchor point of the ship to the top left of the frame
        ship1.anchorPoint = CGPointMake(0, 0);
        
        // Move ship1 and the other sublayers move too
        ship1.position = CGPointMake(150, 200);
    }
    else
    {
        [self returnShipsToDefaultState];
    }
    alternate = !alternate;
    
}


-(void) returnShipsToDefaultState
{
    // Move ship and sublayers back.
    ship1.position = CGPointMake(0, 0);
    
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
