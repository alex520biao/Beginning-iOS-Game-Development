//
//  CircleView.m
//  Circles
//
//  Created by Alessi Patrick on 9/9/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "CircleView.h"

@implementation CircleView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    //	Seed the random number generator
    srandom( time( NULL ) );
    
    int randomX, randomY, randomDiam;
    
    UIBezierPath* path;
        
    // Draw 10 circles
    for (int i=0; i<10; i++)
    {
    
        randomX = random() % 270;
        randomY = random() % 430;
        randomDiam = random() % 50;

        
    // Make a 40 x 40 pixel square at 0,0
        CGRect aRectangle = CGRectMake(randomX, randomY, randomDiam, randomDiam);
        
    // Make a path for a circle with the rectangle
    path = [UIBezierPath bezierPathWithOvalInRect:aRectangle];
    
    // Fill the circle
    [path fill];
    
    
    }
    
    
}

@end
