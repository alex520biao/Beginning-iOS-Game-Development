//
//  ViewController.m
//  Concentration
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
    [self createCards];
    
    firstTappedView = nil;
    isAnimating = NO;
    
}
-(void) createCards
{
    // 16 * 4 cards
    // Create cards
    NSMutableArray *cards = [[NSMutableArray alloc] initWithCapacity:64];
    
    for (int i=1; i<=16; i++) {
        for (int j=1; j<=4; j++) {
            [cards addObject:[NSNumber numberWithInt:i]];
        }
    }
    
    // Shuffle cards
    srandom( time( NULL ) );
    int swapA, swapB;
    
    for (int i=0; i<100000; i++) {
        
        swapA = (random() % 64);
        swapB = (random() % 64);
        
        NSNumber *tempNumber = [cards objectAtIndex:swapA];
        [cards replaceObjectAtIndex:swapA 
                         withObject:[cards objectAtIndex:swapB]];
        [cards replaceObjectAtIndex:swapB
                         withObject:tempNumber];
    }
    
    [self addCardsToView:cards];
    
}

-(void) addCardsToView:(NSMutableArray*) cards
{
    
    CardImageView* card;
    CGRect cardFrame;
    CGRect cardOrigin = CGRectMake(0,0, 40, 60);
    
    cardFrame.size = CGSizeMake(40, 60);
    CGPoint origin;
    int cardIndex = 0;
    
    NSTimeInterval timeDelay = 0.0;
    
    for (int i=0; i<8; i++) {
        for (int j=0; j<8; j++) {
            origin.y = i*70 + 100;
            origin.x = j * 50 + 100;
            cardFrame.origin = origin;
            
            // Create the card at the origin
            card = [[CardImageView alloc] initWithFrame:cardOrigin 
                                                  value:[[cards objectAtIndex:cardIndex] intValue]];
            
            // Configure gesture recognizer
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] 
                                           initWithTarget:self 
                                           action:@selector(handletap:)];
            tap.numberOfTapsRequired = 1;
            
            [card addGestureRecognizer:tap];
            
            
            [self.view addSubview:card];
            
            // Animate moving the cards into position
            // In iOS 4 and later, use the Block-based animation methods.
            [UIView animateWithDuration:0.5 
                                  delay:timeDelay 
                                options:UIViewAnimationOptionCurveLinear 
                             animations: ^{
                                 card.frame = cardFrame;
                             } 
                             completion:NULL];
            
            timeDelay += 0.1;
            cardIndex++;
        }
        
    }
}

- (void)handletap:(UIGestureRecognizer *)gestureRecognizer
{
    
    // If an animation is running, ignore taps
    if (isAnimating)
        return;
    
    CardImageView *tappedCard = (CardImageView*) gestureRecognizer.view;
    
    // Has a card already been tapped?
    if (firstTappedView == nil)
    {
        // Flip the tapped card
        [UIView transitionWithView:tappedCard
                          duration:0.5
                           options:UIViewAnimationOptionTransitionFlipFromLeft
                        animations:^{ 
                            [tappedCard flipCard];
                        }
         
                        completion:NULL];
        // This is the first card, so just set it
        firstTappedView = tappedCard;
    }
    else if (firstTappedView != tappedCard)
    {
        // If the player didn't tap the same card again...
        
        // Ignore taps because we are animating
        isAnimating = YES;
        
        [UIView transitionWithView:tappedCard
                          duration:0.5
                           options:UIViewAnimationOptionTransitionFlipFromLeft
                        animations:^{ 
                            [tappedCard flipCard];
                        }
         
                        completion:NULL];
        // A card has already been tapped, so test for a match
        if (firstTappedView.value == tappedCard.value)
        {
            // Player found a match
            // Remove the cards
            [UIView animateWithDuration:1 delay:1
                                options:UIViewAnimationOptionTransitionNone
                             animations:^{
                                 firstTappedView.alpha = 0; 
                                 tappedCard.alpha=0;
                             }
                             completion:^(BOOL finished) { 
                                 [firstTappedView removeFromSuperview];
                                 [tappedCard removeFromSuperview];
                                 // Stop ignoring taps because animation is done
                                 isAnimating=NO;
                             }
             ];
            
            
            // Reset the first tapped card to nil
            firstTappedView = nil;
        }
        
        else
        {
            // Flip both cards back over
            secondTappedView = tappedCard;
            [self performSelector:@selector(flipCards) withObject:nil
                       afterDelay:2];
            
        }
    }
}

-(void) flipCards
{
    [UIView transitionWithView:firstTappedView
                      duration:1
                       options:UIViewAnimationOptionTransitionFlipFromRight
                    animations:^{ 
                        [firstTappedView flipCard];
                    }
                    completion:NULL
     ];
    [UIView transitionWithView:secondTappedView
                      duration:1
                       options:UIViewAnimationOptionTransitionFlipFromRight
                    animations:^{ 
                        [secondTappedView flipCard];
                    }
                    completion:^(BOOL finished) { 
                        // Stop ignoring events because animation is done
                        isAnimating=NO;
                        
                    }
     ];
    
    // Reset the first tapped cards to nil
    firstTappedView = nil;
    secondTappedView = nil;
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
