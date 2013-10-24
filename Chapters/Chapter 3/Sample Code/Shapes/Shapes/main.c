//
//  main.c
//  Shapes
//
//  Created by Patrick Alessi on 3/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#include <stdio.h>

struct point {
	int x;
	int y;
};

struct rectangle {
    struct point upperLeft;
    struct point lowerRight;
};

int main (int argc, const char * argv[])
{

    // Declare points 
    struct point ul;
    struct point lr;
    
    // Specify the location of the ul point
    ul.x = 3;
    ul.y = 4;
    
    // Specify the location of the lr point
    lr.x = 6;
    lr.y = 2;
    
    // Declare the rectangle
    struct rectangle theRectangle;
    
    // Define the rectangle using the points
    theRectangle.upperLeft = ul;
    theRectangle.lowerRight = lr;
    
    // Print the coordinates of the rectangle
    printf("Upper Left -- x:%i y:%i  Lower Right -- x:%i y:%i\n",
           theRectangle.upperLeft.x,theRectangle.upperLeft.y,
           theRectangle.lowerRight.x,theRectangle.lowerRight.y);
    
    // Move the rectangle right 2 units and up 3 units
    theRectangle.upperLeft.x +=2;
    theRectangle.upperLeft.y +=3;
    theRectangle.lowerRight.x +=2;
    theRectangle.lowerRight.y +=3;
    
    // Print the new coordinates of the rectangle
    printf("Upper Left -- x:%i y:%i  Lower Right -- x:%i y:%i\n",
           theRectangle.upperLeft.x,theRectangle.upperLeft.y,
           theRectangle.lowerRight.x,theRectangle.lowerRight.y);
    
    return 0;
}

