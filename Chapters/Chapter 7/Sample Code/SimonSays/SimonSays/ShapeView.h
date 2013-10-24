//
//  ShapeView.h
//  SimonSays
//
//  Created by Alessi Patrick on 9/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#define TRIANGLE        0
#define SQUARE          1
#define CIRCLE          2
#define PENTAGON        3


@interface ShapeView : UIView {
    int shape;
}

@property int shape;

- (id)initWithFrame:(CGRect)frame shape:(int) theShape;

@end
