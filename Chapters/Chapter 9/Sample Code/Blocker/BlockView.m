//
//  BlockView.m
//  Blocker
//
//  Created by Alessi Patrick on 9/9/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "BlockView.h"

@implementation BlockView
@synthesize color;


- (id)initWithFrame:(CGRect)frame color:(int) inputColor;
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.color = inputColor;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    float viewWidth, viewHeight;
	viewWidth = self.bounds.size.width;
	viewHeight = self.bounds.size.height;
    
	//	Get the drawing context
	CGContextRef context =  UIGraphicsGetCurrentContext ();
	
    // Define a rect in the shape of the block
    CGRect blockRect = CGRectMake(0, 0,  viewWidth, viewHeight);
    
    // Define a path using the rect
    UIBezierPath* path = [UIBezierPath bezierPathWithRect:blockRect];
    
    // Set the line width of the path
    path.lineWidth = 2.0;
    
    //	Define a gradient to use to fill the blocks
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGGradientRef myGradient; 
    int num_locations = 2; 
    CGFloat locations[2] = { 0.0, 1.0 }; 
    
    CGFloat components[8] = { 0.0, 0.0, 0.0, 1.0,  // Start color 
        1.0, 1.0, 1.0, 1.0 }; // End color 
    
    // Determine gradient color based on color property
    switch (self.color) {
        case RED_COLOR:
            // Red Block
            components[0] = 1.0;
            break;
        case GREEN_COLOR:
            // Green Block
            components[1] = 1.0;
            break;
        case BLUE_COLOR:
            // Blue Block
            components[2] = 1.0;
            break;            
        default:
            break;
    }
    
    myGradient = CGGradientCreateWithColorComponents (colorSpace, components, 
                                                      locations, num_locations); 
    
    CGContextDrawLinearGradient (context, myGradient, CGPointMake(0, 0),
                                 CGPointMake(viewWidth, 0), 0);
    
	//	Clean up the color space & gradient
	CGColorSpaceRelease(colorSpace);
	CGGradientRelease(myGradient);
	
    // Stroke the path
	[path stroke];
    
}

@end
