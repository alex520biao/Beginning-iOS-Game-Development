//
//  TestView.m
//  GraphicsStart
//
//  Created by Alessi Patrick on 9/8/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "TestView.h"

@implementation TestView

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
    // Make a 40 x 40 pixel square at 0,0
    CGRect aRectangle = CGRectMake(0.0, 0.0, 40.0, 40.0);
    
    // Make a path with the square
    UIBezierPath* path = [UIBezierPath bezierPathWithRect:aRectangle];
    
    // Stroke the square
    [path stroke];
    
    // Make a path for a circle with the same square
    path = [UIBezierPath bezierPathWithOvalInRect:aRectangle];
    
    // Fill the circle
    [path fill];
    
    // Make a path for a star
    UIBezierPath* starPath = [UIBezierPath bezierPath];
    
    // Draw the path for a star
    [starPath moveToPoint:CGPointMake(40.0, 0.0)];
    [starPath addLineToPoint:CGPointMake(30.0, 30.0)];
    [starPath addLineToPoint:CGPointMake(0.0, 30.0)];
    [starPath addLineToPoint:CGPointMake(20.0, 50.0)];
    [starPath addLineToPoint:CGPointMake(10.0, 80.0)];
    [starPath addLineToPoint:CGPointMake(40.0, 60.0)];
    [starPath addLineToPoint:CGPointMake(70.0, 80.0)];
    [starPath addLineToPoint:CGPointMake(60.0, 50.0)];
    [starPath addLineToPoint:CGPointMake(80.0, 30.0)];
    [starPath addLineToPoint:CGPointMake(50.0, 30.0)];
    [starPath closePath];
    
    //	Get the drawing context
    CGContextRef context =  UIGraphicsGetCurrentContext ();
    
    // Save the context state
    CGContextSaveGState (context);
    
    // Translate the coordinate system origin
    CGContextTranslateCTM(context, 100, 100);
    
    // Set the fill color to yellow
    UIColor* fillColor = [UIColor yellowColor];
    [fillColor setFill];
    
    // Fill the star
    [starPath fill];
    
    // Translate and rotate the coordinates
    CGContextTranslateCTM(context, 100, 100);
    CGContextRotateCTM(context, 3.14/4);
    
    // Set the fill color to green
    fillColor = [UIColor greenColor];
    [fillColor setFill];
    
    // Fill and stroke the star
    [starPath fill];
    [starPath stroke];
    
    // Restore the context
    CGContextRestoreGState(context);
    
    // Save the context state
    CGContextSaveGState (context);
    
    // Translate the coordinate system origin
    CGContextTranslateCTM(context, 50, 250);
    
    // Fill the star
    [starPath fill];
    
    // Restore the context
    CGContextRestoreGState(context);
    
    // Save the context state
    CGContextSaveGState (context);
    
    // Translate the coordinate system origin
    CGContextTranslateCTM(context, 220, 0);
    
    // Create drop shadow
    CGContextSetShadow(context, CGSizeMake(10, 10), 5);
    
    // Set the fill color to green
    fillColor = [UIColor orangeColor];
    [fillColor setFill];
    
    [starPath fill];
    
    // Restore the context
    CGContextRestoreGState(context);
    // Save the context state
    CGContextSaveGState (context);
    
    // Translate the coordinate system origin
    CGContextTranslateCTM(context, 220, 320);
    
    // Declare the gradient
    CGGradientRef myGradient; 
    
    //	Define the color space
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    // Define the color components of the gradient
    CGFloat components[8] = { 1.0, 0.0, 0.0, 1.0,  // Start color 
        0.0, 0.0, 1.0, 1.0 }; // End color 
    
    // Define the location of each component
    int num_locations = 2; 
    CGFloat locations[2] = { 0.0, 1.0 };
    
    // Create the gradient
    myGradient = CGGradientCreateWithColorComponents (colorSpace, components, 
                                                      locations, num_locations); 
    
    // Use the star path as a clipping path for the gradient
    [starPath addClip];
    
    // Draw the gradient
    CGContextDrawLinearGradient (context, myGradient, CGPointMake(0, 0),
                                 CGPointMake(80, 0), 0); 
    
	//	Clean up the color space & gradient
	CGColorSpaceRelease(colorSpace);
	CGGradientRelease(myGradient);
    
    // Restore the context
    CGContextRestoreGState(context);

    
}

@end
