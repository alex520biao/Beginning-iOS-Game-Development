//
//  ViewController.h
//  Concentration
//
//  Created by Alessi Patrick on 9/14/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardImageView.h"

@interface ViewController : UIViewController
{
    CardImageView *firstTappedView;
    CardImageView *secondTappedView;
    bool isAnimating;
}

-(void) createCards;
-(void) addCardsToView:(NSMutableArray*) cards;
-(void) flipCards;

@end
