//
//  CardImageView.m
//  Concentration
//
//  Created by Alessi Patrick on 9/14/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "CardImageView.h"

@implementation CardImageView
@synthesize faceDown,value;

- (id)initWithFrame:(CGRect)aRect value:(int) inValue
{
    self = [super initWithFrame:aRect];
    if (self) {
        self.value = inValue;
        self.faceDown = YES;
        self.userInteractionEnabled = YES;
        self.image = [UIImage imageNamed:@"Card_Back.png"];
    }
    return self;
    
}


-(void) flipCard
{
    if (self.faceDown)
    {
        NSString* frontFileName =
        [NSString stringWithFormat:@"Card Front_%i.png",self.value];
        
        self.image = [UIImage imageNamed:frontFileName]; 
        self.faceDown = NO;
    }
    else
    {
        self.image = [UIImage imageNamed:@"Card_Back.png"];
        self.faceDown = YES;
    }
}

@end
